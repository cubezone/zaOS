/*
 * ZaAppRes.cpp
 *
 *  Created on: 2012-11-19
 *      Author: Administrator
 */

#include "ZaAppRes.h"

namespace bbcubezone
{

ZaAppRes::ZaAppRes()
{
	// TODO Auto-generated constructor stub

}

ZaScreenBase * ZaAppRes::LoadScreen(string scrname, int w, int h)
{
	ZaScreenBase * l_main = NULL;
	if (scrname == "ZaScreenFlash")
	{
		l_main = new ZaScreenFlash();
		l_main->setSize(0, 0, w, h);
		l_main->init();
	}
	else if (scrname == "ZaScreenLuckyWheel")
	{
		l_main = new ZaScreenLuckyWheel();
		l_main->setSize(0, 0, w, h);
		l_main->init();
	}

	return l_main;
}

ZaAppRes::~ZaAppRes()
{
// TODO Auto-generated destructor stub
}

} /* namespace bbcubezone */
