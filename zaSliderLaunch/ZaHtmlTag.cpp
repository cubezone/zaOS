// ZaHtmlTag.cpp: implementation of the ZaHtmlTag class.
//
//////////////////////////////////////////////////////////////////////

#include "ZaHtmlTag.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

ZaHtmlTag::ZaHtmlTag()
{

}

ZaHtmlTag::~ZaHtmlTag()
{

}
string ZaHtmlTag::getAttr(string attr)
{
	for(int i = 0; i +2 < this->m_attr.size();i += 2)
	{
		if (m_attr[i] == attr)
		{
			return m_attr[i+2];
		}
	}
	return "";
}

bool ZaHtmlTag::isEnd()
{
	return m_tagname[0]== '/';
}

bool ZaHtmlTag::isLink()
{
	return m_tagname=="a";
}

bool ZaHtmlTag::isImg()
{
	return m_tagname=="image";
}

void ZaHtmlTag::dump()
{
	printf("tag:name [%s] \n",m_tagname.c_str());		
	for (int i = 0; i < m_attr.size();i ++)
	printf("--->attr [%s] \n",m_attr[i].c_str());
	if (this->isLink())
	printf("--->try to get href [%s] \n",this->getAttr(string("href")).c_str());
	if (this->isImg())
	printf("--->image [%s] \n",this->getAttr(string("src")).c_str());
}
