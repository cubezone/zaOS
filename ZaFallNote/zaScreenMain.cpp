/*
 * zaScreenMain.cpp
 *
 *  Created on: 2012-8-25
 *      Author: Administrator
 */

#include "zaScreenMain.h"

namespace bbcubezone
{

zaScreenMain::zaScreenMain()
{
	// TODO Auto-generated constructor stub
	m_midi = NULL;
}

void zaScreenMain::init()
{
	m_bg = new ZAImage();
	m_bg->LoadImg("app/native/res/bg5.jpg", m_width, m_height);
	m_bg->setXY(300, 512);
	AddChild(m_bg);

	m_btn_a = new ZaButton();
	m_btn_b = new ZaButton();

	m_lab_score = new ZaLabel();

	m_lab_score->m_text = "Score";
	m_lab_score->m_id = 0;
	m_lab_score->setSize(10, m_height - 100, 600, 100);
	m_lab_score->setfont(1.0f, 1.0f, 1.0f, 1.0f, 9);
	AddChild(m_lab_score);

	ZAImage *l_img = new ZAImage();
	l_img->LoadImg("app/native/res/bookmark.png", 0, 0);
	m_btn_a->setImage(l_img);
	m_btn_a->setSize(50, 900, 96, 96);
	AddChild(m_btn_a);

	m_mp3 = new ZaMPG123();
	addListener(m_btn_a, ZaEvent::EVENT_DOWN, &zaScreenMain::onclick);
	addListener(m_btn_a, ZaEvent::EVENT_CLICK, &zaScreenMain::onclick);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/bookmark.png", 0, 0);
	m_btn_b->setImage(l_img);
	m_btn_b->setSize(400, 900, 96, 96);
	AddChild(m_btn_b);

	addListener(m_btn_b, ZaEvent::EVENT_DOWN, &zaScreenMain::onclick);
	addListener(m_btn_b, ZaEvent::EVENT_CLICK, &zaScreenMain::onclick);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/key.png", 0, 0);
	for (int i = 0; i < 50; i++)
	{
		m_btn[i] = new ZaButton();
		m_btn[i]->setImage(l_img);
		m_btn[i]->setSize(50 + i * 15, 0, 96, 96);
		m_btn[i]->m_id = 0;
		AddChild(m_btn[i]);
		addListener(m_btn[i], ZaEvent::EVENT_DOWN, &zaScreenMain::onclick);
		addListener(m_btn[i], ZaEvent::EVENT_CLICK, &zaScreenMain::onclick);
	}

	addnotes();
	ZaTweener::getInstance()->m_param ="app/native/res/bb.mid";
}

void zaScreenMain::addListener(ZaObj * obj, int event, PTRFUNZaScreenMain func)
{
	m_p[(int) obj * 256 + event] = func;
}

void zaScreenMain::callFunc(ZaObj * obj, ZaEvent *env)
{
	int i = (int) obj * 256 + env->m_event;
	PTRFUNZaScreenMain func = m_p[i];
	if (func)
		(this->*func)(obj, env);
}

void zaScreenMain::onclick(ZaObj * obj, ZaEvent *env)
{

	if (obj == m_btn_a && env->m_event == ZaEvent::EVENT_DOWN)
	{
		obj->m_id = sm.play("a");
//		float r = 30.0f*rand()/RAND_MAX;
//		ZaTweener::getInstance()->push(obj,ZaTweener::Y,m_height,0,r,100);
		m_lab_score->m_id++;
		char a[10];
		sprintf(a, "%d", m_lab_score->m_id);
		m_lab_score->m_text = a;
		delete m_midi;
		m_midi = new ZaMidi();
		ZaTweener::getInstance()->pop(this);
		m_midi->Decode_Midi("app/native/res/bb.mid");
		this->tweener(11, 0);
	}
	else if (obj == m_btn_a && env->m_event == ZaEvent::EVENT_CLICK)
	{
		//stop;
	}
	else if (obj == m_btn_b && env->m_event == ZaEvent::EVENT_DOWN)
	{

		m_mp3->run();
		ZaTweener::getInstance()->pop(this);
		ZaScreenFlash * l_flash = (ZaScreenFlash *)ZaResLib::getInstance()->getScreen("ZaScreenFlash");
		ZaScreenBase * l_src = (ZaScreenBase *)ZaResLib::getInstance()->getScreen("ZaScreenDir");
		string p= "";
		l_flash->changeScreen(l_src,this,l_src,p.c_str(),ZaScreenFlash::LEFT);
		ZaTweener::getInstance()->push(l_src,13,0,0,16,1);
	}
	else if (env->m_event == ZaEvent::EVENT_DOWN)
	{
		char id[4];
		sprintf(id, "%d", obj->m_id);
		sm.play(id);
		m_lab_score->m_id++;
		char a[10];
		sprintf(a, "%d", m_lab_score->m_id);
		m_lab_score->m_text = a;
	}
	else if (env->m_event == ZaEvent::EVENT_CLICK)
	{

	}
}

void zaScreenMain::tweener(int id, float value)
{
	if (id == 10)
	{
		ZaResLib::getInstance()->m_next = this;
		this->m_x = 0;
		if (m_midi)
		{
			delete m_midi;
			m_midi = NULL;
		}

		m_midi = new ZaMidi();
		string fname = ZaTweener::getInstance()->m_param;
		if (fname.length()>0)
		{
			m_midi->Decode_Midi((char*)fname.c_str());
			this->tweener(11, 0);
		}
	}
	if (id == 11)
	{
		ZaMidiEvent *e;
		ZaButton *btn;
		m_midi->m_curtime += 7;
		while ((e = m_midi->getNext(m_midi->m_curtime)) != NULL)
		{
			//e->dump(0);
			if (e->len  > 0 )
			{
				for (int i = 0; i < 50; i++)
				{
					btn = m_btn[i];
					if (btn->m_y <= 0)
					{
						btn->m_y = m_height + 50
								- (m_midi->m_curtime - e->time);
						btn->m_x = (e->note - 65) * 30;
						btn->m_width = 50;
						btn->m_height = e->len;
						btn->m_id = e->note - 25;
						char id[4];
						sprintf(id, "%d", btn->m_id);
						sm.play(id);
						ZaTweener::getInstance()->push(btn, ZaTweener::YMOVE,
								btn->m_y, -7, 0, 300);
						break;
					}
				}
			}
		}

		ZaTweener::getInstance()->push(this, 11, 0, 0, 1, 1);
	}
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

		callFunc(l_obj, env);
	}
}

