/*
 * zaFont.cpp
 *
 *  Created on: 2012-2-19
 *      Author: zhuxy
 */

#include "zaFont.h"

zaFont::zaFont() {
	// TODO Auto-generated constructor stub

		int dpi = bbutil_calculate_dpi(screen_cxt);
		font = bbutil_load_font(
		//"/usr/fonts/font_repository/adobe/MyriadPro-Bold.otf", 8, dpi);
		"/usr/fonts/font_repository/dejavu-ttf-2.17/DejaVuSans.ttf", 7, dpi);
		//"/usr/fonts/font_repository/dejavu-ttf-2.17/DejaVuSans.ttf", 8, dpi);
}

zaFont::~zaFont() {
	// TODO Auto-generated destructor stub
}

