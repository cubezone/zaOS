/*
 * ZaScreenDict.cpp
 *
 *  Created on: 2012-10-1
 *      Author: Administrator
 */

#include "ZaScreenDict.h"

namespace bbcubezone
{

ZaScreenDict::ZaScreenDict()
{
	// TODO Auto-generated constructor stub
	m_showloader = true;
	m_dict = NULL;
}

void ZaScreenDict::init()
{
	if (m_init)
		return;

	m_bg = new ZAImage();
	m_bg->LoadImg("app/native/res/bg0.jpg", m_width, m_height);
	m_bg->setXY((int) m_width / 2, (int) m_height / 2);
	AddChild(m_bg);

	m_loader.m_parent = this;

//	m_list = new ZaList();
//	m_list->m_rowheight = 50;
//	m_list->setSize(50, 50, m_width - 100, m_height - 100);
//	m_list->m_font = ZaResLib::getInstance()->m_font_rt;
//	AddChild(m_list);
//	addListener(m_list,ZaEvent::EVENT_LIST_SELECT,&ZaScreenDict::onclick);

	ZAImage *l_img = new ZAImage();
	l_img->LoadImg("app/native/res/delete.png", 48, 48);
	m_back = new ZaButton();
	m_back->setImage(l_img);
	m_back->setSize(m_width - 60, m_height - 70, 48, 48);
	AddChild(m_back);
	addListener(m_back, ZaEvent::EVENT_CLICK, &ZaScreenDict::onclick);

//	m_scroll = new ZaScroller();
//	m_scroll->setSize(50, 700, m_width - 100, m_height - 750);
//	m_lab = new ZaLabel();
//	m_lab->m_text = "explian:";
//	m_lab->setSize(0, m_scroll->m_height - 50, m_scroll->m_width,
//			m_scroll->m_height - 50);
//	m_scroll->AddChild(m_lab);
//	AddChild(m_scroll);

	m_lab = new ZaTextArea();
	m_lab->init();
	m_lab->m_font =ZaResLib::getInstance()->m_font;
	m_lab->setSize(20, 550, m_width - 100, m_height - 600);
	m_lab->setcontent("explian:","UTF-8");
	AddChild(m_lab);

	m_list = new ZaList();
	m_list->m_rowheight = 50;
	m_list->setSize(20, 330, m_width - 100, 200);
	m_list->m_font = ZaResLib::getInstance()->m_font;
	AddChild(m_list);
	addListener(m_list, ZaEvent::EVENT_LIST_SELECT, &ZaScreenDict::onclick);

	m_input = new ZaInputText();
	m_input->m_text = "words to find";
	m_input->setSize(20, 290, 500, 50);
	AddChild(m_input);
	//addListener(m_input, ZaEvent::EVENT_INPUT_ENTER, &ZaScreenDict::onclick);
	addListener(m_input, ZaEvent::EVENT_INPUT_CHAR, &ZaScreenDict::onclick);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/copy.png", 48, 48);
	m_copy = new ZaButton();
	m_copy->setImage(l_img);
	m_copy->setSize(m_width - 60,280+60, 48, 48);
	AddChild(m_copy);
	addListener(m_copy, ZaEvent::EVENT_CLICK, &ZaScreenDict::onclick);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/paste.png", 48, 48);
	m_paste = new ZaButton();
	m_paste->setImage(l_img);
	m_paste->setSize(m_width - 60,280, 48, 48);
	AddChild(m_paste);
	addListener(m_paste, ZaEvent::EVENT_CLICK, &ZaScreenDict::onclick);

	m_init = true;
}

void ZaScreenDict::drawControl()
{
	if (m_motion)
	{
		if (m_bg)
			m_bg->drawControl();
		if (m_dict)
		{
			m_loader.setSize(m_width / 2 - 110, m_height / 2, 500, 100);
			m_loader.m_text = "finding in dictionary..";
		}
		else
		{
			m_loader.setSize(m_width / 2 - 180, m_height / 2, 500, 100);
			m_loader.m_text = "loading dictionary first time ...";
		}
		m_loader.drawControl();
	}
}

void ZaScreenDict::processEvent(ZaEvent *env)
{
	if (env->m_type == 100)
	{
		eventtest(env);
	}

	if (env->m_type == SCREEN_EVENT_KEYBOARD)
		env->m_obj = m_input;

	ZaObj * l_obj = env->m_obj;
//	fprintf(stderr,"-ZaScreenMain::processEvent-%p-%p-%d-%d-%d---\n",l_obj,this,env->m_type, env->m_x,env->m_y);
	fflush(stderr);
	if (l_obj && l_obj != this)
	{
		l_obj->processEvent(env);
		callFunc(l_obj, env);

		//set focus to m_input
	}
}

string& lTrim(string &ss)
{
	string::iterator p = find_if(ss.begin(), ss.end(), not1(ptr_fun(isspace)));
	ss.erase(ss.begin(), p);
	return ss;
}

string& rTrim(string &ss)
{
	string::reverse_iterator p = find_if(ss.rbegin(), ss.rend(),
			not1(ptr_fun(isspace)));
	ss.erase(p.base(), ss.end());
	return ss;
}

string& trim(string &st)
{
	lTrim(rTrim(st));
	return st;
}

void ZaScreenDict::tweener(int id, float value)
{
	if (id == 10) // first loadd
	{
		ZaResLib::getInstance()->m_next = this;
		this->m_x = 0;

		string l_s = ZaTweener::getInstance()->m_param;

		bool  is_a = true;
		for(int i = 0 ;i < l_s.length(); i ++)
		{
			if ((unsigned char)(l_s[i]) > 0x7f)
			{
				is_a = false;
				break;
			}
		}
		if (is_a)
		{   l_s = trim(l_s);
			//std::transform(l_s.begin(), l_s.end(), l_s.begin(), ::tolower);
		}

		m_input->m_text = l_s;

		this->m_motion = true;
		ZaTweener::getInstance()->push(this, 11, 0, 0, 0, 1);
	}
	if (id == 11) //second load
	{
		m_dict = ZaResLib::getInstance()->getDict();
		//this->m_scroll->m_top = 0;

		string l_s = m_input->m_text;
		string ls_out;
		m_list->m_top=m_list->m_height;
		m_dict->queryWord(l_s, ls_out);
		if (ls_out.length() > 0)
		{
			m_list->m_index = 0;
			m_lab->setcontent(ls_out,"UTF-8");
		}
		else
		{
			m_lab->setcontent(string("not found:[").append(l_s).append("]\n"),"UTF-8");
		}
		m_list->m_v.clear();
		if (m_dict->m_index < 0)
			return;
		for (int i = m_dict->m_index; i < m_dict->m_index + 20; i++)
		{
			if (i < m_dict->m_v_idx.size())
				m_list->addlistitem(m_dict->m_v_idx[i].word);
		}
		virtualkeyboard_show();
		int v_h;
		virtualkeyboard_get_height(&v_h);
		this->m_input->m_y = v_h +30;
		this->m_paste->m_y = v_h +30;
		this->m_copy->m_y = m_height -200;
		m_motion = false;
	}
}

void ZaScreenDict::onclick(ZaObj * obj, ZaEvent *env)
{
	if (obj == m_copy)
	{
		empty_clipboard();
		set_clipboard_data("text/plain",m_lab->m_content_utf8.length(),m_lab->m_content_utf8.c_str());
	}
	if (obj == m_paste)
	{
		char * p;
		get_clipboard_data("text/plain",&p);
		if(strlen(p)>50)
		{
		  m_input->m_text = "the size of paste is over 50.";
		}
		else
		  m_input->m_text = p;
		free(p);
	}
	if (obj == m_list)
	{
		string ls_out;
		string l_s = m_list->m_v[m_list->m_index];
		m_dict->queryWord(l_s, ls_out);
		if (ls_out.length() > 0)
		{
			m_lab->setcontent(ls_out,"UTF-8");
		}
		else
		{
			m_lab->setcontent(string("not found:[").append(l_s).append("]\n"),"UTF-8");
		}

	}
	if (obj == m_input)
	{
		string l_s = m_input->m_text;
		string ls_out;
		m_dict->queryWord(l_s, ls_out);
		if (ls_out.length() > 0)
		{
			m_lab->setcontent(ls_out,"UTF-8");
		}
		else
		{
			m_lab->setcontent(string("not found:[").append(l_s).append("]\n"),"UTF-8");
		}

		m_list->m_v.clear();
		m_list->m_top = m_list->m_height;
		if (m_dict->m_index > 0)
		{
			int l_max = 50;
			for (int i = m_dict->m_index; i < m_dict->m_v_idx.size(); i++)
			{
				l_max--;
				if (stardict_strncmp(m_dict->m_v_idx[i].word.c_str(),
						m_input->m_text.c_str(), m_input->m_text.length()) == 0)
				{
					m_list->addlistitem(m_dict->m_v_idx[i].word);
				}
				else
					break;
				if (l_max == 0)
					break;
			}
		}
	}

	if (obj == m_back)
	{
		virtualkeyboard_hide();
		ZaScreenFlash * l_flash =
				(ZaScreenFlash *) ZaResLib::getInstance()->getScreen("ZaScreenFlash");
		ZaScreenBase * l_src =
				(ZaScreenBase *) ZaResLib::getInstance()->getScreen("ZaScreenRead");
		string p = "ret";
		l_flash->changeScreen(this, l_src, l_src, p.c_str(),
				ZaScreenFlash::ALPHA);
	}

}

void ZaScreenDict::addListener(ZaObj * obj, int event, PTRFUNZaScreenDict func)
{
	m_p[(int) obj * 256 + event] = func;
}

void ZaScreenDict::callFunc(ZaObj * obj, ZaEvent *env)
{
	int i = (int) obj * 256 + env->m_event;
	PTRFUNZaScreenDict func = m_p[i];
	if (func)
		(this->*func)(obj, env);
}

ZaScreenDict::~ZaScreenDict()
{
	// TODO Auto-generated destructor stub

	delete m_list;
	delete m_input;
	delete m_lab;
	//delete m_scroll;
	delete m_back;
}

} /* namespace bbcubezone */
