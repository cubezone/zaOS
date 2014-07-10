/*
 * ZaScreenBase.h
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#ifndef ZaScreenBase_H_
#define ZaScreenBase_H_
#include <map>
#include <bps/virtualkeyboard.h>
#include <sys/keycodes.h>
#include "ZaObj.h"
#include "ZaButton.h"
#include "ZaSlider.h"
#include "ZaSliderSwitch.h"
#include "ZaList.h"
#include "ZaLabel.h"
#include "DateTime.h"
#include <bps/navigator_invoke.h>



namespace bbcubezone {

class ZaScreenBase: public bbcubezone::ZaObj {

public:

	ZAImage * m_tweenera;
	ZAImage * m_tweenerb;
	ZaScreenBase();
	virtual void init();;

	bool m_init;
	ZaLabel m_loader;
	bool m_showloader;

	//copy below to newscreen

	void drawControl();
	void onclick(ZaObj * obj,ZaEvent *env);

	typedef void (ZaScreenBase::*PTRFUN2)(ZaObj *,ZaEvent *);
	virtual void callFunc(ZaObj * obj, ZaEvent *env);

	void processEvent(ZaEvent *env);
	void addListener(ZaObj * obj , int event,PTRFUN2 func );

	ZAImage * m_bg;

	std::map<int,PTRFUN2> m_p;

	virtual ~ZaScreenBase();
};


} /* namespace bbcubezone */
#endif /* ZaScreenBase_H_ */
