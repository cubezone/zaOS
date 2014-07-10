/*
 * ZaListColor.cpp
 *
 *  Created on: 2012-10-2
 *      Author: Administrator
 */

#include "ZaListColor.h"
#include <sys/stat.h>
namespace bbcubezone {

ZaListColor::ZaListColor() {
	// TODO Auto-generated constructor stub
	m_style= 0;
}

int  ZaListColor::init(const char * lang)
{
	m_top = m_height;
	m_v.clear();
	m_v_color.clear();

	uint cmap[] =
	{
		0x000000,0xffffff,0x00ff00,0xffff00,
		0x000000,0xffff60,0xff00ff,0xffa0a0,
		0x00222b,0x00ccff,0x01bef6,0x01bef6,
		0x600000,0xeeff99,0xff00ff,0xffcc88,
		0x333333,0xf0e68c,0xcd5c5c,0xffa0a0,
		0x000000,0xcd3333,0xff00ff,0xff1493,
		0x000080,0xffffff,0xffa500,0x00ffff,
		0x000050,0xd2b48c,0xff00ff,0xffa0a0,
		0x061a3e,0x7e75b5,0x8db8c3,0x72a5e4,
		0x0e4072,0xffffff,0xff00ff,0xff00ff,
		0x005c70,0xffff80,0xffffff,0x60ffff,
		0x202020,0x7e8aa2,0xf6f3e8,0x606060,
		0x080808,0x8fff8f,0x8f5fd7,0xd7ff00,
		0x111410,0xfac5b3,0x60b0ea,0x7b5b5d,
		0xffffff,0x000000,0x00ff00,0x0000ff,
		0xe0e0e0,0x006600,0x000000,0xeb2c2c,
		0xf1efd8,0x41898a,0x416b24,0x6a3f70,
		0xdeb887,0x7e5827,0x793807,0xaa712f,
		0xffffde,0x008000,0x800080,0x7070a0,
		0xffffff,0x800000,0xff00ff,0xff00ff,
		0xffdab9,0xcd5555,0x112662,0x8010a0,
		0xffffff,0x000080,0xff00ff,0x969696,
		0xd7d7af,0x87005f,0x0000af,0x005f5f,
		0xcdcabd,0x191970,0xff00ff,0x8b4500,
		0xe0e0e0,0x2060a8,0xa030a0,0x007068,
		0xdcf0ff,0x804040,0xff00ff,0xff0d00,
		0xf0f0dd,0x0000ee,0x007f00,0x007f00,
		0xc0c0c0,0x700000,0x000000,0x336c6c
	};

	for (int i = 0 ;i < 28*4; i += 4)
	{
		char num[4];
		sprintf(num,"%d",i);
		m_v.push_back(num);
		struct color_str *p;
		p = new (struct color_str);
		p->bg = cmap[i];
		p->color_font =  cmap[i+1];
		p->color_font1 =  cmap[i+2];
		p->color_font2 =  cmap[i+3];
		m_v_color.push_back(p);
	}
	return 0;
}

void ZaListColor::drawControl()
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
				m_font->setcolor(0x0000FF);
			else  if ((int)i== m_index_temp)
				m_font->setcolor(0x00FF00);
			else
				m_font->setcolor(0xFFFFFF);
			char ln[4];
			sprintf(ln,"%d",i+1);
			m_font->render_text(ln,0, a , itempos - 10 ,"UTF-8",m_width,5);

			ZAImage::FillRect(m_v_color[i]->bg,a+l_xx+50, itempos - 0.5f*m_rowheight,
					this->m_width-30,this->m_rowheight,1);

			m_font->setcolor(m_v_color[i]->color_font);
			m_font->render_text("Normal",0,
					a + l_xx+60, itempos - 10 ,"UTF-8",m_width,5);

			m_font->setcolor(m_v_color[i]->color_font2);

			m_font->render_text("Dialog",0,
					a + l_xx+60 +150, itempos - 10,"UTF-8",m_width,5);

		}
//		fprintf(stderr,"ZaList::drowcontrol %d %s\n",m_top , m_v[i].c_str());
	}
	glDisable(GL_SCISSOR_TEST);
	ZAImage::DrawRect(a,b,m_width,m_height);
//	fprintf(stderr,"ZaListColor::drowcontrol %p %d %d %d %d\n",this,a, b,m_width,m_height);
}

ZaListColor::~ZaListColor() {
	// TODO Auto-generated destructor stub
	for (int i = 0 ;i < m_v_color.size(); i ++)
	{
		delete m_v_color[i];
	}
}

} /* namespace bbcubezone */
