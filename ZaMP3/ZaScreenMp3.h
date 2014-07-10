/*
 * ZaScreenMp3.h
 *
 *  Created on: 2012-8-25
 *      Author: Administrator
 */

#ifndef ZaScreenMp3_H_
#define ZaScreenMp3_H_
#include "ZaOS/ZaScreen.h"
#include "ZaMPG123.h"

namespace bbcubezone {

class ZaScreenMp3:public ZaScreenBase {
public:
	ZaScreenMp3();
	ZaButton * m_btn_a ;
	ZaButton * m_btn_b ;
	ZaMPG123 m_mp3;
	void init();
	void processEvent(ZaEvent *env);

	void tweener(int id, float value);
	void onclick(ZaObj * obj,ZaEvent *env);
	typedef void (ZaScreenMp3::*PTRFUNZaScreenMp3)(ZaObj *,ZaEvent *);
	void addListener(ZaObj * obj , int event,PTRFUNZaScreenMp3 func );
	void callFunc(ZaObj * obj,  ZaEvent *env);
	std::map<int,PTRFUNZaScreenMp3> m_p;

	virtual ~ZaScreenMp3();
};

} /* namespace bbcubezone */
#endif /* ZaScreenMp3_H_ */
