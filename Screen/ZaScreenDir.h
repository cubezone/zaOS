/*
 * ZaScreenDir.h
 *
 *  Created on: 2012-10-2
 *      Author: Administrator
 */

#ifndef ZASCREENDIR_H_
#define ZASCREENDIR_H_

#include "ZaScreenBase.h"
#include "ZaScreenFlash.h"
#include "ZaListDir.h"
#include "ZaLabel.h"
#include <bps/soundplayer.h>

namespace bbcubezone {

class ZaScreenDir: public bbcubezone::ZaScreenBase {
public:
	ZaScreenDir();
	void init();

	ZaButton *m_back;
	ZAImage *m_head;
	ZaLabel *m_lab;
	ZaListDir * m_dir;

	void processEvent(ZaEvent *env);

	void tweener(int id, float value);
	void onclick(ZaObj * obj,ZaEvent *env);
	typedef void (ZaScreenDir::*PTRFUN)(ZaObj *,ZaEvent *);
	void addListener(ZaObj * obj , int event,PTRFUN func );
	void callFunc(ZaObj * obj,  ZaEvent *env);
	std::map<int,PTRFUN> m_p;

	virtual ~ZaScreenDir();
};

} /* namespace bbcubezone */
#endif /* ZASCREENDIR_H_ */
