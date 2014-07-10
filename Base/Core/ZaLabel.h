/*
 * ZaLabel.h
 *
 *  Created on: 2012-9-27
 *      Author: Administrator
 */

#ifndef ZALABEL_H_
#define ZALABEL_H_
#include <string>
#include "ZaObj.h"
#include "ZaResLib.h"

namespace bbcubezone {

class ZaLabel: public bbcubezone::ZaObj {
public:
	ZaLabel();
	void drawControl();
	inline void setfont(float r,float g, float b, float a, int size){
		m_r = r;
		m_g  = g;
		m_b = b;
		m_a = a;
		m_fontsize = size;
	}
	float m_r, m_g ,m_b,m_a;
	int m_fontsize;
	std::string m_text;
	virtual ~ZaLabel();
};

} /* namespace bbcubezone */
#endif /* ZALABEL_H_ */
