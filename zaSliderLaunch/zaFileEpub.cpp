/*
 * zaFileEpub.cpp
 *
 *  Created on: 2012-8-28
 *      Author: Administrator
 */

#include "zaFileEpub.h"

namespace bbcubezone {

zaFileEpub::zaFileEpub() {
	// TODO Auto-generated constructor stub

}

int zaFileEpub::reset()
{

	m_xml.m_pages.clear();
	m_xml.m_navmap.clear();
	m_xml.m_spine.clear();
	m_xml.m_manifest.clear();

	m_xml.m_docauthor[0]=0;
	m_xml.m_docname[0]=0;
	m_xml.m_coverimg[0]=0;
	m_pagecur = 0;

	return 0;
}

int zaFileEpub::openEpub(char * path, const char * epubbook){

	char l_efile[255];
	char l_path[255];
//	if (path)
//		strcpy(l_path ,path);
//	else
	sprintf(l_path ,"/accounts/1000/shared/books/BookReader/%s",m_hash);

	sprintf(l_efile,"%s/%s",path,epubbook);

	char l_s[200];
	sprintf(l_s,"%s/t.dat",l_path);

	strcpy(m_xml.m_path,l_path);
	zaMySQL * l_my = zaMySQL::getInstance();
	//没有文件,或没有记录
	if(access(l_s,R_OK)<0 || l_my->getreadhis(m_hash)==0)
	{
		//"/accounts/1000/shared/documents/test/test.epub"
		unzFile uf= unzOpen(l_efile);
		fprintf(stderr, "openEpub path %s \n", l_path);
		char cwd[255];
		getcwd(cwd,255);
		chdir(l_path);
		do_extract(uf,0,1,NULL);
		unzClose(uf);
		chdir(cwd);
		m_xml.getOPF();

			m_xml.getNcx();

			m_xml.getlink();

			m_xml.buildpages();

		//	m_xml.dump();
			for (unsigned int i = 0 ; i < m_xml.m_pages.size() ; i ++)
			{
					char l_fn[200];
					sprintf(l_fn,"%s/%s",m_xml.m_path,m_xml.m_pages[i].href.c_str());
					if (access(l_fn,R_OK)<0)
					{
						reset();
						throw CException(__FILE__,__LINE__,"File Not Exist %s",l_fn);
					}
			}

			fprintf(stderr,"%d\n",m_xml.m_pages.size());

			char *l_sql;
			l_sql = sqlite3_mprintf("delete from tab_catelog  where bookname=%Q;",m_hash);
			string ls_sql = l_sql;
			sqlite3_free(l_sql);
			for (unsigned int i = 0 ; i < m_xml.m_pages.size() ; i ++)
			{
				l_sql = sqlite3_mprintf("insert into tab_catelog select %Q,'%d',%Q,'%d %q'; ",
							m_hash,i+1,
							m_xml.m_pages[i].href.c_str(),i+1,
							m_xml.m_pages[i].navlabel.c_str());
				ls_sql.append(l_sql);
				sqlite3_free(l_sql);
			}
			zaMySQL::getInstance()->exec(ls_sql.c_str());

	}
	else
	{
		m_xml.m_pages.clear();

		string ls;
		if(l_my->getcatelog(m_hash))
		{
			for (int i =  l_my->m_column ; i < (l_my->m_row +1)* l_my->m_column;i +=  l_my->m_column)
			{
				struct zaXML::bookspages_str l_bs;
				l_bs.href = l_my->m_strTable[i+1];
				l_bs.navlabel = l_my->m_strTable[i+2];
				m_xml.m_pages.push_back(l_bs);
			}
		}
		if(l_my->getreadhis(m_hash))
		{
			string ls;
			for (int i = l_my->m_column ; i < (l_my->m_row +1)* l_my->m_column;i += l_my->m_column)
			{
				strcpy(m_xml.m_coverimg ,l_my->m_strTable[i+3]);
				strcpy(m_xml.m_docname,l_my->m_strTable[i+4]);
				strcpy(m_xml.m_docauthor ,l_my->m_strTable[i+5]);
				strcpy(m_xml.m_path ,l_my->m_strTable[i+8]);
			}
		}

	//	m_xml.dump();
	}
	return 0;
}

void zaFileEpub::gethtmlpath(){

	if (m_pagecur <m_xml.m_pages.size())
		sprintf(m_pathname,"%s/%s",m_xml.m_path,m_xml.m_pages[m_pagecur].href.c_str());
	else
		throw CException(__FILE__,__LINE__,"m_pagecur %d over the book size %d ",m_pagecur,m_xml.m_pages.size());
}


int zaFileEpub::gotoPage(int n){
	return 0;
}

int zaFileEpub::prePage(){
	if (m_pagepos>0)
		m_pagepos --;
	return gotoPage(m_pagepos);
}

int zaFileEpub::nextPage(){
	if (m_pagepos < m_pagelen)
		m_pagepos ++;
	else
		//if (next()>0)
		{
			m_pagelen ++;
			m_pagepos = m_pagelen;
		}
	return gotoPage(m_pagepos);
}

int zaFileEpub::close(){
	return 0;
}

zaFileEpub::~zaFileEpub() {
	// TODO Auto-generated destructor stub
}

} /* namespace bbcubezone */
