/*
 * ZaObj.cpp
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#include "ZaObj.h"

namespace bbcubezone {

ZaObj::ZaObj() {
	// TODO Auto-generated constructor stub
	m_alpha = 1.0f;
	m_parent = NULL;
	m_next = NULL;
	m_child = NULL;
	m_z = 1.0f;
	m_r = 0.0f;
	m_percent = 0.0f;
	m_visiable = true;
	m_dirty = true;
	m_motion = false;
	m_enable = true;
	m_dragable = false;
	m_postparent = false;
}

int ZaObj::setSize(int x, int y , int w, int h)
{
	m_x = x; m_y = y; m_width = w; m_height = h;
	return 1;
}

//void string_replace(string & strBig, const string & strsrc, const string &strdst)
//{
// string::size_type pos=0;
// string::size_type srclen=strsrc.size();
// string::size_type dstlen=strdst.size();
// while( (pos=strBig.find(strsrc, pos)) != string::npos)
// {
//  strBig.replace(pos, srclen, strdst);
//  pos += dstlen;
// }
//}

int ZaObj::getClientXY(int & x ,int &y)
{
	ZaObj *p = m_parent;
	if (p)
	{
		x += p->m_x;
		y += p->m_y;
		p->getClientXY(x,y);
	}
	return 0;
}

void ZaObj::tweener(int id, float value)
{

}

void ZaObj::AddChild(ZaObj * obj)
{
	ZaObj *p = this;
	obj->m_parent = p;
	if (p->m_child == NULL)
		p->m_child  = obj;
	else
	{
		p = p->m_child;
		while (p->m_next)
			p = p->m_next;
		p->m_next = obj;
	}
}

bool ZaObj::inPoint(int x, int y)
{
	int a = m_x,b= m_y;
	getClientXY(a,b);
	if (x >a && x < a + this->m_width &&
			y >b && y < b + this->m_height
	)
	return true;
	else
	return false;
}

void ZaObj::RemoveChild(ZaObj * obj)
{
	ZaObj *p = obj;
	ZaObj *t = obj;
	if(p->m_child)
	{
		p = p->m_child;
		RemoveChild(p);
	}
	if(t->m_next)
	{
		t = t->m_next;
		RemoveChild(t);
	};
	delete obj;
}

void ZaObj::drawControl()
{
//	int a = m_x, b= m_y;
//	getClientXY(a,b);
//	glEnable(GL_SCISSOR_TEST);
//	glScissor(a,b,m_width,m_height);
//
//	glDisable(GL_SCISSOR_TEST);
}

void  ZaObj::eventtest(ZaEvent * event)
{
	ZaObj *p = this;
	ZaObj *t = this;
	// ����,��Ч
//fprintf(stderr,"ZaObj::eventtest  x %d, y %d, w %d,h %d\n", m_x, m_y, m_width,m_height);
	if ( m_visiable && m_enable && inPoint(event->m_x,event->m_y))
	{
		event->m_obj = this;
		fprintf(stderr,"ZaObj::eventtest : hit %p \n", this);
	}
	if (p->m_visiable && p->m_child)
	{
		p = p->m_child;
		p->eventtest(event);
	}
	if (t->m_next)
	{
		t = t->m_next;
	    t->eventtest(event);
	};
}

void  ZaObj::draw()
{
	ZaObj *p = this;
	ZaObj *t = this;
	if (p->m_visiable)
	{
		p->drawControl();
		p->m_dirty = false;
		if (!m_motion && p->m_child)
		{
			p = p->m_child;
			p->draw();
		}
	}
	if (t->m_next)
	{
		t = t->m_next;
	    t->draw();
	};
}

void ZaObj::processEvent(ZaEvent * env)
{
	if (m_postparent && m_parent)
		m_parent->processEvent(env);
}

ZaObj::~ZaObj() {
	// TODO Auto-generated destructor stub

}

} /* namespace bbcubezone */
