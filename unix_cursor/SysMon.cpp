// ShMemMon.cpp: implementation of the CSysMon class.
//
//////////////////////////////////////////////////////////////////////

#include "SysMon.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CSysMon::CSysMon()
{
	m_subwin = 0;
}

CSysMon::~CSysMon()
{

}

int CSysMon::Open()
{
	return SUCCEED;
}

int CSysMon::ScrOpen()
{	
    initscr();
    savetty();
    //clear();
    noecho();
    nonl();                        
    return SUCCEED;
}

int CSysMon::ScrClose()
{
    //clear();
    refresh();
    resetty();
	endwin();
	return SUCCEED;
};

int CSysMon::Refresh(WINDOW *l_win,WINPOS *l_winpos, char * buffer[])
{
	int m , irow = 4;
	int l_y,l_x;
	
	if (l_winpos->totalrow > l_winpos->listtop + l_winpos->listmax - 2)
		m = l_winpos->listtop + l_winpos->listmax - 2;
	else 
		m = l_winpos->totalrow;
	mvwaddstr(l_win,4,1," ");
	for(int n = l_winpos->listtop; n <= m ; n ++ )
	{	
		if (l_winpos->list)
		{
			mvwaddstr(l_win,irow,1, " ");
			if (n == l_winpos->currow)
			{
				mvwaddstr(l_win,irow,1, "*");			
				wstandout(l_win);	
			}
		}
		if (buffer[n] != NULL)
		{
			mvwaddnstr(l_win,irow,3,"                                                                     ",getmaxx(l_win)-5);
			mvwaddstr(l_win,irow,3,buffer[n]);
		}
		if (l_winpos->list)
		{
			if (n == l_winpos->currow)
				wstandend(l_win);					
		}

		irow++;               
	}	

	wrefresh(l_win);

	return SUCCEED;
}

int CSysMon::Close()
{
	return SUCCEED;
}

