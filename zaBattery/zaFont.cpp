/*
 * zaFont.cpp
 *
 *  Created on: 2012-2-19
 *      Author: zhuxy
 */

#include "zaFont.h"

zaFont::zaFont() {
	// TODO Auto-generated constructor stub


}

void zaFont::init(const char * path ,int size)
{
	int dpi = bbutil_calculate_dpi(screen_cxt);
	if (path ==NULL)
	font = bbutil_load_font(
		//"/usr/fonts/font_repository/adobe/AdobeMingStd-Light.otf", 8, dpi);
		//"app/native/res/TungusFont_Tinet.ttf", size, dpi);
	   //"/usr/fonts/font_repository/dejavu-ttf-2.17/DejaVuSerif.ttf", size, dpi);
		"/usr/fonts/font_repository/monotype/SlatePro.ttf",size,dpi);
		//"/usr/fonts/font_repository/adobe/MyriadPro-Bold.otf", size, dpi);
	else
	 font = bbutil_load_font(
		//"/usr/fonts/font_repository/adobe/MyriadPro-Bold.otf", 8, dpi);
			path, size, dpi);

}

zaFont::~zaFont() {
	// TODO Auto-generated destructor stub
}

