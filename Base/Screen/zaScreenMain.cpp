/*
 * zaScreenMain.cpp
 *
 *  Created on: 2012-8-25
 *      Author: Administrator
 */

#include "zaScreenMain.h"

namespace bbcubezone {

zaScreenMain::zaScreenMain() {
	// TODO Auto-generated constructor stub

}

void zaScreenMain::init()
{
	m_bg = new ZAImage();
	m_bg->LoadImg("app/native/res/bg3.jpg",m_width,m_height);
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

	addListener(m_btn_a,103,&zaScreenMain::onclick);
	addListener(m_btn_b,103,&zaScreenMain::onclick);
}

void zaScreenMain::addListener(ZaObj * obj , int event,PTRFUNZaScreenMain func )
{
	m_p[(int)obj*256+event] = func ;
}

void zaScreenMain::callFunc(ZaObj * obj,  ZaEvent *env)
{
	int i = (int)obj*256 + env->m_event;
	PTRFUNZaScreenMain func = m_p[i];
	if (func)
	(this->*func)(obj,env);
}

void zaScreenMain::onclick(ZaObj * obj,ZaEvent *env)
{
	if (obj == m_btn_a)
	{
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
			ZaScreenBase * l_src = (ZaScreen *)ZaResLib::getInstance()->getScreen("ZaScreen");
			ZaScreenBase * l_flash = (ZaScreen *)ZaResLib::getInstance()->getScreen("ZaScreenFlash");
			l_flash->m_tweenera->LoadImgFromMemory("old screen",m_width,m_height);
			l_flash->m_tweenera->setXY(300,512);
				l_src->setSize(0,0,600,1024);

				glClear(GL_COLOR_BUFFER_BIT);
				glClearColor(0.8f,0.8f,0.8f, 1.0f);
				l_src->draw();
				l_flash->m_tweenerb->LoadImgFromMemory("new screen",m_width,m_height);
				l_flash->m_tweenerb->setXY(300,512);
			ZaTweener::getInstance()->push(this,1,0,600,0,1);
			ZaTweener::getInstance()->push(l_flash->m_tweenera,1,m_width/2,-m_width/2,0,10);
			ZaTweener::getInstance()->push(l_flash->m_tweenerb,1,m_width*3/2,m_width/2,0,10);

			ZaResLib::getInstance()->m_next = l_flash;
			l_flash->m_x = 0;

			ZaTweener::getInstance()->push(this,10,m_width/2,-m_width/2,21,1);
	}
}

void zaScreenMain::tweener(int id, float value)
{
	ZaScreenBase *l_src = (ZaScreen *)ZaResLib::getInstance()->getScreen("ZaScreen");
	ZaResLib::getInstance()->m_next = l_src;
	l_src->m_x = 0;
}

void zaScreenMain::processEvent(ZaEvent *env)
{
	if (env->m_type == 100)
	{
		eventtest(env);
	}
	ZaObj * l_obj = env->m_obj;
//	fprintf(stderr,"-ZaScreenMain::processEvent-%p-%p-%d-%d-%d---\n",l_obj,this,env->m_type, env->m_x,env->m_y);
	fflush(stderr);
	if (l_obj && l_obj != this)
	{
		l_obj->processEvent(env);

		callFunc(l_obj,env);
	}
}

zaScreenMain::~zaScreenMain() {
	// TODO Auto-generated destructor stub

}

} /* namespace bbcubezone */
