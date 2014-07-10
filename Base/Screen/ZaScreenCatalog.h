/*
 * ZaScreenCatalog.h
 *
 *  Created on: 2012-10-1
 *      Author: Administrator
 */

#ifndef ZaScreenCatalog_H_
#define ZaScreenCatalog_H_

#include "zaMySQL.h"
#include "ZaScreenBase.h"
#include "ZaScreenFlash.h"
#include "ZaList.h"

namespace bbcubezone {

class ZaScreenCatalog: public bbcubezone::ZaScreenBase {
public:
	ZaScreenCatalog();
	void init();
	ZaList * m_list;

	void processEvent(ZaEvent *env);
	void onclick(ZaObj * obj,ZaEvent *env);

	void tweener(int id, float value);
	typedef void (ZaScreenCatalog::*PTRFUNZaScreenCatalog)(ZaObj *,ZaEvent *);
	void addListener(ZaObj * obj , int event,PTRFUNZaScreenCatalog func );
	void callFunc(ZaObj * obj,  ZaEvent *env);
	std::map<int,PTRFUNZaScreenCatalog> m_p;
	std::vector<string> m_link;
	virtual ~ZaScreenCatalog();
};

} /* namespace bbcubezone */
#endif /* ZaScreenCatalog_H_ */
