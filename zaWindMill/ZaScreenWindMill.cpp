/*
 * ZaScreenWindMill.cpp
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#include "ZaScreenWindMill.h"

namespace bbcubezone {

ZaScreenWindMill::ZaScreenWindMill() {
	// TODO Auto-generated constructor stub
}

void ZaScreenWindMill::init()
{
	m_bg = new ZAImage();
	m_bg->LoadImg("app/native/res/windbg.jpg",m_width,m_height);
	m_bg->setXY(m_width/2,m_height/2);
	this->AddChild(m_bg);

	m_wm = new ZaWindMill();
	m_wm->setSize(0,0,m_width,m_height);
	this->AddChild(m_wm);

	ZaResLib::getInstance()->m_mp3->playloop("/app/native/res/wind.mp3");
}

void ZaScreenWindMill::processEvent(ZaEvent *env)
{
	if (env->m_type == 100)
	{
		eventtest(env);
	}
	ZaObj * l_obj = env->m_obj;
	//fprintf(stderr,"-ZaScreenWindMill::processEvent-%p-%p-%d-%d-%d---\n",l_obj,this,env->m_type, env->m_x,env->m_y);
	fflush(stderr);
	if (l_obj && l_obj != this)
	{
		l_obj->processEvent(env);

		callFunc(l_obj,env);
	}
}

void ZaScreenWindMill::addListener(ZaObj * obj , int event,PTRFUN2 func )
{
	m_p[(int)obj*256+event] = func ;
}

void ZaScreenWindMill::callFunc(ZaObj * obj,  ZaEvent *env)
{
	int i = (int)obj*256 + env->m_event;
	PTRFUN2 func = m_p[i];
	if (func)
	(this->*func)(obj,env);
}

void ZaScreenWindMill::onclick(ZaObj * obj,ZaEvent *env)
{

}

ZaScreenWindMill::~ZaScreenWindMill() {
	// TODO Auto-generated destructor stub
	delete m_wm;
	delete m_bg;
}

} /* namespace bbcubezone */

