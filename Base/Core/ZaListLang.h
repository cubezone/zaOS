/*
 * ZaListLang.h
 *
 *  Created on: 2012-10-2
 *      Author: Administrator
 */

#ifndef ZaListLang_H_
#define ZaListLang_H_

#include "ZaList.h"
#include "ZAImage.h"

#include <bps/soundplayer.h>

namespace bbcubezone {

class ZaListLang: public bbcubezone::ZaList {
public:
	ZaListLang();

	void init();
	std::vector<string> m_lang;

	virtual ~ZaListLang();
};

} /* namespace bbcubezone */
#endif /* ZaListLang_H_ */
