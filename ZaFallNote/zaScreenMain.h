/*
 * zaScreenMain.h
 *
 *  Created on: 2012-8-25
 *      Author: Administrator
 */

#ifndef ZASCREENMain_H_
#define ZASCREENMain_H_
#include "ZaScreen.h"
#include "soundmanager.h"
#include "ZaMidi.h"
#include "ZaMPG123.h"

namespace bbcubezone {

class zaScreenMain:public ZaScreenBase {
public:
	zaScreenMain();
	ZaButton * m_btn[50] ;
	ZaButton * m_btn_a ;
	ZaButton * m_btn_b ;
	ZaButton * m_btn_c ;
	ZaButton * m_btn_d ;
	ZaButton * m_btn_e ;
	ZaButton * m_btn_f ;
	ZaButton * m_btn_g ;
	ZaMPG123 * m_mp3;

	ZaLabel * m_lab_score ;
	soundmanager sm;
	ZaMidi *m_midi;
	void init();
	void processEvent(ZaEvent *env);
	void addnotes();

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
