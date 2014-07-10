/*
 * ZaScreenRead.cpp
 *
 *  Created on: 2012-10-2
 *      Author: Administrator
 */

#include "ZaScreenRead.h"

namespace bbcubezone
{

ZaScreenRead::ZaScreenRead()
{
	// TODO Auto-generated constructor stub

}

#define ICONSIZE  80

void ZaScreenRead::init()
{
	m_rt = new ZaRichText();
	m_rt->setSize(0, 0, m_width, m_height);
	m_rt->init();

	AddChild(m_rt);
	addListener(m_rt, ZaEvent::EVENT_CLICK, &ZaScreenRead::onclick);
	addListener(m_rt, ZaEvent::EVENT_SWIPE_RIGHT, &ZaScreenRead::onclick);
	addListener(m_rt, ZaEvent::EVENT_SWIPE_LEFT, &ZaScreenRead::onclick);
	addListener(m_rt, ZaEvent::EVENT_RT_END, &ZaScreenRead::onclick);

	m_head = new ZAImage();
	m_head->LoadImg("app/native/res/grey.png", m_width, 120);
	m_head->m_r = 180;
	m_head->setSize((int) m_width / 2, (int) m_height - 60, m_width, 120);
	AddChild(m_head);

	ZAImage *l_img = new ZAImage();
	l_img->LoadImg("app/native/res/leftback.png", ICONSIZE, ICONSIZE);
	m_back = new ZaButton();
	m_back->setImage(l_img);
	m_back->setSize(-350, -40, ICONSIZE, ICONSIZE);
//	m_head->AddChild(m_back);
//	addListener(m_back, ZaEvent::EVENT_CLICK, &ZaScreenRead::onclick);

	m_sld_a = new ZaSlider();

	ZAImage *l_img1 = new ZAImage();
	ZAImage *l_img2 = new ZAImage();
	l_img1->LoadImg("app/native/res/bg6.jpg", 0, 0);
	l_img2->LoadImg("app/native/res/jspDrag.png", 0, 0);
	m_sld_a->setImage(l_img1, l_img2);
	m_sld_a->setSize(80, m_height - 90,600, 30);
	AddChild(m_sld_a);
	addListener(m_sld_a, ZaEvent::EVENT_SLIDER_CHANGED, &ZaScreenRead::onclick);

	m_foot = new ZAImage();
	m_foot->LoadImg("app/native/res/grey.png", m_width, 120);
	m_foot->setSize((int) m_width / 2, 60, m_width, 120);
	AddChild(m_foot);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/copy.png", ICONSIZE, ICONSIZE);
	m_copy = new ZaButton();
	m_copy->setImage(l_img);
	m_copy->setSize(40, 30, ICONSIZE, ICONSIZE);
//	AddChild(m_copy);
	addListener(m_copy, ZaEvent::EVENT_CLICK, &ZaScreenRead::onclick);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/catalog.png", ICONSIZE, ICONSIZE);
	m_catalog = new ZaButton();
	m_catalog->setImage(l_img);
	m_catalog->setSize(m_width*0.2, 30, ICONSIZE, ICONSIZE);
	AddChild(m_catalog);
	addListener(m_catalog, ZaEvent::EVENT_CLICK, &ZaScreenRead::onclick);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/dict.png", ICONSIZE, ICONSIZE);
	m_dict = new ZaButton();
	m_dict->setImage(l_img);
	m_dict->setSize(m_width*0.7, 30, ICONSIZE, ICONSIZE);
//	AddChild(m_dict);
	addListener(m_dict, ZaEvent::EVENT_CLICK, &ZaScreenRead::onclick);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/font_i.png", ICONSIZE, ICONSIZE);
	m_font_conf = new ZaButton();
	m_font_conf->setImage(l_img);
	m_font_conf->setSize(m_width*0.65, 30, ICONSIZE, ICONSIZE);
	AddChild(m_font_conf);
	addListener(m_font_conf, ZaEvent::EVENT_CLICK, &ZaScreenRead::onclick);

	m_font_bg = new ZAImage();
	m_font_bg->LoadImg("app/native/res/grey2.png", m_width, m_height - 600);
	m_font_bg->setSize(m_width / 2, m_height / 2, m_width, m_height - 600);
	AddChild(m_font_bg);

	m_lst_lang = new ZaListLang();

	m_lst_lang->setSize(20, 900, m_width - 20 - 80, 100);
	m_lst_lang->m_rowheight = 40;
	m_lst_lang->init();
//	AddChild(m_lst_lang);
	addListener(m_lst_lang, ZaEvent::EVENT_LIST_SELECT, &ZaScreenRead::onclick);

	m_lst_font = new ZaListFont();
	m_lst_font->setSize(20, 520, m_width - 20 , 350);
	m_lst_font->m_rowheight = 40;
	m_lst_font->init("en");
//	AddChild(m_lst_font);
	addListener(m_lst_font, ZaEvent::EVENT_LIST_SELECT, &ZaScreenRead::onclick);

	m_lst_color = new ZaListColor();
	m_lst_color->setSize(20, 400, m_width - 20 - 200, 300);
	m_lst_color->m_rowheight = 40;
	m_lst_color->init("en");
	AddChild(m_lst_color);
	addListener(m_lst_color, ZaEvent::EVENT_LIST_SELECT,
			&ZaScreenRead::onclick);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/Theme48.png", ICONSIZE, ICONSIZE);
	m_the_me = new ZaButton();
	m_the_me->setImage(l_img);
	m_the_me->setSize(m_width - 160, 490, ICONSIZE, ICONSIZE);
	AddChild(m_the_me);
	addListener(m_the_me, ZaEvent::EVENT_CLICK, &ZaScreenRead::onclick);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/font_i.png", ICONSIZE, ICONSIZE);
	m_font_i = new ZaButton();
	m_font_i->setImage(l_img);
	//m_font_i->setSize(m_width-70, 30, ICONSIZE, ICONSIZE);
	m_font_i->setSize(m_width - 200, 750, ICONSIZE, ICONSIZE);
	AddChild(m_font_i);
	addListener(m_font_i, ZaEvent::EVENT_CLICK, &ZaScreenRead::onclick);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/font_i.png", ICONSIZE*0.7, ICONSIZE*0.7);
	m_font_d = new ZaButton();
	m_font_d->setImage(l_img);
	m_font_d->setSize(m_width - 600, 750, ICONSIZE*0.7, ICONSIZE*0.7);
	AddChild(m_font_d);
	addListener(m_font_d, ZaEvent::EVENT_CLICK, &ZaScreenRead::onclick);

	m_scroll = new ZaScroller();
	m_scroll->setSize(10, (m_height - (m_height / 2 + 100)) / 2, m_width - 20,
			m_height / 2 + 100);
	m_lab = new ZaLabel();
	m_lab->m_text = "Desc:";
	m_lab->setSize(0, m_scroll->m_height - 50, m_scroll->m_width,
			m_scroll->m_height - 50);
	m_scroll->AddChild(m_lab);
	AddChild(m_scroll);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/delete.png", ICONSIZE, ICONSIZE);
	m_delete = new ZaButton();
	m_delete->setImage(l_img);
	m_delete->setSize(m_width - 60, m_scroll->m_y + m_scroll->m_height - 60, ICONSIZE,
			ICONSIZE);
	addListener(m_delete, ZaEvent::EVENT_CLICK, &ZaScreenRead::onclick);
	AddChild(m_delete);

	m_input = new ZaInputText();
	m_input->m_text = "keyword";
	m_input->setSize(50, 900, 500, 100);
	//AddChild(m_input);
	addListener(m_input, ZaEvent::EVENT_INPUT_ENTER, &ZaScreenRead::onclick);
	m_init = true;

	//std::string dict("/accounts/1000/shared/books/dict/langdao-ec-gb");
	std::string dict(
			"/accounts/1000/shared/books/dict/oxford_advanced_learner_dictionary");

	m_dictionary = new ZaDict();
	//m_dictionary->openDict(dict);

	menu();
}

void ZaScreenRead::loading()
{
	//m_rt->openfile(ZaTweener::getInstance()->m_param.c_str());
}

void ZaScreenRead::addListener(ZaObj * obj, int event,
		PTRFUNZaScreenReader func)
{
	m_p[(int) obj * 256 + event] = func;
}

void ZaScreenRead::callFunc(ZaObj * obj, ZaEvent *env)
{
	int i = (int) obj * 256 + env->m_event;
	PTRFUNZaScreenReader func = m_p[i];
	if (func)
		(this->*func)(obj, env);
}

void ZaScreenRead::menu()
{
	m_rt->m_drawImg = false;
	m_foot->m_visiable = !m_foot->m_visiable;
	if (m_foot->m_visiable)
	{
		ZaTweener::getInstance()->push(m_copy, 2, -ICONSIZE, 30, 1, 5);
		ZaTweener::getInstance()->push(m_catalog, 2, -ICONSIZE, 30, 1, 5);
		ZaTweener::getInstance()->push(m_dict, 2, -ICONSIZE, 30, 1, 5);
		ZaTweener::getInstance()->push(m_font_conf, 2, -ICONSIZE, 30, 1, 5);
		ZaTweener::getInstance()->push(this, 12, 0, 0, 6, 1);
	}
	else
	{
		m_head->m_visiable = false;
		m_sld_a->m_visiable = false;
		m_font_bg->m_visiable = false;
		m_lst_lang->m_visiable = false;
		m_lst_font->m_visiable = false;
		m_lst_color->m_visiable = false;

		m_font_i->m_visiable = false;
		m_font_d->m_visiable = false;

		m_the_me->m_visiable = false;
		m_delete->m_visiable = false;

		if (m_rt->m_select_a.m_visiable)
		{
			m_rt->m_select_a.m_visiable = false;
			m_rt->m_select_b.m_visiable = false;
		}
		if (m_scroll->m_visiable)
		{
			m_scroll->m_visiable = false;
			m_input->m_visiable = false;
		}
		ZaTweener::getInstance()->push(m_copy, 2, 30, -ICONSIZE, 1, 5);
		ZaTweener::getInstance()->push(m_catalog, 2, 30, -ICONSIZE, 1, 5);
		ZaTweener::getInstance()->push(m_dict, 2, 30, -ICONSIZE, 1, 5);
		ZaTweener::getInstance()->push(m_font_conf, 2, 30, -ICONSIZE, 1, 5);
		ZaTweener::getInstance()->push(this, 14, 0, 0, 6, 1);
	}

}

void ZaScreenRead::recHis()
{

	char * l_sql;
	l_sql = sqlite3_mprintf(
			"delete from tab_bookmark where bookURL =  \"%s\" ;",
			m_rt->m_filename);
	zaMySQL::getInstance()->exec(l_sql);
	sqlite3_free(l_sql);
	CDateTime dt;
	dt.GetCurTime();
//	if (strcmp(m_rt->m_filename + strlen(m_rt->m_filename)-4,"epub") == 0)
	{
		if (m_rt->m_txt.m_epub.m_xml.m_docname[0] == 0)
		{
			l_sql = sqlite3_mprintf(
					"insert into tab_bookmark select %Q,%Q,%Q,%Q,"
							"%Q,%Q,'%d','%d',%Q ;", m_rt->m_filename,
					dt.GetDateTime(), m_rt->m_txt.m_hash,
					m_rt->m_txt.m_epub.m_xml.m_coverimg,
					m_rt->m_txt.fname(m_rt->m_txt.m_fn),
					m_rt->m_txt.m_epub.m_xml.m_docauthor,
					m_rt->m_txt.m_epub.m_pagecur,
					m_rt->m_txt.m_filepos - m_rt->m_txt.m_pagesize,
					m_rt->m_txt.m_epub.m_xml.m_path);
		}
		else
			l_sql = sqlite3_mprintf(
					"insert into tab_bookmark select %Q,%Q,%Q,%Q,"
							"%Q, %Q, '%d', '%d',%Q;", m_rt->m_filename,
					dt.GetDateTime(), m_rt->m_txt.m_hash,
					m_rt->m_txt.m_epub.m_xml.m_coverimg,
					m_rt->m_txt.m_epub.m_xml.m_docname,
					m_rt->m_txt.m_epub.m_xml.m_docauthor,
					m_rt->m_txt.m_epub.m_pagecur,
					m_rt->m_txt.m_filepos - m_rt->m_txt.m_pagesize,
					m_rt->m_txt.m_epub.m_xml.m_path);
		zaMySQL::getInstance()->exec(l_sql);
		sqlite3_free(l_sql);
	}
}

void ZaScreenRead::onclick(ZaObj * obj, ZaEvent *env)
{
	if (obj == m_delete)
	{
		m_delete->m_visiable = false;
		m_font_bg->m_visiable = false;
		m_scroll->m_visiable = false;
	}
	if (obj == m_copy)
	{
		if (m_rt->m_select_a.m_visiable)
		{
			string l_s;
			m_rt->getSelectText(l_s);
			if (l_s.size() > 0)
			{
				empty_clipboard();
				soundplayer_play_sound("input_keypress");
				set_clipboard_data("text/plain", l_s.length(), l_s.c_str());

			}
		}
		else
		{
			m_rt->m_select_a.m_visiable = true;
			m_rt->m_select_b.m_visiable = true;
			ZaTweener::getInstance()->push(&m_rt->m_select_a, ZaTweener::X, 0,
					m_width / 2 - 100, 0, 7);
			ZaTweener::getInstance()->push(&m_rt->m_select_a, ZaTweener::Y, 0,
					m_height / 2 + 100, 0, 7);
			ZaTweener::getInstance()->push(&m_rt->m_select_b, ZaTweener::X, 0,
					m_width / 2 + 100, 0, 7);
			ZaTweener::getInstance()->push(&m_rt->m_select_b, ZaTweener::Y, 0,
					m_height / 2 - 100, 0, 7);
		}

	}
	else if (obj == m_dict)
	{
		if (m_rt->m_select_a.m_visiable)
		{
//			m_scroll->m_visiable = true;
//			m_input->m_visiable = m_scroll->m_visiable;
//			m_font_bg->m_visiable = m_scroll->m_visiable;
//			m_delete->m_visiable = m_scroll->m_visiable;
//			m_scroll->m_top = 0;
			string l_s;
			m_rt->getSelectText(l_s);

			if (l_s.length() > 0)
			{
				ZaScreenFlash * l_flash =
						(ZaScreenFlash *) ZaResLib::getInstance()->getScreen(
								"ZaScreenFlash");
				ZaScreenBase * l_src =
						(ZaScreenBase *) ZaResLib::getInstance()->getScreen(
								"ZaScreenDict");
				l_src->m_srceencaller = this;
				l_flash->changeScreen(this, l_src, l_src, l_s.c_str(),
						ZaScreenFlash::ALPHA);
			}
		}
		else
		{
			m_rt->m_select_a.m_visiable = true;
			m_rt->m_select_b.m_visiable = true;
			ZaTweener::getInstance()->push(&m_rt->m_select_a, ZaTweener::X,
					m_dict->m_x, m_width / 2 - 100, 0, 7);
			ZaTweener::getInstance()->push(&m_rt->m_select_a, ZaTweener::Y, 0,
					m_height / 2 + 100, 0, 7);
			ZaTweener::getInstance()->push(&m_rt->m_select_b, ZaTweener::X,
					m_dict->m_x, m_width / 2 + 100, 0, 7);
			ZaTweener::getInstance()->push(&m_rt->m_select_b, ZaTweener::Y, 0,
					m_height / 2 - 100, 0, 7);
		}
	}
	else if (obj == m_input)
	{
		string l_q = m_input->m_text;
		string l_o;
		m_dictionary->queryWord(l_q, m_lab->m_text);
	}
	else if (obj == m_lst_color)
	{
		m_rt->m_Imgbg = false;
		m_rt->m_color_bg = m_lst_color->m_v_color[m_lst_color->m_index]->bg;
		m_rt->m_color_content =
				m_lst_color->m_v_color[m_lst_color->m_index]->color_font;
		m_rt->m_color_head =
				m_lst_color->m_v_color[m_lst_color->m_index]->color_font1;
		m_rt->m_color_dialog =
				m_lst_color->m_v_color[m_lst_color->m_index]->color_font2;
		m_rt->m_color_link = 0x00FF00;
	}
	else if (obj == m_font_conf)
	{
		m_font_bg->m_visiable = !m_font_bg->m_visiable;
		m_lst_lang->m_visiable = !m_lst_lang->m_visiable;
		m_lst_font->m_visiable = !m_lst_font->m_visiable;
		m_lst_color->m_visiable = !m_lst_color->m_visiable;
		m_font_i->m_visiable = !m_font_i->m_visiable;
		m_font_d->m_visiable = !m_font_d->m_visiable;
		m_the_me->m_visiable = !m_the_me->m_visiable;
	}
	else if (obj == m_lst_lang && env->m_event == ZaEvent::EVENT_LIST_SELECT)
	{
		m_lst_font->init(m_lst_lang->m_lang[m_lst_lang->m_index].c_str());
	}
	else if (obj == m_lst_font && env->m_event == ZaEvent::EVENT_LIST_SELECT)
	{
		m_rt->m_font->initbyPath(
				m_lst_font->m_path[m_lst_font->m_index].c_str(),
				m_rt->m_font->m_size);
		m_rt->changefont(m_rt->m_font->m_size);
	}
	else if (obj == m_rt && env->m_event == ZaEvent::EVENT_CLICK)
	{
		soundplayer_play_sound("input_keypress");
		menu();
	}
	else if (obj == m_rt && env->m_event == ZaEvent::EVENT_RT_END)
	{
		soundplayer_play_sound("input_keypress");
	}
	else if (obj == m_rt && env->m_event == ZaEvent::EVENT_SWIPE_RIGHT)
	{
		m_rt->getpos(m_sld_a->m_percent);
		recHis();
	}
	else if (obj == m_rt && env->m_event == ZaEvent::EVENT_SWIPE_LEFT)
	{
		m_rt->getpos(m_sld_a->m_percent);
		recHis();
	}

	else if (obj == m_font_i)
	{
		soundplayer_play_sound("input_keypress");
		m_rt->changefont(m_rt->m_font->m_size + 1);
	}
	else if (obj == m_font_d)
	{
		soundplayer_play_sound("input_keypress");
		m_rt->changefont(m_rt->m_font->m_size - 1);
	}
	else if (obj == m_sld_a)
	{
		soundplayer_play_sound("input_keypress");
		m_rt->setpos(m_sld_a->m_percent);
	}
	else if (obj == m_catalog)
	{
		menu();
		ZaScreenFlash * l_flash =
				(ZaScreenFlash *) ZaResLib::getInstance()->getScreen(
						"ZaScreenFlash");
		ZaScreenBase * l_src =
				(ZaScreenBase *) ZaResLib::getInstance()->getScreen(
						"ZaScreenCatalog");

		char l_n[10];
		sprintf(l_n, "%d", m_rt->m_txt.m_epub.m_pagecur);
		string p = l_n;
		p = m_rt->m_txt.m_hash;
		ZaTweener::getInstance()->m_param2 = l_n;
		l_flash->changeScreen(this, l_src, l_src, p.c_str(), ZaScreenFlash::UP);
	}

	else if (obj == m_the_me)
	{
		soundplayer_play_sound("input_keypress");
		static int m_theme = 0;
		m_theme++;
		if (m_theme > 8)
			m_theme = 0;
		m_rt->m_theme = m_theme;
		m_rt->m_Imgbg = true;
		if (m_theme == 0)
		{
			m_rt->m_bg.LoadImg("app/native/res/bg0.jpg", m_width, m_height);
		}
		if (m_theme == 1)
		{

			m_rt->m_bg.LoadImg("app/native/res/bg1.png", m_width, m_height);
		}
		if (m_theme == 2)
		{

			m_rt->m_bg.LoadImg("app/native/res/bg3.jpg", m_width, m_height);
		}
		if (m_theme == 3)
		{
			m_rt->m_bg.LoadImg("app/native/res/bg4.jpg", m_width, m_height);
		}
		if (m_theme == 4)
		{
			m_rt->m_bg.LoadImg("app/native/res/bg5.jpg", m_width, m_height);
		}
		if (m_theme == 5)
		{
			m_rt->m_bg.LoadImg("app/native/res/bg6.jpg", m_width, m_height);
		}
		if (m_theme == 6)
		{
			m_rt->m_bg.LoadImg("app/native/res/bg7.jpg", m_width, m_height);
		}
		if (m_theme == 7)
		{
			m_rt->m_bg.LoadImg("app/native/res/bg8.jpg", m_width, m_height);
		}
		if (m_theme == 8)
		{
			m_rt->m_bg.LoadImg("app/native/res/bg8.jpg", m_width, m_height);
		}
		if (m_theme == 9)
		{
			m_rt->m_Imgbg = false;
		}
	}
	else if (obj == m_back)
	{
		soundplayer_play_sound("input_keypress");
		m_rt->closefile();
		menu();

		ZaScreenFlash * l_flash =
				(ZaScreenFlash *) ZaResLib::getInstance()->getScreen(
						"ZaScreenFlash");
		ZaScreenBase * l_src =
				(ZaScreenBase *) ZaResLib::getInstance()->getScreen(
						"ZaScreenHis");

		l_flash->changeScreen(this, l_src, l_src, "", ZaScreenFlash::RIGHT);

	}
}

void ZaScreenRead::tweener(int id, float value)
{

	if (id == 10)
	{
		ZaResLib::getInstance()->m_next = this;
		m_x = 0;

		if (ZaTweener::getInstance()->m_param.compare("ret") == 0)
		{
		}
		else if (ZaTweener::getInstance()->m_param.length() > 3)
		{
			m_rt->m_txt.m_first = true;
			m_rt->openfile(ZaTweener::getInstance()->m_param.c_str());
			m_rt->getpos(m_sld_a->m_percent);
		}
		else
		{
			unsigned int n = atoi(ZaTweener::getInstance()->m_param.c_str());
			if (n >= 0 && n < m_rt->m_txt.m_epub.m_xml.m_pages.size())
			{
				m_rt->m_txt.m_epub.m_pagecur = n;
				m_rt->m_txt.m_epub.gethtmlpath();
				m_rt->m_txt.openfile(m_rt->m_txt.m_epub.m_pathname);
				m_rt->nextpage();
				m_rt->getpos(m_sld_a->m_percent);
			}
		}
	}
	if (id == 12)
	{
		m_head->m_visiable = true;
		m_sld_a->m_visiable = true;

		m_rt->m_drawImg = true;
	}
	if (id == 14)
	{
		m_rt->m_drawImg = true;
	}
	if (id == 11)
	{
		m_rt->m_opened = false;
	}
	if (id == 13)
	{
		m_rt->m_opened = true;
	}
}

void ZaScreenRead::processEvent(ZaEvent *env)
{
	if (env->m_type == 100)
	{
		eventtest(env);
	}
	ZaObj * l_obj = env->m_obj;
//	fprintf(stderr, "-ZaScreenMain::processEvent-%p-%p-%d-%d-%d---\n", l_obj,this, env->m_type, env->m_x, env->m_y);
	fflush(stderr);
	if (l_obj && l_obj != this)
	{
		l_obj->processEvent(env);

		callFunc(l_obj, env);
	}
}

ZaScreenRead::~ZaScreenRead()
{
	// TODO Auto-generated destructor stub
	delete m_rt;
	m_dictionary->closeDict();
	free(m_dictionary);
}

} /* namespace bbcubezone */
