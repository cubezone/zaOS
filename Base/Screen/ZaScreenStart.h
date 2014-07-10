/*
 * ZaScreenStart.h
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#ifndef ZaScreenStart_H_
#define ZaScreenStart_H_
#include <map>
#include "ZaObj.h"
#include "ZaButton.h"
#include "ZaSlider.h"
#include "ZaSliderSwitch.h"
#include "ZaList.h"
#include "ZaLabel.h"
#include "DateTime.h"
#include "ZaMp3.h"
#include "ZaScreenFlash.h"
#include <bps/navigator.h>

namespace bbcubezone {

class ZaScreenStart: public bbcubezone::ZaScreenBase {

public:

	ZaScreenStart();
	void init();

	ZaSliderSwitch * m_sld_c;
	ZAImage * m_head;

	ZaLabel * m_lab_date;
	ZaLabel * m_lab_time;
	CDateTime m_dt;

	void onclick(ZaObj * obj,ZaEvent *env);
	//������������ݵ�ZaScreenStart�ļ̳���
	typedef void (ZaScreenStart::*PTRFUN2)(ZaObj *,ZaEvent *);
	void callFunc(ZaObj * obj, ZaEvent *env);
	void processEvent(ZaEvent *env);
	void onoff();
	void tweener(int id, float value);
	void addListener(ZaObj * obj , int event,PTRFUN2 func );
	std::map<int,PTRFUN2> m_p;

	virtual ~ZaScreenStart();
};


} /* namespace bbcubezone */
#endif /* ZaScreenStart_H_ */
