/*
 * Copyright 2011 kubtek <kubtek@mail.com>
 *
 * This file is part of StarDict.
 *
 * StarDict is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * StarDict is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with StarDict.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _MAPFILE_HPP_
#define _MAPFILE_HPP_

#ifdef HAVE_CONFIG_H
#  include "config.h"
#endif

#define HAVE_MMAP
#define gint int
#define gboolean bool
#define gchar char
#define gsize size_t
#define g_free free
#define g_stat stat

#  include <stdio.h>
#  include <stdlib.h>
#  include <string.h>

#ifdef HAVE_MMAP
#  include <sys/types.h>
#  include <fcntl.h>
#  include <sys/mman.h>
#  include <unistd.h>
#endif
#ifdef _WIN32
#  include <windows.h>
#endif
//#include <glib.h>
//#include "utils.h"
//#include "libcommon.h"

class MapFile {
public:
  MapFile(void) : 
#ifdef HAVE_MMAP
		mmap_fd(-1),
#elif defined(_WIN32)
		hFile(0),
		hFileMap(0),
#endif
		data(NULL)
	{
	}
  ~MapFile();
  /* file_name in file name encoding */
  inline bool open(const char *file_name, unsigned long file_size);
  inline void close();
  inline gchar *begin(void) { return data; }
private:
#ifdef HAVE_MMAP
  int mmap_fd;
#elif defined(_WIN32)
  HANDLE hFile;
  HANDLE hFileMap;
#endif
  char *data;
  unsigned long size;
};

inline bool MapFile::open(const char *file_name, unsigned long file_size)
{
  size=file_size;
#ifdef HAVE_MMAP
  if ((mmap_fd = ::open(file_name, O_RDONLY)) < 0) {
    //g_print("Open file %s failed!\n",fullfilename);
    return false;
  }
  data = (gchar *)mmap( NULL, file_size, PROT_READ, MAP_SHARED, mmap_fd, 0);
  if ((void *)data == (void *)(-1)) {
    //g_print("mmap file %s failed!\n",idxfilename);
    ::close(mmap_fd);
    data=NULL;
    return false;
  }
#elif defined(_WIN32)
	std::string file_name_utf8;
	std_win_string file_name_win;
	if(!file_name_to_utf8(file_name, file_name_utf8))
		return false;
	if(!utf8_to_windows(file_name_utf8, file_name_win))
		return false;
  hFile = CreateFile(file_name_win.c_str(), GENERIC_READ, 0, NULL, OPEN_ALWAYS, 
		     FILE_ATTRIBUTE_NORMAL, 0);
  hFileMap = CreateFileMapping(hFile, NULL, PAGE_READONLY, 0,  
			       file_size, NULL);
  data = (gchar *)MapViewOfFile(hFileMap, FILE_MAP_READ, 0, 0, file_size);
#else
	  gsize read_len;
	  if (!g_file_get_contents(file_name, &data, &read_len, NULL))
		return false;

	  if (read_len!=file_size)
		return false;
#endif

  return true;
}

inline void MapFile::close()
{
  if (!data)
    return;
#ifdef HAVE_MMAP
  munmap(data, size);
  ::close(mmap_fd);
#else
#  ifdef _WIN32
  UnmapViewOfFile(data);
  CloseHandle(hFileMap);
  CloseHandle(hFile);
#  else
  g_free(data);
#  endif
#endif			
  data=NULL;
}

inline MapFile::~MapFile()
{
  close();
}

#endif//!_MAPFILE_HPP_
