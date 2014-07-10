/*
 * ZaResLib.cpp
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#include "ZaResLib.h"

namespace bbcubezone
{

ZaResLib * ZaResLib::m_reslib = NULL;
int ZaResLib::m_charnum = 8000;

ZaResLib::ZaResLib()
{
	// TODO Auto-generated constructor stub
	m_v.push_back(new ZaIcon());
	m_next = NULL;
	m_active = NULL;
	m_dict = NULL;
}

ZaResLib * ZaResLib::getInstance()
{
	if (m_reslib != NULL)
	{
		return m_reslib;
	}
	else
	{
		m_reslib = new ZaResLib();
		return m_reslib;
	}
}

void ZaResLib::init()
{
		m_reslib->m_jpg = new ZAImage();

		m_reslib->m_jpg->LoadImg("app/native/res/leftback.png", 0, 0);

		m_reslib->m_font = new zaFont();
		//m_reslib->m_font->initbyCharSet("zh-CN",9);
		//m_reslib->m_font->setcolor(1.0f,1.0f,1.0f,1.0f);

		m_reslib->m_font->fontconf("en");
		if (m_reslib->m_device == ZaResLib::PLAYBOOK)
			m_reslib->m_font->initbyPath(m_reslib->m_font->m_path, 8);
		else
			m_reslib->m_font->initbyPath(m_reslib->m_font->m_path, 7);

		char en_charmap[m_charnum * 2];
		for (int i = 0; i < m_charnum; i++)
		{
			en_charmap[i * 2] = (char) (i % 256);
			en_charmap[i * 2 + 1] = (char) (i / 256);
		}

		m_reslib->m_font->load_font(en_charmap, m_charnum * 2);
		m_reslib->m_font->fontconf("zh-CN");

		if (m_reslib->m_device == ZaResLib::PLAYBOOK)
			m_reslib->m_font->initbyPath(m_reslib->m_font->m_path, 8);
		else
			m_reslib->m_font->initbyPath(m_reslib->m_font->m_path, 8);

		m_reslib->m_font_en = new zaFont();

		if (m_reslib->m_device == ZaResLib::PLAYBOOK)
			m_reslib->m_font_en->initbyCharSet("en", 9);
		else
			m_reslib->m_font_en->initbyCharSet("en", 7);

		m_reslib->m_font_en->setcolor(1.0f, 1.0f, 1.0f, 1.0f);
		m_reslib->m_font_en_m = new zaFont();

		if (m_reslib->m_device == ZaResLib::PLAYBOOK)
			m_reslib->m_font_en_m->initbyCharSet("en", 15);
		else
			m_reslib->m_font_en_m->initbyCharSet("en", 8);

		m_reslib->m_font_en_m->setcolor(1.0f, 1.0f, 1.0f, 1.0f);
		m_reslib->m_font_en_l = new zaFont();

		if (m_reslib->m_device == ZaResLib::PLAYBOOK)
			m_reslib->m_font_en_l->initbyCharSet("en", 30);
		else
			m_reslib->m_font_en_l->initbyCharSet("en", 10);

		m_reslib->m_font_bbui = new zaFont();
		m_reslib->m_font_bbui->initbyCharSet("en", 5);

		m_reslib->m_font_en_l->setcolor(1.0f, 1.0f, 1.0f, 1.0f);

		m_reslib->m_font_rt = new zaFont();
		if (m_reslib->m_device == ZaResLib::PLAYBOOK)
			m_reslib->m_font_rt->initbyCharSet("en", 10);
		else
			m_reslib->m_font_rt->initbyCharSet("en", 9);

		m_reslib->m_font_rt->setcolor(1.0f, 1.0f, 1.0f, 1.0f);

		m_reslib->m_mp3 = new ZaMp3();
}

ZaDict *ZaResLib::getDict()
{
	if (m_dict == NULL)
	{
		//std::string dict("/accounts/1000/shared/books/dict/fundset");
		//std::string dict("/accounts/1000/shared/books/dict/bookreader");
		//std::string dict("app/native/res/dict/bookreader");

		struct dirent *ptr;
		DIR *dir;
		dir = opendir("app/native/dict");
		string dictname="";
		if (dir)
		{
			while ((ptr = readdir(dir)) != NULL) {
				if (strstr(ptr->d_name, ".dict") != 0)
				{
					dictname = ptr->d_name;
					break;
				}
			}
			closedir(dir);
		}
		int n = dictname.find(".dict");
		dictname = dictname.substr(0,n);
		string dict("app/native/dict/"+dictname);
		m_dict = new ZaDict();
		m_dict->openDict(dict);
	}
	return m_dict;
}

void ZaResLib::addScreen(string name, ZaObj * src)
{
	m_map[name] = src;
}

ZaObj * ZaResLib::getScreen(string name)
{
	if (m_map.find(name) != m_map.end())
	{
		return m_map[name];
	}
	else
	{
		ZaObj * scr = m_srcloader->LoadScreen(name, m_screenwidth ,m_screenheight);
		if (scr)
		{
			addScreen(name, scr);
			return scr;
		}
		else
		{
			throw CException(__FILE__, __LINE__,
					"ZaResLib::getScreen not found, %s", (char *) name.c_str());
			return NULL;
		}
	}
}

ZaObj *ZaResLib::getOjb(int id)
{
	return m_v[id];
}

ZaResLib::~ZaResLib()
{
	// TODO Auto-generated destructor stub
	for (int i = 0; i < m_v.size(); i++)
		delete m_v[i];

	if (m_font)
	{
		delete m_font;
		m_font = NULL;
	}
	if (m_font_rt)
	{
		delete m_font_rt;
		m_font_rt = NULL;
	}
	if (m_font_en)
	{
		delete m_font_en;
		m_font_en = NULL;
	}
	if (m_mp3)
	{
		delete m_mp3;
		m_mp3 = NULL;
	}
	if (m_dict)
	{
		m_dict->closeDict();
		delete m_dict;
		m_dict = NULL;
	}

	if (m_srcloader)
		delete m_srcloader;
	m_v.clear();
}

} /* namespace bbcubezone */
