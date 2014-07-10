/*
 * ZaScreenDesktop.cpp
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#include "ZaScreenDesktop.h"

namespace bbcubezone {

ZaScreenDesktop::ZaScreenDesktop() {
	// TODO Auto-generated constructor stub

	m_tweenera = NULL;
	m_tweenerb = NULL;

}
void ZaScreenDesktop::init()
{
	//setSize(0,0,600,1024);

	m_bg = new ZAImage();
	//m_bg->LoadImg("app/native/res/earth.jpg",600,1024);
	m_bg->LoadImg("app/native/res/bg5.jpg",m_width,m_height);

	m_bg->setXY(m_width/2,m_height/2);
	AddChild(m_bg);

	m_showloader = true;

	for (int i = 0 ;i < 15;i ++)
	{
		ZAImage *l_img = new ZAImage();
		if (i == 0)
			l_img->LoadImg("app/native/res/icon/internet.png",0,0);
		else if (i == 1)
			l_img->LoadImg("app/native/res/icon/Mailgreen.png",0,0);
		else if (i == 2)
			l_img->LoadImg("app/native/res/icon/AddressBook.png",0,0);
		else if (i == 3)
			l_img->LoadImg("app/native/res/icon/Calender.png",0,0);
		else if (i == 4)
			l_img->LoadImg("app/native/res/icon/Camera.png",0,0);
		else if (i == 5)
			l_img->LoadImg("app/native/res/icon/Pictures.png",0,0);
		else if (i == 6)
			l_img->LoadImg("app/native/res/icon/Movies.png",0,0);
		else if (i == 7)
			l_img->LoadImg("app/native/res/icon/ITunes.png",0,0);
		else if (i == 8)
			l_img->LoadImg("app/native/res/icon/SystemPreferences.png",0,0);
		else if (i == 9)
			l_img->LoadImg("app/native/res/icon/Application.png",0,0);
		else if (i == 10)
			l_img->LoadImg("app/native/res/icon/compass.png",0,0);
		else if (i == 11)
			l_img->LoadImg("app/native/res/icon/BPpiano.png",0,0);
		else if (i == 12)
			l_img->LoadImg("app/native/res/icon/book.png",0,0);
		else if (i == 13)
			l_img->LoadImg("app/native/res/icon/MusicBox.png",0,0);
		else
			l_img->LoadImg("app/native/res/icon/battery.png",0,0);

		ZaButton * l_btn = new ZaButton();
		l_btn->setImage(l_img);
		l_btn->setSize(30+ m_width/3 * (i%3), m_height-170 - m_height/5*(i/3),128,128);
		l_btn->m_visiable = false;
		l_btn->m_id = i;
		AddChild(l_btn);
		addListener(l_btn,ZaEvent::EVENT_CLICK,&ZaScreenDesktop::onclick);
		m_icon.push_back(l_btn);
	}
}

void ZaScreenDesktop:: onoff()
{
	static int style = 0;
	style = style % 5;
	if (style == 0)
	for (int i = 0 ;i < m_icon.size();i ++)
	{
		ZaObj * l_obj = m_icon[i];
		l_obj->m_visiable = true;
		l_obj->m_y = -200;
		ZaTweener::getInstance()->push(l_obj,ZaTweener::Y,-100,m_height-170 - m_height/5*(l_obj->m_id/3),25+ l_obj->m_id*2,15);
	}

	if (style == 1)
	for (int i = m_icon.size()-1 ;i >= 0 ;i --)
	{
		ZaObj * l_obj = m_icon[i];
		l_obj->m_visiable = true;
		l_obj->m_y = m_height+200;
		ZaTweener::getInstance()->push(l_obj,ZaTweener::Y,m_height+200,m_height-170 - m_height/5*(l_obj->m_id/3),25+(15-l_obj->m_id)*2,15);
	}

	if (style == 2)
	for (int i = 0 ;i < m_icon.size();i ++)
	{
		ZaObj * l_obj = m_icon[i];
		l_obj->m_visiable = true;
		l_obj->m_x = -200;
		ZaTweener::getInstance()->push(l_obj,ZaTweener::X,-200,30+ m_width/3 * (l_obj->m_id%3),25+(3-l_obj->m_id%3)*10,15);
	}

	if (style == 3)
	for (int i = m_icon.size()-1 ;i >= 0 ;i --)
	{
		ZaObj * l_obj = m_icon[i];
		l_obj->m_visiable = true;
		l_obj->m_x = m_width+200;
		ZaTweener::getInstance()->push(l_obj,ZaTweener::X,m_width +200,30+ m_width/3 * (l_obj->m_id%3),25+ (l_obj->m_id%3)*10,15);
	}
	if (style == 4)
	for (int i = m_icon.size()-1 ;i >= 0 ;i --)
	{
		ZaObj * l_obj = m_icon[i];
		l_obj->m_visiable = true;
		l_obj->m_alpha = 0.0f;
		l_obj->m_z = 0.0f;
		ZaTweener::getInstance()->push(l_obj,ZaTweener::ZOOM,0,1,25+ (l_obj->m_id)*3,15);
		ZaTweener::getInstance()->push(l_obj,ZaTweener::ALPHA,0,1,25+ (l_obj->m_id)*3,15);
	}
	style ++;
}

void ZaScreenDesktop:: tweener(int id, float value)
{
	if(id == 10)
	{
		for (int i = 0 ;i < m_icon.size();i ++)
		{
			ZaObj * l_obj = m_icon[i];
			l_obj->m_visiable = false;
		}
		m_bg->m_visiable  = true;
		m_bg->m_isRGBA = true;
		m_bg->m_alpha = 0.0f;
		ZaTweener::getInstance()->push(m_bg,ZaTweener::ALPHA,0,1,0,20);
		ZaResLib::getInstance()->m_next = this;
		this->m_x = 0;
		ZaTweener::getInstance()->push(this,11,0,1,21,1);
	}
	else if (id==11)
	{
		onoff();
	}
}
void ZaScreenDesktop::processEvent(ZaEvent *env)
{
	if (env->m_type == 100)
	{
		eventtest(env);
	}
	ZaObj * l_obj = env->m_obj;
	fprintf(stderr,"-ZaScreenDesktop::processEvent-%p-%p-%d-%d-%d---\n",l_obj,this,env->m_type, env->m_x,env->m_y);
	fflush(stderr);
	if (l_obj && l_obj != this)
	{
		l_obj->processEvent(env);
	}
	callFunc(l_obj,env);
}

void ZaScreenDesktop::addListener(ZaObj * obj , int event,PTRFUN2 func )
{
	m_p[(int)obj*256+event] = func ;
}

void ZaScreenDesktop::callFunc(ZaObj * obj,  ZaEvent *env)
{
	int i = (int)obj*256 + env->m_event;
	PTRFUN2 func = m_p[i];
	if (func)
	(this->*func)(obj,env);
}

void ZaScreenDesktop::onclick(ZaObj * obj,ZaEvent *env)
{
	if (obj)
	{
		if (obj->m_id==0)
		{
			navigator_open_file("http://www.bbcubezone.com",NULL);
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
}

ZaScreenDesktop::~ZaScreenDesktop() {
	// TODO Auto-generated destructor stub
	for (uint i = 0 ;i < m_icon.size();i ++)
	{
		delete m_icon[i];
	}
}

} /* namespace bbcubezone */

