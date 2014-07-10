/*
 * ZaScroller.cpp
 *
 *  Created on: 2012-10-1
 *      Author: Administrator
 */

#include "ZaScroller.h"

namespace bbcubezone
{

ZaScroller::ZaScroller()
{
	// TODO Auto-generated constructor stub
	m_style = 0;
}

void ZaScroller::drawControl()
{
	int a = m_x, b = m_y;
	getClientXY(a, b);
	glEnable(GL_SCISSOR_TEST);
	glScissor(a, b, m_width, m_height);
	for(int i = 0 ; i< m_v.size(); i++)
	{
		m_v[i]->m_y += m_top;
		m_v[i]->draw();
		m_v[i]->m_y -= m_top;
	};
	glDisable(GL_SCISSOR_TEST);
	fprintf(stderr,"ZaScroller::drowcontrol %p %d %d %d %d\n",this,a, b,m_width,m_height);
}

int ZaScroller::setSize(int x, int y, int w, int h)
{
	ZaObj::setSize(x, y, w, h);
	m_top = 0;
	return 1;
}

// child will post every event to its parent Scroller.
void ZaScroller::AddChild(ZaObj * obj)
{
	m_v.push_back(obj);
	obj->m_parent = this;
	obj->m_postparent = true;
}

void ZaScroller::processEvent(ZaEvent * env)
{
	static int o_x, o_y;

	calChildHeight();

	env->m_event = env->m_type;
	if (env->m_type == ZaEvent::EVENT_DOWN)
	{
		ZaTweener::getInstance()->pop(this);
		o_x = env->m_x;
		o_y = env->m_y;
		env->m_event = 100;
	}
	if (env->m_type == ZaEvent::EVENT_MOVE)
	{
		if (m_height < m_childheight)
		{
			m_top += env->m_y - o_y;
			if (m_top < 0)
				m_top = 0;
			else if (m_top > m_childheight - m_height)
				m_top =  m_childheight - m_height;
		}
		o_x = env->m_x;
		o_y = env->m_y;
	}
	if (env->m_type == ZaEvent::EVENT_UP)
	{
		if (m_childheight > m_height && abs(o_y - env->m_y) > 2.0f)
		{
			ZaTweener::getInstance()->push(this, 10, (o_y - env->m_y) * 2, 0, 0,
					int(abs(o_y - env->m_y) * 2));
		}
	}
}

void ZaScroller::tweener(int id, float value)
{
	if (id == 10)
	{
		m_top -= value;
		if (m_top < 0 )
			m_top = 0;
		else if (m_top > m_childheight - m_height)
			m_top =  m_childheight - m_height;
	}
}

void ZaScroller::calChildHeight()
{
	m_childheight=0;
	for(int i = 0 ; i< m_v.size(); i++)
	{
		m_childheight = max(m_childheight,m_v[i]->m_y + m_v[i]->m_height);
	}
}

ZaScroller::~ZaScroller()
{
	// TODO Auto-generated destructor stub
}

} /* namespace bbcubezone */
