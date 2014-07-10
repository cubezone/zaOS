// Pipe.h: interface for the CPipe class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_PIPE_H__7E9FC4AE_3A66_4DA5_9EB6_891392A45B0D__INCLUDED_)
#define AFX_PIPE_H__7E9FC4AE_3A66_4DA5_9EB6_891392A45B0D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<sys/time.h>

class CPipe  
{
public:
	int Running(char * runprogram);
	int GetFileName(char *fdir,char *format,char * filename);
	int GetLine(char *line);
	int Close();
	int Open(char * cmdstr);
	CPipe();
	virtual ~CPipe();

private:
	FILE * m_handle;
};

#endif // !defined(AFX_PIPE_H__7E9FC4AE_3A66_4DA5_9EB6_891392A45B0D__INCLUDED_)
