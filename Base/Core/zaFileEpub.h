/*
 * zaFileEpub.h
 *
 *  Created on: 2012-8-28
 *      Author: Administrator
 */

#ifndef ZAFILEEPUB_H_
#define ZAFILEEPUB_H_
#include "zaAll.h"
#include "zaFile.h"

namespace bbcubezone {


class zaFileEpub: public bbcubezone::zaFile {
public:
	zaFileEpub();
	virtual ~zaFileEpub();

	int openEpub(char * path, const char * epubbook);
	int gotoPage(int n);
	int prePage();
	int nextPage();
	int close();
	int reset();



	void gethtmlpath();

	zaXML m_xml;

	char m_hash[255];
	char m_opf[255];
	char m_ncx[255];
	char m_page[255];
	char m_pathname[255];
	std::string s;
	unsigned int  m_pagecur ;
	int m_pagelen;
	int m_pagepos;
};

} /* namespace bbcubezone */
#endif /* ZAFILEEPUB_H_ */
