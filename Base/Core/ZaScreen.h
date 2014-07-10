/*
 * ZaScreen.h
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#ifndef ZASCREEN_H_
#define ZASCREEN_H_
#include <map>
#include "ZaObj.h"
#include "ZaButton.h"
#include "ZaSlider.h"
#include "ZaList.h"
#include "ZaScreenBase.h"
#include "ZaScreenFlash.h"

namespace bbcubezone {

class ZaScreen: public bbcubezone::ZaScreenBase {
public:
	ZaButton * m_btn_a ;
	ZaButton * m_btn_b ;
	ZaButton * m_btn_c ;
	ZaButton * m_btn_d ;

	ZaSlider * m_sld_a ;
	ZaSlider * m_sld_b ;

	ZaLabel * m_lab_a ;

	ZaList * m_lst_a ;

	ZAImage * m_img;

	ZAImage * m_pic;
	ZAImage * m_pic2;


	ZaScreen();
	void init();
	void onclick(ZaObj * obj,ZaEvent *env);
	bool m_go;
	void tweener(int id, float value);


	typedef void (ZaScreen::*PTRFUNZaScreen)(ZaObj *,ZaEvent *);
	void addListener(ZaObj * obj , int event,PTRFUNZaScreen func );
	void callFunc(ZaObj * obj,  ZaEvent *env);
	std::map<int,PTRFUNZaScreen> m_p;

	virtual ~ZaScreen();
};


} /* namespace bbcubezone */
#endif /* ZASCREEN_H_ */
