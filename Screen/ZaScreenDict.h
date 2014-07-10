/*
 * ZaScreenDict.h
 *
 *  Created on: 2012-10-1
 *      Author: Administrator
 */

#ifndef ZaScreenDict_H_
#define ZaScreenDict_H_


#include <bps/soundplayer.h>
#include <clipboard/clipboard.h>
#include "ZaScreenBase.h"
#include "ZaScreenFlash.h"
#include "ZaList.h"
#include "ZaInputText.h"
#include "ZaDict.h"
#include "ZaScroller.h"
#include "ZaTextArea.h"


#include "zaMySQL.h"
#include <algorithm>
#include <functional>

namespace bbcubezone {

class ZaScreenDict: public bbcubezone::ZaScreenBase {
public:
	ZaScreenDict();
	void init();
	ZaLabel m_loader;
	//ZaList * m_list;
	ZaInputText *m_input;
	ZaTextArea *m_lab;
	ZaDict *m_dict;
	ZaScroller *m_scroll;
	ZaButton *m_back;
	ZaButton *m_paste;
	ZaButton *m_copy;
	ZaList * m_list;

	void processEvent(ZaEvent *env);
	void onclick(ZaObj * obj,ZaEvent *env);
	void drawControl();
	void tweener(int id, float value);
	typedef void (ZaScreenDict::*PTRFUNZaScreenDict)(ZaObj *,ZaEvent *);
	void addListener(ZaObj * obj , int event,PTRFUNZaScreenDict func );
	void callFunc(ZaObj * obj,  ZaEvent *env);
	std::map<int,PTRFUNZaScreenDict> m_p;
	std::vector<string> m_link;
	virtual ~ZaScreenDict();
};

} /* namespace bbcubezone */
#endif /* ZaScreenDict_H_ */
