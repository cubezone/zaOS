// IniFile.h: interface for the CIniFile class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_INIFILE_H__16E7DBE1_A14B_11D4_B9C2_E04A63DD4C02__INCLUDED_)
#define AFX_INIFILE_H__16E7DBE1_A14B_11D4_B9C2_E04A63DD4C02__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include "DateTime.h"

class CIniFile  
{
public:

	int Log(char * format,...);
	int LogErr(char * format,...);
	int WriteString(char * value);
	int Init(char *filename);
	int Open(char *filename,char *mode);	
	int Open(char * mode);
	int GetKeyValue(char *section,char *key,const char *defaultvalue,char *value);
	int RowGet(char * line);
	int Close();
	int m_debug;
	CIniFile();
	virtual ~CIniFile();
private:
	char m_filename[255];
	FILE *m_filehandle;
	int m_valid;
	
};

#endif // !defined(AFX_INIFILE_H__16E7DBE1_A14B_11D4_B9C2_E04A63DD4C02__INCLUDED_)
