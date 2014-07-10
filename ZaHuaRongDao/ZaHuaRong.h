/*
 * ZaButton.h
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#ifndef ZaHuaRong_H_
#define ZaHuaRong_H_

#include "ZaObj.h"
#include "Exception.h"
#include "ZAImage.h"
#include "ZaTweener.h"
#include "bps/soundplayer.h"
#include "ZaResLib.h"

namespace bbcubezone {

class ZaHuaRong: public bbcubezone::ZaObj {
public:
	ZaHuaRong();
	void drawControl();
	void reset();
	void init();
	ZAImage * m_zf;
	ZAImage * m_cc;
	ZAImage * m_zy;
	ZAImage * m_mc;
	ZAImage * m_gy;
	ZAImage * m_hz;
	ZAImage * m_zu1;
	ZAImage * m_zu2;
	ZAImage * m_zu3;
	ZAImage * m_zu4;
	int m_sx;
	int m_sy;
	void processEvent(ZaEvent * env);
	std::vector<ZAImage *> m_v ;
	virtual ~ZaHuaRong();
};

} /* namespace bbcubezone */
#endif /* ZaHuaRong_H_ */
