/*
 * zaFileText.h
 *
 *  Created on: 2012-8-28
 *      Author: Administrator
 */

#ifndef ZAFILETEXT_H_
#define ZAFILETEXT_H_

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/io.h>
#include <vector>
#include <iconv.h>
#include <sys\stat.h>
#include "zaFileEpub.h"
#include "zaFile.h"


namespace bbcubezone {

class zaFileText: public bbcubezone::zaFile {
public:
	zaFileText();

	virtual ~zaFileText();

	//file name
	char m_filename[255];

	//handle of file
	FILE * m_fh;

	//当前的文件指针.
	int m_filepos;

	//file size
	int m_size;

	bool m_first;

	char m_hash[110];

#define FILETYPE_TXT  0
#define FILETYPE_HTML 1
	//file type
	// 0 txt;
	// 1 html;
	int m_filetype;

	// char count of current page.
	int m_pagesize;

	int m_height;

	//content of current page.
	char * m_contents[3000];
	//int  m_contents_len[3000];
	char  m_charset[100];

	char * m_content;
	//page len;
	int m_contentlen;

	char m_encode[100];

	int openfile(char * fn);
	void UTF16file(char * inf,char *outf, char * decode);
	void resetcnt();

	int m_segno ;
	int m_segnomax ;

	static unsigned long hash(const char *value)
	{
		register unsigned long h;
		register unsigned const char *p;
		for(h = 0, p = (unsigned const char *)value; *p ; p++)
			h = 31 * h + *p;
		return h%1000000;
	}
	zaFileEpub m_epub;


	char * fname( char * fn);
	char m_fn[255];

	int nextseg();
	int getEncode(char * fn);
	int getEncodeUTF16(char *fn);
	int readseg(int dict);
	int readword(char * buf);
	int readchar(char * buf);
	int preseg();

	std::vector<char *> m_v;
};

} /* namespace bbcubezone */
#endif /* ZAFILETEXT_H_ */
