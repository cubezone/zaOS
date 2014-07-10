// ZaHtmlDecode.cpp: implementation of the ZaHtmlDecode class.
//
//////////////////////////////////////////////////////////////////////

#include "ZaHtmlDecode.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

ZaHtmlDecode::ZaHtmlDecode()
{

}

ZaHtmlDecode::~ZaHtmlDecode()
{

}


void ZaHtmlDecode::run()
{
	string l_w = getWord();
	while (l_w.length()>0)
	{		
		if (l_w == "<")
		{	
			ZaHtmlTag l_t = getTag();
			l_t.dump();
		}
		else if (l_w != " " && l_w != "\r\n")
			printf("cnt:[%s] \n",l_w.c_str());
		l_w = getWord();
	}
}


ZaHtmlTag ZaHtmlDecode::getTag()
{

	ZaHtmlTag l_tag;

	string l_w=getWord();
	int i = 0;
	l_tag.m_tagname = l_w;
	while(l_w != ">")
	{		
		if (i >0 && l_w != " ")
			l_tag.m_attr.push_back(l_w);
		i ++;
		if (l_w == "\"")
		{
			l_tag.m_attr.pop_back();
			l_w=l_w+getQWord();
		}
		else
			l_w=getWord();
	}
	return l_tag;
}

int ZaHtmlDecode::setContent(const char *cnt, int len)
{
	this->m_content = cnt;
	this->m_len = len;
	m_p = (char *)m_content;
	return 0;
}

inline bool segchar(char c)
{
	return ((c) == '>' ||(c) == '<'||c==' '||c=='='||c=='"'||c==';'||c=='&');
}

string ZaHtmlDecode::getQWord()
{
	string l_w = getWord();
	string l_qw = l_w;
	while(l_w != "\"")
	{
		l_w = getWord();		
		l_qw.append(l_w);
	}
	return l_qw;
}


string	ZaHtmlDecode::getWord()
{
	char l_buf[3000];
	char *l_p = l_buf;
	string ls ;
	if (segchar(*m_p))
	{
		*l_p = *m_p;
		*(l_p+1)=0;
		m_p ++;		
		ls = l_buf;
		return ls;
	}

	while (m_p <= m_content + m_len)
	{
		if (segchar(*m_p))
		{
			break;
		}		

		*l_p = *m_p;
		m_p ++;
		l_p ++;
		*l_p=0;
	}
	if(m_p > m_content + m_len)
		return "";
    ls = l_buf;
    return ls;
}
