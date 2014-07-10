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
	bool m_file;
	void disinfo(int l_x,int l_y,int i);
	int m_index ;
	int render();
	void exec();
	void ppopen();
	int dirlist();
	int dirlist(const char * p);
	void porcess(zaWorker * wk);
	char m_output[500][100];
	char m_log[100][100];
	int m_index_log ;
	struct stat m_sb[500];
	virtual ~zaDir();
	int filedesc(const char * filename ,int index);
};

#endif /* ZADIR_H_ */
