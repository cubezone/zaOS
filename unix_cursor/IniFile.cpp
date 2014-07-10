// IniFile.cpp: implementation of the CIniFile class.
//
//////////////////////////////////////////////////////////////////////

#include "IniFile.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CIniFile::CIniFile()
{
	m_valid = 0;
};

CIniFile::~CIniFile()
{
	Close();
};


int CIniFile::GetKeyValue(char *section,char *key,const char *defaultvalue, char *value)
{
    int state=0;
    char line[300];

	Open("r");

	if (! m_valid)
	{
		strcpy(value,defaultvalue);
		return -1;
	}	

	*value = 0;

    while(fgets(line,300,m_filehandle)!=NULL)
    {
	  if (*line == '#') continue;

      if (*line =='[' && state == 0)
		{
        	if(!strncmp(line+1,section,strlen(section)) 
           	&& *(line+1+strlen(section)) == ']') 
				state =1;
			continue;
		}
	  if (*line =='[' && state == 1) break ;	

      if(state == 1 && !strncmp(line,key,strlen(key)))
	  { 
        if(strchr(line,'=') == NULL) 
			break;		
        else
        	sscanf(strchr(line,'=') + 1,"%s",value);
		Close();
		return 0;
	  }
    }
	strcpy(value,defaultvalue);
	Close();
	return -1;
};

int CIniFile::RowGet(char * line)
{
	if (!m_valid) return -1;
		
	return fgets(line,500,m_filehandle) == NULL ? -1 : 0;
};

int CIniFile::Open(char * mode)
{
	Close();
	
	m_filehandle = fopen(m_filename,mode);

	return m_valid = m_filehandle == NULL ? 0 : 1;
}

int CIniFile::Init(char *filename)
{
	memset(m_filename,0,255);
	strcpy(m_filename,filename);
	m_debug = 0;
	return 0;
}

int CIniFile::Open(char *filename,char * mode)
{
	Init(filename);
	return Open(mode);
}

int CIniFile::Close()
{
	if (m_valid)
	{
		fclose(m_filehandle);
		m_valid = 0;
	}
	return m_valid;
}

int CIniFile::WriteString(char * value)
{
	fwrite(value,strlen(value),1,m_filehandle);
	fflush(m_filehandle);
	return 0;
}

int CIniFile::Log(char * format, ...)
{
	char msg[1024];
	va_list  pvar;
	CDateTime l_dt;
	memset(msg,0,1024);
	sprintf(msg,"%s %s  ",l_dt.GetDateTime(),"   ");
	va_start (pvar, format);
	vsprintf(msg + strlen(msg),format,pvar);
	va_end (pvar);
	strcat(msg,"\n");
	if(Open("a+") == 1)
	{
		WriteString(msg);
		if(m_debug)
		{
			printf(msg);
			fflush(stdout);
		}
		Close();
		return 0;
	}
	else 
		return -1;
};

int CIniFile::LogErr(char * format, ...)
{
	char msg[1024]; 
	va_list  pvar;
	CDateTime l_dt;
	memset(msg,0,1024);
	sprintf(msg,"%s %s  ",l_dt.GetDateTime(),":-(");
	va_start (pvar, format);
	vsprintf(msg + strlen(msg),format,pvar);
	va_end (pvar);
	strcat(msg,"\n");
	if(Open("a+") == 1)
	{
		WriteString(msg);	
		if(m_debug)
		{
			printf(msg);
			fflush(stdout);
		}
		Close();
		return 0;
	}
	else 
		return -1;
};