int CSysMon::MessageBox(WINDOW *p_win,char *title, int x, int y, int high, int width, char *cmd,char cmkey)
{	
	WINDOW *l_win;		
	WINPOS l_winpos;
	CPipe *l_pip;
	char *buffer[200];
	char cmdsh[6][20];
	char *cmdptr;
	char runcmd[50];
	int l_help = 0;
	int n;
	l_pip = new CPipe;

	if (l_pip->Open(cmd) != 1)
	{
		m_log->LogErr("Pipe can't open %s",cmd);
		delete l_pip;
		return 0;
	}	

	for( n = 0; n < 6; n ++)
		memset(cmdsh[n],0,20);

	for ( n = 0; n < 200; n ++)
		buffer[n] = (char *)NULL;

	memset(&l_winpos,0,sizeof(WINPOS));

	buffer[0] = new char[200];
	
	if (l_pip->GetLine(buffer[0]) != 1)
	{
		m_log->LogErr("Pipe can't read %s",cmd);
		l_pip->Close();
		delete l_pip;
		delete buffer[0];
		return 0;
	}

	m_subwin ++ ;

	wrefresh(stdscr);
	
	if (strncmp(buffer[0],"*#SHELL",7) == 0)
	{
		l_pip->Close();
		delete l_pip;
		endwin();
		system(buffer[0] + 7);
		refresh();
		delete buffer[0];
		m_subwin -- ;
		return 0;
	}
    
	if (strncmp(buffer[0],"*#POSIT",7) == 0)
	{
		cmdptr = strtok(buffer[0]," ");
		if ((cmdptr = strtok(NULL," ")) != NULL)
			x = atoi(cmdptr);
		if ((cmdptr = strtok(NULL," ")) != NULL)
			y = atoi(cmdptr);
		if ((cmdptr = strtok(NULL," ")) != NULL)
			high = atoi(cmdptr);
		if ((cmdptr = strtok(NULL," ")) != NULL)
			width = atoi(cmdptr);

		l_win = newwin(high,width,x,y);
		
		keypad(l_win,TRUE);

		if (m_subwin == 1)
			m_mdi = l_win;
	}
	else
	{
		l_pip->Close();
		delete l_pip;
		delete buffer[0];
		m_subwin -- ;
		return -1;
	}

	box(l_win,0,0);
	mvwaddstr(l_win,0,width - 8,"Q=Quit");
	wrefresh(l_win);

	int i = 0;
	
	while ((l_pip->GetLine(buffer[i]) == 1))
	{
		if (strncmp(buffer[i],"*#",2) != 0)
		{
			if (i < high - 5)
				mvwaddnstr(l_win,i+2,3,buffer[i],width-6);
			if (i == 1)
				mvwaddnstr(l_win,high - 3,3,buffer[i],width -6);
			buffer[++i] = new char[200];
			memset(buffer[i],0,200);
		}
		else //internal control command 
		if (!strncmp(buffer[i],"*#HELPS",7))
		{
			mvwaddnstr(l_win,0,2,"H=Help",8);
			l_help = 1;
		}
		else if (!strncmp(buffer[i],"*#TITLE",7))
			mvwaddstr(l_win,0,(width - strlen(buffer[i] + 8))/2,buffer[i] + 8);
		else if (!strncmp(buffer[i],"*#CLIST",7))
			l_winpos.list = 1;
		else if (!strncmp(buffer[i],"*#CMDSH",7))
		{
			cmdptr = strtok(buffer[i]," ");
			for(int t = 0 ; t < 6 ; t ++)
				if ((cmdptr = strtok(NULL," ")) != NULL)
					sprintf(cmdsh[t],"%s",cmdptr);
		}
		else if (!strncmp(buffer[i],"*#CMDBT",7))
			mvwaddnstr(l_win,high - 2,3,buffer[i] + 8,60);
		
		
	}

	wrefresh(l_win);

	l_pip->Close();
	
	delete l_pip;

	wrefresh(l_win);
	l_winpos.listmax = high -  6;
	l_winpos.currow = 2;
	l_winpos.listtop = 2;
	l_winpos.totalrow = i-1 ; 

	int ckey ='0';
	int l_reload = 0;

	while ((ckey = wgetch(l_win)) != 'q')
	{ 
		switch(ckey)
		{
		case '1':
		case '2':
		case '3':
		case '4':
		case '5':
			if (cmdsh[ckey - '1' + 1][0])
			{
				sprintf(runcmd, "sysmon.sh %s",cmdsh[ckey - '1' + 1]);
				m_log->Log("%s",runcmd);
				MessageBox(l_win,"",0,0,0,0,runcmd,ckey);
				Refresh(l_win,&l_winpos,buffer);
			}
			else
				beep();
			break;
		case 'r': 
			if(m_subwin > 1)
			{ 
				ungetch('q');
				l_reload = 1;
			}
			break;
		case 'h': 
			if (l_help == 1)
			{
				sprintf(runcmd, "sysmon.sh %sh",cmdsh[0]);
				m_log->Log("%s",runcmd);
				MessageBox(l_win,"",0,0,0,0,runcmd,'0');
				Refresh(l_win,&l_winpos,buffer);
			}
			else
				beep();
			break;
		case 'j': 
		case KEY_DOWN : 
			if (! l_winpos.list ) break;
			if (l_winpos.currow < l_winpos.totalrow )
			{
				l_winpos.currow ++;
				if (l_winpos.currow  > l_winpos.listtop + l_winpos.listmax - 2)
				{
					l_winpos.listtop ++;
				}
		       Refresh(l_win,&l_winpos,buffer);
			}
			break;
		case 'k' :
		case KEY_UP : 
			if (! l_winpos.list ) break;
			if (l_winpos.currow > 2)
			{
				l_winpos.currow --;
				if (l_winpos.currow < l_winpos.listtop)
				{
					l_winpos.listtop --;
				}    		                        
				Refresh(l_win,&l_winpos,buffer);
			}
			break;
		default : 
			beep();
		}
	} 

	delwin(l_win);

	if (l_reload)
		ungetch(cmkey);
	else
	{	
		redrawwin(p_win);
		wrefresh(p_win);
	}
	for( n = 0 ; n < 200; n ++)
		delete buffer[n];
	
	m_subwin --;

	return 0;
}

int CSysMon::MDI()
{
	return MessageBox(stdscr,"",1,1,78,24,"sysmon.sh Main",'0');
}

int CSysMon::OnTimer()
{
	CDateTime ldt;
	mvwaddstr(m_mdi,21,54,ldt.GetDateTime());
	wrefresh(m_mdi);
	return 0;
}



