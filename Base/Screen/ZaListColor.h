/*
 * ZaListColor.h
 *
 *  Created on: 2012-10-2
 *      Author: Administrator
 */

#ifndef ZaListColor_H_
#define ZaListColor_H_

#include "ZaList.h"
#include "ZAImage.h"
#include "ZaResLib.h"
#include <bps/soundplayer.h>

namespace bbcubezone {


class ZaListColor: public bbcubezone::ZaList {
struct color_str
{
	uint bg;
	uint color_font;
	uint color_font1;
	uint color_font2;
};
public:
	ZaListColor();

	int  init(const char * lang);
	std::vector<struct color_str *> m_v_color;
	void drawControl();

	virtual ~ZaListColor();
};

} /* namespace bbcubezone */
#endif /* ZaListColor_H_ */
