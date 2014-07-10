/*
 * ZaScreenStart.cpp
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#include "ZaScreenStart.h"

namespace bbcubezone {

ZaScreenStart::ZaScreenStart() {
	// TODO Auto-generated constructor stub

	m_tweenera = NULL;
	m_tweenerb = NULL;

}
void ZaScreenStart::init()
{
	m_bg = new ZAImage();
	m_bg->LoadImg("app/native/res/earth.jpg",m_width,m_height);

	m_bg->setXY(m_width/2,m_height/2);
	AddChild(m_bg);

	ZAImage * l_img,*l_img2;
	m_sld_c = new ZaSliderSwitch();
	m_sld_c->setSize((m_width-450)/2,80,450,80);
	l_img = new ZAImage();
	l_img2 = new ZAImage();
	l_img->LoadImg("app/native/res/b4.png",0,0);
	l_img2->LoadImg("app/native/res/a.png",0,0);
	m_sld_c->setImage(l_img,l_img2);
	AddChild(m_sld_c);
	addListener(m_sld_c,ZaEvent::EVENT_SLIDER_CHANGED,&ZaScreenStart::onclick);

	m_head = new ZAImage();
	m_head->LoadImg("app/native/res/cc2.png",m_width,200);
	m_head->setXY(m_width/2,m_height-140);
	AddChild(m_head);

	m_dt.GetCurTime();

	m_lab_time = new ZaLabel();
	m_lab_time->m_text = m_dt.GetDateTime((char*)"%H:%M");
	m_lab_time->setSize(200,m_height-200,500,100);
	m_lab_time->setfont(1.0f,1.0f,1.0f,1.0f,30);
	AddChild(m_lab_time);

	m_lab_date = new ZaLabel();
	m_lab_date->m_text = m_dt.GetDateTime("%a, %b %d, %Y");
	m_lab_date->setfont(0.6f,0.6f,0.6f,1.0f,9);
	m_lab_date->setSize(210,m_height-280,500,100);
	AddChild(m_lab_date);

	addListener(NULL,NAVIGATOR_WINDOW_INACTIVE,&ZaScreenStart::onclick);

}

void ZaScreenStart:: onoff()
{
	if (m_sld_c->m_visiable)
	{
		fprintf(stderr,"ZaScreenStart:: onoff %d ",m_height);
		//m_sld_c->m_visiable = false;
		m_sld_c->m_y = -300;
		m_sld_c->m_percent = 0.0f;
		ZaTweener::getInstance()->push(m_head,ZaTweener::Y,m_head->m_y,m_height+200,0,15);
		ZaTweener::getInstance()->push(m_lab_time,ZaTweener::Y,m_lab_time->m_y,m_height+200,0,15);
		ZaTweener::getInstance()->push(m_lab_date,ZaTweener::Y,m_lab_date->m_y,m_height+200,0,15);

		ZaTweener::getInstance()->push(m_bg,ZaTweener::ZOOM,1,0.6,5,10);
		ZaTweener::getInstance()->push(m_bg,ZaTweener::ZOOM,0.6,0,15,6);
	}
}

void ZaScreenStart:: tweener(int id, float value)
{
	if(id==10)
	{
		ZaResLib::getInstance()->m_next = this;
		this->m_x = 0;
		m_head->m_y= m_height-140;
		m_sld_c->m_y = 80;
		m_lab_time->m_y = m_height-200;
		m_lab_date->m_y = m_height-280;
		m_bg->m_z =1.0f;
	}
	else if (id == 11 && m_sld_c->m_visiable)
	{
		fprintf(stderr,"ZaScreenStart:: tweener  %d ",m_height);
		//m_sld_c->m_visiable = false;
		m_sld_c->m_y = -300;
		m_sld_c->m_percent = 0.0f;
		ZaTweener::getInstance()->push(m_head,ZaTweener::Y,m_head->m_y,m_height+200,0,15);
		ZaTweener::getInstance()->push(m_lab_time,ZaTweener::Y,m_lab_time->m_y,m_height+200,0,15);
		ZaTweener::getInstance()->push(m_lab_date,ZaTweener::Y,m_lab_date->m_y,m_height+200,0,15);

		ZaTweener::getInstance()->push(m_bg,ZaTweener::ZOOM,1,0.6,5,10);
		ZaTweener::getInstance()->push(m_bg,ZaTweener::ZOOM,0.6,0,15,6);
		ZaResLib::getInstance()->m_mp3->setid("1");
		ZaResLib::getInstance()->m_mp3->play("/app/native/res/unlock4.mp3");
		ZaTweener::getInstance()->push(this,12,0,1,21,1);
	}
	else if (id == 12)
	{
		ZaScreenFlash * l_flash = (ZaScreenFlash *)ZaResLib::getInstance()->getScreen("ZaScreenFlash");
		ZaScreenBase * l_src = (ZaScreenBase *)ZaResLib::getInstance()->getScreen("ZaScreenDesktop");
		string p= "";
		l_flash->changeScreen(this,l_src,l_src,p.c_str(),ZaScreenFlash::NONE);
	}

}
void ZaScreenStart::processEvent(ZaEvent *env)
{
	if (env->m_type == 100)
	{
		eventtest(env);
	}
	ZaObj * l_obj = env->m_obj;
	fprintf(stderr,"-ZaScreenStart::processEvent-%p-%p-%d-%d-%d---\n",l_obj,this,env->m_type, env->m_x,env->m_y);
	fflush(stderr);
	if (l_obj && l_obj != this)
	{
		l_obj->processEvent(env);
	}
	callFunc(l_obj,env);

	m_dt.GetCurTime();
	m_lab_time->m_text = m_dt.GetDateTime("%H:%M");
	m_lab_date->m_text = m_dt.GetDateTime("%a, %b %d, %Y");
}

void ZaScreenStart::addListener(ZaObj * obj , int event,PTRFUN2 func )
{
	m_p[(int)obj*256+event] = func ;
}

void ZaScreenStart::callFunc(ZaObj * obj,  ZaEvent *env)
{
	int i = (int)obj*256 + env->m_event;
	PTRFUN2 func = m_p[i];
	if (func)
	(this->*func)(obj,env);
}

void ZaScreenStart::onclick(ZaObj * obj,ZaEvent *env)
{
	if (obj==m_sld_c )
	{
		ZaTweener::getInstance()->push(this,ZaTweener::FUNCTION,0,1,0,1);

	}
	else if (obj == NULL && env->m_event == NAVIGATOR_WINDOW_INACTIVE )
	{
		m_head->m_y= m_height-140;
		m_sld_c->m_y = 80;
		m_lab_time->m_y = m_height-200;
		m_lab_date->m_y = m_height-280;
		m_bg->m_z =1.0f;
		ZaResLib::getInstance()->m_mp3->setid("2");
		ZaResLib::getInstance()->m_mp3->play("/app/native/res/lock.mp3");
		 env->m_event = 0;
	}
	else if (obj)
	{
		if (obj->m_id==0)
		{
			//navigator_open_file("http://www.bbcubezone.com",NULL);
			navigator_invoke("http://www.blackberry.com",NULL);
		}
		else if (obj->m_id==1)
		{
			navigator_invoke("messages://",NULL);
		}
		else if (obj->m_id==2)
		{
			navigator_invoke("contacts://",NULL);
		}
		else if (obj->m_id==3)
		{
			navigator_invoke("calendar://",NULL);
		}
		else if (obj->m_id==4)
		{
			navigator_invoke("camera://photo",NULL);
		}
		else if (obj->m_id==5)
		{
			navigator_invoke("photos://",NULL);
		}
		else if (obj->m_id==6)
		{
			navigator_invoke("videos://recorded",NULL);
		}
		else if (obj->m_id==7)
		{
			navigator_invoke("music://",NULL);
		}
		else if (obj->m_id==8)
		{
			navigator_invoke("settings://about",NULL);
		}
		else if (obj->m_id==9)
		{
			navigator_invoke("appworld://myworld",NULL);
		}
		else if (obj->m_id==10)
		{
			navigator_invoke("appworld://content/130976",NULL);
		}
		else if (obj->m_id==11)
		{
			navigator_invoke("appworld://content/79306",NULL);
		}
		else if (obj->m_id==12)
		{
			navigator_invoke("appworld://content/136420",NULL);
		}
		else if (obj->m_id==13)
		{
			navigator_invoke("appworld://content/44172",NULL);
		}
		else
			navigator_invoke("appworld://content/92819",NULL);


	}
//
//	ZaScreenFlash * l_flash = (ZaScreenFlash *)ZaResLib::getInstance()->getScreen(0);
//	ZaScreenBase * l_src = (ZaScreenBase *)ZaResLib::getInstance()->getScreen(2);
//	string p= "";
//	l_flash->changeScreen(this,l_src,l_src,p.c_str(),ZaScreenFlash::LEFT);
//	m_sld_c->m_percent = 0.0f;

}


ZaScreenStart::~ZaScreenStart() {
	// TODO Auto-generated destructor stub
}

} /* namespace bbcubezone */

