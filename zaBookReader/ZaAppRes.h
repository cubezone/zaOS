/*
 * ZaAppRes.h
 *
 *  Created on: 2012-11-19
 *      Author: Administrator
 */

#ifndef ZAAPPRES_H_
#define ZAAPPRES_H_

#include "ZaScreenLoader.h"
#include "ZaScreen.h"
#include "ZaScreenFlash.h"
#include "ZaScreenMain.h"
#include "ZaScreenDir.h"
#include "ZaScreenRead.h"
#include "ZaScreenCatalog.h"
#include "ZaScreenHis.h"
#include "ZaScreenWindMill.h"
#include "ZaScreenDict.h"
#include "ZaScreenStart.h"
#include "ZaScreenDesktop.h"

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
