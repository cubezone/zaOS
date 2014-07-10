/*
 * ZaListHis.cpp
 *
 *  Created on: 2012-10-1
 *      Author: Administrator
 */

#include "ZaListHis.h"

namespace bbcubezone {

ZaListHis::ZaListHis() {
	// TODO Auto-generated constructor stub
	m_style = 0;
	m_bookbg = new ZAImage();
	m_bookbg->LoadImg("app/native/res/bookbg.png",0,0);

	m_cover_bg = new ZAImage();
	m_cover_bg->LoadImg("app/native/res/cover_bg.png",0,0);

	// ��ʾm_delete
	AddChild(m_delete);
}

void ZaListHis::removeItem(int id)
{
	m_delete->m_visiable = false;

	m_v.erase(m_v.begin()+id);

	m_author.erase(m_author.begin()+id);

	m_lasttime.erase(m_lasttime.begin()+id);

	m_name.erase(m_name.begin()+id);

	delete m_img[id];
	m_img.erase(m_img.begin()+id);

	string bname = m_filename[id].c_str();

	m_filename.erase(m_filename.begin()+id);

	zaMySQL::getInstance()->deleteBookmark((char *)bname.c_str());
	bname  = "rm -Rf /accounts/1000/shared/books/BookReader/"+bname;
	system(bname.c_str());

};

void ZaListHis::drawControl()
{

	l_txt.init();
	l_txt.m_font =ZaResLib::getInstance()->m_font;
	int a = m_x, b= m_y;
	getClientXY(a,b);
	glEnable(GL_SCISSOR_TEST);
	glScissor(a,b,m_width,m_height);

	for (unsigned int i=0 ; i < m_v.size(); i ++)
	{
		int itempos = b + m_top - i * m_rowheight - 0.5*m_rowheight;
		if (itempos <= m_height + m_rowheight && itempos > -m_rowheight)
		{

			int l_xx = 0;
			if (m_style == 1)
				l_xx = m_width -
				sqrt(pow(m_width,2) - pow( (b + itempos) - (b + m_height/2) ,2));
			else if(m_style == 0)
				l_xx = 0;

			zaFont *l_fnt = ZaResLib::getInstance()->m_font;
			if ((int)i== m_index_temp)
				l_fnt->setcolor(1.0f,1.0f,0.5f,1.0f);
//			else if ((int)i== m_index)
//				 l_fnt->setcolor(1.0f,1.0f,0.0f,1.0f);
			else
				l_fnt->setcolor(1.0f,1.0f,1.0f,1.0f);

			m_cover_bg->setSize(m_img[i]->m_width+35,m_img[i]->m_height+40);
			m_cover_bg->DrawImg(a + l_xx +120, itempos-3,0);

			m_img[i]->m_isRGBA = false;
			m_img[i]->DrawImg(a + l_xx +120 ,itempos,0);

//			l_txt.setSize(a + l_xx +250-10, itempos- 70,
//					m_width-m_cover_bg->m_width-80,200);
//			l_txt.setcontent(m_name[i]+" ","UTF-8");
//			l_txt.drawControl();

			l_fnt->render_text(m_name[i].c_str(),0,
					a + l_xx +250, itempos+ 85,"UTF-8",m_width-m_cover_bg->m_width,5);

			l_fnt->render_text(m_author[i].c_str(),0,
					a + l_xx +250 , itempos ,"UTF-8");

			l_fnt->setcolor(0.6f,0.6f,0.6f,0.6f);
			l_fnt->render_text(m_lasttime[i].c_str(),0,
					a + l_xx +250 , itempos - 90 ,"UTF-8");
			l_fnt->setcolor(1.0f,1.0f,1.0f,1.0f);

			//m_delete->drawControl();
		}
//		fprintf(stderr,"ZaListHis::drowcontrol %d %s\n",m_top , m_v[i].c_str());
	}
	glDisable(GL_SCISSOR_TEST);
//	fprintf(stderr,"ZaListHis::drowcontrol %p %d %d %d %d\n",this,a, b,m_width,m_height);
}


void ZaListHis::init()
{
		m_v.clear();
		m_top = m_height;
		m_name.clear();
		m_author.clear();
		m_lasttime.clear();
		m_filename.clear();

		for(unsigned int i= 0 ;i < m_img.size() ; i ++)
		{
			delete m_img[i];
		}
		m_img.clear();
		zaMySQL * l_my = zaMySQL::getInstance();

		if(l_my->getreadhis(NULL))
		{
				string ls;
				for (int i = l_my->m_column ; i < (l_my->m_row +1)* l_my->m_column;i += l_my->m_column)
				{
					addlistitem(string(l_my->m_strTable[i]));
					ZAImage *l_img = new ZAImage();
					if(access(l_my->m_strTable[i+3],F_OK)>=0)
						l_img->LoadImg(l_my->m_strTable[i+3],280*0.7,280);
					else
						l_img->LoadImg("app/native/res/wt.png",280*0.7,280);
					m_img.push_back(l_img);
					m_filename.push_back(string(l_my->m_strTable[i+2]));
					m_name.push_back(string(l_my->m_strTable[i+4]));
					m_author.push_back(string(l_my->m_strTable[i+5]));
					m_lasttime.push_back(string(l_my->m_strTable[i+1]));
					ls = ls.append(l_my->m_strTable[i+4]).append(l_my->m_strTable[i+5]).append(l_my->m_strTable[i+1]);
				}
				ZaResLib::getInstance()->m_font->load_font((char*)ls.c_str(),0);
		}
}

ZaListHis::~ZaListHis() {
	// TODO Auto-generated destructor stub
	delete m_bookbg;

}

} /* namespace bbcubezone */
