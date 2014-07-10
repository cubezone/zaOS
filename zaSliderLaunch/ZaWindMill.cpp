/*
 * ZaWindMill.cpp
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#include "ZaWindMill.h"

namespace bbcubezone {

ZaWindMill::ZaWindMill() {
	m_z = 1.0f;
	// TODO Auto-generated constructor stub

}


void ZaWindMill::drawControl()
{
	int a = m_x, b= m_y;
	getClientXY(a,b);
	for (uint i = 0 ; i < m_v.size(); i++)
	{
		ZAImage * l_img = m_v[i];
		if(l_img->m_z != 0)
			l_img->DrawImg(a+l_img->m_x,b+l_img->m_y,l_img->m_r);
	}
}


void ZaWindMill::processEvent(ZaEvent * env)
{
	env->m_event = env->m_type;
	if (env->m_type == ZaEvent::EVENT_DOWN )
	{
		///ZaTweener::getInstance()->push(this,ZaTweener::ZOOM,1,3,0,3);
		env->m_event = ZaEvent::EVENT_DOWN;
	}
	if (env->m_type == ZaEvent::EVENT_MOVE)
	{
		env->m_event = ZaEvent::EVENT_MOVE;
	}
	if (env->m_type == ZaEvent::EVENT_UP)
	{
		float l_size = 200 + 100.0f*(float) rand()/RAND_MAX;

		soundplayer_play_sound("input_keypress");
		std::vector<ZAImage *>::iterator iter;
		ZAImage * l_img ;
		for (iter = m_v.begin();iter != m_v.end();iter++)
		{
				if ((*iter)->m_z == 0)
				{
					l_img = (*iter);
					l_img->reset();

					l_img->setSize(env->m_x,env->m_y,l_size,l_size);
					ZaTweener::getInstance()->push(l_img,ZaTweener::X,l_img->m_x,m_width/2,0,150);
					ZaTweener::getInstance()->push(l_img,ZaTweener::Y,l_img->m_y,m_height/2,0,150);
					ZaTweener::getInstance()->push(l_img,ZaTweener::ROTATION,0,l_size*10,0,150);
					ZaTweener::getInstance()->push(l_img,ZaTweener::ZOOM,1,0,0,150);
					return;
				}
		}
		l_img = new ZAImage();
		l_img->LoadImg("app/native/res/fly2.png",l_size,l_size);
		l_img->setXY(env->m_x,env->m_y);
		m_v.push_back(l_img);
		//AddChild(l_img);

		ZaTweener::getInstance()->push(l_img,ZaTweener::X,l_img->m_x,m_width/2,0,150);
		ZaTweener::getInstance()->push(l_img,ZaTweener::Y,l_img->m_y,m_height/2,0,150);
		ZaTweener::getInstance()->push(l_img,ZaTweener::ROTATION,0,l_size*10,0,150);
		ZaTweener::getInstance()->push(l_img,ZaTweener::ZOOM,1,0,0,150);

		//post click;
		if (inPoint(env->m_x,env->m_y))
			env->m_event = ZaEvent::EVENT_CLICK;
	}

}

ZaWindMill::~ZaWindMill() {
	// TODO Auto-generated destructor stub
	for (uint i ; i < m_v.size(); i++)
	{
		delete m_v[i];
	}
	m_v.clear();
}

} /* namespace bbcubezone */
