/*
 * ZaScreenHuaRong.cpp
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#include "ZaScreenHuaRong.h"

namespace bbcubezone {

ZaScreenHuaRong::ZaScreenHuaRong() {
	// TODO Auto-generated constructor stub
}

void ZaScreenHuaRong::init()
{
	m_bg = new ZAImage();
	m_bg->LoadImg("app/native/res/bg2.png",m_width,m_height);
	m_bg->setXY(m_width/2,m_height/2);
	this->AddChild(m_bg);

	ZAImage * l_img = new ZAImage();
	l_img->LoadImg("app/native/res/bgrect.png",0,0);
//	m_sx = (m_width - 480) / 2;
//	m_sy = (m_height - 400);
	l_img->setXY((m_width - 480) / 2 + l_img->m_width/2 -8 ,
			   (m_height - 600)/2 + 600 - l_img->m_height/2 +8);
	this->AddChild(l_img);

	m_hr = new ZaHuaRong();
	m_hr->setSize(0,0,m_width,m_height);
	m_hr->init();
	this->AddChild(m_hr);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/reset.png",0,0);
	l_img->setXY(l_img->m_width/2,l_img->m_height/2);
	m_btn_reset= new ZaButton();
	m_btn_reset->setImage(l_img);
	m_btn_reset->setSize(m_width/2-90,100,180,80);
	this->AddChild(m_btn_reset);
	this->addListener(m_btn_reset,ZaEvent::EVENT_CLICK,&ZaScreenHuaRong::onclick);

	//ZaResLib::getInstance()->m_mp3->playloop("/app/native/res/wind.mp3");
}

void ZaScreenHuaRong::processEvent(ZaEvent *env)
{
	if (env->m_type == 100)
	{
		eventtest(env);
	}
	ZaObj * l_obj = env->m_obj;
	fprintf(stderr,"-ZaScreenHuaRong::processEvent-%p-%p-%d-%d-%d---\n",l_obj,this,env->m_type, env->m_x,env->m_y);
	fflush(stderr);
	if (l_obj && l_obj != this)
	{
		l_obj->processEvent(env);

		callFunc(l_obj,env);
	}
}

void ZaScreenHuaRong::addListener(ZaObj * obj , int event,PTRFUN2 func )
{
	m_p[(int)obj*256+event] = func ;
}

void ZaScreenHuaRong::callFunc(ZaObj * obj,  ZaEvent *env)
{
	int i = (int)obj*256 + env->m_event;
	PTRFUN2 func = m_p[i];
	if (func)
	(this->*func)(obj,env);
}

void ZaScreenHuaRong::onclick(ZaObj * obj,ZaEvent *env)
{
	if(obj == m_btn_reset)
	{
		soundplayer_play_sound("input_keypress");
		m_hr->reset();
	}
}

ZaScreenHuaRong::~ZaScreenHuaRong() {
	// TODO Auto-generated destructor stub
	delete m_hr;
	delete m_btn_reset;
	delete m_bg;
}

} /* namespace bbcubezone */

