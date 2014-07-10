// ZaHtmlTag.h: interface for the ZaHtmlTag class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_ZAHTMLTAG_H__B9148B77_F2D6_4475_BA60_6B65FC14F7D3__INCLUDED_)
#define AFX_ZAHTMLTAG_H__B9148B77_F2D6_4475_BA60_6B65FC14F7D3__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include <string>
#include <vector>
using namespace std;
class ZaHtmlTag  
{
public:
	void dump();
	string m_tagname;
	vector<string> m_attr;
	
	bool isEnd();
	bool isImg();
	bool isLink();
	string getAttr(string attr);
	ZaHtmlTag();
	virtual ~ZaHtmlTag();
};

#endif // !defined(AFX_ZAHTMLTAG_H__B9148B77_F2D6_4475_BA60_6B65FC14F7D3__INCLUDED_)
