// ZaHtmlDecode.h: interface for the ZaHtmlDecode class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_ZAHTMLDECODE_H__2D609602_3533_46B3_874C_EF1110886AAA__INCLUDED_)
#define AFX_ZAHTMLDECODE_H__2D609602_3533_46B3_874C_EF1110886AAA__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include <string>
#include "Exception.h"
#include "ZaHtmlTag.h"
using namespace std;


class ZaHtmlDecode  
{
public:
	string getWord();
	string getQWord();
	int setContent(const char * cnt, int len);
	void run();
	ZaHtmlTag getTag();
	ZaHtmlDecode();
	virtual ~ZaHtmlDecode();
	const char *m_content;
	int m_len;
	char *m_p;
	string m_lastword;

};

#endif // !defined(AFX_ZAHTMLDECODE_H__2D609602_3533_46B3_874C_EF1110886AAA__INCLUDED_)
