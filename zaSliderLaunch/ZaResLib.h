/*
 * ZaResLib.h
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#ifndef ZARESLIB_H_
#define ZARESLIB_H_
#include <vector>
#include <string>
#include <map>
#include "ZaObj.h"
#include "ZaMp3.h"
#include "ZAImage.h"
#include "zaFont.h"
#include "ZaIcon.h"
#include "ZaDict.h"


namespace bbcubezone {

class ZaResLib {
public:
//	static const int SCREEN_DIR = 1;
//	static const int SCREEN_FLASH = 1;
//	static const int SCREEN_READ = 1;
//	static const int SCREEN_HIS = 1;
//	static const int SCREEN_Catalog = 1;
	ZaResLib();
	static ZaResLib *m_reslib;
	static ZaResLib * getInstance();
	ZAImage *m_jpg;
	ZaObj * getOjb(int id);
	void addScreen(string name,ZaObj * src);
	ZaObj * getScreen(string name);
	ZaDict * getDict();
	std::vector<ZaObj*> m_v;
	std::map<string,ZaObj *> m_map;

	ZaMp3 * m_mp3;

	zaFont * m_font;

	zaFont * m_font_en;
	zaFont * m_font_en_m;
	zaFont * m_font_en_l;

	zaFont * m_font_rt;
	ZaDict * m_dict;
	ZaObj *m_active;
	ZaObj *m_next;
	virtual ~ZaResLib();
};

} /* namespace bbcubezone */
#endif /* ZARESLIB_H_ */
