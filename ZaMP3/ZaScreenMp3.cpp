/*
 * ZaScreenMp3.cpp
 *
 *  Created on: 2012-8-25
 *      Author: Administrator
 */

#include "ZaScreenMp3.h"

namespace bbcubezone {

ZaScreenMp3::ZaScreenMp3() {
	// TODO Auto-generated constructor stub

}

void ZaScreenMp3::init()
{
	m_bg = new ZAImage();
	m_bg->LoadImg("app/native/res/bg0.jpg",m_width,m_height);
	m_bg->setXY(300,512);
	AddChild(m_bg);


	m_btn_a = new ZaButton();
	m_btn_b = new ZaButton();


	ZAImage *m_img = new ZAImage();
	m_img->LoadImg("app/native/res/Theme48.png",0,0);
	m_btn_a->setImage(m_img);
	m_btn_a->setSize(200,500,48,48);

	m_img = new ZAImage();
	m_img->LoadImg("app/native/res/MusicFolder.png",64,64);
	m_btn_b->setImage(m_img);

	m_btn_b->setSize(260,760,128,128);

	AddChild(m_btn_a);
	AddChild(m_btn_b);

	addListener(m_btn_a,103,&ZaScreenMp3::onclick);
	addListener(m_btn_b,103,&ZaScreenMp3::onclick);
}

void ZaScreenMp3::addListener(ZaObj * obj , int event,PTRFUNZaScreenMp3 func )
{
	m_p[(int)obj*256+event] = func ;
}

void ZaScreenMp3::callFunc(ZaObj * obj,  ZaEvent *env)
{
	int i = (int)obj*256 + env->m_event;
	PTRFUNZaScreenMp3 func = m_p[i];
	if (func)
	(this->*func)(obj,env);
}

void ZaScreenMp3::onclick(ZaObj * obj,ZaEvent *env)
{
	if (obj == m_btn_a)
	{
		static float f = 0.5;
		f += 0.1 ; if (f > 1 ) f= 0.1;

		m_mp3.setvolume(f);


		if (m_btn_b->m_x == 350)
		{
			m_btn_b->m_visiable = true;
			ZaTweener::getInstance()->push(m_btn_b,5,0,0.5,0,2);
			ZaTweener::getInstance()->push(m_btn_b,5,0.5,1,3,10);
			ZaTweener::getInstance()->push(m_btn_b,1,m_btn_b->m_x,0,0,20);
			ZaTweener::getInstance()->push(m_btn_b,3,m_btn_b->m_width,128,0,10);
		//	ZaTweener::getInstance()->push(m_btn_b,6,0,360.0f,0,20);

			ZaTweener::getInstance()->push(m_btn_b,7,2,1,20,20);
		}
		else
		{
			m_btn_b->m_visiable = false;
			ZaTweener::getInstance()->push(m_btn_b,5,0.5,0,10,12);
			ZaTweener::getInstance()->push(m_btn_b,5,1,0.5,0,10);
			ZaTweener::getInstance()->push(m_btn_b,3,m_btn_b->m_width,128,0,10);
			ZaTweener::getInstance()->push(m_btn_b,1,m_btn_b->m_x,350,0,20);
		//	ZaTweener::getInstance()->push(m_btn_b,6,360.0f,0,0,20);
			ZaTweener::getInstance()->push(m_btn_b,7,1,2,20,20);
		}
	}
	if (obj==m_btn_b)
	{
		ZaScreenFlash * l_flash = (ZaScreenFlash *)ZaResLib::getInstance()->getScreen("ZaScreenFlash");
		ZaScreenBase * l_src = (ZaScreenBase *)ZaResLib::getInstance()->getScreen("ZaScreenDir");

		string p= "";
		l_flash->changeScreen(this,l_src,l_src,p.c_str(),ZaScreenFlash::LEFT);
	}
}

void ZaScreenMp3::tweener(int id, float value)
{
	if (id == 10)
	{
		ZaResLib::getInstance()->m_next = this;
		this->m_x = 0;
		string fname = ZaTweener::getInstance()->m_param;
		if (fname.length()>0)
			m_mp3.run((char *)fname.c_str());
	}
}

void ZaScreenMp3::processEvent(ZaEvent *env)
{
	if (env->m_type == 100)
	{
		eventtest(env);
	}
	ZaObj * l_obj = env->m_obj;
//	fprintf(stderr,"-ZaScreenMp3::processEvent-%p-%p-%d-%d-%d---\n",l_obj,this,env->m_type, env->m_x,env->m_y);
	fflush(stderr);
	if (l_obj && l_obj != this)
	{
		l_obj->processEvent(env);

		callFunc(l_obj,env);
	}
}

ZaScreenMp3::~ZaScreenMp3() {
	// TODO Auto-generated destructor stub

}

} /* namespace bbcubezone */
