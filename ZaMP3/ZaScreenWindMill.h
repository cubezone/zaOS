/*
 * ZaScreenBase.h
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#ifndef ZaScreenWindMill_H_
#define ZaScreenWindMill_H_
#include <map>
#include "ZaObj.h"
#include "ZaButton.h"
#include "ZaSlider.h"
#include "ZaSliderSwitch.h"
#include "ZaList.h"
#include "ZaLabel.h"
#include "DateTime.h"
#include "ZaWindMill.h"
#include "ZaScreenBase.h"


namespace bbcubezone {

class ZaScreenWindMill : public bbcubezone::ZaScreenBase {

public:

	ZaScreenWindMill();
	virtual void init();;


	void onclick(ZaObj * obj,ZaEvent *env);
	//������������ݵ�ZaScreenBase�ļ̳���
	typedef void (ZaScreenWindMill::*PTRFUN2)(ZaObj *,ZaEvent *);
	virtual void callFunc(ZaObj * obj, ZaEvent *env);
	void processEvent(ZaEvent *env);
	void addListener(ZaObj * obj , int event,PTRFUN2 func );

	//ZAImage * m_bg;
	ZaWindMill * m_wm;

	std::map<int,PTRFUN2> m_p;

	virtual ~ZaScreenWindMill();
};


} /* namespace bbcubezone */
#endif /* ZaScreenBase_H_ */
