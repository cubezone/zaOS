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
		l_btn->setSize(70+ m_width/3 * (i%3), m_height-170 - m_height/5*(i/3),128,128);
		l_btn->m_visiable = false;
		l_btn->m_id = i;

		if (i <= 9
//			&&
//			i != 1 &&
//			i != 5 &&
//			i != 6 &&
//			i != 7
			)
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
		ZaTweener::getInstance()->push(l_obj,ZaTweener::X,-200,70+ m_width/3 * (l_obj->m_id%3),25+(3-l_obj->m_id%3)*10,15);
	}

	if (style == 3)
	for (int i = m_icon.size()-1 ;i >= 0 ;i --)
	{
		ZaObj * l_obj = m_icon[i];
		l_obj->m_visiable = true;
		l_obj->m_x = m_width+200;
		ZaTweener::getInstance()->push(l_obj,ZaTweener::X,m_width +200,70+ m_width/3 * (l_obj->m_id%3),25+ (l_obj->m_id%3)*10,15);
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
	//		navigator_invoke("http://",NULL);

//			http://stackoverflow.com/questions/14530908/blackberry-10-invoking-browser
//			navigator_invoke_invocation_t *invoke = NULL;
//			navigator_invoke_invocation_create(&invoke);
//
//			navigator_invoke_invocation_set_target(invoke, "sys.browser");
//			navigator_invoke_invocation_set_action(invoke, "bb.action.OPEN");
//			navigator_invoke_invocation_set_uri(invoke, "http://stackoverflow.com");
//
//			navigator_invoke_invocation_send(invoke);
//			navigator_invoke_invocation_destroy(invoke);


//			navigator_invoke_invocation_t *iRequest = NULL;
//			navigator_invoke_invocation_create(&iRequest);
//			navigator_invoke_invocation_set_target(iRequest,"sys.appworld");
//			navigator_invoke_invocation_set_action(iRequest, "bb.action.OPEN");
//			navigator_invoke_invocation_set_uri(iRequest,  "appworld://");


//
			navigator_invoke_invocation_t *iRequest = NULL;
			navigator_invoke_invocation_create(&iRequest);
			navigator_invoke_invocation_set_target(iRequest,"sys.bbm.sharehandler");
			navigator_invoke_invocation_set_action(iRequest, "bb.action.SHARE");
			navigator_invoke_invocation_set_type(iRequest,  "text/plain");
//			// navigator_invoke_invocation_set_uri(iRequest, " http:///www.mysite.com/myphoto.png");
//			char fff[8];
//			memset(fff,0,8);
//			strcpy(fff,"1234567");
//			navigator_invoke_invocation_set_data(iRequest,fff,7);
//
//			fprintf(stderr,"-ZaScreenDesktop::navigator_invoke_invocation_t -%p --\n",iRequest);
//
			navigator_invoke_invocation_send(iRequest);

			navigator_invoke_invocation_destroy(iRequest);

//			InvokeRequest invoke_req;
//			invoke_req.setAction("bb.action.SHARE");
//			invoke_req.setTarget("sys.bbm.sharehandler");
//			invoke_req.setMimeType("text/plain");
//	     	QString ls=" fdafdsafdsa";
//			invoke_req.setData(ls.toUtf8());
//			InvokeManager tt;
//			tt.invoke(invoke_req);


			fflush(stderr);
//			bbmRequest.setTarget("sys.bbm.sharehandler");
//			bbmRequest.setAction("bb.action.SHARE");
//			bbmRequest.setData(text.toUtf8());
//			qDebug() << "share with BBM: " << text;
//			mInvokeManager->invoke(bbmRequest);
		}
		else if (obj->m_id==1)
		{
			//navigator_invoke("messages://",NULL);
			navigator_invoke_invocation_t *iRequest = NULL;
			navigator_invoke_invocation_create(&iRequest);
			navigator_invoke_invocation_set_target(iRequest,"sys.pim.uib.email.hybridcomposer");
			navigator_invoke_invocation_set_action(iRequest, "bb.action.OPEN, bb.action.SENDEMAILE");
			navigator_invoke_invocation_set_type(iRequest,"text/plain");
			char fff[500];
			memset(fff,0,500);
			//strcpy(fff,"mailto:address@domain.com?cc=address2@domain.com&bcc=address3@domain.com&subject=A%20Subject&body=That%20body");
			strcpy(fff,"mailto:?cc=&bcc=&subject=&body=");
			navigator_invoke_invocation_set_uri(iRequest,fff);

			navigator_invoke_invocation_send(iRequest);

			navigator_invoke_invocation_destroy(iRequest);
		}
		else if (obj->m_id==2)
		{
			//navigator_invoke("contacts://",NULL);
			navigator_invoke_invocation_t *iRequest = NULL;
			navigator_invoke_invocation_create(&iRequest);
			navigator_invoke_invocation_set_target(iRequest,"sys.pim.contacts.app");
			navigator_invoke_invocation_set_action(iRequest, "bb.action.OPEN");
			navigator_invoke_invocation_set_type(iRequest,"application/vnd.blackberry.contact.id");
			navigator_invoke_invocation_send(iRequest);
			navigator_invoke_invocation_destroy(iRequest);
		}
		else if (obj->m_id==3)
		{
		//	navigator_invoke("calendar://",NULL);
			navigator_invoke_invocation_t *iRequest = NULL;
			navigator_invoke_invocation_create(&iRequest);
			navigator_invoke_invocation_set_target(iRequest,"sys.pim.calendar.viewer.nav");
			navigator_invoke_invocation_set_action(iRequest, "bb.calendar.OPEN");
			navigator_invoke_invocation_set_type(iRequest,  "text/calendar");
			navigator_invoke_invocation_send(iRequest);
			navigator_invoke_invocation_destroy(iRequest);
		}
		else if (obj->m_id==4)
		{
		//	navigator_invoke("camera://photo",NULL);
			navigator_invoke_invocation_t *iRequest = NULL;
			navigator_invoke_invocation_create(&iRequest);
			navigator_invoke_invocation_set_target(iRequest,"sys.camera.card");
			navigator_invoke_invocation_set_action(iRequest, "bb.action.CAPTURE");
			navigator_invoke_invocation_set_type(iRequest,  "photo");
			navigator_invoke_invocation_send(iRequest);
			navigator_invoke_invocation_destroy(iRequest);
		}
		else if (obj->m_id==5)
		{
			navigator_invoke("photos://",NULL);
		}
		else if (obj->m_id==6)
		{
			//navigator_invoke("videos://recorded",NULL);
			navigator_invoke_invocation_t *iRequest = NULL;
			navigator_invoke_invocation_create(&iRequest);
			navigator_invoke_invocation_set_target(iRequest,"sys.camera.card");
			navigator_invoke_invocation_set_action(iRequest, "bb.action.CAPTURE");
			navigator_invoke_invocation_set_type(iRequest,  "video");
			navigator_invoke_invocation_send(iRequest);
			navigator_invoke_invocation_destroy(iRequest);
		}
		else if (obj->m_id==7)
		{
			//navigator_invoke("music://",NULL);
			navigator_invoke_invocation_t *iRequest = NULL;
			navigator_invoke_invocation_create(&iRequest);
			navigator_invoke_invocation_set_target(iRequest,"sys.mediaplayer.previewer.app");
			navigator_invoke_invocation_send(iRequest);
			navigator_invoke_invocation_destroy(iRequest);

		}
		else if (obj->m_id==8)
		{
			//navigator_invoke("settings://about",NULL);
			navigator_invoke_invocation_t *iRequest = NULL;
			navigator_invoke_invocation_create(&iRequest);
			navigator_invoke_invocation_set_target(iRequest,"sys.settings.target");
			navigator_invoke_invocation_set_action(iRequest, "bb.action.OPEN");
			navigator_invoke_invocation_set_type(iRequest,  "settings/view");
			navigator_invoke_invocation_set_uri(iRequest, "settings://about");
			navigator_invoke_invocation_send(iRequest);
			navigator_invoke_invocation_destroy(iRequest);
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

