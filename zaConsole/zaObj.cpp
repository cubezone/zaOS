/*
 * zaObj.cpp
 *
 *  Created on: 2012-2-19
 *      Author: zhuxy
 */

#include "zaObj.h"

zaObj::zaObj() {
	// TODO Auto-generated constructor stub

}

void zaObj::render()
{
	std::vector<ZAImage>::iterator iter;

	for (iter = m_v.begin();iter != m_v.end();iter++)
	{
		iter->RunImg();
	}
}

void zaObj::porcess(zaWorker * wk)
{
	m_y += wk->m_y - wk->m_oy;
}

void zaObj::move()
{
	std::vector<ZAImage>::iterator iter;
	if (m_d>0)
	{
		if (m_d > 20)
				m_d -=2;
			else
				m_d = 5;
	}
	else if (m_d<0)
	{
		if (m_d < -20)
				m_d +=2;
		else
				m_d = -5;
	}

	if (m_d!= 0)
	{
		if ( m_v.at(0).m_x +  m_x - m_ox < 312 &&
				m_v.at(0).m_x +  m_x - m_ox > - m_ll)
		{
				for (iter = m_v.begin();iter != m_v.end();iter++)
				{
					iter->m_x += m_d;
					if (abs(iter->m_x-512)>512)
						iter->m_alpha = 0.0f;
					else if (abs(iter->m_x-512)>200)
						iter->m_alpha = 1.0f- (float)(abs(iter->m_x-512)-200)/312;
					else
						iter->m_alpha = 1.0f;
				}
			}
			else
			{
				m_d =0;
			}
		}

		if (m_d != 0)
		{
//			render();
			m_event = false;
		}
}
zaObj::~zaObj() {
	// TODO Auto-generated destructor stub
}

