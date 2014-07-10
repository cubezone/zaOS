/*
 * zaFont.h
 *
 *  Created on: 2012-2-19
 *      Author: zhuxy
 */

#include "zaAll.h"

#ifndef ZAFONT_H_
#define ZAFONT_H_

class zaFont {
public:
	zaFont();
	screen_context_t screen_cxt;
	font_t* font;
	virtual ~zaFont();
};

#endif /* ZAFONT_H_ */
