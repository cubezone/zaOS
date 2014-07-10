/*
 * ZaScreen.cpp
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#include "ZaScreen.h"

namespace bbcubezone {

ZaScreen::ZaScreen() {
	// TODO Auto-generated constructor stub
	m_go = false;

}
void ZaScreen::init()
{
//	m_tweenerb = new ZAImage();
//	m_tweenera = new ZAImage();

	setSize(0,0,600,1024);

	m_bg = new ZAImage();
	m_bg->LoadImg("app/native/res/bg6.jpg",600,1024);
	m_bg->setXY(300,512);
	AddChild(m_bg);


	m_pic = new ZAImage();
	m_pic->LoadImg("app/native/res/kv3.png",400,490);
	m_pic->setXY(300,500);
	AddChild(m_pic);

	m_pic2 = new ZAImage();
	m_pic2->LoadImg("app/native/res/cc.jpg",380,400);
	m_pic2->setXY(0,35);
	m_pic->AddChild(m_pic2);


	m_btn_a = new ZaButton();
	m_btn_b = new ZaButton();
	m_btn_c = new ZaButton();
	m_btn_d = new ZaButton();

	m_img = new ZAImage();
	m_img->LoadImg("app/native/res/Theme48.png",0,0);
	m_btn_a->setImage(m_img);
	m_btn_a->setSize(200,200,48,48);

	m_img = new ZAImage();
	m_img->LoadImg("app/native/res/MusicFolder.png",0,0);
	m_btn_b->setImage(m_img);

	m_btn_b->setSize(260,360,128,128);

	m_img = new ZAImage();
	m_img->LoadImg("app/native/res/txtfile.png",0,0);
	m_btn_c->setImage(m_img);

	m_btn_c->setSize(170,570,48,48);

	m_img = new ZAImage();
	m_img->LoadImg("app/native/res/font_i.png",0,0);
	m_btn_d->setImage(m_img);

	m_btn_d->setSize(20,280,48,48);

	AddChild(m_btn_a);
	AddChild(m_btn_b);
	AddChild(m_btn_c);
	m_btn_c->AddChild(m_btn_d);

	addListener(m_btn_a,103,&ZaScreen::onclick);
	addListener(m_btn_b,103,&ZaScreen::onclick);
	addListener(m_btn_c,103,&ZaScreen::onclick);

	m_sld_a = new ZaSlider();
	m_sld_a->setSize(100,760,400,30);
	ZAImage *l_img = new ZAImage();
	ZAImage *l_img2 = new ZAImage();
	l_img->LoadImg("app/native/res/grey.png",0,0);
	l_img2->LoadImg("app/native/res/jspDrag.png",0,0);
	m_sld_a->setImage(l_img,l_img2);
	AddChild(m_sld_a);
	addListener(m_sld_a,ZaEvent::EVENT_SLIDER_CHANGED,&ZaScreen::onclick);


	m_sld_b = new ZaSlider();
	m_sld_b->setSize(100,160,400,20);
	l_img = new ZAImage();
	l_img2 = new ZAImage();
	l_img->LoadImg("app/native/res/grey.png",0,0);
	l_img2->LoadImg("app/native/res/jspDrag_B.png",0,0);
	m_sld_b->setImage(l_img,l_img2);
	AddChild(m_sld_b);
	addListener(m_sld_b,ZaEvent::EVENT_SLIDER_CHANGED,&ZaScreen::onclick);

	m_lab_a = new ZaLabel();
	m_lab_a->setSize(100,960,300,50);
	m_lab_a->m_text = "test file";
	AddChild(m_lab_a);

	m_lst_a = new ZaList();
	m_lst_a->setSize(500,300,100,300);
	m_lst_a->m_rowheight = 50;
	m_lst_a->addlistitem(string("11111"));
	m_lst_a->addlistitem(string("22222"));
	m_lst_a->addlistitem(string("33333"));
	m_lst_a->addlistitem(string("44444"));
	m_lst_a->addlistitem(string("55555"));
	m_lst_a->addlistitem(string("66666"));
	m_lst_a->addlistitem(string("77777"));
	m_lst_a->addlistitem(string("88888"));
	m_lst_a->addlistitem(string("99999"));
	m_lst_a->addlistitem(string("00000"));
	m_lst_a->addlistitem(string("1111"));
	m_lst_a->addlistitem(string("2222"));
	m_lst_a->addlistitem(string("3333"));
	m_lst_a->addlistitem(string("4444"));
	m_lst_a->addlistitem(string("5555"));
	m_lst_a->addlistitem(string("6666"));
	m_lst_a->addlistitem(string("7777"));
	m_lst_a->addlistitem(string("8888"));
	m_lst_a->addlistitem(string("9999"));
	m_lst_a->addlistitem(string("0000"));
	m_lst_a->addlistitem(string("111"));
	m_lst_a->addlistitem(string("222"));
	m_lst_a->addlistitem(string("333"));
	m_lst_a->addlistitem(string("444"));
	m_lst_a->addlistitem(string("555"));
	m_lst_a->addlistitem(string("666"));
	m_lst_a->addlistitem(string("777"));
	m_lst_a->addlistitem(string("888"));
	m_lst_a->addlistitem(string("999"));
	m_lst_a->addlistitem(string("000"));
	AddChild(m_lst_a);
	addListener(m_lst_a,ZaEvent::EVENT_LIST_SELECT,&ZaScreen::onclick);
}

void ZaScreen::addListener(ZaObj * obj , int event,PTRFUNZaScreen func )
{
	m_p[(int)obj*256+event] = func ;
}

void ZaScreen::callFunc(ZaObj * obj,  ZaEvent *env)
{
	int i = (int)obj*256 + env->m_event;
	PTRFUNZaScreen func = m_p[i];
	if (func)
	(this->*func)(obj,env);
}

void ZaScreen::onclick(ZaObj * obj,ZaEvent *env)
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
			ZaTweener::getInstance()->push(m_btn_c,5,0,1,0,20);
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
			ZaTweener::getInstance()->push(m_btn_c,5,1,0,0,20);
			ZaTweener::getInstance()->push(m_btn_b,7,1,2,20,20);
		}
	}
	if (obj == m_btn_b)
	{
		ZaScreenBase * l_src = (ZaScreen *)ZaResLib::getInstance()->getScreen("ZaScreenHis");
		ZaScreenFlash * l_flash = (ZaScreenFlash *)ZaResLib::getInstance()->getScreen(0);
		l_flash->changeScreen(this,l_src,l_src,"",1);
		//ZaTweener::getInstance()->push(this,10,-300,300,16,1);
	}
	if (obj == m_btn_c )
	{
		m_lst_a->m_style = 1;
		navigator_invoke("settings://general", NULL);
	}

	if (obj == m_sld_a )
	{
	   ZaTweener::getInstance()->push(m_btn_c,1,m_btn_c->m_x,500*((ZaSlider*)m_sld_a)->m_percent,0,10);
	}
	if (obj == m_sld_b )
	{
		ZaTweener::getInstance()->push(m_lab_a,1,m_lab_a->m_x,500*((ZaSlider*)m_sld_b)->m_percent,0,10);
	}
	if (obj == m_lst_a )
	{

	}
//	if (obj == m_lst_a )
//	{
//		ZaScreenBase * l_src = (ZaScreen *)ZaResLib::getInstance()->getScreen(2);
//		l_src->m_tweenera= new ZAImage();
//		l_src->m_tweenera->LoadImgFromMemory("old screen",600,1024);
//		l_src->m_tweenera->setXY(300,512);
//		l_src->setSize(0,0,600,1024);
//
//		glClear(GL_COLOR_BUFFER_BIT);
//		glClearColor(0.8f,0.8f,0.8f, 1.0f);
//		l_src->draw();
//		l_src->m_tweenerb= new ZAImage();
//		l_src->m_tweenerb->LoadImgFromMemory("new screen",600,1024);
//		l_src->m_tweenerb->setXY(300,512);
//
//		ZaTweener::getInstance()->push(this,1,0,600,0,1);
//		ZaTweener::getInstance()->push(l_src->m_tweenera,1,300,900,0,20);
//		ZaTweener::getInstance()->push(l_src->m_tweenerb,1,-300,300,0,20);
//		ZaTweener::getInstance()->push(l_src->m_tweenerb,1,300,900,20,1);
//		l_src->AddChild(l_src->m_tweenerb);
//		l_src->AddChild(l_src->m_tweenera);
//		this->m_x = 600;
//		l_src->m_x = 0;
//		ZaResLib::getInstance()->m_next = l_src;
//
//		fprintf(stderr,"------m_lst_a::onclick----%p-%d\n" ,obj,env->m_index);
//		//this->m_lab_a->m_text = env->m_index +'0';
//	}

	fprintf(stderr,"------ZaScreen::onclick----%p-%d\n" ,obj,env->m_event);
}

void ZaScreen::tweener(int id, float value)
{
	ZaScreenBase *l_src = (ZaScreen *)ZaResLib::getInstance()->getScreen("ZaScreenHis");
	ZaResLib::getInstance()->m_next = l_src;
	l_src->m_x = 0;
}

ZaScreen::~ZaScreen() {
	// TODO Auto-generated destructor stub
	delete m_btn_a;
	delete m_btn_b;
	delete m_btn_c;
	delete m_btn_d;
	delete m_img;

}

} /* namespace bbcubezone */

