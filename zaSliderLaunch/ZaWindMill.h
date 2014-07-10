/*
 * ZaButton.h
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#ifndef ZaWindMill_H_
#define ZaWindMill_H_

#include "ZaObj.h"
#include "Exception.h"
#include "ZAImage.h"
#include "ZaTweener.h"
#include "bps/soundplayer.h"
#include "ZaResLib.h"

namespace bbcubezone {

class ZaWindMill: public bbcubezone::ZaObj {
public:
	ZaWindMill();
	void drawControl();
	void processEvent(ZaEvent * env);
	std::vector<ZAImage *> m_v ;
	virtual ~ZaWindMill();
};

} /* namespace bbcubezone */
#endif /* ZaWindMill_H_ */
