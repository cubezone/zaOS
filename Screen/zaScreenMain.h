/*
 * zaScreenMain.h
 *
 *  Created on: 2012-8-25
 *      Author: Administrator
 */

#ifndef ZASCREENMain_H_
#define ZASCREENMain_H_
#include "ZaScreen.h"

namespace bbcubezone {

class zaScreenMain:public ZaScreenBase {
public:
	zaScreenMain();
	ZaButton * m_btn_a ;
	ZaButton * m_btn_b ;
	void init();
	void processEvent(ZaEvent *env);

	void tweener(int id, float value);
	void onclick(ZaObj * obj,ZaEvent *env);
	typedef void (zaScreenMain::*PTRFUNZaScreenMain)(ZaObj *,ZaEvent *);
	void addListener(ZaObj * obj , int event,PTRFUNZaScreenMain func );
	void callFunc(ZaObj * obj,  ZaEvent *env);
	std::map<int,PTRFUNZaScreenMain> m_p;

	virtual ~zaScreenMain();
};

} /* namespace bbcubezone */
#endif /* ZASCREENMain_H_ */
