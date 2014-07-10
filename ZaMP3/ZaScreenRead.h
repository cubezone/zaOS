/*
 * ZaScreenRead.h
 *
 *  Created on: 2012-10-2
 *      Author: Administrator
 */

#ifndef ZASCREENREAD_H_
#define ZASCREENREAD_H_

#include "ZaScreenBase.h"
#include "ZaScreenFlash.h"
#include "ZaRichText.h"
#include "ZaListLang.h"
#include "ZaListFont.h"
#include "ZaInputText.h"
#include "ZaDict.h"
#include "ZaScroller.h"


namespace bbcubezone {

class ZaScreenRead: public bbcubezone::ZaScreenBase {
public:
	ZaScreenRead();
	void init();
	ZaRichText*  m_rt;
	ZaButton *m_font_i;
	ZaButton *m_copy;
	ZaButton *m_font_d;
	ZaButton *m_font_conf;
	ZaButton *m_catalog;
	ZaButton *m_the_me;
	ZaButton *m_dict;
	ZaButton *m_back;
	ZAImage *m_head;
	ZAImage *m_foot;

	ZAImage *m_font_bg;

	ZaSlider * m_sld_a;
	ZaListLang *m_lst_lang;
	ZaListFont *m_lst_font;

	ZaInputText *m_input;
	ZaLabel *m_lab;
	ZaDict *m_dictionary;
	ZaScroller *m_scroll;
	ZaButton *m_delete;

	void loading();

	void menu();
	void processEvent(ZaEvent *env);
	void recHis();
	void tweener(int id, float value);
	typedef void (ZaScreenRead::*PTRFUNZaScreenReader)(ZaObj *,ZaEvent *);
	void addListener(ZaObj * obj , int event,PTRFUNZaScreenReader func );
	void callFunc(ZaObj * obj,  ZaEvent *env);
	std::map<int,PTRFUNZaScreenReader> m_p;
	void onclick(ZaObj * obj,ZaEvent *env);


	virtual ~ZaScreenRead();
};

} /* namespace bbcubezone */
#endif /* ZASCREENREAD_H_ */
