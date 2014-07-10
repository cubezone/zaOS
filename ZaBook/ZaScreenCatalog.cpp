/*
 * ZaScreenCatalog.cpp
 *
 *  Created on: 2012-10-1
 *      Author: Administrator
 */

#include "ZaScreenCatalog.h"

namespace bbcubezone {

ZaScreenCatalog::ZaScreenCatalog() {
	// TODO Auto-generated constructor stub
	m_init = false;
}


void ZaScreenCatalog::init()
{
	if (m_init) return;
	m_bg = new ZAImage();
	m_bg->LoadImg("app/native/res/bg0.jpg",m_width,m_height);
	m_bg->setXY((int)m_width/2,(int)m_height/2);
	AddChild(m_bg);

	m_list = new ZaList();
	m_list->m_rowheight = 120;
	m_list->setSize(20,20,m_width-40,m_height-40);
	m_list->m_font = ZaResLib::getInstance()->m_font;
	AddChild(m_list);
	addListener(m_list,ZaEvent::EVENT_LIST_SELECT,&ZaScreenCatalog::onclick);
	m_init = true;
}

void ZaScreenCatalog::processEvent(ZaEvent *env)
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

void ZaScreenCatalog::tweener(int id, float value)
{
	if (id == 10)
	{
		ZaResLib::getInstance()->m_next = this;
		this->m_x = 0;
		m_list->m_v.clear();
		m_list->m_top = m_list->m_height ;
		m_link.clear();

		zaMySQL * l_my = zaMySQL::getInstance();
		string ls;
		if(l_my->getcatelog(ZaTweener::getInstance()->m_param.c_str()))
		{
				for (int i = 3 ; i < (l_my->m_row +1)* l_my->m_column;i += 3)
				{
					m_list->addlistitem(string(l_my->m_strTable[i+2]));
					m_link.push_back(string(l_my->m_strTable[i+1]));
					ls.append(l_my->m_strTable[i+2]).append(l_my->m_strTable[i+1]);
				}
		}
		ZaResLib::getInstance()->m_font->load_font((char*)ls.c_str(),0);
		m_list->m_index = atoi(ZaTweener::getInstance()->m_param2.c_str());
	}
	if (id == 11)
	{
		ZaScreenFlash * l_flash = (ZaScreenFlash *)ZaResLib::getInstance()->getScreen("ZaScreenFlash");
		ZaScreenBase * l_src = (ZaScreenBase *)ZaResLib::getInstance()->getScreen("ZaScreenRead");
		char l_n[10] ;
		sprintf(l_n,"%d",m_list->m_index);
		string p= l_n;
		l_flash->changeScreen(l_src,this,l_src,p.c_str(),ZaScreenFlash::DOWN);
		ZaTweener::getInstance()->push(l_src,13,0,0,16,1);
	}
}

void ZaScreenCatalog::onclick(ZaObj * obj,ZaEvent *env)
{
	if (obj == m_list)
	{
		ZaScreenBase * l_src = (ZaScreenBase *)ZaResLib::getInstance()->getScreen("ZaScreenRead");
		ZaTweener::getInstance()->push(l_src,11,0,0,0,1);
		//call push(this,11) to init the screen;
		ZaTweener::getInstance()->push(this,11,0,0,1,1);
	}
//	if (obj == m_back)
//	{
//		ZaScreenFlash * l_flash = (ZaScreenFlash *)ZaResLib::getInstance()->getScreen(0);
//		ZaScreenBase * l_src = (ZaScreenBase *)ZaResLib::getInstance()->getScreen(3);
//		char l_n[10] ;
//		sprintf(l_n,"%d",m_list->m_index);
//		string p= l_n;
//		l_flash->changeScreen(this,l_src,p.c_str(),ZaScreenFlash::RIGHT);
//	}
}

void ZaScreenCatalog::addListener(ZaObj * obj , int event,PTRFUNZaScreenCatalog func )
{
	m_p[(int)obj*256+event] = func ;
}

void ZaScreenCatalog::callFunc(ZaObj * obj,  ZaEvent *env)
{
	int i = (int)obj*256 + env->m_event;
	PTRFUNZaScreenCatalog func = m_p[i];
	if (func)
	(this->*func)(obj,env);
}

ZaScreenCatalog::~ZaScreenCatalog() {
	// TODO Auto-generated destructor stub
}

} /* namespace bbcubezone */
