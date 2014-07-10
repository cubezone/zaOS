/*
 * zaFileText.cpp
 *
 *  Created on: 2012-8-28
 *      Author: Administrator
 */

#include "zaFileText.h"

namespace bbcubezone
{

zaFileText::zaFileText()
{
	// TODO Auto-generated constructor stub
	m_content = NULL;
}

zaFileText::~zaFileText()
{
	// TODO Auto-generated destructor stub
}

void zaFileText::resetcnt()
{
	m_segno = -1;
	m_segnomax = 0;
	if (m_content)
	{
		free(m_content);
		m_content = NULL;
	}
	m_contentlen = 0;
	m_filepos = 0;
	m_pagesize = 0;
}

void zaFileText::UTF16file(char * inf, char *outf, char * decode)
{

	struct stat st;
	stat(inf, &st);
	char * p = (char *) malloc(st.st_size);
	char * pp = (char *) malloc(st.st_size * 2);
	FILE* inh = fopen(inf, "rb");
	if (inh)
	{
		fread(p, st.st_size, 1, inh);
		fclose(inh);
	}

	iconv_t tt;
	tt = iconv_open("UTF-16LE", decode);
	char* inbuf = p + m_filepos; // m_filepos,  file head
	char* outbuf = pp;
	size_t inbytesleft = st.st_size;
	size_t outbytesleft = st.st_size * 2;

	int ret = iconv(tt, &inbuf, &inbytesleft, &outbuf, &outbytesleft);
	if (ret < 0)
	{
		int err = errno;
		fprintf(stderr,"UTF16file errno %d\n",err);
		throw CException(__FILE__,__LINE__,"font convert error ,filename %s",inf);
	}
		else
		fprintf(stderr,"UTF16file convert %d--%d--%d:\n",ret,st.st_size*2,outbytesleft);
	iconv_close(tt);

	FILE * oufh = fopen(outf, "wb");
	if (oufh)
	{
		fwrite(pp, st.st_size * 2 - outbytesleft, 1, oufh);
		fclose(oufh);
	}
	m_filepos = 0;
	free(p);
	free(pp);
}

int zaFileText::openfile(char * fn)
{

	strcpy(m_fn, fn);

	if (m_first)
	{
		char * p = fn + strlen(fn);
		while (*p != '/')
			p--;
		p++;
		//sprintf(m_hash,"%d",hash(m_fn));
		memset(m_hash, 0, 110);
		strncpy(m_hash, p, fn + strlen(fn) - p);
		strcpy(m_epub.m_hash, m_hash);
		char d_f[255];
		sprintf(d_f, "/accounts/1000/shared/books/BookReader/%s", m_hash);
		mkdir(d_f, 0775);
		m_first = false;
	}
	m_filetype = FILETYPE_TXT;
	if (strcmp(m_fn + strlen(m_fn) - 4, ".htm") == 0)
	{
		m_filetype = FILETYPE_HTML;
	}
	if (strcmp(m_fn + strlen(m_fn) - 5, ".html") == 0)
	{
		m_filetype = FILETYPE_HTML;
	}
	else if (strcmp(m_fn + strlen(m_fn) - 4, ".xml") == 0)
	{
		m_filetype = FILETYPE_HTML;
	}
	else if (strcmp(m_fn + strlen(m_fn) - 6, ".xhtml") == 0)
	{
		m_filetype = FILETYPE_HTML;
	}
	else if (strcmp(m_fn + strlen(m_fn) - 5, ".epub") == 0)
	{
		m_filetype = FILETYPE_HTML;
		char * p = m_fn + strlen(m_fn);
		while (*p != '/')
		{
			p--;
		}
		char l_p[255];
		memset(l_p, 0, 255);
		strncpy(l_p, m_fn, p - m_fn);
		m_epub.openEpub(l_p, p);
		m_epub.gethtmlpath();
		sprintf(m_fn, "%s", m_epub.m_pathname);
	}

	resetcnt();

	getEncode(m_fn);
	fprintf(stderr,"open file %s format %s\n",m_fn,this->m_encode);

	char u_f[255];
	sprintf(u_f, "/accounts/1000/shared/books/BookReader/%s/t.dat", m_hash);
	UTF16file(m_fn, u_f, m_encode);

	strcpy(m_filename, u_f);
	getEncodeUTF16(m_filename);

	struct stat l_st;
	stat(m_filename, &l_st);
	m_size = l_st.st_size;
	return 0;
}

int zaFileText::readword(char * buf)
{
	return 0;

}

//utf-8
int zaFileText::readchar(char * buf)
{
	char buffer[2];
	char c;
	while (int ret = fread(&c, sizeof(char), 1, m_fh) > 0)
	{
		if (c < 128)
		{
			buffer[0] = c;
			return 1;
		}
		else
		{
			buffer[0] = c;
		}
	}
}

int zaFileText::preseg()
{
	return readseg(1);
}

char * zaFileText::fname(char * fn)
{
	char * p = fn + strlen(fn);
	for (int i = strlen(fn); i > 0; i--)
	{
		if (*p != '/')
			p--;
		else
			break;
	}
	return p + 1;
}

int zaFileText::nextseg()
{
	return readseg(0);
}

int zaFileText::getEncodeUTF16(char *fn)
{
	FILE * f = fopen(fn, "rb");
	if (!f)
	{
		if (fn)
			throw CException(__FILE__, __LINE__,
					"file handle is null ,filename %s", fn);
		else
			throw CException(__FILE__, __LINE__,
					"file handle is null ,filename %s", "NULL");
	}

	unsigned char cod[2000];
	int ret = fread(cod, sizeof(char), 2000, f);
	fclose(f);
	unsigned char * p = cod;
	for (int i = 0; i < ret; i += 2)
	{
		unsigned int charcode = ((unsigned char) *(p + 1)) * 256
				+ (unsigned char) *p;
		if (charcode > 0x3300 && charcode < 0x9FFF)
		{
			strcpy(m_charset, "zh-CN");
			break;
		}
		p += 2;
	}
	fprintf(stderr,"zaFileText::getEncodeUTF16 m_encode %s, m_charset %s\n",
	this->m_encode,this->m_charset);

	return 0;
}

int zaFileText::getEncode(char * fn)
{

	FILE * f = fopen(fn, "rb");
	if (!f)
	{
		if (fn)
			throw CException(__FILE__, __LINE__,
					"file handle is null ,filename %s", fn);
		else
			throw CException(__FILE__, __LINE__,
					"file handle is null ,filename %s", "NULL");
	}

	char cod[400];
	fread(cod, sizeof(char), 400, f);
	fclose(f);

	strcpy(m_encode, "GBK");

	if ((unsigned char) cod[0] == 0xFF && (unsigned char) cod[1] == 0xFE)
	{
		strcpy(m_encode, "UTF-16LE");
		m_filepos = 2;
	}
	if ((unsigned char) cod[1] == 0xFF && (unsigned char) cod[0] == 0xFE)
	{
		strcpy(m_encode, "UTF-16BE");
		m_filepos = 2;
	}

	if ((unsigned char) cod[0] == 0xEF && (unsigned char) cod[1] == 0xBB)
	{
		strcpy(m_encode, "UTF-8");
		m_filepos = 3;
	}

	if (strstr(cod, "utf-8") || strstr(cod, "UTF-8")
			|| strstr(cod, "W3C//DTD XHTML"))
		strcpy(m_encode, "UTF-8");

	//lang="en";
	strcpy(m_charset, "en");
	char * p = strstr(cod, "lang=\"");
	if (p)
	{
		p += 6;
		int n = 0;
		while (*p && *p != '"')
		{
			this->m_charset[n] = *p;
			p++;
			n++;
		}
	}
	fprintf(stderr,"zaFileText::getEncode m_encode %s, m_charset %s\n",
	this->m_encode,this->m_charset);

	return 0;
}

//����ļ�ָ���ȡҳ��
int zaFileText::readseg(int dirct)
{
	int PAGE = 3000;

	if (dirct == 0)
	{
		if (m_filepos == this->m_size)
		{
			if (m_epub.m_xml.m_pages.size() > 0
					&& m_epub.m_pagecur < m_epub.m_xml.m_pages.size() - 1)
			{
				m_epub.m_pagecur++;
				m_epub.gethtmlpath();
				m_filepos = 0;
				openfile(m_epub.m_pathname);
			}
			else
			{
				return 0;
			}
		}
	}
	else
	{
		fprintf(stderr,"zaFileText::readseg %d, %d\n",m_pagesize,m_filepos);
		if(m_filepos == m_pagesize)
		{
			if (m_epub.m_xml.m_pages.size()==0)
			return 0;
		}

		if(m_filepos == m_pagesize)
		if (m_epub.m_xml.m_pages.size() > 0)
		{
			if (m_epub.m_pagecur > 0)
			{
				m_epub.m_pagecur --;
				m_epub.gethtmlpath();
				openfile(m_epub.m_pathname);
				m_filepos = m_size;
				m_pagesize = 0;
			}
			else
			return 0;
		}
	}

	if (m_content)
	{
		free(m_content);
		m_content = NULL;
	}
	m_content = (char *) malloc(sizeof(char) * PAGE);
	// forward

	this->m_fh = fopen(m_filename, "rb");
	if (!m_fh)
	{
		throw CException(__FILE__, __LINE__, "file handle is null ,filename %s",
				m_filename);
		fprintf(stderr,"zaFileText::readseg errno %s\n",m_filename);
		return 0;
	}
	int ret;
//		fprintf(stderr,"back %d %d\n",m_filepos,m_pagesize);
	if (dirct == 0)
	{
		fseek(m_fh, m_filepos, 0);
		ret = fread(m_content, sizeof(char), PAGE, m_fh);
	}
	else
	{
		m_filepos -= m_pagesize;
		//backward
		if (m_filepos - PAGE >= 0)
		{
			fprintf(stderr,"back %s %d\n",m_epub.m_pathname,m_filepos-PAGE);

			fseek(m_fh,m_filepos-PAGE,0);
			ret = fread(m_content,sizeof(char),PAGE,m_fh);

			fprintf(stderr,"back2 %s %d\n",m_epub.m_pathname,m_filepos-PAGE);
		}
		else
		{
			fprintf(stderr,"rewind %s %d\n",m_epub.m_pathname,m_filepos);
			rewind(m_fh);
			ret = fread(m_content,sizeof(char),m_filepos,m_fh);
		}
	}

	fclose(m_fh);

	if (ret <= 0)
	{
		strcpy(m_content, "no content");
		m_pagesize = 0;
		m_contentlen = 0;
		if (ret < 0)
		{
			throw CException(__FILE__, __LINE__, "file read error ,filename %s",
					m_filename);
		}
		return 0;
	}
	else
	{
		this->m_contentlen = ret;
		return 1;
	}
	return 0;
}

} /* namespace bbcubezone */
