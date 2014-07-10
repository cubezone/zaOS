/*
 * ZaScreenHis.cpp
 *
 *  Created on: 2012-10-1
 *      Author: Administrator
 */

#include "ZaScreenHis.h"

namespace bbcubezone {

ZaScreenHis::ZaScreenHis() {
	// TODO Auto-generated constructor stub
	m_init = false;
}


void ZaScreenHis::init()
{
	if (m_init)
		return;

	m_bg = new ZAImage();
	m_bg->LoadImg("app/native/res/bg0.jpg",m_width,m_height);
	m_bg->setXY((int)m_width/2,(int)m_height/2);
	AddChild(m_bg);

	m_list = new ZaListHis();
	m_list->m_rowheight = 310;
	m_list->setSize(0,20,m_width,m_height-40);
	AddChild(m_list);
	addListener(m_list,ZaEvent::EVENT_LIST_SELECT,&ZaScreenHis::onclick);
	addListener(m_list->m_delete,ZaEvent::EVENT_CLICK,&ZaScreenHis::onclick);

	ZAImage *l_img = new ZAImage();
	l_img->LoadImg("app/native/res/GenericFolder.png", 48, 48);
	m_dir = new ZaButton();
	m_dir->setImage(l_img);
	m_dir->setSize(m_width-100, m_height-70, 48, 48);
	AddChild(m_dir);
	addListener(m_dir, ZaEvent::EVENT_CLICK, &ZaScreenHis::onclick);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/Mailgreen.png", 48, 48);
	m_mail = new ZaButton();
	m_mail->setImage(l_img);
	m_mail->setSize(m_width-100, m_height-200, 48, 48);
	AddChild(m_mail);
	addListener(m_mail, ZaEvent::EVENT_CLICK, &ZaScreenHis::onclick);

	m_textarea = new ZaTextArea();
	m_textarea->init();
	m_textarea->setSize(0,400,600,200);
	m_textarea->setcontent("<p>aaaaa</p><p>bbbbbbbb</p><p>cccccccccc</p><p>ddddd</p><p>eeeeeeeee</p><p>ffffffff</p>","utf-8");

	//AddChild(m_textarea);

	m_init = true;
}

void ZaScreenHis::processEvent(ZaEvent *env)
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

void ZaScreenHis::tweener(int id, float value)
{
	if (id == 10)
	{
		ZaResLib::getInstance()->m_next = this;
		this->m_x = 0;

		m_list->init();
		m_list->m_index = atoi(ZaTweener::getInstance()->m_param.c_str());
	}
}

void ZaScreenHis::onclick(ZaObj * obj,ZaEvent *env)
{
	if (obj == m_list)
	{
		ZaScreenFlash * l_flash = (ZaScreenFlash *)ZaResLib::getInstance()->getScreen("ZaScreenFlash");
		ZaScreenBase * l_src = (ZaScreenBase *)ZaResLib::getInstance()->getScreen("ZaScreenRead");

		string p= m_list->m_v[ m_list->m_index];
		l_flash->changeScreen(this,l_src,l_src,p.c_str(),ZaScreenFlash::LEFT);
	}
	if (obj == m_list->m_delete)
	{
		fprintf(stderr,"-ZaScreenHis::onclick-%d---\n",m_list->m_index);
		m_list->removeItem(m_list->m_index);
	}
	if ( obj == m_dir)
	{
		ZaScreenFlash * l_flash = (ZaScreenFlash *)ZaResLib::getInstance()->getScreen("ZaScreenFlash");
		ZaScreenBase * l_src = (ZaScreenBase *)ZaResLib::getInstance()->getScreen("ZaScreenDir");

		string p= "";
		l_flash->changeScreen(this,l_src,l_src,p.c_str(),ZaScreenFlash::LEFT);
	}
	if (obj == m_mail)
	{
//		mailto:<em>comma_delimited_list_of_email_addresses</em>
//		 *   ?to=<em>comma_delimited_list_of_email_addresses</em>
//		 *   &cc=<em>comma_delimited_list_of_email_addresses</em>
//		 *   &bcc=<em>comma_delimited_list_of_email_addresses</em>
//		 *   &body=<em>body_of_message</em>
//		 *   &subject=<em>subject_of_message</em>

		string ls = "mailto";
		ls.append(":");
		ls.append("?to=bbcubezone@gmail.com");
		ls.append("&body=\n\nbug report: \n\n\n");
		ls.append("advices:\n\n\n");
		ls.append("attach epub file or URL in public:\n\n");
		ls.append("&subject=about Book Reader(v1.8.2.200) App");
		navigator_invoke(ls.c_str(),NULL);
	}

}

void ZaScreenHis::addListener(ZaObj * obj , int event,PTRFUNZaScreenHis func )
{
	m_p[(int)obj*256+event] = func ;
}

void ZaScreenHis::callFunc(ZaObj * obj,  ZaEvent *env)
{
	int i = (int)obj*256 + env->m_event;
	PTRFUNZaScreenHis func = m_p[i];
	if (func)
	(this->*func)(obj,env);
}

ZaScreenHis::~ZaScreenHis() {
	// TODO Auto-generated destructor stub
}

} /* namespace bbcubezone */
