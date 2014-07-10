/*
 * ZaLabel.cpp
 *
 *  Created on: 2012-9-27
 *      Author: Administrator
 */

#include "ZaLabel.h"

namespace bbcubezone {

ZaLabel::ZaLabel() {
	// TODO Auto-generated constructor stub

}
void ZaLabel::drawControl()
{
	int a = m_x, b= m_y;
	getClientXY(a,b);

		zaFont *l_f=ZaResLib::getInstance()->m_font;

		if ( l_f->m_size < m_fontsize)
		{
			l_f=ZaResLib::getInstance()->m_font_en_m;
			if ( l_f->m_size < m_fontsize)
			{
				l_f=ZaResLib::getInstance()->m_font_en_l;
			}
		}
		l_f->setcolor(m_r,m_g,m_b,m_a);
	m_height = l_f->render_text(m_text.c_str(),0,a,b,"UTF-8",m_width);
}

ZaLabel::~ZaLabel() {
	// TODO Auto-generated destructor stub
}

} /* namespace bbcubezone */
