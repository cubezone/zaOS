/*
 * ZaRichText.cpp
 *
 *  Created on: 2012-10-2
 *      Author: Administrator
 */

#include "ZaRichText.h"

namespace bbcubezone {

ZaRichText::ZaRichText() {
	// TODO Auto-generated constructor stub
	m_opened  = false;
	m_changing = 0;
	m_drawImg = true;
	m_layout_org = 0;
	m_link.LoadImg("app/native/res/link.png",0,0);

	ZAImage * l_img = new ZAImage();
	l_img->LoadImg("app/native/res/select_b.png",0,0);
	m_select_a.setImage(l_img);
	m_select_a.setXY( 20,20);
	m_select_a.m_dragable = true;
	AddChild(&m_select_a);
	m_select_a.m_visiable =false;

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/select_e.png",0,0);
	m_select_b.setImage(l_img);
	m_select_b.setXY( 20,120);
	m_select_b.m_dragable = true;
	AddChild(&m_select_b);
	m_select_b.m_visiable =false;
}

void ZaRichText::drawControl()
{
	if (!m_opened)
	{
		m_bg.DrawImg();
		if(this->m_theme%2==0)
			m_font->setcolor(1.0f,1.0f,1.0f,1.0f);
		else
			m_font->setcolor(0.0f,0.0f, 0.0f, 1.0f);
		m_font->render_text((char*)"Loading ...",0,m_width/2-80.0f,m_height/2, "UTF-8");
		return ;
	}
	if (m_changing > 0)
	{
		glClearColor(0.0f,0.0f,0.0f, 1.0f);
		m_a.DrawImg();
		m_b.DrawImg();
		return;
	}
	m_bg.DrawImg();
	if (m_theme%2 ==0)
		m_font->setcolor(1.0f,1.0f, 1.0f, 1.0f);
	if (m_theme%2 ==1)
		m_font->setcolor(0.0f,0.0f, 0.0f, 1.0f);
	std::vector<str_char *>::iterator iter;
	bool begin_copy= false;
	for (iter = m_v.begin();iter != m_v.end();iter++)
	{
		if ((*iter)->y  < m_height -30 )
		{
			// ����ͼ, m_drawImg
			if ((*iter)->action ==10)
			{
				if (m_drawImg )
				{
					//fprintf(stderr, "ZaRichText::drawControl Image %s \n       %s\n",m_image.m_filename,(*iter)->img_path);
					if (strcmp(m_image.m_filename,(*iter)->img_path)!=0)
					m_image.LoadImg((*iter)->img_path , (*iter)->w,(*iter)->h);
					m_image.setXY((*iter)->x,(*iter)->y);
					m_image.setSize( (*iter)->w, (*iter)->h);
					m_image.DrawImg((*iter)->x,(*iter)->y,0);
					{
						if (m_theme%2 ==0)
							m_font->setcolor(1.0f,1.0f, 1.0f, 1.0f);
						if (m_theme%2 ==1)
							m_font->setcolor(0.0f,0.0f, 0.0f, 1.0f);
					}
				}
				else
				{
					m_image.setXY((*iter)->x,(*iter)->y);
					m_image.DrawFrame();
				}
			}
			if ((*iter)->action ==11)
			{
				m_link.setXY((*iter)->x,(*iter)->y);
				m_link.DrawImg((*iter)->x,(*iter)->y,0);
			    {
					if (m_theme%2 ==0)
						m_font->setcolor(1.0f,1.0f, 1.0f, 1.0f);
					if (m_theme%2 ==1)
						m_font->setcolor(0.0f,0.0f, 0.0f, 1.0f);
				}
			}

			// top and buttom
//				int ty = l_s_b->m_y;
//				int tx = l_s_b->m_x;
//				int by = l_s_e->m_y;
//				int bx = l_s_e->m_x;

				if (m_select_a.m_visiable)
				{
					ZaButton *l_s_b;
					ZaButton *l_s_e;
					if (m_select_a.m_y > m_select_b.m_y)
					{
						l_s_b = &m_select_a;
						l_s_e = &m_select_b;
					}
					else
					{
						l_s_e = &m_select_a;
						l_s_b = &m_select_b;
					}

					l_s_b = &m_select_a;
					l_s_e = &m_select_b;

					if (l_s_e->inPoint((*iter)->x,(*iter)->y+100))
					{
						begin_copy = false;
						if (m_theme%2 ==0)
							m_font->setcolor(1.0f,1.0f, 1.0f, 1.0f);
						if (m_theme%2 ==1)
							m_font->setcolor(0.0f,0.0f, 0.0f, 1.0f);
					}

					if (begin_copy)
						m_v_copy.push_back(*iter);

					if (l_s_b->inPoint((*iter)->x,(*iter)->y-60) && !begin_copy)
					{
						m_font->setcolor(1.0f,0.0f, 0.0f, 1.0f);
						begin_copy = true;
						m_v_copy.clear();
						m_v_copy.push_back(*iter);
					}

					m_font->render_text_one(m_font->m_map[(*iter)->charcode],
							(*iter)->charcode,(*iter)->x,(*iter)->y);
				}

				else if ((*iter)->action < 10 )
				{
				// 1,2 " "
				// 6,7 head
				// 8,9 link
				if ((*iter)->action ==1)
				{
					if (m_theme%2 ==0)
						m_font->setcolor(0.5f,0.5f, 1.0f, 1.0f);
					if (m_theme%2 ==1)
						m_font->setcolor(0.4f,0.4f, 0.8f, 1.0f);
				}
				if ((*iter)->action ==8)
				{
					m_font->setcolor(0.0f,1.0f, 0.0f, 1.0f);
				}


				m_font->render_text_one(m_font->m_map[(*iter)->charcode],(*iter)->charcode,(*iter)->x,(*iter)->y);

				if ((*iter)->action ==9)
				{
					m_font->setcolor(1.0f,1.0f, 1.0f, 1.0f);
				}

				if ((*iter)->action ==2)
				{
					if (m_theme%2 ==0)
						m_font->setcolor(1.0f,1.0f, 1.0f, 1.0f);
					if (m_theme%2 ==1)
						m_font->setcolor(0.0f,0.0f, 0.0f, 1.0f);
				}

				if ((*iter)->action ==6)
				{	if (m_theme%2 ==0)
					m_font->setcolor(1.0f,1.0f, 0.3f, 1.0f);
					if (m_theme%2 ==1)
						m_font->setcolor(0.3f,0.3f, 0.0f, 1.0f);
				}

				if ((*iter)->action ==7)
				{
					if (m_theme%2 ==0)
						m_font->setcolor(1.0f,1.0f, 1.0f, 1.0f);
					if (m_theme%2 ==1)
						m_font->setcolor(0.0f,0.0f, 0.0f, 1.0f);
				}
			}
		}
	}
}

void ZaRichText::init()
{
	m_font = ZaResLib::getInstance()->m_font_rt;
}

void ZaRichText::getSelectText(string & txt)
{
	if (m_select_a.m_visiable)
	{

		string ls= "aaaaaaaaaaaa";
		string l_copy;
		int ll= m_v_copy.size()*2;
		size_t inbytesleft= ll;
		size_t outbytesleft = inbytesleft*2;

		char * pin = ( char *)malloc(inbytesleft);
		char * pout = ( char *)malloc(outbytesleft);
		memset(pout,0,outbytesleft);
		unsigned char *p = (unsigned char *)pin;
		for (uint i = 0 ;i < m_v_copy.size(); i++)
		{
			*p = m_v_copy[i]->charcode%256;
			*(p+1) = m_v_copy[i]->charcode/256;
			p += 2;
		}

		 char * inbuf = pin ; // m_filepos,  file head
		 char * outbuf = pout;

		fprintf(stderr,"ZaRichText::getSelectText load begin length  %d\n",ll);

		iconv_t tt;
		tt = iconv_open("UTF-8","UTF-16LE");
		int ret = iconv(tt,&inbuf,&inbytesleft,&outbuf,&outbytesleft);
		if ( ret < 0)
		{
				fprintf(stderr,"zaFont::getSelectText load error  %d\n",errno);
				throw CException(__FILE__,__LINE__,"zaFont::load_font convert error ,filename %s","NULL");
		}
		fprintf(stderr,"ZaRichText::getSelectText sucess.len %d bytes:\n",ll-outbytesleft);
		iconv_close(tt);

		int len= strlen(pout)+1;
		if(len > 1)
		{
			txt=pout;

			//fprintf(stderr,"ZaRichText::copy  outpub %s:\n",pout);
		}
		else
			txt = "";
		free(pin);
		free(pout);
	}

}

void ZaRichText::closefile()
{
	m_txt.m_epub.reset();
	m_txt.resetcnt();
	m_opened = false;
}

void ZaRichText::openfile(const char *p)
{
	try
	{
		m_txt.m_epub.reset();
		m_txt.m_first = true;
		m_txt.resetcnt();
		strcpy(m_filename,p);
		m_txt.openfile(m_filename);
		ZaResLib::getInstance()->m_font_rt->initbyCharSet(m_txt.m_charset,0);
		m_opened = true;
		int page,f;
		if (zaMySQL::getInstance()->getreadhis(m_filename,&page,&f))
		{
			if (page > 0)
			{
				m_txt.m_epub.m_pagecur = page;
				m_txt.m_epub.gethtmlpath();
				m_txt.openfile(m_txt.m_epub.m_pathname);
			}
			ZaResLib::getInstance()->m_font_rt->initbyCharSet(m_txt.m_charset,0);
			m_txt.m_filepos = f;
			if (m_txt.m_epub.m_pagecur > m_txt.m_epub.m_xml.m_pages.size())
				throw CException(__FILE__,__LINE__,"read page is over the real size of book, %d",page);
			fprintf(stderr, "readhis  %d->%d \n", page, f);
		}
	//	zaMySQL::getInstance()->close_database();
		nextpage();
	}
	catch (CException & e)
	{
		m_txt.m_epub.reset();
		m_txt.m_first = true;
		m_txt.resetcnt();
		fprintf(stderr,e.GetString());
		strcpy(m_filename,"app/native/res/error.txt");
		m_txt.openfile(m_filename);
		m_opened = true;
	}
}

void ZaRichText::processEvent(ZaEvent * env)
{
	static int o_x , o_y;
	static int s_x , s_y;
	env->m_event = env->m_type;
	if (env->m_type == ZaEvent::EVENT_DOWN)
	{
		m_changing  = 0;
		ZaTweener::getInstance()->pop(this);
		s_x = o_x = env->m_x ;
		s_y = o_y = env->m_y ;

		int a = m_x, b= m_y;
		getClientXY(a,b);
		env->m_event = ZaEvent::EVENT_DOWN;
	}
	if (env->m_type == ZaEvent::EVENT_MOVE)
	{
		env->m_event = ZaEvent::EVENT_MOVE;

		if (m_changing==0)
		{
			if (env->m_x - o_x < -3)
			{
				m_a.LoadImgFromMemory("",m_width,m_height);
				m_a.setXY(m_width/2,m_height/2);
				m_a.m_alpha = 1.0f;
				m_a.m_isRGBA = true;
				glClear(GL_COLOR_BUFFER_BIT);
				glClearColor(0.0f,0.0f,0.0f, 1.0f);
				m_bg.DrawImg();
				if (nextpage())
				{
					m_drawImg = false;
					drawControl();
					m_drawImg = true;
					glFlush();
					m_b.LoadImgFromMemory("",m_width,m_height);
					m_b.setXY(m_width*3/2,m_height/2);
					m_changing  = 1;
				}
				else
					env->m_event = ZaEvent::EVENT_RT_END;
			}
			if (env->m_x - o_x > 3)
			{
				m_a.LoadImgFromMemory("",m_width,m_height);
				m_a.setXY(m_width/2,m_height/2);
				m_a.m_alpha = 1.0f;
				m_a.m_isRGBA = true;
				glClear(GL_COLOR_BUFFER_BIT);
				glClearColor(0.0f,0.0f,0.0f, 1.0f);
				m_bg.DrawImg();
				if (prepage())
				{
					m_drawImg = false;
					drawControl();
					m_drawImg = true;
					drawControl();
					glFlush();
					m_b.LoadImgFromMemory("",m_width,m_height);
					m_b.setXY(-m_width/2,m_height/2);
					m_changing  = 1;
				}
				else
					env->m_event = ZaEvent::EVENT_RT_END;
			}
		}
		else if (m_changing==1)
		{
			m_b.m_x += env->m_x -o_x;
			if (m_b.m_x > 900)
				m_b.m_x = 900;
			if (m_b.m_x < -300)
				m_b.m_x = -300;
			m_a.m_alpha = (float)abs(m_b.m_x-m_width/2)/(m_width*3/2);
		}

		o_x = env->m_x ;
		o_y = env->m_y ;
	}
	if (env->m_type == ZaEvent::EVENT_UP)
	{
		if (m_changing  > 0)
		{
			ZaTweener::getInstance()->push(&m_b,1,m_b.m_x,m_width/2,0,12);
			ZaTweener::getInstance()->push(this,10,NULL,NULL,12,1);
		}
		//post click;

		if (inPoint(env->m_x,env->m_y))
		{
			fprintf(stderr,"ZaRichText:EVENT AAAA \n");
			if(abs(env->m_x-s_x) + abs(env->m_y-s_y)<5)
			{
				int x = env->m_x;
				int y = env->m_y;
				fprintf(stderr,"bbbbbbbbb %d %d \n", x,y);
				std::vector<str_char *>::iterator iter;
				for (iter = m_v.begin();iter != m_v.end();iter++)
				{

					str_char *lc= *iter;
					if (lc->action == 11)
					{
						fprintf(stderr,"fdsafdsa %d %d \n", x,y);
						if (abs(lc->x -x) + abs(lc->y -y) < 50)
						{
							navigator_invoke((*iter)->img_path,NULL);
							env->m_event = ZaEvent::EVENT_CLICK_URL;
							return ;
						}
					}

				}
				env->m_event = ZaEvent::EVENT_CLICK;
			}
			if (env->m_x - s_x > 10)
			{
				env->m_event = ZaEvent::EVENT_SWIPE_RIGHT;
				//nextpage();
			}
			if (env->m_x - s_x < -10)
			{
				env->m_event = ZaEvent::EVENT_SWIPE_LEFT;
				//prepage();
			}
			fprintf(stderr,"ZaRichText:EVENT END \n");
		}
	}
}

void ZaRichText::tweener(int id, float value)
{
	m_changing = 0;
}

void ZaRichText::changefile(const char *p)
{
	if(strncmp(p,"CMD",3)==0)
	{
		int n = atoi(p+3);
		if (n>=0 && n < m_txt.m_epub.m_xml.m_pages.size())
		{
			m_txt.m_epub.m_pagecur = n;
			m_txt.m_epub.gethtmlpath();
			m_txt.openfile(m_txt.m_epub.m_pathname);
			this->nextpage();
		}
		return ;
	}
	if (strcmp(p,"CANCEL")==0)
	{
		return ;
	}
	sprintf(m_filename,"%s",p);
}

void ZaRichText::settext(char *c)
{
	;
}
int  ZaRichText::nextpage()
{
	if (m_txt.nextseg())
	{
		layout(0);
		m_txt.m_filepos += m_txt.m_pagesize;
	}
	else
		return 0;
}
int  ZaRichText::prepage()
{
	if (m_txt.preseg())
	{
		layout(1);
	}
	else
		return 0;
}

void ZaRichText::changetheme(int index)
{
	;
}

void ZaRichText::layout(int dirct)
{
	m_layout_org = dirct;

	if (m_txt.m_filetype == FILETYPE_HTML)
	{
		layouthtml(dirct);
	}
	else
	{
		layouttxt( dirct);
	}
}

void ZaRichText::layouttxt(int dirct)
{
	m_font->load_font(m_txt.m_content,m_txt.m_contentlen);
	unsigned int charcode = 0;
	char *p = m_txt.m_content;
	int len = m_txt.m_contentlen;
	int l_x=10,l_y=0;
	int line_height = m_font->m_max_y +16 ;
	int line_width = m_width;
	str_char * l_word[100];
	int l_wordcnt = 0;
	int l_wordwidth = 0;

	std::vector<str_char *>::iterator iter;
	for (iter = m_v.begin();iter != m_v.end();iter++)
	{
		if((*iter)->img_path)
			free((*iter)->img_path);
		delete (*iter);
	}

	m_v.clear();

	l_y = m_height - line_height -30;
	int cci ;

	static int l_match = 0;

	for ( cci =0 ; cci < len ; cci +=2)
	{
		charcode = ((unsigned char)*(p+1))*256+(unsigned char)*p ;

		p += 2;

		str_char * l_char ;
		l_char = (str_char *) malloc(sizeof(str_char) );
		l_char->pos = cci;
		l_char->img_path = NULL;
		l_char->charcode = charcode;
		l_char->action = 0;

		int lx ,ly;
		m_font->getcharsize(charcode,&lx,&ly);

		if ((charcode >= 'a' && charcode <= 'z' )
			||(charcode >= 'A' && charcode <= 'Z'))
		{
				l_word[l_wordcnt] = l_char;
				l_char->x = lx;
				l_wordcnt ++;
				l_wordwidth += lx;
				continue;
		}
		else
		{
			if (l_wordcnt > 0)
			{
				if (l_x + l_wordwidth > line_width )
				{
					l_y -= line_height;
					l_x = 10;
				}
				if ( dirct == 0 && l_y < 10 )
				{
					break;
				}
				for (int i =  0; i < l_wordcnt ; i++)
				{
					l_word[i]->y = l_y;
					int t = l_word[i]->x;
					l_word[i]->x = l_x;
					l_x += t;
					m_v.push_back(l_word[i]);
				}

				l_wordcnt = 0;
				l_wordwidth = 0;
			}
		}

		{
			l_word[0] = l_char;
			l_char->x = lx;
			l_wordcnt = 1 ;
			l_wordwidth = lx;
		}

		if (charcode == 0x000A)
		{
			if (l_x != 10)
				l_y -= line_height+20;
			l_x = 10;
		}
		if (charcode == 0xFFFE)
		{
			charcode = 0x0020;
		}

		if (charcode == 0x0022) //"
		{
			l_match ++;
			if (l_match%2 == 1)
				l_char->action = 1;
			else
				l_char->action = 2;
		}

		if (charcode == 0x201C) //"
		{
			l_match ++;
			l_char->action = 1;
		}

		if (charcode == 0x201D) //"
		{
			l_match --;
			l_char->action = 2;
			if (l_match<0)
			{
				if (m_v.begin() == m_v.end())
				{
					l_char->action = 1;
				}
				else
					(*m_v.begin())->action = 1;
			}
		}

		if (l_x + l_wordwidth > line_width )
		{
			l_y -= line_height;
			l_x = 10;
		}

		if ( dirct == 0 && l_y < 10 )
		{
			break;
		}
		// only one
		for (int i =  0; i < l_wordcnt ; i++)
			{
				l_word[i]->y = l_y;
				int t = l_word[i]->x;
				l_word[i]->x = l_x;
				l_x += t;
				m_v.push_back(l_word[i]);
			}
		l_wordcnt = 0;
		l_wordwidth = 0;
	}

	if ( dirct == 1)
	{
		int l_pos = 10000;
			// ���Ű�
			std::vector<str_char *>::iterator  it;
			for (it = m_v.begin(); it != m_v.end();it ++)
			{
				(*it)->y -= l_y-30;
				if ((*it)->y < m_height - 30 )
					l_pos = min(l_pos,(*it)->pos);
			}
		if (l_pos == 10000)
				l_pos = 0;

		m_txt.m_pagesize = len-l_pos;
	}
	// ���㵱ǰҳ��С, ��������һ�ζ�ȡ���ļ�ָ��
	if ( dirct == 0 )
	{
		m_txt.m_pagesize = cci ;
		//m_txt.m_filepos += m_txt.m_pagesize;
	}

}

void ZaRichText::getpos(float & percent)
{
	if (m_txt.m_epub.m_xml.m_pages.size()>0)
		{
			percent =
					(float)
					( m_txt.m_epub.m_pagecur +
					  (m_txt.m_filepos ) /(float)m_txt.m_size
					 )/
					 (float)m_txt.m_epub.m_xml.m_pages.size();
		}
		else
		{
			percent =
				(float)(m_txt.m_filepos) /(float)m_txt.m_size;

		}
}
void ZaRichText::setpos(float percent)
{
	if (m_txt.m_epub.m_xml.m_pages.size()>0)
	{
		int mt = int(percent*10000*m_txt.m_epub.m_xml.m_pages.size());
			int fp =  mt %  10000;
		m_txt.m_epub.m_pagecur = (mt - fp ) /(10000) ;
		if (percent ==1.0f)
			m_txt.m_epub.m_pagecur --;

		m_txt.m_epub.gethtmlpath();
		m_txt.openfile(m_txt.m_epub.m_pathname);

		if (percent == 1.0f)
			m_txt.m_filepos = m_txt.m_size -100;
		else
			m_txt.m_filepos = fp *m_txt.m_size/(10000);
	}
	else
		m_txt.m_filepos = (float)(percent*10000)*m_txt.m_size/10000;

	if(m_txt.m_filepos < 0)
		m_txt.m_filepos =0;

	if(m_txt.m_filepos >= m_txt.m_size)
		m_txt.m_filepos =  m_txt.m_size;

	if (m_txt.m_filepos % 2 ==1)
		m_txt.m_filepos--;
	fprintf(stderr,"ZaRichText::setpos  %d, %d\n", m_txt.m_size,m_txt.m_filepos );

	this->nextpage();
}

void ZaRichText::changefont(int size)
{
	fprintf(stderr,"changefont %d\n",size);
	m_font->changesize(size);

	//����������²���,��Ҫ�޸�ָ��m_filepos.
	if(m_layout_org==0)
	{
		m_txt.m_filepos -= m_txt.m_pagesize;
		this->layout(0);
		m_txt.m_filepos += m_txt.m_pagesize;
	}
	else
		this->layout(1);
}

void ZaRichText::onLoading()
{
	m_y = 0;
	m_txt.m_epub.reset();
	m_txt.resetcnt();

	this->layout(0);
	try
	{
		m_txt.openfile(m_filename);
	}
	catch (CException & e)
	{
		fprintf(stderr,e.GetString());
		m_txt.m_epub.reset();
		m_txt.resetcnt();
		strcpy(m_filename,"app/native/res/error.txt");
		m_txt.openfile(m_filename);
	}
//	zaMySQL::getInstance()->create_database("/accounts/1000/shared/documents/TextReader/TR.db");
	int p,f;
	if (zaMySQL::getInstance()->getreadhis(m_filename,&p,&f))
	{
		if (p > 0)
		{
			m_txt.m_epub.m_pagecur = p;
			m_txt.m_epub.gethtmlpath();
			m_txt.openfile(m_txt.m_epub.m_pathname);
		}
		m_txt.m_filepos = f;
		fprintf(stderr, "readhis  %d->%d \n", p, f);
	}
//	zaMySQL::getInstance()->close_database();

	this->nextpage();
}

//m_txt.m_content; char.
//m_font    char size
//this->m_GL screen size
void ZaRichText::layouthtml(int dirct)
{
	m_font->load_font(m_txt.m_content,m_txt.m_contentlen);

	if (m_font->m_map.find(' ')==m_font->m_map.end())
		m_font->m_map[' '] = m_font->load_font(' ');

	unsigned int charcode = 0;
	unsigned int charcode_last = 0;
	char *p = m_txt.m_content;
	int len = m_txt.m_contentlen;
	int l_x=10,l_y=0;
	int line_height = m_font->m_max_y *1.6 ;
	int line_width = m_width;
	str_char * l_word[2000];
	int l_wordcnt = 0;
	int l_wordwidth = 0;

#define BEGIN_TAG 0 //<
#define END_TAG 1
#define BEGIN_P 2
#define END_P 3
#define BEGIN_D 4
#define END_D 5

#define BEGIN_STYLE 6
#define END_STYLE 7
#define BEGIN_TITLE 8
#define END_TITLE 9

	int l_stat = END_TAG;
	int l_stat_dsp = END_STYLE;
	bool l_stat_empty_par = false;

	std::vector<str_char *>::iterator iter;
	for (iter = m_v.begin();iter != m_v.end();iter++)
	{
			if((*iter)->img_path)
				free((*iter)->img_path);
			delete (*iter);
	}

	m_v.clear();

	l_y = m_height - line_height -10 ;

	str_char * l_char ;

	int cci ;
	int l_islink = 0;

	static int l_match = 0;

	if (l_match %2 ==1)
	{
		l_char = (str_char *) malloc(sizeof(str_char) );
		l_char->img_path = NULL;
		l_char->pos = 0;
		l_char->x = l_x;
		l_char->y = l_y;
		l_char->charcode = ' ';
		l_char->action = 1;
		m_v.push_back(l_char);
	}

	for ( cci =0 ; cci < len ; cci +=2)
	{
		charcode = ((unsigned char)*(p+1))*256+(unsigned char)*p ;
		if (l_wordcnt>1900)
			throw CException(__FILE__,__LINE__,"l_wordcnt too long, %d",l_wordcnt);
		p += 2;
		if (charcode==0x0D || charcode==0x0A )
		{
			charcode = ' ';
		}
		if (charcode < ' ')
			continue;
		if (charcode_last ==' ' && charcode == ' ' )
			continue;

		l_char = (str_char *) malloc(sizeof(str_char) );
		l_char->img_path = NULL;
		l_char->pos = cci;
		l_char->charcode = charcode;
		if (l_islink ==1 )
			l_char->action = 8;
		else
			l_char->action = 0;

		int lx  = 0 ,ly =0;

		m_font->getcharsize(charcode,&lx,&ly);

		if (l_stat == BEGIN_D && charcode == ';')
		{
			char l_tag_content[1000];
			int ti;
			for ( ti= 0 ; ti < l_wordcnt ; ti++)
			{
				l_tag_content[ti] = l_word[ti]->charcode%256;
			}
			l_tag_content[ti] = 0;

			if (l_stat_dsp != BEGIN_TITLE && l_stat_dsp != BEGIN_STYLE)
			{
			if (strcmp(l_tag_content,"nbsp")==0)
			{
				l_char->charcode = ' ';
				l_char->pos = cci;
				l_char->y = l_y;
				if (m_font->m_map.find(l_char->charcode)==m_font->m_map.end())
					m_font->m_map[l_char->charcode] = m_font->load_font(l_char->charcode);
				m_font->getcharsize(l_char->charcode,&lx,&ly);
				l_char->x = l_x;
				l_x += lx;
				m_v.push_back(l_char);
			}
			else if ( strcmp(l_tag_content,"#8211")==0
					|| strcmp(l_tag_content,"ndash")==0 )
			{
				l_char->charcode = 8211;
				l_char->pos = cci;
				l_char->y = l_y;
				if (m_font->m_map.find(l_char->charcode)==m_font->m_map.end())
					m_font->m_map[l_char->charcode] = m_font->load_font(l_char->charcode);
				m_font->getcharsize(l_char->charcode,&lx,&ly);
				l_char->x = l_x;
				l_x += lx;
				m_v.push_back(l_char);
			}
			else if (strcmp(l_tag_content,"#8212")==0 ||
					strcmp(l_tag_content,"mdash")==0)
			{
				l_char->charcode = 8212;
				l_char->pos = cci;
				l_char->y = l_y;
				if (m_font->m_map.find(l_char->charcode)==m_font->m_map.end())
					m_font->m_map[l_char->charcode] = m_font->load_font(l_char->charcode);
				m_font->getcharsize(l_char->charcode,&lx,&ly);
				l_char->x = l_x;
				l_x += lx;
				m_v.push_back(l_char);
			}
			else if (strcmp(l_tag_content,"#8226")==0 )
			{
				l_char->charcode = 8226;
				l_char->pos = cci;
				l_char->y = l_y;
				if (m_font->m_map.find(l_char->charcode)==m_font->m_map.end())
					m_font->m_map[l_char->charcode] = m_font->load_font(l_char->charcode);
				m_font->getcharsize(l_char->charcode,&lx,&ly);
				l_char->x = l_x;
				l_x += lx;
				m_v.push_back(l_char);
			}
			else if (strcmp(l_tag_content,"middot")==0)
			{
				l_char->charcode = 183; //.
				l_char->pos = cci;
				l_char->y = l_y;
				if (m_font->m_map.find(l_char->charcode)==m_font->m_map.end())
					m_font->m_map[l_char->charcode] = m_font->load_font(l_char->charcode);
				m_font->getcharsize(l_char->charcode,&lx,&ly);
				l_char->x = l_x;
				l_x += lx;
				m_v.push_back(l_char);
			}
			else if (strcmp(l_tag_content,"quot")==0)
			{
				l_char->charcode = 34; //"
				l_char->pos = cci;
				l_char->y = l_y;
				if (m_font->m_map.find(l_char->charcode)==m_font->m_map.end())
					m_font->m_map[l_char->charcode] = m_font->load_font(l_char->charcode);
				m_font->getcharsize(l_char->charcode,&lx,&ly);
				l_char->x = l_x;
				l_x += lx;
				m_v.push_back(l_char);
			}
			else if (strcmp(l_tag_content,"amp")==0)
			{
				l_char->charcode = 38; //&
				l_char->pos = cci;
				l_char->y = l_y;
				if (m_font->m_map.find(l_char->charcode)==m_font->m_map.end())
					m_font->m_map[l_char->charcode] = m_font->load_font(l_char->charcode);
				m_font->getcharsize(l_char->charcode,&lx,&ly);
				l_char->x = l_x;
				l_x += lx;
				m_v.push_back(l_char);
			}
			else if (strcmp(l_tag_content,"lt")==0)
			{
				l_char->charcode = '<'; //<
				l_char->pos = cci;
				l_char->y = l_y;
				if (m_font->m_map.find(l_char->charcode)==m_font->m_map.end())
					m_font->m_map[l_char->charcode] = m_font->load_font(l_char->charcode);
				m_font->getcharsize(l_char->charcode,&lx,&ly);
				l_char->x = l_x;
				l_x += lx;
				m_v.push_back(l_char);
			}
			else if (strcmp(l_tag_content,"gt")==0)
			{
				l_char->charcode = '>'; //>
				l_char->pos = cci;
				l_char->y = l_y;
				if (m_font->m_map.find(l_char->charcode)==m_font->m_map.end())
					m_font->m_map[l_char->charcode] = m_font->load_font(l_char->charcode);
				m_font->getcharsize(l_char->charcode,&lx,&ly);
				l_char->x = l_x;
				l_x += lx;
				m_v.push_back(l_char);
			}
			else if (strcmp(l_tag_content,"laquo")==0)
			{
				l_char->charcode = 171; //&
				l_char->pos = cci;
				l_char->y = l_y;
				if (m_font->m_map.find(l_char->charcode)==m_font->m_map.end())
					m_font->m_map[l_char->charcode] = m_font->load_font(l_char->charcode);
				m_font->getcharsize(l_char->charcode,&lx,&ly);
				l_char->x = l_x;
				l_x += lx;
				m_v.push_back(l_char);
			}
			else if (strcmp(l_tag_content,"raquo")==0)
			{
				l_char->charcode = 187; //&
				l_char->pos = cci;
				l_char->y = l_y;
				if (m_font->m_map.find(l_char->charcode)==m_font->m_map.end())
					m_font->m_map[l_char->charcode] = m_font->load_font(l_char->charcode);
				m_font->getcharsize(l_char->charcode,&lx,&ly);
				l_char->x = l_x;
				l_x += lx;
				m_v.push_back(l_char);
			}else if (strcmp(l_tag_content,"ldquo")==0)
			{
				l_char->charcode = 8220; //"
				l_char->pos = cci;
				l_char->y = l_y;
				if (m_font->m_map.find(l_char->charcode)==m_font->m_map.end())
					m_font->m_map[l_char->charcode] = m_font->load_font(l_char->charcode);
				m_font->getcharsize(l_char->charcode,&lx,&ly);
				l_char->x = l_x;
				l_x += lx;
				m_v.push_back(l_char);
			}
			else if (strcmp(l_tag_content,"rdquo")==0)
			{
				l_char->charcode = 8221; //"
				l_char->pos = cci;
				l_char->y = l_y;
				if (m_font->m_map.find(l_char->charcode)==m_font->m_map.end())
					m_font->m_map[l_char->charcode] = m_font->load_font(l_char->charcode);
				m_font->getcharsize(l_char->charcode,&lx,&ly);
				l_char->x = l_x;
				l_x += lx;
				m_v.push_back(l_char);
			}
			}// ����ʾ�����style

			l_stat= END_D;
			l_wordcnt = 0;
			l_wordwidth = 0;
			charcode_last  = charcode;
	//		fprintf(stderr,"<convert char> %s\n",l_tag_content);
			continue;
		}

		if (l_stat == BEGIN_D||(charcode == '&'&& l_stat != BEGIN_TAG
				&& l_stat_dsp != BEGIN_TITLE && l_stat_dsp != BEGIN_STYLE)
								)
		{
			if (l_stat != BEGIN_D)
			{
				if (l_x + l_wordwidth > line_width -10 )
				{
					l_y -= line_height;
					l_x = 10;
				}
				// �����Ű��Ż�
						if ( dirct == 0 && l_y < 10 )
						{
							break;
						}
				for (int i =  0; i < l_wordcnt ; i++)
				{
					l_word[i]->y = l_y;
					int t = l_word[i]->x;
					l_word[i]->x = l_x;
					l_x += t;
					m_v.push_back(l_word[i]);
				}

				l_wordcnt = 0;
				l_wordwidth = 0;
				l_stat = BEGIN_D;
			}
			else
			{
				l_word[l_wordcnt] = l_char;
				l_char->x = lx;
				l_wordcnt ++;
				l_wordwidth += lx;
			}
			continue;
		}

//		if (l_stat == BEGIN_P && charcode == '}')
//		{
//			l_stat= END_P;
//			l_wordcnt = 0;
//			l_wordwidth = 0;
//			continue;
//		}
//
//		if ( (l_stat == BEGIN_P)||(l_stat != BEGIN_TAG && charcode == '@'))
//		{
//			l_stat = BEGIN_P;
//			l_word[l_wordcnt] = l_char;
//			l_char->x = lx;
//			l_wordcnt ++;
//			l_wordwidth += lx;
//			continue;
//		}

		if (l_stat == BEGIN_TAG && charcode == '>')
		{
			l_stat = END_TAG;

			l_word[l_wordcnt] = l_char;
			l_char->x = lx;
			l_wordcnt ++;
			l_wordwidth += lx;

			char l_tag_content[1000];

			int ti;
			for ( ti= 0 ; ti < l_wordcnt ; ti++)
			{
				l_tag_content[ti] = l_word[ti]->charcode%256;
			}
			l_tag_content[ti] = 0;
			//fprintf(stderr,"l_tag_content %s\n",l_tag_content);
			char *p;

//			fprintf(stderr,"<HHHH> %s\n",l_tag_content);

			//h1,h2,h3�ı���ɫ , ����<head>
			if (l_tag_content[0]=='h' && l_tag_content[1] > '0' && l_tag_content[1] <'9')
			{
				//if (l_x != 50)
				l_y -= 1*(float)line_height;
				l_x = 10;
				l_char = (str_char *) malloc(sizeof(str_char) );
				l_char->img_path = NULL;
				l_char->pos = cci;
				l_char->action = 6;
				l_char->x = l_x;
				l_char->y = l_y;
				l_char->charcode = ' ';
				//�����ɫ���
				m_v.push_back(l_char);
			}

			if (strncmp(l_tag_content,"style",5) == 0)
			{
				l_stat_dsp = BEGIN_STYLE;
				fprintf(stderr,"RICHTEXT DECODE  STYLE BEGIN\n");
			}
			if (strncmp(l_tag_content,"/style>",7) == 0)
			{
				l_stat_dsp = END_STYLE;
				fprintf(stderr,"RICHTEXT DECODE  STYLE END\n");
			}

			if (strncmp(l_tag_content,"title",5)  == 0)
			{
				l_stat_dsp = BEGIN_TITLE;
				fprintf(stderr,"RICHTEXT DECODE TITLE BEGIN\n");
			}

			if (strncmp(l_tag_content,"/title>",7)  == 0)
			{
				l_stat_dsp = END_TITLE;
				fprintf(stderr,"RICHTEXT DECODE TITLE END\n");
			}

			if (strncmp(l_tag_content,"div",3)  == 0)
			{
				//if (l_x != 50)
				l_y -= line_height;
				l_x = 50;
			}

			if (strncmp(l_tag_content,"/div>",5)  == 0)
			{
				//if (l_x != 50)
				l_y -= line_height;
				l_x = 50;
			}

			if (strncmp(l_tag_content,"/h",2) == 0
				&& strncmp(l_tag_content,"/head",5) != 0)
			{
				l_char = (str_char *) malloc(sizeof(str_char) );
				l_char->img_path = NULL;
				l_char->pos = cci;
				l_char->action = 7;
				l_char->x = l_x;
				l_char->y = l_y;
				l_char->charcode =' ';
				m_v.push_back(l_char);
				//if (l_x != 50)
				l_y -= 1*(float)line_height;
				l_x = 50;
			}

			if (strncmp(l_tag_content,"tr>",3) == 0)   //<tr>
			{
				l_y -= 1.3*(float)line_height;
				l_x = 10;
			}

			//<p> ��ǰ���κ󣬶�����
			if (strncmp(l_tag_content,"p>",2) == 0    //<p>
				|| strncmp(l_tag_content,"p ",2) == 0) //<p
			{
				if (l_match%2 != 0)
				{
					l_char = (str_char *) malloc(sizeof(str_char) );
					l_char->img_path = NULL;
					l_char->pos = cci;
					l_char->action = 2;
					l_char->x = l_x;
					l_char->y = l_y;
					l_char->charcode =' ';
					m_v.push_back(l_char);
					l_match = 0;
				}
				l_stat_empty_par = true;
				l_y -= 1.3*(float)line_height;
				l_x = 50;
			}

			if(strncmp(l_tag_content,"br",2) == 0) //<br>
			{
				l_y -= line_height;
				l_x = 10;

				// �����Ű��Ż�
				if ( dirct == 0 && l_y < 10 )
				{
						break;
				}
			}
			if (strncmp(l_tag_content,"/p>",3)  == 0)//</p>

			{
				// <p>< ����
				if( l_stat_empty_par == true)
				{
					l_y += 1.3*(float)line_height;
					l_stat_empty_par = false;
				}
				else
				{
					// ����� <p>�пո�, l_x������50.
					//if (l_x != 50)
					l_y -= 0.3*(float)line_height;
					//fprintf(stderr,"ZaRichText DECODE .<P> cci %d, l_x %d,l_y  %d\n",cci,l_x,l_y);
					l_x = 50;
				}

				if (l_match%2 != 0)
				{
					l_char = (str_char *) malloc(sizeof(str_char) );
					l_char->img_path = NULL;
					l_char->pos = cci;
					l_char->action = 2;
					l_char->x = l_x;
					l_char->y = l_y;
					l_char->charcode =' ';
					m_v.push_back(l_char);
					l_match = 0;
				}
			}

			if (strstr(l_tag_content,"a href=") != NULL)
			{

				p = strstr(l_tag_content,"href=") ;
				if (p != NULL)
				{
					char l_img[2000];
					l_char->img_path = (char *)malloc(sizeof(char)*2000);
					while (*p != '"')
					{
						p ++;
					}
					p++;
					ti = 0;
					while (*p != '"' )
					{
				//		fprintf(stderr,"*p %c\n",*p);
						if (*p == 0 ) break;
						l_img[ti] = *p;
						ti ++;
						p ++;
					}
					l_img[ti] = 0;
					strcpy(l_char->img_path,l_img);
					//fprintf(stderr,"ZaRichText DECODE .<a link %s\n",l_char->img_path);
				}
				l_islink = 1;
				l_char->pos = cci;
				l_char->action = 11;
				if (l_x + 60 > line_width -10 )
				{
					l_y -= line_height;
					l_x = 10;
				}
				l_char->y = l_y + line_height/3 ;
				l_char->x = l_x + 30 ;
				l_x += 30 + 30;
				l_char->charcode =' ';
				m_v.push_back(l_char);
			}
			if (strcmp(l_tag_content,"/a>") == 0)
			{
				fprintf(stderr,"link over %s\n",l_tag_content);
				l_char = (str_char *) malloc(sizeof(str_char) );
				l_char->img_path = NULL;
				l_char->pos = cci;
				l_char->action = 9;
				l_char->x = l_x;
				l_char->y = l_y;
				l_char->charcode = ' ';
				m_v.push_back(l_char);
				//if (l_x != 50)
//				l_y -= 1.2f*(float)line_height;
//				l_x = 50;
				l_islink = 0;
			}

			if (strncmp(l_tag_content,"img",3) ==0||
			    strstr(l_tag_content,"image") != NULL)
			{
				p = strstr(l_tag_content,"src=\"") ;
				if (p==NULL)
				{
					p = strstr(l_tag_content,"href=\"") ;
				}
				if (p != NULL)
				{
//					if ( dirct == 0 && l_y - 750 < 10 )
//						break;
//					fprintf(stderr,"p %s\n",p);
					char l_img[255];
					sprintf(l_img,"%s",m_txt.m_epub.m_pathname);
					ti = strlen(l_img);
					char *pp = l_img+ti;
					while(*pp != '/')
					{
						*pp = 0;
						pp --;
					}
					ti = strlen(l_img);
					fprintf(stderr,"m_txt.m_epub.m_xml.m_path %s\n",l_img);
					while (*p != '"')
					{
				//		fprintf(stderr,"*p1 %c\n",*p);
						p ++;
					}
					p++;
					while (*p != '"' )
					{
				//		fprintf(stderr,"*p %c\n",*p);
						if (*p == 0 ) break;
						l_img[ti] = *p;
						ti ++;
						p ++;
					}
					l_img[ti] = 0;

					// getimg

					l_char = (str_char *) malloc(sizeof(str_char) );
					l_char->pos = cci;
					l_char->img_path = (char *)malloc(sizeof(char)*255 );

					int l_jpg_w , l_jpg_h;
					ZAImage *l_jpg = new ZAImage();
					l_jpg->getsize((const char*)l_img,l_jpg_w,l_jpg_h);
					delete l_jpg;
					if (l_jpg_h > 0)
					{
						float lf_rate= (float)l_jpg_w/(float)l_jpg_h;
						if(l_jpg_w >m_width-30)
						{
							l_jpg_w = m_width-30;
							l_jpg_h = (float)l_jpg_w /lf_rate;
						}
						if( l_jpg_h > m_height-60)
						{
							l_jpg_h = m_height-60;
							l_jpg_w = l_jpg_h*lf_rate;
						}
					}
					strcpy(l_char->img_path,l_img);
					l_char->action = 10;
					l_char->x = m_width/2;
					l_char->y = l_y - l_jpg_h/2 - 20;
					l_char->w = l_jpg_w;
					l_char->h = l_jpg_h;
					fprintf(stderr,"l_img %s %d %d\n",l_img, l_jpg_w,l_jpg_h);
					l_y -= l_jpg_h+50;
					l_x = 50;
//					if ( dirct == 0 && l_y < 10 )
//					{
//						break;
//					}
					m_v.push_back(l_char);
				}
			}


			l_wordcnt = 0;
			l_wordwidth = 0;
			charcode_last  = charcode;
			continue;
		}

		if (l_stat == BEGIN_TAG || (charcode == '<') )
		{

			if (l_stat != BEGIN_TAG)
			{

				l_stat = BEGIN_TAG;

				if (l_x + l_wordwidth > line_width -10 )
				{
					l_y -= line_height;
					l_x = 10;
				}
				// �����Ű��Ż�
				if ( dirct == 0 && l_y < 10 )
				{
					break;
				}
				//����ʾtitel ,style ������
				if (l_stat_dsp != BEGIN_TITLE && l_stat_dsp != BEGIN_STYLE)
				{
					//��ʾ���.
					for (int i =  0; i < l_wordcnt ; i++)
					{
						l_word[i]->y = l_y;
						int t = l_word[i]->x;
						l_word[i]->x = l_x;
						l_x += t;
						m_v.push_back(l_word[i]);
					}
				}
				//���
				l_wordcnt = 0;
				l_wordwidth = 0;
			}
			else
			{
				//�ۼ�<>����
				l_stat = BEGIN_TAG;
				l_word[l_wordcnt] = l_char;
				l_char->x = lx;
				l_wordcnt ++;
				l_wordwidth += lx;
			}
			charcode_last  = charcode;
			continue;
		}

		l_stat_empty_par = false;

		if (this->m_txt.m_charset)
		if ((charcode >= 'a' && charcode <= 'z' )
			||(charcode >= 'A' && charcode <= 'Z')
			||(charcode =='\'')
			||(charcode =='-')
			||(charcode > 0x0080 && charcode < 0x024F))
		//  0080..00FF; Latin-1 Supplement
		//	0100..017F; Latin Extended-A
		//	0180..024F; Latin Extended-B
		{
				l_word[l_wordcnt] = l_char;
				l_char->x = lx;
				l_wordcnt ++;
				l_wordwidth += lx;
				charcode_last  = charcode;
				continue;
		} else if ((charcode >='0'&& charcode <='9') ||charcode =='-'
				|| charcode =='.' || charcode =='%' )
		{
			l_word[l_wordcnt] = l_char;
			l_char->x = lx;
			l_wordcnt ++;
			l_wordwidth += lx;
			charcode_last  = charcode;
			continue;
		}
		else
		{
			// ���Ѿ��е� import one word
			//����ʾtitel ,style ������
			if (l_stat_dsp != BEGIN_TITLE && l_stat_dsp != BEGIN_STYLE)
			if (l_wordcnt > 0)
			{

				if (l_x + l_wordwidth > line_width -10 )
				{
					l_y -= line_height;
					l_x = 10;
				}
				// �����Ű��Ż�
				if ( dirct == 0 && l_y < 10 )
				{
					break;
				}
				for (int i =  0; i < l_wordcnt ; i++)
				{
					l_word[i]->y = l_y;
					int t = l_word[i]->x;
					l_word[i]->x = l_x;
					l_x += t;
					m_v.push_back(l_word[i]);
				}

				l_wordcnt = 0;
				l_wordwidth = 0;
			}
		}

		{
			l_word[0] = l_char;
			l_char->x = lx;
			l_wordcnt = 1 ;
			l_wordwidth = lx;
		}


		if (charcode == 0x000A)
		{

		}

		if (charcode == 0xFFFE)
		{
			charcode = 0x0020;
		}

		if (charcode == 0x0022) //"
		{
			l_match ++;
			if (l_match%2 == 1)
				l_char->action = 1;
			else
				l_char->action = 2;
		}

		if (charcode == 0x201C) //"
		{
			l_match =1;
			l_char->action = 1;
		}

		if (charcode == 0x201D) //"
		{
			l_match = 0;
			l_char->action = 2;
		}

		if (l_x + l_wordwidth > line_width -10 )
		{
			l_y -= line_height;
			l_x = 10;
		}
		// �����Ű��Ż�
		if ( dirct == 0 && l_y < 10 )
		{
			break;
		}

		// �����鵹��
		//����ʾtitel ,style ������
		if (l_stat_dsp != BEGIN_TITLE && l_stat_dsp != BEGIN_STYLE)
		for (int i =  0; i < l_wordcnt ; i++)
			{
				l_word[i]->y = l_y;
				int t = l_word[i]->x;
				l_word[i]->x = l_x;
				l_x += t;
				m_v.push_back(l_word[i]);
			}
		l_wordcnt = 0;
		l_wordwidth = 0;
		charcode_last  = charcode;
	}

	if ( dirct == 1)
	{
		int l_pos = 10000;
		// ���Ű�
		std::vector<str_char *>::iterator  it;
		for (it = m_v.begin(); it != m_v.end();it ++)
		{
			(*it)->y -= l_y-30;
			if ((*it)->y < m_height - 30 )
				l_pos = min(l_pos,(*it)->pos);
		}
		if (l_pos == 10000)
			l_pos = 0;

		m_txt.m_pagesize = len-l_pos;
	}

	// ���㵱ǰҳ��С, ��������һ�ζ�ȡ���ļ�ָ��
	if ( dirct == 0 )
	{
		//�������һ�е��ַ� cci==len,û�ж��������,���BEGIN_TAG
		if (m_v.size() > 0 && cci < len )
		{
			if (m_v[m_v.size()-1]->y < (10 + line_height))
			{
				for (int i = m_v.size()-1;i>=0;i--)
				{
				//fprintf(stderr, "ZaRichText cci %d,%d\n",cci,m_v[i]->pos);
					if (m_v[i]->y >= 10 )
					{
						cci = m_v[i]->pos+2;
						break;
					}
				}
			}
		}
		if ( l_stat == BEGIN_TAG)
		{
			for (int i = m_v.size()-1;i>=0;i--)
			{
			//fprintf(stderr, "ZaRichText cci %d,%d\n",cci,m_v[i]->pos);
				if (m_v[i]->y >= 10 )
				{
					cci = m_v[i]->pos+2;
					break;
				}
			}
		}

		m_txt.m_pagesize = cci ;
	}

	fprintf(stderr,"open file %d-%d %d-%d %d\n",
			m_txt.m_filepos,
			m_txt.m_pagesize,
			m_txt.m_epub.m_pagecur,
			m_txt.m_epub.m_xml.m_pages.size(),
			m_txt.m_size
						);
}
ZaRichText::~ZaRichText() {
	// TODO Auto-generated destructor stub
}

} /* namespace bbcubezone */
