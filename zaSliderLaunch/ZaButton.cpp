/*
 * ZaButton.cpp
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#include "ZaButton.h"

namespace bbcubezone {

ZaButton::ZaButton() {
	m_z = 1.0f;
	// TODO Auto-generated constructor stub
	m_fog = ZaResLib::getInstance()->getOjb(0);
}

void ZaButton::setImage(ZAImage *img)
{
	if (img)
	{
		m_img = img;
		m_width = img->m_width;
		m_height = img->m_height;
	}
	else
		throw CException(__FILE__,__LINE__,"img is NULL");
}


void ZaButton::drawControl()
{
	int a = m_x, b= m_y;
	getClientXY(a,b);
	//fprintf(stderr,"ZaButton drawControl %d %d %d alpha %f %d\n",m_id,a, b ,m_alpha,m_visiable);

	if (! m_visiable)
		return;

	if (m_img == NULL)
	{
		m_img = ZaResLib::getInstance()->m_jpg;
	}
	m_img->setXY(a+m_width/2,b+m_height/2);
	m_img->m_height = m_height;
	m_img->m_width = m_width;
	m_img->m_alpha = m_alpha;
	m_img->m_r = m_r;
	m_img->m_z = m_z;
	m_img->DrawImg();
//	fprintf(stderr,"ZaButton::drowcontrol %p %d %d %d %d\n",this,a, b,m_width,m_height);
//
//	m_fog->setSize(a,b,m_width,m_height);
//	m_fog->m_alpha = m_alpha;
//	m_fog->drawControl();
}


void ZaButton::processEvent(ZaEvent * env)
{
	static int o_x , o_y;

	env->m_event = env->m_type;
	if (env->m_type == ZaEvent::EVENT_DOWN )
	{
		o_x = env->m_x ;
		o_y = env->m_y ;
		ZaTweener::getInstance()->push(this,ZaTweener::ZOOM,1,3,0,3);
		env->m_event = ZaEvent::EVENT_DOWN;
	}
	if (env->m_type == ZaEvent::EVENT_MOVE)
	{
		env->m_event = ZaEvent::EVENT_MOVE;
		if(m_dragable)
		{
			this->m_x+= env->m_x-o_x;
			this->m_y+= env->m_y-o_y;
		}
		o_x = env->m_x ;
		o_y = env->m_y ;
	}
	if (env->m_type == ZaEvent::EVENT_UP)
	{
		ZaTweener::getInstance()->push(this,ZaTweener::ZOOM,3,1,3,3);
		//post click;
		if (inPoint(env->m_x,env->m_y))
			env->m_event = ZaEvent::EVENT_CLICK;
	}
	//if (m_parent)
	//	m_parent->processEvent(env);
}


ZaButton::~ZaButton() {
	// TODO Auto-generated destructor stub
	if(m_img)
	{
		delete m_img;
		m_img = NULL;
	}
}

} /* namespace bbcubezone */
