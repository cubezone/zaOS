/*
 * ZaAppRes.h
 *
 *  Created on: 2012-11-19
 *      Author: Administrator
 */

#ifndef ZAAPPRES_H_
#define ZAAPPRES_H_

#include "ZaScreenLoader.h"
#include "ZaScreenBase.h"
#include "ZaScreenFlash.h"
#include "ZaScreenHuaRong.h"

namespace bbcubezone
{

class ZaAppRes: public bbcubezone::ZaScreenLoader
{
public:
	ZaAppRes();
	ZaScreenBase * LoadScreen(string scrname,int w,int h);
	virtual ~ZaAppRes();
};

} /* namespace bbcubezone */
#endif /* ZAAPPRES_H_ */
