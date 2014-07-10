/*
 * zaApp.cpp
 *
 *  Created on: 2012-8-25
 *      Author: Administrator
 */

#include "zaApp.h"

namespace bbcubezone {

zaApp::zaApp() {
	// TODO Auto-generated constructor stub
}

int zaApp::init()
{
	mkdir("/accounts/1000/shared/books/BookReader",0775);
	//	system("cp app/native/res/tt.epub /accounts/1000/shared/books/tt.epub");
	mkdir("data",0775);
	if (access("/accounts/1000/shared/books/BOOKREADERRESET.TXT",F_OK)>=0)
	{
		system("rm -Rf /accounts/1000/shared/books/BookReader/*");
		system("rm -Rf data/*.db");
		system("rm -Rf /accounts/1000/shared/books/TxtReader1012.db");
	}

	//system("cp data/TxtReader1012.db /accounts/1000/shared/books/TxtReader1012.db");

	zaMySQL * l_sql = zaMySQL::getInstance();
	l_sql->create_database("data/TxtReader1012.db");
	l_sql->createbookdb();


	m_startscreen = "ZaScreenHis";
	return zaAppBase::init();
}

zaApp::~zaApp()
{

}
} /* namespace bbcubezone */
