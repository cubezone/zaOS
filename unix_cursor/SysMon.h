// ShMemMon.h: interface for the CSysMon class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_SHMEMMON_H__EBA40161_BE42_11D4_B24D_00C04F0BEEAB__INCLUDED_)
#define AFX_SHMEMMON_H__EBA40161_BE42_11D4_B24D_00C04F0BEEAB__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include "IniFile.h"
#include <curses.h>
#include "Pipe.h"
#include "Const.h"
#include "DateTime.h"
#include <unistd.h>

class CSysMon  
{
public:
	typedef struct WINPOS
	{
		int listmax;
		int totalrow;
		int listtop;
		int currow;
		int list;
		char key;
	} WINPOS;
	int OnTimer();
	int MDI();
	int MessageBox(WINDOW * p_win,char * title, int x,int y, int high,int width,char * cmd,char cmkey);
	CIniFile * m_log;
	int Close();
	int Refresh(WINDOW *l_win,WINPOS *l_winpos, char * buffer[]);
	int ScrOpen();
	int ScrClose();
	int Open();
	CSysMon();
	int m_subwin;
	WINDOW * m_mdi;
	virtual ~CSysMon();
};

#endif // !defined(AFX_SHMEMMON_H__EBA40161_BE42_11D4_B24D_00C04F0BEEAB__INCLUDED_)

