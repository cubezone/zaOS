/*
 * zaDir10.cpp
 *
 *  Created on: 2012-2-19
 *      Author: zhuxy
 */

#include "zaDir10.h"

zaDir10::zaDir10() {
	// TODO Auto-generated constructor stub
}

int zaDir10::dirlist()
{
	this->m_0.LoadImg("app/native/res/battery_empty.png",512,512);
	this->m_0.setposition(380,980-90);
	this->m_1.LoadImg("app/native/res/battery_1.png",512,512);
	this->m_1.setposition(380,980-90);
	this->m_2.LoadImg("app/native/res/battery_2.png",512,512);
	this->m_2.setposition(380,980-90);
	this->m_3.LoadImg("app/native/res/battery_3.png",512,512);
	this->m_3.setposition(380,980-90);
	this->m_4.LoadImg("app/native/res/battery_4.png",512,512);
	this->m_4.setposition(380,980-90);
	this->m_5.LoadImg("app/native/res/battery_5.png",512,512);
	this->m_5.setposition(380,980-90);
	this->m_6.LoadImg("app/native/res/battery_6.png",512,512);
	this->m_6.setposition(380,980-90);
	this->m_7.LoadImg("app/native/res/battery_7.png",512,512);
	this->m_7.setposition(380,980-90);
	this->m_8.LoadImg("app/native/res/battery_full.png",512,512);
	this->m_8.setposition(380,980-90);
	this->m_9.LoadImg("app/native/res/battery_power.png",512,512);
	this->m_9.setposition(380,980-90);

	m_bar1.LoadImg("app/native/res/bar.png",768,100);
	m_bar1.setposition(384,1230);

	m_bar2.LoadImg("app/native/res/bar.png",768,150);
	m_bar2.setposition(384,550);

	m_bar3.LoadImg("app/native/res/bar.png",768,100);
	m_bar3.setposition(384,410);

	m_font.init("/usr/fonts/font_repository/monotype/SlatePro.ttf",20);
	m_fonts.init("/usr/fonts/font_repository/monotype/SlatePro.ttf",10);
	ppopen();

	return 0;
}

int zaDir10::dirlist( const char * p)
{
		  struct dirent *ptr;
		  DIR *dir;
		  dir=opendir(p);
		  if (dir == NULL)
			  return -1;
		  m_y = -300;
		  strcpy(m_path,p);
		  int i = 0;
		  strcpy(m_output[i],m_path);
		  if (m_path[strlen(m_path)-1] =='/')
			  strcat(m_output[i],"..");
		  else
			  strcat(m_output[i],"/..");
		  i ++;
		  m_index = 0;
		  fprintf(stderr,"pwd %s\n",m_path);
		  while((ptr=readdir(dir))!=NULL)
		  {

			  //���'.'��'..'����Ŀ¼
			  if(ptr->d_name[0] == '.')
			     continue;
			  if ( strcmp(m_path,"/") != 0)
				  strcpy(m_output[i],m_path);
			  else
				  strcpy(m_output[i],"");
			  strcat(m_output[i],"/");
			  strcat(m_output[i],ptr->d_name);
			  filedesc(m_output[i],i);
			  i ++;
			  fprintf(stderr,"<%s>\n",ptr->d_name);
		  }
		  m_output[i][0]=0;
		closedir(dir);
		fprintf(stderr,"%s","ov1");
		m_index_log = 0;
		return 0;
}

int zaDir10::filedesc(const char * filename,int index)
{
	stat(filename, &m_sb[index]) ;
//	 switch (sb.st_mode & S_IFMT)
//	 {
//	           case S_IFBLK:  printf("block device\n");            break;
//	           case S_IFCHR:  printf("character device\n");        break;
//	           case S_IFDIR:  printf("directory\n");               break;
//	           case S_IFIFO:  printf("FIFO/pipe\n");               break;
//	           case S_IFLNK:  printf("symlink\n");                 break;
//	           case S_IFREG:  printf("regular file\n");            break;
//	           case S_IFSOCK: printf("socket\n");                  break;
//	           default:       printf("unknown?\n");                break;
//	 }
//
//	  printf("I-node number:            %ld\n", (long) sb.st_ino);
//
//	  printf("Mode:                     %lo (octal)\n",
//	                                 (unsigned long) sb.st_mode);
//
//	           printf("Link count:               %ld\n", (long) sb.st_nlink);
//	           printf("Ownership:                UID=%ld   GID=%ld\n",
//	                   (long) sb.st_uid, (long) sb.st_gid);
//
//	           printf("Preferred I/O block size: %ld bytes\n",
//	                   (long) sb.st_blksize);
//	           printf("File size:                %lld bytes\n",
//	                   (long long) sb.st_size);
//	           printf("Blocks allocated:         %lld\n",
//	                   (long long) sb.st_blocks);
//
//	           printf("Last status change:       %s", ctime(&sb.st_ctime));
//	           printf("Last file access:         %s", ctime(&sb.st_atime));
//	           printf("Last file modification:   %s", ctime(&sb.st_mtime));

	           return 0;
}

