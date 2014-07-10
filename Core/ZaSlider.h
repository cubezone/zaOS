/*
 * ZaSlider.h
 *
 *  Created on: 2012-9-27
 *      Author: Administrator
 */

#ifndef ZASLIDER_H_
#define ZASLIDER_H_

#include "ZaObj.h"
#include "Exception.h"
#include "ZAImage.h"

#include "ZaTweener.h"
#include "ZaLabel.h"

namespace bbcubezone {

class ZaSlider: public bbcubezone::ZaObj {

public:
	ZaSlider();
	void drawControl();
	void setImage(ZAImage *img,ZAImage *dot);
	void processEvent(ZaEvent * env);
	ZAImage * m_dot;
	ZAImage * m_img;
	ZaLabel * m_lb;
	virtual ~ZaSlider();

};

} /* namespace bbcubezone */
#endif /* ZASLIDER_H_ */
