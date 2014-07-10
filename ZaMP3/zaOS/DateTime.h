// DateTime.h: interface for the CDateTime class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_DATETIME_H__340D0F01_C181_11D4_B24D_00C04F0BEEAB__INCLUDED_)
#define AFX_DATETIME_H__340D0F01_C181_11D4_B24D_00C04F0BEEAB__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include <time.h>
#include "Exception.h"
#include <stdio.h>
#include <stdlib.h>
//??ʱ����
class CDateTime
{
public:
	//??�õ���ǰʱ��
	//??������
	//??��
	//??����ֵ��
	//??��ǰʱ��
	char* GetCurTime();
	
	//??��ǰ�Ƿ���Ч
	//??������
	//??-EffDate ��ʼʱ��
	//??-ExpDate ��ֹʱ��
	//??����ֵ��
	//??1 ��
	//??0 ��
	bool IsDateEffect(const CDateTime &EffDate, const CDateTime &ExpDate);
	
	//??�õ�����
	//??������
	//??��
	//??����ֵ��
	//??������
	int GetWeekDay();
	
	//??�õ�ԭʼʱ���ʽ
	//??������
	//??��
	//??����ֵ��
	//??��ǰʱ��
	char * GetRawDateTime();
		
	//??��ֵ
	//??������
	//??-datetime ʱ���ַ���
	//??����ֵ��
	//??1 �ɹ�
	//??0 ʧ��
	int Assign(char * datetime);
	
	//??����
	//??������
	//??-dt ʱ����
	//??����ֵ��
	//??ʱ�����
	CDateTime operator=(CDateTime dt);
	
	//??������
	//??������
	//??-dt ���ٵ�ʱ��
	//??����ֵ��
	//??ʱ�����
	CDateTime operator-(int dt);
	
	//??�Լ�����
	//??������
	//??-dt ���ٵ�ʱ��
	//??����ֵ��
	//??ʱ�����
	CDateTime operator-=(int dt);
	//??�Ӳ���
	//??������
	//??-dt ���ӵ�ʱ��
	//??����ֵ��
	//??ʱ�����
	CDateTime operator+(int dt);
	//??�Լ�����
	//??������
	//??+dt ���ٵ�ʱ��
	//??����ֵ��
	//??ʱ�����
	CDateTime operator+=(int dt);	
	//??������
	//??������
	//??-dt ʱ�����
	//??����ֵ��
	//??ʱ���
	int operator-(const CDateTime &dt);
	
	//??���ڱȽ�
	//??������
	//??-dt �Ƚϵ�ʱ�����
	//??����ֵ��
	//??�Ƿ����
	int operator>(const CDateTime &dt);
	
	//??���ڱȽ�
	//??������
	//??-dt �Ƚϵ�ʱ�����
	//??����ֵ��
	//??�Ƿ����
	int operator == (const CDateTime &dt);
	
	//??С�ڱȽ�
	//??������
	//??-dt �Ƚϵ�ʱ�����
	//??����ֵ��
	//??�Ƿ�С��
	int operator<(const CDateTime &dt);
	
	//??�õ�ʱ��
	//??������
	//??��
	//??����ֵ��
	//??��ǰʱ��
	char * GetDateTime();
	
	//??�õ�ʱ��
	//??������
	//??-format ʱ���ʽ
	//??����ֵ��
	//??��ǰʱ��
	char * GetDateTime(char * format);
	
	//??��ʱ����
	char m_temp[20];
	//??���㵥λ
	int m_unit;
	//??ʱ�����
	struct tm * m_localtime;
	//??ʱ�����
	struct tm m_datetime;
	//??���캯��
	CDateTime();
	//??��������
	~CDateTime();

protected:
	//??ʱ�����
	time_t m_time;
};

#endif // !defined(AFX_DATETIME_H__340D0F01_C181_11D4_B24D_00C04F0BEEAB__INCLUDED_)
