// DateTime.cpp: implementation of the CDateTime class.
//
//////////////////////////////////////////////////////////////////////

#include "DateTime.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CDateTime::CDateTime()
{
	m_unit = 1;
    time(&m_time);
    m_localtime = localtime(&m_time);
	m_datetime = *m_localtime;
	memset(m_temp,0,20);
	strftime(m_temp,20,"%Y/%m/%d %S:%M:%S",m_localtime);
}

CDateTime::~CDateTime()
{

}


char * CDateTime::GetDateTime()
{
	memset(m_temp,0,20);
	strftime(m_temp,20,"%Y/%m/%d %H:%M:%S",&m_datetime);
	return m_temp;
}

char * CDateTime::GetDateTime(char *format)
{
	memset(m_temp,0,20);
	if (!strcmp(format,"HMS"))
		strftime(m_temp,20,"%H%M%S",&m_datetime);
	else if (!strcmp(format,"Ymd"))
		strftime(m_temp,20,"%Y%m%d",&m_datetime);
	else if (!strcmp(format,"YmdH"))
		strftime(m_temp,20,"%Y%m%d%H",&m_datetime);
	else if (!strcmp(format,"YmdHMS"))
		strftime(m_temp,20,"%Y%m%d%H%M%S",&m_datetime);
	return m_temp;
}

char * CDateTime::GetRawDateTime()
{
	return GetDateTime("YmdHMS");
}


int CDateTime::operator - (const CDateTime &dt)
{
	return (int)(difftime(m_time,dt.m_time) + m_unit - 1)/m_unit;	 
}

CDateTime CDateTime::operator=(CDateTime dt)
{
	m_datetime = dt.m_datetime;
	m_time = dt.m_time;
	return *this;
};

CDateTime CDateTime::operator+(int dt)
{
	m_datetime.tm_sec += dt;
	mktime(&m_datetime);
	return *this;
}

CDateTime CDateTime::operator-(int dt)
{
	m_datetime.tm_sec -= dt;
	mktime(&m_datetime);
	return *this;
}

int CDateTime::operator > (const CDateTime &dt)
{
	if (difftime(m_time,dt.m_time) > 0)
		return 1;
	return 0;
}

int CDateTime::operator < (const CDateTime &dt)
{
	if (difftime(m_time,dt.m_time) < 0)
		return 1;
	return 0;
}

int CDateTime::Assign(char *datetime)
{
	char l_temp[5];
	char *lp;
	char ls_dt[15];
	int year,month,day,hour,min,sec;
	int slen = strlen(datetime);
	memset(ls_dt,0,15);
	if (slen == 19)
	{
		strncat(ls_dt,datetime,4);
		strncat(ls_dt,datetime+5,2);
		strncat(ls_dt,datetime+8,2);
		strncat(ls_dt,datetime+11,2);
		strncat(ls_dt,datetime+14,2);
		strncat(ls_dt,datetime+17,2);
		slen = 14;
	}

	if ((slen != 14)
		&&(slen != 10)
		&&(slen != 8)
		&&(slen != 6)
	)
		return -1;
	lp = ls_dt;
	if (slen == 14)//Y
	{	
		memset(l_temp,0,5);
		strncpy(l_temp,lp,4);
		m_datetime.tm_year = atoi(l_temp) - 1900;
		lp += 4;
	}
	year = m_datetime.tm_year ;
	if (slen >= 10)//m
	{
		memset(l_temp,0,5);
		strncpy(l_temp,lp,2);
		m_datetime.tm_mon = atoi(l_temp) - 1;
		lp += 2;
	}
	month = m_datetime.tm_mon ;
	if (slen >= 8)//d
	{
		memset(l_temp,0,5);
		strncpy(l_temp,lp,2);
		m_datetime.tm_mday = atoi(l_temp);
		lp += 2;
	}
	day = m_datetime.tm_mday ;
	if (slen >= 6)//H
	{
		memset(l_temp,0,5);
		strncpy(l_temp,lp,2);
		m_datetime.tm_hour = atoi(l_temp);
		lp += 2;
	}
	hour = m_datetime.tm_hour ;
	if (slen >= 4)//S
	{
		memset(l_temp,0,5);
		strncpy(l_temp,lp,2);
		m_datetime.tm_min = atoi(l_temp);
		lp += 2;
	}
	min = m_datetime.tm_min;
	if (slen >= 2)//M
	{
		memset(l_temp,0,5);
		strncpy(l_temp,lp,2);
		m_datetime.tm_sec = atoi(l_temp);		
	}
	sec = m_datetime.tm_sec ;
	m_time = mktime(&m_datetime);

	if ((year  == m_datetime.tm_year)&&
		(month == m_datetime.tm_mon )&&
		(day   == m_datetime.tm_mday)&&
		(hour  == m_datetime.tm_hour)&&
		(min   == m_datetime.tm_min )&&
		(sec   == m_datetime.tm_sec )
		)
		return 0;
	else
		return -1;
}

int CDateTime::GetWeekDay()
{
	return m_datetime.tm_wday == 0 ? 7 : m_datetime.tm_wday;
}
