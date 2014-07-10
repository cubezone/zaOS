/*
 * ZaScreenDir.cpp
 *
 *  Created on: 2012-10-2
 *      Author: Administrator
 */

#include "ZaScreenDir.h"

namespace bbcubezone {

ZaScreenDir::ZaScreenDir() {
	// TODO Auto-generated constructor stub
	m_init = false;
}

void ZaScreenDir::init()
{
	if (m_init)
		return;
	m_bg = new ZAImage();
	m_bg->LoadImg("app/native/res/bg0.jpg",m_width,m_height);
	m_bg->setXY(m_width/2,m_height/2);
	AddChild(m_bg);

	m_dir = new ZaListDir();
	m_dir->setSize(0,0,m_width,m_height);
	m_dir->m_rowheight = 120;
	m_dir->init();
	m_dir->changeeDir("/accounts/1000/shared");
	AddChild(m_dir);
	addListener(m_dir,ZaEvent::EVENT_LIST_SELECT_FILE,&ZaScreenDir::onclick);

	m_head = new ZAImage();
	m_head->LoadImg("app/native/res/grey.png",m_width,60);
	m_head->m_alpha = 0.8f;
	m_head->setXY(m_width/2,m_height-30);
//	AddChild(m_head);

	ZAImage *l_img = new ZAImage();
	l_img->LoadImg("app/native/res/leftback.png", 48, 48);
	m_back = new ZaButton();
	m_back->setImage(l_img);
	m_back->setSize(30, m_height-70, 48, 48);
	AddChild(m_back);
	addListener(m_back,ZaEvent::EVENT_CLICK,&ZaScreenDir::onclick);
	m_init = true;
}

void ZaScreenDir::addListener(ZaObj * obj , int event,PTRFUN func )
{
	m_p[(int)obj*256+event] = func ;
}

void ZaScreenDir::callFunc(ZaObj * obj,  ZaEvent *env)
{
	int i = (int)obj*256 + env->m_event;
	PTRFUN func = m_p[i];
	if (func)
	(this->*func)(obj,env);
}

void ZaScreenDir::onclick(ZaObj * obj,ZaEvent *env)
{
	if (obj == m_dir)
	{
		ZaScreenFlash * l_flash = (ZaScreenFlash *)ZaResLib::getInstance()->getScreen("ZaScreenFlash");
		ZaScreenBase * l_src = (ZaScreenBase *)ZaResLib::getInstance()->getScreen("ZaScreenMp3");

		string p= this->m_dir->m_path +string("/")+
					m_dir->m_v[m_dir->m_index];

		l_flash->changeScreen(this,l_src,l_src,p.c_str(),ZaScreenFlash::RIGHT);
		//ZaTweener::getInstance()->push(this,10,-300,300,21,1);
	}
	if (obj == m_back)
	{
		ZaScreenFlash * l_flash = (ZaScreenFlash *)ZaResLib::getInstance()->getScreen("ZaScreenFlash");
			ZaScreenBase * l_src = (ZaScreenBase *)ZaResLib::getInstance()->getScreen("ZaScreenMp3");
		string p = "";
		l_flash->changeScreen(this,l_src,l_src,p.c_str(),ZaScreenFlash::RIGHT);
	}
}

void ZaScreenDir::tweener(int id, float value)
{
	if( id == 10)
	{
		ZaResLib::getInstance()->m_next = this;
		m_x = 0;
	}
	if( id == 11)
	{
		ZaScreenBase * l_src = (ZaScreenBase *)ZaResLib::getInstance()->getScreen("ZaScreenHis");
		ZaResLib::getInstance()->m_next = l_src;
		l_src->m_x = 0;
	}
}

void ZaScreenDir::processEvent(ZaEvent *env)
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
ZaScreenDir::~ZaScreenDir() {
	// TODO Auto-generated destructor stub
	delete m_bg;
	delete m_back;
	delete m_head;
	delete m_dir;

}

} /* namespace bbcubezone */
