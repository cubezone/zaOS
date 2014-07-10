/*
 * ZaListDir.h
 *
 *  Created on: 2012-10-2
 *      Author: Administrator
 */

#ifndef ZALISTDIR_H_
#define ZALISTDIR_H_

#include "ZaList.h"
#include "ZAImage.h"
#include <bps/soundplayer.h>

namespace bbcubezone {

class ZaListDir: public bbcubezone::ZaList {
public:
	ZaListDir();
	char m_path[255];

	ZAImage *m_icon;
	ZAImage *m_icon_epub;
	ZAImage *m_icon_txt;
	ZAImage *m_icon_mp3;
	ZAImage *m_icon_img;
	ZAImage *m_icon_dir;
	ZAImage *m_icon_dir_doc;
	ZAImage *m_icon_dir_camera;
	ZAImage *m_icon_dir_downloads;
	ZAImage *m_icon_dir_music;
	ZAImage *m_icon_dir_photos;
	ZAImage *m_icon_dir_books;
	ZAImage *m_icon_dir_print;
	ZAImage *m_icon_dir_videos;
	std::vector<struct stat *> m_s;
	std::map<string,ZAImage *> m_map;
	void init();
	void drawControl();
	static unsigned long hash(const char *value)
	{
		register unsigned long h;
		register unsigned const char *p;
		for(h = 0, p = (unsigned const char *)value; *p ; p++)
			h = 31 * h + *p;
		return h%1000000;
	}
	void processEvent(ZaEvent * env);
	void changeeDir(const char *p);
	virtual ~ZaListDir();
};

} /* namespace bbcubezone */
#endif /* ZALISTDIR_H_ */
