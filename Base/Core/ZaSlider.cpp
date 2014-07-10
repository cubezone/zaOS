/*
 * ZaSlider.cpp
 *
 *  Created on: 2012-9-27
 *      Author: Administrator
 */

#include "ZaSlider.h"

namespace bbcubezone {

ZaSlider::ZaSlider() {
	// TODO Auto-generated constructor stub
	m_img = NULL;
	m_dot = NULL;
	m_percent = 0.0f;
	m_z = 1.0f;
	m_pressed = false;
	m_lb = new ZaLabel();
	m_lb->setSize(0,0,200,20);
	m_lb->m_parent = this;
	m_lb->m_alpha = 1.0f;
	//m_lb->setSize(0,0,100,20);
}

ZaSlider::~ZaSlider() {
	// TODO Auto-generated destructor stub
	if (m_img) {
		delete m_img;
		m_img = NULL;
	}
	if (m_dot) {
		delete m_dot;
		m_dot = NULL;
	}
	if (m_lb)
		delete m_lb;

}

void ZaSlider::setImage(ZAImage *img, ZAImage *dot) {
	if (img) {
		m_img = img;
		m_img->m_parent = this;
	} else
		throw CException(__FILE__, __LINE__, "img is NULL");
	if (dot) {
		m_dot = dot;
		m_dot->m_parent = this;
		m_dot->setXY(m_percent * m_width, m_height / 2);
	} else
		throw CException(__FILE__, __LINE__, "dot is NULL");
}

void ZaSlider::drawControl() {
//	int a = m_x, b = m_y;
//	getClientXY(a, b);
//	fprintf(stderr, "ZaSliderSwitch drawControl %p %d %d alpha %f\n", this, a,
//		b, m_alpha);
	if (m_img == NULL) {
		m_img = ZaResLib::getInstance()->m_jpg;
	}

	m_img->setXY(m_width / 2, m_height / 2);
	m_img->m_height = m_height / 5;
	m_img->m_width = m_width;
	m_img->m_alpha = m_alpha;
	m_img->m_r = m_r;
	m_img->m_z = m_z;
	//m_img->DrawImg();
	m_img->drawControl();

	char p[100];
	sprintf(p, "%.2f%%", m_percent * 100);
	m_lb->m_text = p;
	ZaResLib::getInstance()->m_font->setcolor(0.9f, 0.9f, 1.0f, m_alpha);
	m_lb->m_x = m_width * m_percent - 40;

	if (m_lb->m_y != 0)
		m_lb->draw();

	if (m_dot) {
		m_dot->setXY(m_percent * m_width, m_height / 2);
		m_dot->drawControl();
	}

//	if (m_pressed)
//	{
//		sprintf(p,"%.2f%%",m_percent*100);
//		ZaResLib::getInstance()->m_font->render_text(p,0,a+m_width*m_percent -30,b + 60,"UTF-8");
//	}
//
//	m_fog->setSize(a,b,m_width,m_height);
//	m_fog->m_alpha = m_alpha;
//	m_fog->drawControl();
}

void ZaSlider::processEvent(ZaEvent * env) {
	static int o_x, o_y;
	env->m_event = env->m_type;
	if (env->m_type == ZaEvent::EVENT_DOWN) {
		ZaTweener::getInstance()->push(m_lb, ZaTweener::Y, 0, 40, 0, 5);
		o_x = env->m_x;
		o_y = env->m_y;
		m_pressed = true;
	}
	if (env->m_type == ZaEvent::EVENT_MOVE) {
		m_lb->m_y = 40;
		if (abs(m_y - env->m_y) < 20)
			m_percent = (m_width * m_percent + env->m_x - o_x) / m_width;
		else {
			float rate = 1.0f - (((float) abs(m_y - env->m_y) - 20) / 300);
			if (rate < 0.0f)
				rate = 0.0f;
			m_percent = (m_percent * m_width + (float) (env->m_x - o_x) * rate)
					/ m_width;
		}
		if (m_percent >= 1.0f)
			m_percent = 1.0f;
		if (m_percent <= 0.0f)
			m_percent = 0.0f;

		o_x = env->m_x;
		o_y = env->m_y;
	}
	if (env->m_type == ZaEvent::EVENT_UP) {
		ZaTweener::getInstance()->push(m_lb, ZaTweener::Y, m_lb->m_y, 0, 0, 10);
		//ZaTweener::getInstance()->push(m_lb,5,1,0,0,10);
		m_pressed = false;

		//post changed;
		env->m_event = ZaEvent::EVENT_SLIDER_CHANGED;
	}
}

} /* namespace bbcubezone */
