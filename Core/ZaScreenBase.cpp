/*
 * ZaScreenBase.cpp
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#include "ZaScreenBase.h"

namespace bbcubezone {

ZaScreenBase::ZaScreenBase() {
	// TODO Auto-generated constructor stub

	m_tweenera = NULL;
	m_tweenerb = NULL;
	m_init = false;
	m_showloader = false;
	m_srceencaller = NULL;
}

void ZaScreenBase::init()
{
	m_tweenerb = new ZAImage();
	m_tweenera = new ZAImage();

}

void ZaScreenBase::drawControl()
{
	if (m_motion)
	{
		if (m_bg)
			m_bg->drawControl();
//		m_loader.drawControl();
	}
}

void ZaScreenBase::processEvent(ZaEvent *env)
{
	if (env->m_type == 100)
	{
		eventtest(env);
	}
	ZaObj * l_obj = env->m_obj;
//	fprintf(stderr,"-ZaScreenBase::processEvent-%p-%p-%d-%d-%d---\n",l_obj,this,env->m_type, env->m_x,env->m_y);
	fflush(stderr);
	if (l_obj && l_obj != this)
	{
		l_obj->processEvent(env);
		callFunc(l_obj,env);
	}
}

void ZaScreenBase::addListener(ZaObj * obj , int event,PTRFUN2 func )
{
	m_p[(int)obj*256+event] = func ;
}

void ZaScreenBase::callFunc(ZaObj * obj,  ZaEvent *env)
{
	int i = (int)obj*256 + env->m_event;
	PTRFUN2 func = m_p[i];
	if (func)
	(this->*func)(obj,env);
}

void ZaScreenBase::onclick(ZaObj * obj,ZaEvent *env)
{

}

ZaScreenBase::~ZaScreenBase() {
	// TODO Auto-generated destructor stub
	if(m_tweenera)
	delete m_tweenera;
	if(m_tweenera)
	delete m_tweenerb;

}

} /* namespace bbcubezone */

