/*
 * zaAppBase.cpp
 *
 *  Created on: 2012-8-25
 *      Author: Administrator
 */

#include "zaAppBase.h"

namespace bbcubezone
{

zaAppBase::zaAppBase()
{
	// TODO Auto-generated constructor stub
	m_multitouch = false;
}

zaAppBase::~zaAppBase()
{
	// TODO Auto-generated destructor stub
	bbutil_terminate();
	delete m_GL;
	zaMySQL::getInstance()->close_database();
	zaMySQL::getInstance()->freeInstance();
	delete ZaTweener::m_tweener;
	delete ZaResLib::m_reslib;
	delete m_active;
}

void zaAppBase::tweener(int id, float value)
{

}

void zaAppBase::onInactive()
{
//	ZaResLib::getInstance()->m_mp3->setid("2");
//	ZaResLib::getInstance()->m_mp3->play("/app/native/res/lock.mp3");
}

ZaScreenBase * zaAppBase::getScreen(string screen_name)
{
	if (m_v.find(screen_name) != m_v.end())
		return m_v[screen_name];
	else
		return NULL;
}

void zaAppBase::addScreen(string scrname, ZaScreenBase * screen)
{
	m_v[scrname] = screen;
}
int fontconf()
{
	FcFontSet* fs = NULL;
	FcPattern* pat = NULL;
	FcObjectSet* os = NULL;
	FcChar8* strpat = (FcChar8*) ":lang=ja";
	pat = FcNameParse(strpat);
	os = FcObjectSetBuild(FC_FAMILY, FC_CHARSET, FC_FILE, (char *) 0);
	fs = FcFontList(0, pat, os);
	if (os)
		FcObjectSetDestroy(os);
	os = NULL;
	FcPatternDestroy(pat);
	pat = NULL;
	if (!fs || fs->nfont <= 0)
		goto nofont;
	FcChar8 *family;
	FcChar8 *file;
	FcCharSet* cs;
	FcChar32 ch;
	FcUtf8ToUcs4((FcChar8*) "��", &ch, 3);
	int i;
	for (i = 0; i < fs->nfont; i++)
	{
		if (FcPatternGetCharSet(fs->fonts[i], FC_CHARSET, 0, &cs)
				!= FcResultMatch)
		{

			fprintf(stderr, "no match\n");

			FcPatternPrint(fs->fonts[i]);

			goto nofont;
		}
		if(FcPatternGetString(fs->fonts[i], FC_FAMILY, 1, &family) !=FcResultMatch)

	 if(FcPatternGetString(fs->fonts[i], FC_FAMILY, 0, &family) != FcResultMatch)
	  goto nofont;
	  printf("[%d] %s ", i, (char *)family);
	  if(FcPatternGetString(fs->fonts[i], FC_FILE, 0, &file) != FcResultMatch)

	 goto nofont;
	  printf("(%s): ", (char *)file);
	  if(FcCharSetHasChar(cs, ch)){

	 puts("Yes");
	  }else{

	 puts("No");
	  }
	}
	FcFontSetDestroy(fs);
	return 0;
	nofont: return 1;
}
int zaAppBase::init()
{
	//fontconf();

	m_GL = new zaGL();
	m_GL->init(zaGL::PORTRAIT);

	m_height = m_GL->surface_height;
	m_width  = m_GL->surface_width;

	ZaResLib * l_reslib = ZaResLib::getInstance();

	if (m_height > 1200 || m_width > 1200)
		l_reslib->m_device = ZaResLib::BB10;
	else
		l_reslib->m_device = ZaResLib::PLAYBOOK;

	l_reslib->init();

	l_reslib->m_screenwidth = m_width;
	l_reslib->m_screenheight = m_height;
	l_reslib->m_srcloader = new ZaAppRes();

	m_active = (ZaScreenBase *) l_reslib->getScreen(m_startscreen);
	m_active->tweener(10, 0);
	return 0;
}

void zaAppBase::dispatchevent(bps_event_t *event)
{
	int domain = bps_event_get_domain(event);
	if (domain == screen_get_domain())
	{
		int screen_val;
		int pair[2];
		int id;
		screen_event_t screen_event = screen_event_get_event(event);
		screen_get_event_property_iv(screen_event, SCREEN_PROPERTY_TYPE,
				&screen_val);
		screen_get_event_property_iv(screen_event,
				SCREEN_PROPERTY_SOURCE_POSITION, pair);
		screen_get_event_property_iv(screen_event, SCREEN_PROPERTY_TOUCH_ID,
				&id);

		if (screen_val >= SCREEN_EVENT_MTOUCH_TOUCH
				&& screen_val <= SCREEN_EVENT_MTOUCH_RELEASE
				&& (id == 0 || m_multitouch))
		{
			e.m_id = id;
			e.m_type = screen_val;
			e.m_x = pair[0];
			e.m_y = m_height - pair[1];
			// e.m_obj
			m_active->processEvent(&e);
		}
		else if (screen_val == SCREEN_EVENT_KEYBOARD)
		{
			int key_status;
			screen_get_event_property_iv(screen_event,
					SCREEN_PROPERTY_KEY_FLAGS, &key_status);
			if (key_status & KEY_DOWN)
			{
				int key_code;
				screen_get_event_property_iv(screen_event,
						SCREEN_PROPERTY_KEY_SYM, &key_code);
				e.m_type = screen_val;
				e.m_keycode = key_code;
				m_active->processEvent(&e);
			}
		}
		else if (screen_val == SCREEN_EVENT_POINTER)
		{
			int buttons;
			static int mouse_pressed = false;
			screen_get_event_property_iv(screen_event, SCREEN_PROPERTY_BUTTONS,
					&buttons);
			e.m_event = 0;
			e.m_x = pair[0];
			e.m_y = m_height - pair[1];
			e.m_id = id;

			if (buttons == SCREEN_LEFT_MOUSE_BUTTON && mouse_pressed == false)
			{
				mouse_pressed = true;
				e.m_type = 100; //down
			}
			else if (mouse_pressed && buttons == SCREEN_LEFT_MOUSE_BUTTON)
			{
				e.m_type = 101; //move
			}
			else if (mouse_pressed)
			{
				fprintf(stderr,"2222222  btn %d, x %d ,y  %d \n", buttons,e.m_x ,e.m_y );
				mouse_pressed = false;
				e.m_type = 102; //up
			}
			if (e.m_type >= 100 && e.m_type <= 102)
				m_active->processEvent(&e);
		}
	}
	else if (domain == navigator_get_domain())
	{
		int cod = bps_event_get_code(event);

		if (NAVIGATOR_WINDOW_INACTIVE == cod)
		{
			onInactive();
//				   ZaScreenFlash * l_flash = (ZaScreenFlash *)ZaResLib::getInstance()->getScreen("ZaScreenFlash");
//				   ZaScreenBase * l_src = (ZaScreenBase *)ZaResLib::getInstance()->getScreen("ZaScreenStart");
//				   string p= "";
//				   l_flash->changeScreen(l_src,l_src,l_src,p.c_str(),ZaScreenFlash::NONE);
		}
	}
}
void zaAppBase::run()
{
	ZaTweener::getInstance()->push(m_active, 2, 0, 0, 0, 1);
	for (;;)
	{
		bps_event_t *event = NULL;

		if (!ZaTweener::getInstance()->empty())
		{
			event = NULL;
		}
		else if (bps_get_event(&event, -1) == BPS_SUCCESS)
		{
			if (event)
			{
				dispatchevent(event);
			}
		}
		for (;;)
		{
			event = NULL;
			e.m_type = 0;
			//screen_get_mtouch_event()
			// wait for ever.
			bps_get_event(&event, 0);
			if (event)
			{
				dispatchevent(event);
			}
			else
				break;
		}
		try
		{
			glClear(GL_COLOR_BUFFER_BIT);
			glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
			glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
			int x = 0, y = 0, w = 0, h = 0;
			ZaTweener::getInstance()->run(x, y, w, h);
//			glEnable(GL_SCISSOR_TEST);
//			glScissor(0,0,600,500);
			//			glScissor(ZaTweener::getInstance()->m_x,
			//					ZaTweener::getInstance()->m_y,
			//					ZaTweener::getInstance()->m_w,
			//					ZaTweener::getInstance()->m_h);
//			glDisable(GL_SCISSOR_TEST);
			if (ZaResLib::getInstance()->m_next)
			{
				if (ZaResLib::getInstance()->m_next->m_x != 0)
				{
					ZaResLib::getInstance()->m_next->draw();
				}
				else
				{
					m_active = (ZaScreenBase *) ZaResLib::getInstance()->m_next;
					ZaResLib::getInstance()->m_next = NULL;
					m_active->draw();
				}
			}
			else
				m_active->draw();
//			if (ZaResLib::getInstance()->m_next)
//				ZaResLib::getInstance()->m_next->draw();
			glFlush();
			bbutil_swap();
		} catch (CException &e)
		{
			fprintf(stderr,"%s",e.GetString());
		}
//		getActive();
	}
}

long curlwriter(void *data, int size, int nmemb, FILE *fn)
{
	long sizes = size * nmemb;
	fwrite(data, 1, sizes, fn);
	//strncat(content,(char*)data,sizes);
	return sizes;
}

int zaAppBase::curl(char * url, char * filename)
{
	return 0;
}

} /* namespace bbcubezone */
