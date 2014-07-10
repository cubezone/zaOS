/*
 * ZaTweener.cpp
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#include "ZaTweener.h"


namespace bbcubezone {

ZaTweener * ZaTweener::m_tweener = ZaTweener::getInstance();

ZaTweener::ZaTweener() {
	// TODO Auto-generated constructor stub

}

ZaTweener * ZaTweener::getInstance()
{
	if (m_tweener != NULL)
	{
		return m_tweener;
	}
	else
	{
		m_tweener = new  ZaTweener();
		return m_tweener;
	}
}

/*
 * type: 1 x, 2, y ,3 ,w ,4 h, 5 alpha 6 r  7 z;
 */
void ZaTweener::push(ZaObj * obj,int type, float o, float n, int begin_seg,int segs)
{
	str_tween * t= new str_tween;
	t->obj = obj;
	t->type = type;
	t->o = o;
	t->n = n;
	t->begin_seg = begin_seg;
	t->segs = segs;
	t->current = 0;
	m_v.push_back(t);
}

void ZaTweener::pop(ZaObj * obj)
{
	std::list<str_tween *>::iterator it = m_v.begin();
	while(it != m_v.end())
	{
		str_tween * t = *it;
		if (t->obj == obj)
		{
			m_v.remove(*it);
			delete *it;
		}
		it ++;
	}
}

bool ZaTweener::empty()
{
	if (m_v.size()==0)
		return true;
	return false;
}
void ZaTweener::run(int& x, int& y, int& w,int& h){
	//fprintf(stderr,"ZaTweener RUN----m_v.size:%d\n",m_v.size());
	std::list<str_tween *>::iterator it = m_v.begin();
	while(it != m_v.end())
	{
		str_tween * t = *it;
		t->current ++;
		float v = 0.0f;
		int tp = t->type;
		if ( t->current > t->begin_seg)
		{
			v = (t->n - t->o)*(t->current - t->begin_seg)/t->segs;
			// 1,7 Ϊ��׼��tweener��ʽ
			if ( tp== X)
				t->obj->m_x = v+t->o;
			else if (tp == Y)
				t->obj->m_y = v+t->o;
			else if (tp == WIDTH)
				t->obj->m_width = v+t->o;
			else if (tp == HEIGHT)
				t->obj->m_height = v+t->o;
			else if (tp == ALPHA)
				t->obj->m_alpha = v+t->o;
			else if (tp == ROTATION)
				t->obj->m_r = v+t->o;
			else if (tp == ZOOM)
				t->obj->m_z = v+t->o;
			else if (tp == PERCENT)
				t->obj->m_percent = v+t->o;
			//tp > 10 , ����obj. tweener����ʵ��
			else if (tp >= LOADSCREEN)
				t->obj->tweener(tp, v+t->o);

			t->obj->m_dirty = true;
			//t->obj->m_motion = true;

//			t->obj->getClientXY(x,y);
//			w = t->obj->m_width;
//			h = t->obj->m_height;
//			x = 0 ; y = 0 ; w = 600, h= 1024;
		}
		if (t->current - t->begin_seg >= t->segs)
		{
			//t->obj->m_motion = false;
			m_v.remove(*it);
			delete *it;
		}
	//	fprintf(stderr,"ZaTweener RUN-OBJ:%p Setp:%d type:%d Value:%f-\n",t->obj,t->current,tp,v+t->o);
		it ++;
	}
	if (m_v.size()==0)
	{
		this->m_x = 0;
		this->m_y = 0;
		this->m_h = 1024;
		this->m_w = 600;
	}
}

ZaTweener::~ZaTweener() {
	// TODO Auto-generated destructor stub
}

} /* namespace bbcubezone */
