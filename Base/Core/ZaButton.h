/*
 * ZaButton.h
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#ifndef ZABUTTON_H_
#define ZABUTTON_H_

#include "ZaObj.h"
#include "Exception.h"
#include "ZAImage.h"
#include "ZaTweener.h"
#include "ZaResLib.h"

namespace bbcubezone {

class ZaButton: public bbcubezone::ZaObj {
public:
	ZaButton();
	void drawControl();
	void processEvent(ZaEvent * env);
	void setImage(ZAImage *img);
	ZaObj * m_fog;
	ZAImage * m_img;
	virtual ~ZaButton();
};

} /* namespace bbcubezone */
#endif /* ZABUTTON_H_ */
