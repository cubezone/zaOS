/*
 * ZaListDir.cpp
 *
 *  Created on: 2012-10-2
 *      Author: Administrator
 */

#include "ZaListDir.h"
#include <sys/stat.h>
namespace bbcubezone {

ZaListDir::ZaListDir() {
	// TODO Auto-generated constructor stub
	m_style= 0;
}

void ZaListDir::init()
{
	m_icon_epub  = new ZAImage();
	m_icon = new ZAImage();
	m_icon->LoadImg("app/native/res/file.png",90,90);
	m_icon_txt = new ZAImage();
	m_icon_txt->LoadImg("app/native/res/txtfile.png",90,90);
	m_icon_mp3 = new ZAImage();
	m_icon_mp3->LoadImg("app/native/res/f_mp3.png",90,90);
	m_icon_img = new ZAImage();
	m_icon_img->LoadImg("app/native/res/f_img.png",90,90);

	m_icon_dir = new ZAImage();
	m_icon_dir->LoadImg("app/native/res/GenericFolder.png",90,90);
	m_icon_dir_doc = new ZAImage();
	m_icon_dir_doc->LoadImg("app/native/res/DocumentsFolder.png",90,90);
	m_icon_dir_camera = new ZAImage();
	m_icon_dir_camera->LoadImg("app/native/res/CameraFolder.png",90,90);
	m_icon_dir_downloads = new ZAImage();
	m_icon_dir_downloads->LoadImg("app/native/res/DownloadsFolder.png",90,90);
	m_icon_dir_music = new ZAImage();
	m_icon_dir_music->LoadImg("app/native/res/d_mp3.png",90,90);
	m_icon_dir_photos = new ZAImage();
	m_icon_dir_photos->LoadImg("app/native/res/d_img.png",90,90);
	m_icon_dir_books = new ZAImage();
	m_icon_dir_books->LoadImg("app/native/res/LibraryFolder.png",90,90);
	m_icon_dir_print = new ZAImage();
	m_icon_dir_print->LoadImg("app/native/res/PrinterFolder.png",90,90);
	m_icon_dir_videos = new ZAImage();
	m_icon_dir_videos->LoadImg("app/native/res/MoviesFolder.png",90,90);
}

void ZaListDir::drawControl()
{
//	ZaList::drawControl();

	int a = m_x, b= m_y;
	getClientXY(a,b);
	glEnable(GL_SCISSOR_TEST);
	glScissor(a,b,m_width,m_height);

	for (unsigned int i=0 ; i < m_v.size(); i ++)
	{
		int itempos =  b + m_top - i * m_rowheight- 0.5 * m_rowheight;
		if (itempos <= m_height + m_rowheight && itempos > 0-m_rowheight)
		{
			ZAImage * l_img;
			if(i == 0 || (m_s[i-1]->st_mode & S_IFMT) == S_IFDIR)
			{
				if (m_v[i].compare("documents")==0 )
					l_img = m_icon_dir_doc;
				else if (m_v[i].compare("books")==0 )
					l_img = m_icon_dir_books;
				else if (m_v[i].compare("camera")==0 )
					l_img = m_icon_dir_camera;
				else if (m_v[i].compare("music")==0 )
					l_img = m_icon_dir_music;
				else if (m_v[i].compare("photos")==0 )
					l_img = m_icon_dir_photos;
				else if (m_v[i].compare("downloads")==0 )
					l_img = m_icon_dir_downloads;
				else if (m_v[i].compare("print")==0 )
					l_img = m_icon_dir_print;
				else if (m_v[i].compare("videos")==0 )
					l_img = m_icon_dir_videos;
				else
					l_img = m_icon_dir;
			}
			else
			{
				if (m_v[i].find(".epub") != string::npos||
						m_v[i].find(".htm") != string::npos||
						m_v[i].find(".html") != string::npos||
					m_v[i].find(".txt") != string::npos)
				{
					l_img = m_icon_txt;
				}
				else if(m_v[i].find(".mp3")!= string::npos)
					l_img = m_icon_mp3;
				else if(m_v[i].find(".jpg") != string::npos ||
						m_v[i].find(".jpeg") != string::npos ||
						m_v[i].find(".png")!= string::npos ||
						m_v[i].find(".bmp")!= string::npos)
					l_img = m_icon_img;
				else
					l_img = m_icon;
			}
			int l_xx = 0;
			if (m_style == 0)
				l_xx = m_width - sqrt(
					pow(m_width,2) -
					pow( (b + itempos) - (b + m_height/2) ,2));
			else if(m_style == 1)
				l_xx = 0;

			if ((int)i==m_index)
				ZaResLib::getInstance()->m_font->setcolor(1.0f,1.0f,0.0f,1.0f);
			else if ((int)i==m_index_temp)
				ZaResLib::getInstance()->m_font->setcolor(1.0f,1.0f,0.5f,1.0f);
			else
				ZaResLib::getInstance()->m_font->setcolor(1.0f,1.0f,1.0f,1.0f);

			ZaResLib::getInstance()->m_font->render_text(m_v[i].c_str(),0,
					a + l_xx + 100 , itempos,"UTF-8",m_width-100);
			l_img->m_z = (float)((float)m_height/1.5 - abs(m_height/2 - (itempos)))/m_height*2;
			l_img->DrawImg(a + l_xx + 50 , itempos  ,0);
		}
//		fprintf(stderr,"ZaList::drowcontrol %d %s\n",m_top , m_v[i].c_str());
	}

	glDisable(GL_SCISSOR_TEST);
}

void ZaListDir::changeeDir(const char *p)
{
	if (strcmp(p,"/accounts/1000/shared/..") == 0)
		return ;

	struct dirent *ptr;
	DIR *dir;
	fprintf(stderr, "zaScreenDir::dirlist %s \n", p);
	dir = opendir(p);
	if (dir == NULL)
		return ;

	m_v.clear();
	for (int i = 0;i < m_s.size();i++)
	{
		free(m_s[i]);
	}
	m_s.clear();

	string ls;
	ls = "..";
	this->addlistitem(ls);
	strcpy(m_path, p);


	fprintf(stderr, "pwd: %s\n", m_path);
	string f_ls="/.";
	while ((ptr = readdir(dir)) != NULL) {
		//���'.'��'..'����Ŀ¼
		if (ptr->d_name[0] == '.')
			continue;
		 ls = ptr->d_name;
		addlistitem(ls);
		char l_fullpathname[255];
		if (strcmp(m_path, "/") != 0)
			sprintf(l_fullpathname, "%s/%s",m_path,ls.c_str());
		else
			sprintf(l_fullpathname, "%s%s",m_path,ls.c_str());

		struct stat *l_st = (struct stat *)malloc(sizeof(struct stat));
		stat(l_fullpathname,l_st);
		m_s.push_back(l_st);
		f_ls.append(ptr->d_name);
		fprintf(stderr, "<%s>\n", ls.c_str());
	}
	closedir(dir);
	ZaResLib::getInstance()->m_font->load_font((char*)f_ls.c_str(),0);
	fprintf(stderr, "change dir over. size %d\n",m_v.size());
	m_top = m_height ;
	return ;
}

void ZaListDir::processEvent(ZaEvent * env)
{
	ZaList::processEvent(env);
//	fprintf(stderr,"ZaListDir::processEvent %d\n",env->m_event);
	if (env->m_event == ZaEvent::EVENT_LIST_SELECT)
	{
		soundplayer_play_sound("input_keypress");
		char l_fullpathname[255];
		if ( m_index==0 )
		{
			if (strcmp(m_path,"/accounts/1000/shared") == 0)
				return ;
			char n = strlen(m_path);
			for (int i = n ;i > 0; i--)
			{
				if (m_path[i] != '/')
				{
					m_path[i] = 0;
				}
				else
				{
					m_path[i] = 0;
					break;
				}
			}
			strcpy(l_fullpathname,m_path);
		}
		else
		{
			if (strcmp(m_path, "/") != 0)
				sprintf(l_fullpathname, "%s/%s",m_path,m_v[m_index].c_str());
			else
				sprintf(l_fullpathname, "%s%s",m_path,m_v[m_index].c_str());
		}
		fprintf(stderr,"ZaListDir::l_fullpathname %s\n",l_fullpathname);
		struct stat l_sb;
		stat(l_fullpathname, &l_sb);
		if ((l_sb.st_mode & S_IFMT) == S_IFREG)
		{
			if(strstr(l_fullpathname,".epub")!= NULL
				|| strstr(l_fullpathname,".htm")!= NULL
				|| strstr(l_fullpathname,".html")!= NULL
				|| strstr(l_fullpathname,".txt")!= NULL)
				env->m_event = ZaEvent::EVENT_LIST_SELECT_FILE;
			if (strstr(l_fullpathname,".jpg")!=NULL
				|| strstr(l_fullpathname,".jpeg")!=NULL
				|| strstr(l_fullpathname,".png")!=NULL
				|| strstr(l_fullpathname,".bmp")!=NULL)
			{
				//sprintf(m_param,"photos://<em>local:%s</em>",m_param);
				navigator_open_file(l_fullpathname,NULL);
			}
			if (strstr(l_fullpathname,".mp3")!=NULL
				|| strstr(l_fullpathname,".wav")!=NULL)
			{
				//navigator_invoke
				//sprintf(m_param,"music://local:%s",m_param);
				navigator_open_file(l_fullpathname,NULL);
			}
		}
		if ((l_sb.st_mode & S_IFMT) == S_IFDIR
			&& access(l_fullpathname,R_OK) >= 0)
			changeeDir(l_fullpathname);

	}
}


ZaListDir::~ZaListDir() {
	// TODO Auto-generated destructor stub
	delete m_icon;
	delete m_icon_txt;
	delete m_icon_mp3;
	delete m_icon_img;
	delete m_icon_dir;
	delete m_icon_dir_doc;
	delete m_icon_dir_camera;
	delete m_icon_dir_downloads;
	delete m_icon_dir_music;
	delete m_icon_dir_photos;
	delete m_icon_dir_books;
	delete m_icon_dir_print;
	delete m_icon_dir_videos;
}

} /* namespace bbcubezone */
