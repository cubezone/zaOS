/*
 * ZaSliderSwitch.h
 *
 *  Created on: 2012-9-27
 *      Author: Administrator
 */

#ifndef ZaSliderSwitch_H_
#define ZaSliderSwitch_H_

#include "ZaObj.h"
#include "Exception.h"
#include "ZAImage.h"
#include "ZaLabel.h"
#include "ZaTweener.h"


namespace bbcubezone {

class ZaSliderSwitch: public bbcubezone:: ZaObj{
public:
	ZaSliderSwitch();
	void drawControl();
	void setImage(ZAImage *img,ZAImage *dot);
	void processEvent(ZaEvent * env);
	ZAImage * m_dot;
	ZAImage * m_img;
	ZaLabel * m_lb;
	virtual ~ZaSliderSwitch();
};

} /* namespace bbcubezone */
#endif /* ZaSliderSwitch_H_ */
