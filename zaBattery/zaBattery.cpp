/*
 * zaWindMill.cpp
 *
 *  Created on: 2012-2-10
 *      Author: zhuxy
 */
#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <math.h>
#include "zaGL.h"
#include "dirent.h"


#include <drvr/hwinfo.h>

int opgltest();

int main()
{
	return opgltest();
}

int opgltest()
{
	bbcubezone::zaGL m_gl;
	m_gl.m_id = 10;
	m_gl.init();
	m_gl.initBG();
	m_gl.start();
	return 0;
}
