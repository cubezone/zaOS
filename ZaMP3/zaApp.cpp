/*
 * zaApp.cpp
 *
 *  Created on: 2012-8-25
 *      Author: Administrator
 */

#include "zaApp.h"

namespace bbcubezone {

zaApp::zaApp() {
	// TODO Auto-generated constructor stub

}

zaApp::~zaApp() {
	// TODO Auto-generated destructor stub
	 delete m_GL;
	 zaMySQL::getInstance()->close_database();
	 zaMySQL::getInstance()->freeInstance();
	 delete ZaTweener::m_tweener;
	 delete ZaResLib::m_reslib;
	 delete m_active;
}

void zaApp::tweener(int id, float value)
{

}

void zaApp::onInactive()
{
	ZaResLib::getInstance()->m_mp3->setid("2");
	ZaResLib::getInstance()->m_mp3->play("/app/native/res/lock.mp3");
}

ZaScreen * zaApp::getScreen(string screen_name)
{
	if (m_v.find(screen_name) != m_v.end())
		return m_v[screen_name];
	else
		return NULL;
}

void zaApp::addScreen(string scrname, ZaScreen * screen)
{
	m_v[scrname] = screen;
}


int zaApp::init()
{
//	curl("http://www.bbcubezone.com/app/bb/Chinese%20IME/image001.png",
//			 "/accounts/1000/shared/documents/a.png");
//
	mkdir("/accounts/1000/shared/books/BookReader",0775);
	//	system("cp app/native/res/tt.epub /accounts/1000/shared/books/tt.epub");
	mkdir("data",0775);
	if (access("/accounts/1000/shared/books/BOOKREADERRESET.TXT",F_OK)>=0)
	{
		system("rm -Rf /accounts/1000/shared/books/BookReader/*");
		system("rm -Rf data/*.db");
		system("rm -Rf /accounts/1000/shared/books/TxtReader1012.db");
	}
	zaMySQL * l_sql = zaMySQL::getInstance();
	l_sql->create_database("data/TxtReader1012.db");
	l_sql->createbookdb();

	m_GL = new zaGL();
	m_GL->init();

	if (m_GL->surface_width<768)
	{
		m_height = 1024;
		m_width = 600;
	}
	else
	{
		m_width = 768;
		m_height = 1280;
	}

	ZaScreenBase *l_main;

	l_main = new ZaScreenFlash();
	l_main->setSize(0,0,m_width,m_height);
	l_main->init();
	ZaResLib::getInstance()->addScreen("ZaScreenFlash",l_main);

//	l_main = new ZaScreen();
//	l_main->setSize(0,0,m_width,m_height);
//	l_main->init();
//	ZaResLib::getInstance()->addScreen("ZaScreen",l_main);

	l_main = new ZaScreenDir();
	l_main->setSize(0,0,m_width,m_height);
	l_main->init();
	ZaResLib::getInstance()->addScreen("ZaScreenDir",l_main);

//	l_main = new ZaScreenRead();
//	l_main->setSize(0,0,m_width,m_height);
//	l_main->init();
//	ZaResLib::getInstance()->addScreen("ZaScreenRead",l_main);
//
//	l_main = new ZaScreenCatalog();
//	l_main->setSize(0,0,m_width,m_height);
//	l_main->init();
//	ZaResLib::getInstance()->addScreen("ZaScreenCatalog",l_main);
//
//	l_main = new ZaScreenHis();
//	l_main->setSize(0,0,m_width,m_height);
//	l_main->init();
//	ZaResLib::getInstance()->addScreen("ZaScreenHis",l_main);

//	l_main = new ZaScreenWindMill();
//	l_main->setSize(0,0,m_width,m_height);
//	l_main->init();
//	ZaResLib::getInstance()->addScreen(6,l_main);

//	l_main = new ZaScreenDict();
//	l_main->setSize(0,0,m_width,m_height);
//	l_main->init();
//	ZaResLib::getInstance()->addScreen("ZaScreenDict",l_main);

	l_main = new ZaScreenMp3();
	l_main->setSize(0,0,m_width,m_height);
	l_main->init();
	ZaResLib::getInstance()->addScreen("ZaScreenMp3",l_main);

	m_active = (ZaScreenBase *)ZaResLib::getInstance()->getScreen("ZaScreenMp3");
	// active open with  param;

	m_active->tweener(10,0);

	return 0;
}

void zaApp::dispatchevent(bps_event_t *event )
{
	int domain = bps_event_get_domain(event);
			if (domain ==  screen_get_domain()) {
				int screen_val;
				int pair[2];
				screen_event_t screen_event = screen_event_get_event(event);
				screen_get_event_property_iv(screen_event, SCREEN_PROPERTY_TYPE,
						&screen_val);
				screen_get_event_property_iv(screen_event, SCREEN_PROPERTY_SOURCE_POSITION,
						pair);
				if (screen_val >= SCREEN_EVENT_MTOUCH_TOUCH &&
					screen_val <= SCREEN_EVENT_MTOUCH_RELEASE)
				{
					e.m_type = screen_val;
					e.m_x = pair[0];
					e.m_y = m_height - pair[1];
					// e.m_obj
					m_active->processEvent(&e);
				}else if(screen_val == SCREEN_EVENT_KEYBOARD)
				{
					 int key_status;
					screen_get_event_property_iv(screen_event, SCREEN_PROPERTY_KEY_FLAGS, &key_status);
					if (key_status & KEY_DOWN)
					{
						int key_code;
						screen_get_event_property_iv(screen_event, SCREEN_PROPERTY_KEY_SYM,&key_code);
						e.m_type = screen_val;
						e.m_keycode = key_code;
						m_active->processEvent(&e);
					}
				}
				else if (screen_val == SCREEN_EVENT_POINTER) {
					int buttons;
					static int mouse_pressed = false;
					screen_get_event_property_iv(screen_event, SCREEN_PROPERTY_BUTTONS,
					&buttons);
					e.m_event = 0;
					e.m_x = pair[0];
					e.m_y = m_height - pair[1];

					if (buttons == SCREEN_LEFT_MOUSE_BUTTON && mouse_pressed == false)
					{
						mouse_pressed = true;
						e.m_type = 100;
					}else if (mouse_pressed && buttons == SCREEN_LEFT_MOUSE_BUTTON)
					{
						e.m_type = 101;
					}else if (mouse_pressed) {
						fprintf(stderr,"2222222  btn %d, x %d ,y  %d \n", buttons,e.m_x ,e.m_y );
						mouse_pressed = false;
						e.m_type = 102;
					}
					if(e.m_type >=100 && e.m_type <= 102)
					m_active->processEvent(&e);
				}
			}
			else if (domain == navigator_get_domain() )
			{
				int cod =  bps_event_get_code(event);

				if (NAVIGATOR_WINDOW_INACTIVE  == cod)
				{
				   onInactive();
//				   ZaScreenFlash * l_flash = (ZaScreenFlash *)ZaResLib::getInstance()->getScreen("ZaScreenFlash");
//				   ZaScreenBase * l_src = (ZaScreenBase *)ZaResLib::getInstance()->getScreen("ZaScreenStart");
//				   string p= "";
//				   l_flash->changeScreen(l_src,l_src,l_src,p.c_str(),ZaScreenFlash::NONE);
				}
			}
}
void zaApp::run()
{
	ZaTweener::getInstance()->push(m_active,2,0,0,0,1);
	for(;;) {
		bps_event_t *event = NULL;

		if (!ZaTweener::getInstance()->empty())
		{
			event = NULL;
		}
		else if (bps_get_event(&event, -1)==BPS_SUCCESS)
		{
			if (event) {
				dispatchevent(event);
			}
		}
		for(;;) {
			event = NULL;
			e.m_type = 0;
			//screen_get_mtouch_event()
			// wait for ever.
			bps_get_event(&event, 0);
			if (event) {
				dispatchevent(event);
			}
			else
				break;
		}
		try
		{
			glClear(GL_COLOR_BUFFER_BIT);
			glClearColor(0.0f,0.0f,0.0f, 1.0f);
			glColor4f(1.0f,1.0f,1.0f,1.0f);
			int x=0,y=0,w=0,h=0;
			ZaTweener::getInstance()->run(x,y,w,h);
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
					m_active = (ZaScreenBase *)ZaResLib::getInstance()->m_next;
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
		}
		catch (CException &e)
		{
			fprintf(stderr,"%s",e.GetString());
		}
//		getActive();
	}
}

void zaApp::getActive()
{
}

long curlwriter(void *data, int size, int nmemb, FILE *fn)
{
    long sizes = size * nmemb;
    fwrite(data,1,sizes,fn);
    //strncat(content,(char*)data,sizes);
    return sizes;
}

int zaApp::curl(char * url,char * filename)
{
	  CURL *curl;

	  //����CURL���͵�ָ��
	 // char * cnt = (char *)malloc(5000);

	  FILE * fn= fopen(filename,"wb");
	  CURLcode res;
	  //����CURLcode���͵ı���
	    curl = curl_easy_init();
	    	//��ʼ��һ��CURL���͵�ָ��
	  if(curl!=NULL)    {
	    	 	//����curlѡ��. ����CURLOPT_URL�����û�ָ��url. argv[1]�д�ŵ������д���������ַ
	   curl_easy_setopt(curl, CURLOPT_URL, url);
	   res = curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, curlwriter);
	   res = curl_easy_setopt(curl, CURLOPT_WRITEDATA, fn);
	  //����curl_easy_perform ִ�����ǵ�����.��������صĲ���. ������ֻ����Ļ����ʾ����.
	   res = curl_easy_perform(curl);	//���curl����.
	   if(CURLE_OK == res) {
	   char *ct;
	   res = curl_easy_getinfo(curl, CURLINFO_CONTENT_TYPE, &ct);
	   double length = 0;
	   res = curl_easy_getinfo(curl, CURLINFO_CONTENT_LENGTH_DOWNLOAD , &length);

	   if (res != CURLE_OK )
		   curl_easy_cleanup(curl);
	   }
	   curl_easy_cleanup(curl);
	  }
	  fclose(fn);
	 return 0;
}

} /* namespace bbcubezone */
