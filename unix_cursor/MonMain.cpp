#include <curses.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <sys/types.h>
#include <sys/time.h>
#include <signal.h>
#include <unistd.h>
#include "Const.h"
#include "IniFile.h"
#include "SysMon.h"

void catcht(int );
void signalinit();
void signalrestore();
void updatetime(int falg);

CSysMon m_sysmon;

int main(int argc, char **argv)
{	
	void * sysarea;
	CIniFile  m_log,m_ini;
	char ls_size[10];
	char ls_id[10];
	char l_logfile[30];

	m_ini.Init("System.ini");

	m_ini.GetKeyValue("SysLog","MonSys","sysmon.log",l_logfile);
	
	m_log.Init(l_logfile);

	m_sysmon.m_log = &m_log;

	m_log.Log("...............................");
	m_log.Log("...............................");
	m_log.Log("Monitor Started.");
/*	            
	struct itimerval timeint;              
	
	timeint.it_value.tv_sec = 1;           
	timeint.it_value.tv_usec = 0;          
	timeint.it_interval.tv_sec = 1;        
	timeint.it_interval.tv_usec = 0;       
	setitimer(ITIMER_REAL,&timeint,NULL);	
    
	signalinit();
*/
	m_sysmon.Open();

	m_sysmon.ScrOpen ();

	m_sysmon.MDI();

	m_sysmon.ScrClose();

	m_sysmon.Close();

//	signalrestore();

	m_log.Log("Monitor Shutdown.");

	return 0;
}

void catcht(int )
{
	signal(SIGALRM,updatetime);        
}

void signalinit()
{
    signal(SIGALRM,updatetime);
};

void signalrestore()
{
	signal(SIGALRM,SIG_DFL);
};

void updatetime(int flag)
{ 
	if (m_sysmon.m_subwin == 1) 
	{
		m_sysmon.OnTimer(); 
	}
    signal(SIGALRM,updatetime);
};