void zaDir10::porcess(zaWorker * wk)
{
	m_dirty = true;
	if (wk->m_task ==2)
	{
		if (wk->m_len < 20)
		{

			soundplayer_play_sound("input_keypress");
			if (m_index_log != 0)
			{
				m_index_log = 0;
				return;
			}

			if(m_index != 0)
			{
				dirlist(m_output[m_index]);
			}
			else
			{
				strcpy(m_path,m_output[m_index]);
				int n = 0;
				for (int i = strlen(m_path) -1;i >=0 ; i --)
				{
					if ( m_path[i] == '/')
					{
						n ++;
						if (i==0)
							m_path[1] = 0;
						else
							m_path[i] = 0;
					}
					if (n ==2)
					{
						break;
					}
				}
				fprintf(stderr,"pwd 2 %s \n",m_path);
				dirlist(m_path);
			}
		}
	}
	else
		m_y -=  wk->m_dy;
}


int zaDir10::render()
{
//	if (!m_dirty)
//		return 0;

	m_dirty = false;

	if (!m_font.font)
	{
		fprintf(stderr,"font err");
		return EXIT_FAILURE;
	}

	static int rep = 0;
	static int a =0;

	char *p;
	int mount = 0;

	p = this->getValue("\"StateOfCharge\":");
	if (p == NULL)
	{
		mount = 0;
	}
	else
	    mount = atoi(p);

	a ++ ;
	if ( a >  mount/12.f)
		a = 0;

    bool l_charge = true;
    p = this->getValue("\"ChargerName\":\"");
	if (p != NULL)
	{
		if (strstr(p,"NONE")!=NULL
		   || strstr(p,"PLUGGED")!=NULL)
		{
			l_charge = false;
			a = mount/12.5f;
		}
	}

	if (a == 0)  this->m_0.RunImg();
	if (a == 1)  this->m_1.RunImg();
	if (a == 2)  this->m_2.RunImg();
	if (a == 3)  this->m_3.RunImg();
	if (a == 4)  this->m_4.RunImg();
	if (a == 5)  this->m_5.RunImg();
	if (a == 6)  this->m_6.RunImg();
	if (a == 7)  this->m_7.RunImg();
	if (a == 8)  this->m_8.RunImg();
	if (a >= 9)  this->m_9.RunImg();
//	m_bar1.RunImg();
//	m_bar2.RunImg();
//	m_bar3.RunImg();

	char info[100];
	memset(info,0,100);

	int l_y = 100;

	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);



	p = this->getValue("\"StateOfCharge\":");
	if (p != NULL)
	{
		sprintf(info,"%s%%",p);
	}

	int l_rate = atoi(p);

	p = this->getValue("AvailableEnergy:n:");
	if (p != NULL)
	{
		sprintf(info,"%s    %s mWH",info,p);
	}

	bbutil_render_text(m_font.font,"", 100.0f, 620-l_y);
	bbutil_render_text(m_font.font,info, 100.0f, 620-l_y);


	p = this->getValue("\"AverageCurrent\":"); //ChargeCurrent
	if (p != NULL)
	{
			sprintf(info,"%s mA",p);
	}

	int l_timeMin = 0;
	int l_cur = 0;
	int l_tofull = 0;

	if (info[0] == '-')
	{
	  glColor4f(1.0f, 0.0f, 0.0f, 1.0f);
	  l_cur = atoi(p+1);
	  l_timeMin = 1800*l_rate*60/100/l_cur;
	  l_tofull = 0;
	}
	else
	{
		glColor4f(0.0f, 1.0f, 0.0f, 1.0f);
		l_cur = atoi(p);
		if (l_cur != 0)
			l_timeMin = 1800*(100-l_rate)*60/100/l_cur;
		else
			l_timeMin = 24*60;
		l_tofull = 1;
	}
	bbutil_render_text(m_font.font,"", 100.0f, 620-l_y);
	bbutil_render_text(m_font.font,info,380.0f, 620-l_y);

	// charge time
	int l_hour, l_min;
	l_min = l_timeMin%60;
	if (l_timeMin > 59)
	{
		l_hour = (l_timeMin-l_min)/60;
		if (l_min == 0)
			sprintf(info," %d hour",l_hour);
		else
			sprintf(info,"%d h %d m",l_hour,l_min);
	}
	else
	{
		sprintf(info,"  %d min",l_min);
	}

	if (!l_tofull)
		strcat(info," to empty");
	else
		strcat(info," to full");
	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);

	if (l_timeMin != 0)
	{
		bbutil_render_text(m_fonts.font,"", 100.0f, 620-l_y);
		bbutil_render_text(m_fonts.font,info,200.0f, 500-l_y);
	}

	if ( !l_charge || (l_charge && rep < 3))
	{
		glColor4f(0.3f, 1.0f, 0.3f, 1.0f);

		p = this->getValue("\"BatteryName\":\"");
		if (p != NULL)
		{
			sprintf(info,"Name: %s",p);
		}
		bbutil_render_text(m_fonts.font,"", 100.0f, 620-l_y);
		bbutil_render_text(m_fonts.font,info, 80.0f, 440-50-l_y);

		p = this->getValue("\"StateOfBattery\":\"");
		if (p != NULL)
		{
			sprintf(info,"State of Battery: %s",p);
		}
		bbutil_render_text(m_fonts.font,"", 100.0f, 620-l_y);
		bbutil_render_text(m_fonts.font,info, 80.0f, 380-50-l_y);

		p = this->getValue("\"StateOfHealth\":");
		if (p != NULL)
		{
			sprintf(info,"Battery Health: %s%%",p);
		}
		bbutil_render_text(m_fonts.font,"", 100.0f, 620-l_y);
		bbutil_render_text(m_fonts.font,info, 80.0f, 320-50-l_y);

		p = this->getValue("\"BatteryAlert\":\"");
		if (p != NULL)
		{
			sprintf(info,"Battery Alert: %s",p);
		}
		bbutil_render_text(m_fonts.font,"", 100.0f, 620-l_y);
		bbutil_render_text(m_fonts.font,info, 80.0f, 260-50-l_y);


		p = this->getValue("\"Temperature\":");
		if (p != NULL)
		{
			sprintf(info,"CPU Temperature: %d",atoi(p)/100);
		}
		bbutil_render_text(m_fonts.font,"", 100.0f, 620-l_y);
		bbutil_render_text(m_fonts.font,info, 80.0f, 200-50-l_y);
	}

	if (l_charge && rep >= 3)
	{
		glColor4f(1.0f, 1.0f, 0.0f, 1.0f);

		p = this->getValue("\"ChargerName\":\"");
		if (p != NULL)
		{
			sprintf(info,"Charger: %s",p);
		}
		bbutil_render_text(m_fonts.font,"", 100.0f, 620-l_y);
		bbutil_render_text(m_fonts.font,info, 80.0f, 440-50-l_y);

		p = this->getValue("\"ChargerParams\":[{\"ChargerStatus\":\"");
		if (p != NULL)
		{
			sprintf(info,"Charger State: %s",p);
		}
		bbutil_render_text(m_font.font,"", 100.0f, 620-l_y);
		bbutil_render_text(m_fonts.font,info, 80.0f, 380-50-l_y);

		p = this->getValue("\"AverageCurrent\":"); //ChargeCurrent
		if (p != NULL)
		{
			sprintf(info,"Average Current: %s mA",p);
		}
		bbutil_render_text(m_fonts.font,"", 100.0f, 620-l_y);
		bbutil_render_text(m_fonts.font,info, 80.0f, 320-50-l_y);

		p = this->getValue("\"BatteryVoltage\":");
		if (p != NULL)
		{
			sprintf(info,"Battery Voltage: %s mV",p);
		}
		bbutil_render_text(m_fonts.font,"", 100.0f, 620-l_y);
		bbutil_render_text(m_fonts.font,info, 80.0f, 260-50-l_y);

		info[0] = 0;
		p = this->getValue("\"CycleCount\":");
		if (p != NULL)
		{
			sprintf(info,"Charge Count: %s",p);
		}
		bbutil_render_text(m_fonts.font,"", 100.0f, 620-l_y);
		bbutil_render_text(m_fonts.font,info, 80.0f, 200-50-l_y);

//		info[0] = 0;
//		p = this->getValue("\"TimeToFull\":");
//		if (p != NULL)
//		{
//			sprintf(info,"Time to Full: %s min",p);
//		}
//		bbutil_render_text(m_fonts.font,info, 80.0f, 200-50);
//
//		info[0] = 0;
//		p = this->getValue("\"Temperature\":");
//		if (p != NULL)
//		{
//			sprintf(info,"CPU Temperature: %s",p);
//		}
//		bbutil_render_text(m_fonts.font,info, 60.0f, 140);
	}

	if (l_charge)
	{
		rep ++ ;
		if( rep > 6)
			rep = 0;
	}
	else
		rep = 0;


	ppopen();

    struct   tm     *ptm;
    time_t ts;
    ts   =   time(NULL);
    ptm   =   localtime(&ts);
    char m_nowtime[40];
    sprintf(m_nowtime,"%04d/%02d/%02d %02d:%02d:%02d",
  		  ptm->tm_year+1900,
  		  ptm->tm_mon+1,
  		  ptm->tm_mday,
  		  ptm->tm_hour,
  		  ptm->tm_min,
  		  ptm->tm_sec );

	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
	bbutil_render_text(m_fonts.font,"", 100.0f, 620-l_y);
	bbutil_render_text(m_fonts.font, m_nowtime, 150.0f,1280-70.0f);
	usleep(1000000);
	return 0 ;
}

