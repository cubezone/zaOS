/*
 * ZaListHis.h
 *
 *  Created on: 2012-10-1
 *      Author: Administrator
 */

#ifndef ZaListHis_H_
#define ZaListHis_H_

#include "ZaList.h"
#include "zaMySQL.h"

using namespace std;
namespace bbcubezone {

class ZaListHis: public bbcubezone::ZaList {
public:
	ZaListHis();

	void drawControl();
	void init();
	void removeItem(int id);
	std::vector<string> m_name;
	std::vector<string> m_author;
	std::vector<string> m_lasttime;
	std::vector<string> m_filename;

	std::vector<ZAImage *> m_img;

	ZaTextArea l_txt;
	ZAImage * m_bookbg;
	ZAImage * m_cover_bg;
	virtual ~ZaListHis();
};

} /* namespace bbcubezone */
#endif /* ZaListHis_H_ */
