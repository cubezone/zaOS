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
	m_list->setSize(0,160,m_width,m_height-180);
	AddChild(m_list);
	addListener(m_list,ZaEvent::EVENT_LIST_SELECT,&ZaScreenHis::onclick);
	addListener(m_list->m_delete,ZaEvent::EVENT_CLICK,&ZaScreenHis::onclick);

	m_buttonbar = new ZAImage();
	m_buttonbar->LoadImg("app/native/res/bbui/buttonbar.png",m_width,140);
	m_buttonbar->setXY((int)m_width/2,(int)140/2);
	AddChild(m_buttonbar);

	m_lab = new ZaLabel();
	m_lab->m_text = "      Email                    Help                     Invite                    Add";
	m_lab->setfont(1.0f,1.0f,1.0f,1.0f,5);
	m_lab->setSize(10,20,m_width,40);
	AddChild(m_lab);

	ZAImage *l_img = new ZAImage();
	l_img->LoadImg("app/native/res/bbui/ic_add.png", ICONSIZE, ICONSIZE);
	m_dir = new ZaButton();
	m_dir->setImage(l_img);
	m_dir->setSize(m_width-ICONSIZE-40, 50, ICONSIZE, ICONSIZE);
	AddChild(m_dir);
	addListener(m_dir, ZaEvent::EVENT_CLICK, &ZaScreenHis::onclick);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/bbui/ic_bbm.png", ICONSIZE, ICONSIZE);
	m_dict = new ZaButton();
	m_dict->setImage(l_img);
	m_dict->setSize(m_width-ICONSIZE-40 -200, 50, ICONSIZE, ICONSIZE);
	AddChild(m_dict);
	addListener(m_dict, ZaEvent::EVENT_CLICK, &ZaScreenHis::onclick);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/bbui/ic_help.png", ICONSIZE, ICONSIZE);
	m_help = new ZaButton();
	m_help->setImage(l_img);
	m_help->setSize(m_width-ICONSIZE-40-400, 50, ICONSIZE, ICONSIZE);
	AddChild(m_help);
	addListener(m_help, ZaEvent::EVENT_CLICK, &ZaScreenHis::onclick);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/bbui/ic_email.png", ICONSIZE, ICONSIZE);
	m_mail = new ZaButton();
	m_mail->setImage(l_img);
	m_mail->setSize(m_width-ICONSIZE-40-600, 50 , ICONSIZE, ICONSIZE);
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
	else if (obj == m_list->m_delete)
	{
		fprintf(stderr,"-ZaScreenHis::onclick-%d---\n",m_list->m_index);
		m_list->removeItem(m_list->m_index);
	}
	else if ( obj == m_dict)
	{
//		ZaScreenFlash * l_flash = (ZaScreenFlash *)ZaResLib::getInstance()->getScreen("ZaScreenFlash");
//		ZaScreenBase * l_src = (ZaScreenBase *)ZaResLib::getInstance()->getScreen("ZaScreenDict");
//		l_src->m_srceencaller = this;
//		string p= "";
//		l_flash->changeScreen(this,l_src,l_src,p.c_str(),ZaScreenFlash::ALPHA);

		navigator_invoke_invocation_t *iRequest = NULL;
		navigator_invoke_invocation_create(&iRequest);
		navigator_invoke_invocation_set_target(iRequest,"sys.bbm.sharehandler");
		navigator_invoke_invocation_set_action(iRequest, "bb.action.SHARE");
		navigator_invoke_invocation_set_type(iRequest,  "text/plain");
		// navigator_invoke_invocation_set_uri(iRequest, " http:///www.mysite.com/myphoto.png");
		char fff[500];
		memset(fff,0,500);
		strcpy(fff,"download this app in BlackBerry World. http://appworld.blackberry.com/webstore/content/20352836");
		navigator_invoke_invocation_set_data(iRequest,fff,strlen(fff));
	//
	//			fprintf(stderr,"-ZaScreenDesktop::navigator_invoke_invocation_t -%p --\n",iRequest);
	//
		navigator_invoke_invocation_send(iRequest);

		navigator_invoke_invocation_destroy(iRequest);
	}
	else if (obj == m_help)
	{
		navigator_invoke("http://www.bbcubezone.com/app/bb/Book%20Reader/Content0.htm",NULL);
	}
	else if ( obj == m_dir)
	{
		ZaScreenFlash * l_flash = (ZaScreenFlash *)ZaResLib::getInstance()->getScreen("ZaScreenFlash");
		ZaScreenBase * l_src = (ZaScreenBase *)ZaResLib::getInstance()->getScreen("ZaScreenDir");

		string p= "";
		l_flash->changeScreen(this,l_src,l_src,p.c_str(),ZaScreenFlash::LEFT);

	}
	else if (obj == m_mail)
	{
//		mailto:<em>comma_delimited_list_of_email_addresses</em>
//		 *   ?to=<em>comma_delimited_list_of_email_addresses</em>
//		 *   &cc=<em>comma_delimited_list_of_email_addresses</em>
//		 *   &bcc=<em>comma_delimited_list_of_email_addresses</em>
//		 *   &body=<em>body_of_message</em>
//		 *   &subject=<em>subject_of_message</em>

//		string ls = "mailto";
//		ls.append(":");
//		ls.append("?to=bbcubezone@gmail.com");
//		ls.append("&body=\n\nbug report: \n\n\n");
//		ls.append("advices:\n\n\n");
//		ls.append("attach epub file or URL in public:\n\n");
//		ls.append("&subject=about Book Reader(v1.8.2.500) App");
//		navigator_invoke(ls.c_str(),NULL);
		navigator_invoke_invocation_t *iRequest = NULL;
		navigator_invoke_invocation_create(&iRequest);
		navigator_invoke_invocation_set_target(iRequest,"sys.pim.uib.email.hybridcomposer");
		navigator_invoke_invocation_set_action(iRequest, "bb.action.OPEN, bb.action.SENDEMAILE");
		navigator_invoke_invocation_set_type(iRequest,"text/plain");
		char fff[500];
		memset(fff,0,500);
		strcpy(fff,"mailto:bbcubezone@gmail.com?"
				"&subject=Book%20Reader(v2.0.0.207)%20for%20Z10"
				"&body=Bug%20report:\n\n\n"
				"Advices:\n\n\n"
				"Attach%20epub%20file%20or%20URL%20in%20public:\n\n\n"
				);

		navigator_invoke_invocation_set_uri(iRequest,fff);

		navigator_invoke_invocation_send(iRequest);

		navigator_invoke_invocation_destroy(iRequest);
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