void zaDir10::disinfo(int l_x,int l_y,int i)
{


}

void zaDir10::exec()
{
	char cmd[100];
	 sprintf(cmd,"rm %s ","/accounts/1000/shared/photos/ChargeInfo.bmp");
	 FILE *read_fp = popen(cmd, "r");
	 pclose(read_fp);
}

void zaDir10::getbootime()
{

}

char * zaDir10::getValue(const char *p)
{
	for (int i = 0 ;i < m_index_log; i ++)
	{
		char * lp;
		if ((lp = strstr(m_log[i],p))!=NULL)
		{
			char *cc = m_log[i] + strlen(m_log[i]);
			while(1)
			{
				if( (*cc >= 48 && *cc <= 57)||
				  (*cc>=65&&*cc <= 90)||
				  (*cc>=97 && *cc <= 122) )
				  {
					break;
				  }
				  else
				  {
					  *cc = 0;
					  cc --;
				  }
			}
			return lp + strlen(p);
		}
	}
	return NULL;
}

void zaDir10::ppopen()
{
	//dsoundplayer_play_sound("event_camera_shutter");
    FILE *read_fp = NULL;
    char buffer[BUFSIZ + 1];
    char out[BUFSIZ + 1];
    int chars_read = 0;
    int i = 0;

    char cmd[255];

    sprintf(cmd,"cat %s ","/pps/system/BattMgr/status");

	memset(buffer, 0, sizeof(buffer));
	memset(out, 0, sizeof(out));

	read_fp = popen(cmd, "r");
	int pos = 0;
	if (read_fp != NULL)
	{
		while ((chars_read = fread(buffer, sizeof(char), 50, read_fp)) > 0)
		{
			char t;
			for (size_t m = 0; m < strlen(buffer); m++) {
				t = buffer[m];
				if (t == ',' || t == '}') {
					strcpy(m_log[i], out);
				//	fprintf(stderr, "%d->%s \n", i, out);
					//bbutil_render_text(font, out , 10.0f, 600-i*30.0f);
					i++;
					if (i > 99)
						break;
					pos = 0;
				} else if (t != ','|| t == '}') {
					out[pos] = t;
					pos++;
					out[pos] = 0;
				}
			}
		}
		if (pos > 0)
			strcpy(m_log[i], out);
		m_index_log = i;
	}
	pclose(read_fp);

	  sprintf(cmd,"cat %s ","/pps/services/power/charger");

		memset(buffer, 0, sizeof(buffer));
		memset(out, 0, sizeof(out));

		read_fp = popen(cmd, "r");
		 pos = 0;
		if (read_fp != NULL) {
			while ((chars_read = fread(buffer, sizeof(char), 50, read_fp)) > 0) {
				char t;

				for (size_t m = 0; m < strlen(buffer); m++) {
					t = buffer[m];
					if (t == 0x0A) {
						strcpy(m_log[i], out);
				//		fprintf(stderr, "%d->%s \n", i, out);
						//bbutil_render_text(font, out , 10.0f, 600-i*30.0f);
						i++;
						if (i > 450)
							break;
						pos = 0;
					} else if (t != 0x0D) {
						out[pos] = t;
						pos++;
						out[pos] = 0;
					}
				}
			}
			if (pos > 0)
				strcpy(m_log[i], out);
			m_index_log = i;
		}
		pclose(read_fp);
}

zaDir10::~zaDir10() {
	// TODO Auto-generated destructor stub
}