void zaScreenMain::addnotes()
{
	sm.init("");

	sm.addSong("1", "app/native/res/note/WK/WK_700_1.wav");
	sm.addSong("2", "app/native/res/note/BK/BK_700_1.wav");
	sm.addSong("3", "app/native/res/note/WK/WK_700_2.wav");
	sm.addSong("4", "app/native/res/note/BK/BK_700_2.wav");
	sm.addSong("5", "app/native/res/note/WK/WK_700_3.wav");

	sm.addSong("6", "app/native/res/note/WK/WK_700_4.wav");
	sm.addSong("7", "app/native/res/note/BK/BK_700_3.wav");
	sm.addSong("8", "app/native/res/note/WK/WK_700_5.wav");
	sm.addSong("9", "app/native/res/note/BK/BK_700_4.wav");
	sm.addSong("10", "app/native/res/note/WK/WK_700_6.wav");
	sm.addSong("11", "app/native/res/note/BK/BK_700_5.wav");
	sm.addSong("12", "app/native/res/note/WK/WK_700_7.wav");

	sm.addSong("13", "app/native/res/note/WK/WK_700_8.wav");
	sm.addSong("14", "app/native/res/note/BK/BK_700_6.wav");
	sm.addSong("15", "app/native/res/note/WK/WK_700_9.wav");
	sm.addSong("16", "app/native/res/note/BK/BK_700_7.wav");
	sm.addSong("17", "app/native/res/note/WK/WK_700_10.wav");

	sm.addSong("18", "app/native/res/note/WK/WK_700_11.wav");
	sm.addSong("19", "app/native/res/note/BK/BK_700_8.wav");
	sm.addSong("20", "app/native/res/note/WK/WK_700_12.wav");
	sm.addSong("21", "app/native/res/note/BK/BK_700_9.wav");
	sm.addSong("22", "app/native/res/note/WK/WK_700_13.wav");
	sm.addSong("23", "app/native/res/note/BK/BK_700_10.wav");
	sm.addSong("24", "app/native/res/note/WK/WK_700_14.wav");

	sm.addSong("25", "app/native/res/note/WK/WK_700_15.wav");
	sm.addSong("26", "app/native/res/note/BK/BK_700_11.wav");
	sm.addSong("27", "app/native/res/note/WK/WK_700_16.wav");
	sm.addSong("28", "app/native/res/note/BK/BK_700_12.wav");
	sm.addSong("29", "app/native/res/note/WK/WK_700_17.wav");

	sm.addSong("30", "app/native/res/note/WK/WK_700_18.wav");
	sm.addSong("31", "app/native/res/note/BK/BK_700_13.wav");
	sm.addSong("32", "app/native/res/note/WK/WK_700_19.wav");
	sm.addSong("33", "app/native/res/note/BK/BK_700_14.wav");
	sm.addSong("34", "app/native/res/note/WK/WK_700_20.wav");
	sm.addSong("35", "app/native/res/note/BK/BK_700_15.wav");
	sm.addSong("36", "app/native/res/note/WK/WK_700_21.wav");

	sm.addSong("37", "app/native/res/note/WK/WK_700_22.wav");
	sm.addSong("38", "app/native/res/note/BK/BK_700_16.wav");
	sm.addSong("39", "app/native/res/note/WK/WK_700_23.wav");
	sm.addSong("40", "app/native/res/note/BK/BK_700_17.wav");
	sm.addSong("41", "app/native/res/note/WK/WK_700_24.wav");

	sm.addSong("42", "app/native/res/note/WK/WK_700_25.wav");
	sm.addSong("43", "app/native/res/note/BK/BK_700_18.wav");
	sm.addSong("44", "app/native/res/note/WK/WK_700_26.wav");
	sm.addSong("45", "app/native/res/note/BK/BK_700_19.wav");
	sm.addSong("46", "app/native/res/note/WK/WK_700_27.wav");
	sm.addSong("47", "app/native/res/note/BK/BK_700_20.wav");
	sm.addSong("48", "app/native/res/note/WK/WK_700_28.wav");

	sm.addSong("49", "app/native/res/note/WK/WK_700_29.wav");
	sm.addSong("50", "app/native/res/note/BK/BK_700_21.wav");
	sm.addSong("51", "app/native/res/note/WK/WK_700_30.wav");
	sm.addSong("52", "app/native/res/note/BK/BK_700_22.wav");
	sm.addSong("53", "app/native/res/note/WK/WK_700_31.wav");

	sm.addSong("54", "app/native/res/note/WK/WK_700_32.wav");
	sm.addSong("55", "app/native/res/note/BK/BK_700_23.wav");
	sm.addSong("56", "app/native/res/note/WK/WK_700_33.wav");
	sm.addSong("57", "app/native/res/note/BK/BK_700_24.wav");
	sm.addSong("58", "app/native/res/note/WK/WK_700_34.wav");
	sm.addSong("59", "app/native/res/note/BK/BK_700_25.wav");
	sm.addSong("60", "app/native/res/note/WK/WK_700_35.wav");

	sm.addSong("61", "app/native/res/note/WK/WK_700_36.wav");
	sm.addSong("62", "app/native/res/note/BK/BK_700_26.wav");
	sm.addSong("63", "app/native/res/note/WK/WK_700_37.wav");
	sm.addSong("64", "app/native/res/note/BK/BK_700_27.wav");
	sm.addSong("65", "app/native/res/note/WK/WK_700_38.wav");

	sm.addSong("66", "app/native/res/note/WK/WK_700_39.wav");
	sm.addSong("67", "app/native/res/note/BK/BK_700_28.wav");
	sm.addSong("68", "app/native/res/note/WK/WK_700_40.wav");
	sm.addSong("69", "app/native/res/note/BK/BK_700_29.wav");
	sm.addSong("70", "app/native/res/note/BK/BK_700_29.wav");
	sm.addSong("71", "app/native/res/note/WK/WK_700_41.wav");
	sm.addSong("72", "app/native/res/note/BK/BK_700_30.wav");
	sm.addSong("73", "app/native/res/note/WK/WK_700_42.wav");

	sm.addSong("74", "app/native/res/note/WK/WK_700_43.wav");

}
zaScreenMain::~zaScreenMain()
{
	// TODO Auto-generated destructor stub
	delete m_btn_a;
	delete m_btn_b;
	delete m_btn_c;
	delete m_lab_score;
}

} /* namespace bbcubezone */
