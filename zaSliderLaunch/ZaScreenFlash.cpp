/*
 * ZaScreenFlash.cpp
 *
 *  Created on: 2012-10-1
 *      Author: Administrator
 */

#include "ZaScreenFlash.h"

namespace bbcubezone {

ZaScreenFlash::ZaScreenFlash() {
	// TODO Auto-generated constructor stub
	m_init = false;
}

//1 right<-left 2 left->right  3 alpha
void ZaScreenFlash::changeScreen(ZaScreenBase * o,ZaScreenBase * n,
		ZaScreenBase * target,
		const char *param,int type)
{
	if (type == NONE)
	{
		target->tweener(10,0);
		return;
	}
	o->draw();
	m_tweenera->LoadImgFromMemory("old screen",m_width,m_height);
	m_tweenera->setXY(m_width/2,m_height/2);

	glClear(GL_COLOR_BUFFER_BIT);
	glClearColor(0.0f,0.0f,0.0f,1.0f);
	n->setSize(0,0,m_width,m_height);
	//n->init();
	if (n->m_showloader)
		n->m_motion = true;
	n->draw();
	if (n->m_showloader)
		n->m_motion = false;
	m_tweenerb->LoadImgFromMemory("new screen",m_width,m_height);
	m_tweenerb->setXY(m_width/2,m_height/2);
	//ZaTweener::getInstance()->push(o,1,0,600,0,1);
	if (type == LEFT)
	{
		ZaTweener::getInstance()->push(m_tweenera,1,m_width/2,-m_width/2,0,15);
		ZaTweener::getInstance()->push(m_tweenerb,1,m_width*3/2,m_width/2,0,15);
	}
	else if (type == RIGHT)
	{
		ZaTweener::getInstance()->push(m_tweenera,1,m_width/2,m_width*3/2,0,15);
		ZaTweener::getInstance()->push(m_tweenerb,1,-m_width/2,m_width/2,0,15);
	}
	else if (type == UP)
	{
		m_tweenerb->m_x = m_width/2;
		//ZaTweener::getInstance()->push(m_tweenera,2,512,512+1024,0,15);
		ZaTweener::getInstance()->push(m_tweenerb,2,-m_height/2,m_height/2,0,15);
	}
	else if (type == DOWN)
	{
		m_tweenera->m_x = m_width/2;
		//ZaTweener::getInstance()->push(m_tweenera,2,512,-512,0,15);
		ZaTweener::getInstance()->push(m_tweenerb,2,m_height/2,-m_height/2,0,15);
	}
	else if (type == ALPHA)
	{
		m_tweenera->m_isRGBA = true;
		ZaTweener::getInstance()->push(m_tweenera,5,1.0f,0.0f,0,15);
		m_tweenerb->m_isRGBA = true;
		ZaTweener::getInstance()->push(m_tweenerb,5,0.0f,1.0f,0,15);
	}

	// active this flashscreen
	ZaResLib::getInstance()->m_next = this;
	m_x = 0;
	// ��ͼ�л���,���� src
	//ZaTweener::getInstance()->push(this,10,300,-300,16,1);
	// set param
	ZaTweener::getInstance()->m_param = param;
	// chang to new screen after 16 segment.

	ZaTweener::getInstance()->push(target,10,m_width/2,-m_width/2,16,1);
}


void ZaScreenFlash::init()
{
	if (m_init) return;

	m_tweenera = new ZAImage();
	m_tweenerb = new ZAImage();
	this->AddChild(m_tweenera);
	this->AddChild(m_tweenerb);
	m_init = true;
}

ZaScreenFlash::~ZaScreenFlash() {
	// TODO Auto-generated destructor stub
}

} /* namespace bbcubezone */
