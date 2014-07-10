// DateTime.h: interface for the CDateTime class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_DATETIME_H__340D0F01_C181_11D4_B24D_00C04F0BEEAB__INCLUDED_)
#define AFX_DATETIME_H__340D0F01_C181_11D4_B24D_00C04F0BEEAB__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include <time.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

class CDateTime  
{
public:
	int GetWeekDay();
	char * GetRawDateTime();
	int m_unit;
	int Assign(char * datetime);	
	CDateTime operator=(CDateTime dt);
	CDateTime operator-(int dt);
	CDateTime operator+(int dt);
	int operator-(const CDateTime &dt);
	int operator>(const CDateTime &dt);
	int operator<(const CDateTime &dt);
	char * GetDateTime();
	char * GetDateTime(char * format);
	char m_temp[20];

	struct tm * m_localtime;
	struct tm m_datetime;
	CDateTime();
	virtual ~CDateTime();

protected:
	time_t m_time;
};

#endif // !defined(AFX_DATETIME_H__340D0F01_C181_11D4_B24D_00C04F0BEEAB__INCLUDED_)
