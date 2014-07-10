/*
 * ZaDict.cpp
 *
 *  Created on: 2012-10-22
 *      Author: Administrator
 */

#include "ZaDict.h"
namespace bbcubezone {

ZaDict::ZaDict() {
	// TODO Auto-generated constructor stub

}

/*
 * 	ZaDict m_dict;
	std::string dict("/accounts/1000/shared/books/dict/langdao-ec-gb");
	m_dict.openDict(dict);
	std::string l_q;
	std::string l_o;
	l_q = "good" ;
	m_dict.queryWord(l_q,l_o);
	l_q = "bad" ;
	m_dict.queryWord(l_q,l_o);
	l_q = "job" ;
	m_dict.queryWord(l_q,l_o);
	l_q = "work away" ;
	m_dict.queryWord(l_q,l_o);
	m_dict.closeDict();
 */

void ZaDict::openDict(std::string & f)
{
	std::string l_name_dict = f + ".dict";
	std::string l_name_dz = f + ".dict.dz";
	std::string l_name_idx = f + ".idx";
	if (access(l_name_dict.c_str(),F_OK)>=0)
		m_dict.open(l_name_dict.c_str(),0);
	else if (access(l_name_dz.c_str(),F_OK)>=0)
		m_dict.open(l_name_dz.c_str(),0);
	else
	{
		fprintf(stderr,"ZaDict::openDict ,no data file\n");
		throw CException(__FILE__,__LINE__,"openDict ,no data file");
	}
	if (access(l_name_idx.c_str(),F_OK)<0)
	{
		fprintf(stderr,"ZaDict::openDict ,no idx file\n");
		throw CException(__FILE__,__LINE__,"openDict ,no inx file");
	}

	FILE *fh = fopen(l_name_idx.c_str(),"rb");
	m_v_idx.clear();
	m_v_idx.reserve(10000);
	struct stat st;
	stat(l_name_idx.c_str(),&st);
	char * buf = (char * )malloc(st.st_size);
	int ret = fread(buf,sizeof(char),st.st_size,fh);

	fclose(fh);
	char w[255];
	char *p = buf;
	int n=0;
	while ((p - buf )< st.st_size )
	{
		struct worditem_t  wd;
		while (*p)
		{
			w[n]=*p;
			p++;
			n++;
		}
		w[n]=0;
		n=0;
		wd.word = w;
		p++;
		wd.offset = ntohl(*reinterpret_cast<const unsigned int *>(p));
		p+=4;
		wd.size = ntohl(*reinterpret_cast<const unsigned int *>(p));
		p+=4;
		this->m_v_idx.push_back(wd);
		//fprintf(stderr,"ZaDict::openDict %s %u %u\n",w,wd.offset,wd.size);
	}
	int r = m_v_idx.size();
	fprintf(stderr,"ZaDict::openDict word count: %d\n",r);
}

int g_ascii_strcasecmp(const char *s1, const char *s2)
{
	const char *p = s1;
	const char *q = s2;
	while (*p != 0 && *q != 0 )
	{
		char c1= (*p>='A'&&*p<='Z') ? *p+32 : *p;
		char c2= (*q>='A'&&*q<='Z') ? *q+32 : *q;
		if (c1 > c2)
			return 1;
		if (c1 < c2)
			return -1;
		p++; q++;
	}
	if(*p && *q == 0 )
		return 1;
	if(*p==0 && *q )
		return -1;
	return 0;
}

int g_ascii_strncasecmp(const char *s1, const char *s2, int n)
{
	const char *p = s1;
	const char *q = s2;
	int i = 0;
	while (*p != 0 && *q != 0 )
	{
		i++;
		if (i > n)
			break;

		char c1= (*p>='A'&&*p<='Z') ? *p+32 : *p;
		char c2= (*q>='A'&&*q<='Z') ? *q+32 : *q;
		if (c1 > c2)
			return 1;
		if (c1 < c2)
			return -1;
		p++; q++;
	}
	return 0;
}

int stardict_strncmp(const char *s1, const char *s2 ,int n)
{
	return g_ascii_strncasecmp(s1,s2,n);
}

int stardict_strcmp(const char *s1, const char *s2)
{
	int a;
	a = g_ascii_strcasecmp(s1, s2);
	if (a == 0)
		return strcmp(s1, s2);
	else
		return a;
}

int Search_Bin(vector< struct worditem_t > &vec,  string key){
   vector<struct worditem_t>::iterator low, high, mid;
   low = vec.begin();
   high = vec.end()-1;
   while(low <= high)
   {
       mid = low + (high-low)/2;
       if(stardict_strcmp((*mid).word.c_str(), key.c_str())==0)
    	  return mid - vec.begin();
       else if (stardict_strcmp((*mid).word.c_str(), key.c_str())>0)
    	   high = mid - 1;
       else
    	   low = mid + 1;
   }
   if( stardict_strcmp((*mid).word.c_str(), key.c_str())<0)
	   return mid - vec.begin()+1;
   else
  	   return mid - vec.begin() ;
    return 0;
}


int ZaDict::queryWord(const std::string & w,std::string& o)
{
	struct worditem_t *t;

	m_index = Search_Bin(m_v_idx,w);
	t = &m_v_idx[m_index];

//	for (unsigned int i = 0 ;i < m_v_idx.size();i ++)
//	{
//		if (w <= m_v_idx[i].word )
//		{
//			t = &(m_v_idx[i]);
//			m_index = i;
//			break;
//		}
//		else
//			m_index = i;
//	}


	if (t->word == w)
	{
		char *buf = (char * )malloc(t->size+1);
		m_dict.read(buf,t->offset,t->size);
		buf[t->size]=0;
		o = buf;
		free(buf);
		fprintf(stderr,"ZaDict::openDict found: [%s] off[%d] size[%d] \n[%s]\n",
				w.c_str(),t->offset,t->size,o.c_str());
	}
	else
	{
		o = "";
		fprintf(stderr,"ZaDict::openDict not found: [%s]\n",w.c_str());
	}
	return 1;
}

void ZaDict::closeDict()
{
	m_dict.close();
}
ZaDict::~ZaDict() {
	// TODO Auto-generated destructor stub
}

}

