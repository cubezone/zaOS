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
#include "ZaScreenBase.h"
#include "ZaScreenLoader.h"

namespace bbcubezone {

class ZaResLib {
public:
//	static const int SCREEN_DIR = 1;
//	static const int SCREEN_FLASH = 1;
//	static const int SCREEN_READ = 1;
//	static const int SCREEN_HIS = 1;
//	static const int SCREEN_Catalog = 1;
	ZaResLib();
	static ZaResLib * m_reslib;
	static int m_charnum;
	static ZaResLib * getInstance();
	void init();
	ZAImage *m_jpg;
	ZaObj * getOjb(int id);
	void addScreen(string name,ZaObj * src);
	ZaScreenLoader * m_srcloader;
	ZaObj * getScreen(string name);
	ZaDict * getDict();
	std::vector<ZaObj*> m_v;
	std::map<string,ZaObj *> m_map;

	ZaMp3 * m_mp3;

	zaFont * m_font;
	int m_screenwidth;
	int m_screenheight;

	static const int PLAYBOOK = 0;
	static const int BB10 = 1;

	int m_device;
	zaFont * m_font_en;
	zaFont * m_font_en_m;
	zaFont * m_font_en_l;

	zaFont * m_font_rt;
	zaFont * m_font_bbui;
	ZaDict * m_dict;
	ZaObj *	 m_active;
	ZaObj *	 m_next;
	virtual ~ZaResLib();
};

} /* namespace bbcubezone */
#endif /* ZARESLIB_H_ */
