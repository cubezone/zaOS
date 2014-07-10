/*
 * zaDir.h
 *
 *  Created on: 2012-2-19
 *      Author: zhuxy
 */

#include "zaAll.h"

#ifndef ZADIR_H_
#define ZADIR_H_
class zaDir : public zaObj {
public:
	zaDir();
	font_t  * font;
	char m_path[255];

	void disinfo(int l_x,int l_y,int i);
	int m_index ;
	zaFont m_font;
	zaFont m_fonts;
	int render();
	void exec();
	void ppopen();
	int dirlist();
	int dirlist(const char * p);
	void getbootime();
	void porcess(zaWorker * wk);
	char m_output[500][100];
	char m_log[100][100];
	char m_boottime[100];
	char m_lastboottime[100];
	char m_nowtime[100];
	int m_index_log ;
	ZAImage m_0;
	ZAImage m_1;
	ZAImage m_2;
	ZAImage m_3;
	ZAImage m_4;
	ZAImage m_5;
	ZAImage m_6;
	ZAImage m_7;
	ZAImage m_8;
	ZAImage m_9;
	char * getValue(const char *p);
	struct stat m_sb[500];
	virtual ~zaDir();
	int filedesc(const char * filename ,int index);
};

#endif /* ZADIR_H_ */