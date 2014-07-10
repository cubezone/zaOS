/*
 * ZaScreenFlash.h
 *
 *  Created on: 2012-10-1
 *      Author: Administrator
 */

#ifndef ZASCREENFLASH_H_
#define ZASCREENFLASH_H_

#include "ZaOS/ZaScreenBase.h"

namespace bbcubezone {

class ZaScreenFlash: public bbcubezone::ZaScreenBase {
public:
	static const int NONE = 0;
	static const int LEFT = 1;
	static const int RIGHT = 2;
	static const int UP = 3;
	static const int DOWN = 4;
	static const int ALPHA = 5;
	ZaScreenFlash();
	void init();
	void changeScreen(ZaScreenBase * o,ZaScreenBase * n,ZaScreenBase * target,const char * param, int type);
	typedef void (ZaScreenFlash::*PTRFUNZaScreenFlash)(ZaObj *,ZaEvent *);
	void addListener(ZaObj * obj , int event,PTRFUNZaScreenFlash func ){};
	void callFunc(ZaObj * obj,  ZaEvent *env){};
	std::map<int,PTRFUNZaScreenFlash> m_p;
	virtual ~ZaScreenFlash();
};

} /* namespace bbcubezone */
#endif /* ZASCREENFLASH_H_ */

