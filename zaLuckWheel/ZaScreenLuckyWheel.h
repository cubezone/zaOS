/*
 * ZaScreenBase.h
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#ifndef ZaScreenLuckyWheel_H_
#define ZaScreenLuckyWheel_H_
#include <map>
#include "ZaObj.h"
#include "ZaButton.h"
#include "ZaSlider.h"
#include "ZaSliderSwitch.h"
#include "ZaList.h"
#include "ZaLabel.h"
#include "DateTime.h"
//#include "ZaLuckyWheel.h"
#include "ZaScreenBase.h"


namespace bbcubezone {

class ZaScreenLuckyWheel : public bbcubezone::ZaScreenBase {

public:

	ZaScreenLuckyWheel();
	void init();

	ZaButton * m_btn_start;
	ZaButton * m_btn_stop;
	ZAImage * m_boll;
	ZAImage * m_disk;

	void drawControl();
	void onclick(ZaObj * obj,ZaEvent *env);
	//������������ݵ�ZaScreenBase�ļ̳���
	typedef void (ZaScreenLuckyWheel::*PTRFUN2)(ZaObj *,ZaEvent *);
	void callFunc(ZaObj * obj, ZaEvent *env);
	void processEvent(ZaEvent *env);
	void addListener(ZaObj * obj , int event,PTRFUN2 func );
	ZaMp3 *m_mp3_s;
	ZaMp3 *m_mp3_e;

	std::map<int,PTRFUN2> m_p;

	virtual ~ZaScreenLuckyWheel();
};


} /* namespace bbcubezone */
#endif /* ZaScreenBase_H_ */
