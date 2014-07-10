/*
 * ZaIcon.h
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#ifndef ZAICON_H_
#define ZAICON_H_


#include "ZaObj.h"
#include "ZaResLib.h"

namespace bbcubezone {

class ZaIcon: public bbcubezone::ZaObj {
public:
	ZaIcon();
	void drawControl();
	virtual ~ZaIcon();
};

} /* namespace bbcubezone */
#endif /* ZAICON_H_ */
