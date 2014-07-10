/*
 * zaXML.h
 *
 *  Created on: 2012-8-24
 *      Author: Administrator
 */

#ifndef ZAXML_H_
#define ZAXML_H_
#include <libxml/parser.h>
#include <libxml/tree.h>
#include <unistd.h>
#include "zaAll.h"

namespace bbcubezone {

typedef struct act
{
	int time;
	int y;
	int x;
	int type;
} cc;

class zaXML {
public:
	zaXML();

	int m_n;
	cc m_s[10];
	virtual ~zaXML();
	char m_num;
	int m_sn;
	int m_now; //current time;
	int m_cur; // current num index;

	int xmlexplorer (char *name);
	int addaction(int time,int x, int y);
	int loadaction(int sn,int x, int y);
	int xmlwrite(char *name);
	void dump();
	int loadfromdb();

	char m_path[255];
	char m_opf[255];
	char m_ncx[255];

	char m_coverimg[255];
	char m_docname[255];
	char m_docauthor[255];

	std::vector<char *> m_page_labels ;
	//std::vector<char *> m_pages ;

	struct manifest_str
	{
		string id;
		string href;
		string mediatype;
	};

	std::vector<manifest_str> m_manifest ;
	std::vector<string> m_spine ;

	struct navMap_str
	{
			string navlabel;
			string href;
	};

	std::vector<navMap_str> m_navmap ;

	struct bookspages_str
	{
			string id;
			string href;
			string navlabel;
	};
	std::vector<bookspages_str> m_pages ;

	int getNcx();
	int getOPF();
	int getlink();
	void buildpages();

};

} /* namespace bbcubezone */
#endif /* ZAXML_H_ */
