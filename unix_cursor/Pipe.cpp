// Pipe.cpp: implementation of the CPipe class.
//
//////////////////////////////////////////////////////////////////////

#include "Pipe.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CPipe::CPipe()
{

}

CPipe::~CPipe()
{

}

int CPipe::GetLine(char *line)
{
	*line = 0;
	if (fgets(line,300,m_handle) != (char *)NULL);
	{
		if (line[0]==0)
			return 0;
		line[strlen(line)-1] = 0;
		return 1;
	}
	return 0;
}

int CPipe::Open(char *cmdstr)
{
	if((m_handle = popen(cmdstr,"r")) == NULL)
		return 0;
	fflush(m_handle);
	return 1;
}

int CPipe::Close()
{
	pclose(m_handle);
	return 1;
}


int CPipe::GetFileName(char *fdir,char *format, char *filename)
{
	char nameformat[100];
	if (filename != NULL)
		*filename = 0;
	else 
		return 0;
	sprintf(nameformat,"find %s -name '%s' -type f -print | sort",fdir,format);
	Open(nameformat);
    GetLine(filename);
	Close();
	if (strlen(filename) == 0)
		return 0;
	else
	{
		if (strncmp(filename,"find: cannot",12) == 0)
		{
			*filename = 0;
			return 0;
		}
		else
		{
		//	filename[strlen(filename)-1] = 0;
			return 1;
		}
	}
}

int CPipe::Running(char *runprogram)
{
	char cmd[200];
	char line[300];
	char runps[9];
	memset(runps,0,9);
	strncpy(runps,runprogram,7);
	int pn = 0;
	sprintf(cmd,"ps -e  -o fname -o ppid | grep %s",runps);
	if (Open(cmd) == 1)
	{
		while (GetLine(line) == 1 )
		{
			if(strncmp(line,runps,7)==0)
				pn ++;
			memset(line,0,300);
		}
		Close();
	}
	else
		return 0;

	if (pn > 1)
		return 1;
	else
		return 0;
}