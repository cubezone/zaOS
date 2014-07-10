/*
 * ZaScreenLuckyWheel.cpp
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#include "ZaScreenLuckyWheel.h"

namespace bbcubezone {

ZaScreenLuckyWheel::ZaScreenLuckyWheel() {
	// TODO Auto-generated constructor stub
}

void ZaScreenLuckyWheel::init()
{
	m_bg = new ZAImage();
	m_bg->LoadImg("app/native/res/bg.jpg",m_width,m_height);
	m_bg->setXY(m_width/2,m_height/2);
	//this->AddChild(m_bg);

	ZAImage * l_img = new ZAImage();
	l_img->LoadImg("app/native/res/start.png",0,0);
	l_img->setXY(l_img->m_width/2,l_img->m_height/2);
	m_btn_start = new ZaButton();
	m_btn_start->setImage(l_img);
	m_btn_start->setSize(m_width/2+100,150,100,60);
	this->AddChild(m_btn_start);
	this->addListener(m_btn_start,ZaEvent::EVENT_CLICK,&ZaScreenLuckyWheel::onclick);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/stop_btn.png",0,0);
	l_img->setXY(l_img->m_width/2,l_img->m_height/2);
	m_btn_stop = new ZaButton();
	m_btn_stop->setImage(l_img);
	m_btn_stop->setSize(m_width/2 -200,150,100,60);
	this->AddChild(m_btn_stop);
	this->addListener(m_btn_stop,ZaEvent::EVENT_CLICK,&ZaScreenLuckyWheel::onclick);

	m_disk = new ZAImage();
	m_disk->LoadImg("app/native/res/wheel.png",540,540);
	m_disk->setXY(m_width/2,m_height/2+ 100);
	//this->AddChild(m_disk);

	m_boll = new ZAImage();
	m_boll->LoadImg("app/native/res/ball.png",0,0);
	m_boll->setXY(m_width/2,m_height/2 +100 );
	m_boll->setRoationCenter(140,140);
	//this->AddChild(m_boll);

	m_mp3_s = new ZaMp3();
	m_mp3_e = new ZaMp3();

}

void ZaScreenLuckyWheel::processEvent(ZaEvent *env)
{
	if (env->m_type == 100)
	{
		eventtest(env);
	}
	ZaObj * l_obj = env->m_obj;
	fprintf(stderr,"-ZaScreenLuckyWheel::processEvent-%p-%p-%d-%d-%d---\n",l_obj,this,env->m_type, env->m_x,env->m_y);
	fflush(stderr);
	if (l_obj && l_obj != this)
	{
		l_obj->processEvent(env);

		callFunc(l_obj,env);
	}
}

void ZaScreenLuckyWheel::addListener(ZaObj * obj , int event,PTRFUN2 func )
{
	m_p[(int)obj*256+event] = func ;
}

void ZaScreenLuckyWheel::callFunc(ZaObj * obj,  ZaEvent *env)
{
	int i = (int)obj*256 + env->m_event;
	PTRFUN2 func = m_p[i];
	if (func)
	(this->*func)(obj,env);
}

void ZaScreenLuckyWheel::drawControl()
{
	int a = m_x, b= m_y;
	getClientXY(a,b);

	m_bg->DrawImg(a+m_bg->m_x,b+m_bg->m_y,m_bg->m_r);

	m_disk->m_r += this->m_percent;
	m_disk->DrawImg(a+m_disk->m_x,b+m_disk->m_y,m_disk->m_r);

	m_boll->m_r -= this->m_percent;
	m_boll->DrawImg(a+m_boll->m_x,b+m_boll->m_y,m_boll->m_r);

	if (this->m_percent == 0)
	{
		 m_mp3_s->stop();
	}
}

void ZaScreenLuckyWheel::onclick(ZaObj * obj,ZaEvent *env)
{
	if (obj == m_btn_start)
	{
		m_mp3_s->setid("1");
	    m_mp3_s->play("/app/native/res/roll60.mp3");
	    ZaTweener::getInstance()->push(this,ZaTweener::PERCENT,100,0,0,600);

//		ZaTweener::getInstance()->push(m_boll,ZaTweener::ROTATION,0,360*10*10,0,600);
//		ZaTweener::getInstance()->push(m_disk,ZaTweener::ROTATION,0,-360*10*8,0,600);
	}
	if (obj == m_btn_stop)
	{
		 m_mp3_s->stop();
		 this->m_percent = 0;
		 m_mp3_e->setid("2");
		 m_mp3_e->play("/app/native/res/metelhit.mp3");
		ZaTweener::getInstance()->pop(this);
	}
}

ZaScreenLuckyWheel::~ZaScreenLuckyWheel() {
	// TODO Auto-generated destructor stub

	delete m_btn_start;
	delete m_btn_stop;
	delete m_boll;
	delete m_disk;
	delete m_mp3_e;
	delete m_mp3_s;
}

} /* namespace bbcubezone */

