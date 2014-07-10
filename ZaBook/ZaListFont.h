/*
 * ZaListFont.h
 *
 *  Created on: 2012-10-2
 *      Author: Administrator
 */

#ifndef ZaListFont_H_
#define ZaListFont_H_

#include "ZaList.h"
#include "ZAImage.h"
#include "ZaResLib.h"
#include <bps/soundplayer.h>

namespace bbcubezone {

class ZaListFont: public bbcubezone::ZaList {
public:
	ZaListFont();

	int  init(const char * lang);
	std::vector<string> m_path;

	virtual ~ZaListFont();
};

} /* namespace bbcubezone */
#endif /* ZaListFont_H_ */
