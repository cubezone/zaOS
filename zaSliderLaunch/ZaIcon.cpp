/*
 * ZaIcon.cpp
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#include "ZaIcon.h"

namespace bbcubezone {

ZaIcon::ZaIcon() {
	// TODO Auto-generated constructor stub

}
void ZaIcon::drawControl()
{
	int a = m_x, b= m_y;
	getClientXY(a,b);
	ZaResLib::getInstance()->m_jpg->setXY(a,b);
	ZaResLib::getInstance()->m_jpg->m_height = m_height;
	ZaResLib::getInstance()->m_jpg->m_width = m_width;
	ZaResLib::getInstance()->m_jpg->DrawImg();
	fprintf(stderr,"ZaIcon drawControl %p %d %d alpha %f\n",this,a, b ,m_alpha);
}


ZaIcon::~ZaIcon() {
	// TODO Auto-generated destructor stub
}

} /* namespace bbcubezone */
