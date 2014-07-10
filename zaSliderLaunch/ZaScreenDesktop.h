/*
 * ZaScreenDesktop.h
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#ifndef ZaScreenDesktop_H_
#define ZaScreenDesktop_H_
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
#include <bb/system/InvokeAction>
#include <bb/system/InvokeRequest>
#include <bb/system/InvokeManager>
using namespace bb::system;


namespace bbcubezone {

class ZaScreenDesktop: public bbcubezone::ZaScreenBase {

public:

	ZaScreenDesktop();
	void init();

	std::vector<ZaObj *> m_icon;

	void onclick(ZaObj * obj,ZaEvent *env);
	//������������ݵ�ZaScreenDesktop�ļ̳���
	typedef void (ZaScreenDesktop::*PTRFUN2)(ZaObj *,ZaEvent *);
	void callFunc(ZaObj * obj, ZaEvent *env);
	void processEvent(ZaEvent *env);
	void onoff();
	void tweener(int id, float value);
	void addListener(ZaObj * obj , int event,PTRFUN2 func );
	std::map<int,PTRFUN2> m_p;

	virtual ~ZaScreenDesktop();
};


} /* namespace bbcubezone */
#endif /* ZaScreenDesktop_H_ */
