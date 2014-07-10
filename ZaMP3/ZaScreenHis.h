/*
 * ZaScreenHis.h
 *
 *  Created on: 2012-10-1
 *      Author: Administrator
 */

#ifndef ZaScreenHis_H_
#define ZaScreenHis_H_

#include "zaMySQL.h"
#include "ZaScreenBase.h"
#include "ZaScreenFlash.h"
#include "ZaListHis.h"
#include "ZaTextArea.h"

namespace bbcubezone {

class ZaScreenHis: public bbcubezone::ZaScreenBase {
public:
	ZaScreenHis();
	void init();
	ZaListHis * m_list;
	ZaButton *m_dir;
	ZaButton *m_mail;
	ZaTextArea *m_textarea;

	void processEvent(ZaEvent *env);
	void onclick(ZaObj * obj,ZaEvent *env);

	void tweener(int id, float value);
	typedef void (ZaScreenHis::*PTRFUNZaScreenHis)(ZaObj *,ZaEvent *);
	void addListener(ZaObj * obj , int event,PTRFUNZaScreenHis func );
	void callFunc(ZaObj * obj,  ZaEvent *env);
	std::map<int,PTRFUNZaScreenHis> m_p;

	virtual ~ZaScreenHis();
};

} /* namespace bbcubezone */
#endif /* ZaScreenHis_H_ */
