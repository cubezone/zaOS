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
//??时间类
class CDateTime
{
public:
	//??得到当前时间
	//??参数：
	//??无
	//??返回值：
	//??当前时间
	char* GetCurTime();
	
	//??当前是否有效
	//??参数：
	//??-EffDate 起始时间
	//??-ExpDate 终止时间
	//??返回值：
	//??1 真
	//??0 假
	bool IsDateEffect(const CDateTime &EffDate, const CDateTime &ExpDate);
	
	//??得到星期
	//??参数：
	//??无
	//??返回值：
	//??星期数
	int GetWeekDay();
	
	//??得到原始时间格式
	//??参数：
	//??无
	//??返回值：
	//??当前时间
	char * GetRawDateTime();
		
	//??赋值
	//??参数：
	//??-datetime 时间字符串
	//??返回值：
	//??1 成功
	//??0 失败
	int Assign(char * datetime);
	
	//??复制
	//??参数：
	//??-dt 时间类
	//??返回值：
	//??时间对象
	CDateTime operator=(CDateTime dt);
	
	//??减操作
	//??参数：
	//??-dt 加少的时间
	//??返回值：
	//??时间对象
	CDateTime operator-(int dt);
	
	//??自减操作
	//??参数：
	//??-dt 加少的时间
	//??返回值：
	//??时间对象
	CDateTime operator-=(int dt);
	//??加操作
	//??参数：
	//??-dt 增加的时间
	//??返回值：
	//??时间对象
	CDateTime operator+(int dt);
	//??自减操作
	//??参数：
	//??+dt 加少的时间
	//??返回值：
	//??时间对象
	CDateTime operator+=(int dt);	
	//??减操作
	//??参数：
	//??-dt 时间对象
	//??返回值：
	//??时间查
	int operator-(const CDateTime &dt);
	
	//??大于比较
	//??参数：
	//??-dt 比较的时间对象
	//??返回值：
	//??是否大于
	int operator>(const CDateTime &dt);
	
	//??等于比较
	//??参数：
	//??-dt 比较的时间对象
	//??返回值：
	//??是否相等
	int operator == (const CDateTime &dt);
	
	//??小于比较
	//??参数：
	//??-dt 比较的时间对象
	//??返回值：
	//??是否小于
	int operator<(const CDateTime &dt);
	
	//??得到时间
	//??参数：
	//??无
	//??返回值：
	//??当前时间
	char * GetDateTime();
	
	//??得到时间
	//??参数：
	//??-format 时间格式
	//??返回值：
	//??当前时间
	char * GetDateTime(char * format);
	
	//??临时变量
	char m_temp[20];
	//??计算单位
	int m_unit;
	//??时间变量
	struct tm * m_localtime;
	//??时间变量
	struct tm m_datetime;
	//??构造函数
	CDateTime();
	//??析构函数
	~CDateTime();

protected:
	//??时间变量
	time_t m_time;
};

#endif // !defined(AFX_DATETIME_H__340D0F01_C181_11D4_B24D_00C04F0BEEAB__INCLUDED_)
