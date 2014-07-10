/*
 * zaFileNanage.cpp
 *
 *  Created on: 2012-2-10
 *      Author: zhuxy
 */

#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <math.h>
#include "ZaApp.h"

int main()
{
	try
	{
		bbcubezone::zaApp m_app;
		m_app.init();
		m_app.run();
	}
	catch ( ...)
	{
		fprintf(stderr,"%s","error");
	}
	return 0;
}
