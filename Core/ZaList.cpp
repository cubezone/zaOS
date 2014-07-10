/*
 * ZaList.cpp
 *
 *  Created on: 2012-10-1
 *      Author: Administrator
 */

#include "ZaList.h"

namespace bbcubezone {

ZaList::ZaList() {
	// TODO Auto-generated constructor stub
	m_style = 0;
	m_rowseg = 1;

	ZAImage *l_img = new ZAImage();
	l_img->LoadImg("app/native/res/delete.png",60,60);
	m_delete = new ZaButton();
	m_delete->setImage(l_img);
	m_delete->setSize(192,200,60,60);
	m_delete->m_visiable = false;
	m_delete->m_id = 100;
	m_font = NULL;
}

void ZaList::drawControl()
{
	int a = m_x, b= m_y;
	getClientXY(a,b);
	glEnable(GL_SCISSOR_TEST);
	glScissor(a,b,m_width,m_height);

	if(!m_font)
		m_font = ZaResLib::getInstance()->m_font;
	for (unsigned int i=0 ; i < m_v.size(); i ++)
	{
		int itempos = b + m_top - (i+0.5) * m_rowheight;
		if (itempos <= b+ m_height + m_rowheight && itempos > b -m_rowheight)
		{
			int l_xx = 5;
			if (m_style == 1)
				l_xx = m_width - sqrt(
					pow(m_width,2) -
					pow( (b + itempos) - (b + m_height/2) ,2));
			else if(m_style == 0)
				l_xx = 5;
			if ((int)i==m_index)
				m_font->setcolor(1.0f,1.0f,0.0f,1.0f);
			else  if ((int)i== m_index_temp)
				m_font->setcolor(1.0f,1.0f,0.5f,1.0f);
			else
				m_font->setcolor(1.0f,1.0f,1.0f,1.0f);

			m_font->render_text(m_v[i].c_str(),0,
					a + l_xx, itempos-10,"UTF-8",m_width,5);
		}
//		fprintf(stderr,"ZaList::drowcontrol %d %s\n",m_top , m_v[i].c_str());
	}
	glDisable(GL_SCISSOR_TEST);
	ZAImage::DrawRect(a,b,m_width,m_height);
//	fprintf(stderr,"ZaList::drowcontrol %p %d %d %d %d\n",this,a, b,m_width,m_height);
}

int ZaList::setSize(int x, int y , int w, int h)
{
	ZaObj::setSize(x,y,w,h);
	m_top = h;
	return 1;
}

void ZaList::processEvent(ZaEvent * env)
{
	static int o_x , o_y;
	static int l_indy = 0;
	static int l_indx = 0;

	env->m_event = env->m_type;
		if (env->m_type == ZaEvent::EVENT_DOWN)
		{
			ZaTweener::getInstance()->pop(this);
			o_x = env->m_x ;
			o_y = env->m_y ;

			int a = m_x, b= m_y;
			getClientXY(a,b);
			l_indx = l_indy = (m_top + b - o_y)/m_rowheight;
			if (l_indy >=0 && l_indy < m_v.size())
				m_index_temp = l_indy;
			env->m_event = 100;
		}
		if (env->m_type == ZaEvent::EVENT_MOVE)
		{
			if (m_height < m_v.size()* m_rowheight)
			{
				m_top +=  env->m_y - o_y;
				if (m_top <m_height)
					m_top = m_height;
				else if (m_top >  m_v.size()* m_rowheight)
					m_top =  m_v.size()* m_rowheight;
			}

			if (abs(o_y-env->m_y)>= 4)//2
			{
				m_delete->m_visiable = false;
				l_indy = -1;
				m_index_temp = -1;
			}

			o_x = env->m_x ;
			o_y = env->m_y ;
		}
		if (env->m_type == ZaEvent::EVENT_UP)
		{
			if (m_v.size()*m_rowheight > m_height &&
			   abs(o_y - env->m_y)> 4) //2.
			{
				m_delete->m_visiable = false;
				ZaTweener::getInstance()->push(this,10,(o_y - env->m_y)*2,0,0,int(abs(o_y - env->m_y)*2));
			}
			else if (abs(o_x - env->m_x)>4 //2
					 && l_indx>=0 && l_indx<m_v.size())
			{
				m_delete->m_visiable = !m_delete->m_visiable;
				m_delete->m_y =  m_top - (l_indx ) * m_rowheight - 44;
				m_index = l_indx;
				m_index_temp = -1;
			}
			else if (inPoint(env->m_x,env->m_y) &&
				l_indy >= 0 && l_indy < m_v.size())
			{
				m_delete->m_visiable = false;
				m_index = l_indy;
				m_index_temp = -1;
				env->m_index = m_index;
				env->m_event = ZaEvent::EVENT_LIST_SELECT;
			}
		}
	ZaObj::processEvent(env);
}


void ZaList::tweener(int id, float value)
{
	if (id == 10)
	{
		m_top -= value;
		if (m_top < m_height )
			m_top = m_height;
		else if (m_top > (int) m_v.size()* m_rowheight)
			m_top =  m_v.size() * m_rowheight;
	}
}

void ZaList::addlistitem(string item)
{
	m_v.push_back(item);
}

ZaList::~ZaList() {
	// TODO Auto-generated destructor stub
	m_v.clear();
	delete m_delete;
}

} /* namespace bbcubezone */
