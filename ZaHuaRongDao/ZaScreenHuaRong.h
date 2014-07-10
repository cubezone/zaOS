/*
 * ZaScreenBase.h
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#ifndef ZaScreenHuaRong_H_
#define ZaScreenHuaRong_H_

#include "ZaHuaRong.h"
#include "ZaButton.h"
#include "ZaScreenBase.h"

namespace bbcubezone {

class ZaScreenHuaRong : public bbcubezone::ZaScreenBase {

public:

	ZaScreenHuaRong();
	void init();;

	void onclick(ZaObj * obj,ZaEvent *env);
	//复制 ZaScreenBase的内容
	typedef void (ZaScreenHuaRong::*PTRFUN2)(ZaObj *,ZaEvent *);
	virtual void callFunc(ZaObj * obj, ZaEvent *env);
	void processEvent(ZaEvent *env);
	void addListener(ZaObj * obj , int event,PTRFUN2 func );

	//ZAImage * m_bg;
	ZaHuaRong * m_hr;

	ZaButton * m_btn_reset;

	std::map<int,PTRFUN2> m_p;

	virtual ~ZaScreenHuaRong();
};


} /* namespace bbcubezone */
#endif /* ZaScreenBase_H_ */
