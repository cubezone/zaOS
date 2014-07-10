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
	system("cp app/native/book/*.epub data");

	//system("cp data/TxtReader1012.db /accounts/1000/shared/books/TxtReader1012.db");

	zaMySQL * l_sql = zaMySQL::getInstance();
	l_sql->create_database("data/BooKRec.db");
	l_sql->createbookdb();
	char cwd[PATH_MAX];
	getcwd(cwd, PATH_MAX);

	m_startscreen = "ZaScreenRead";

	struct dirent *ptr;
	DIR *dir;
	dir = opendir("data");
	string epubname="";
	if (dir)
	{
		while ((ptr = readdir(dir)) != NULL) {
			if (strstr(ptr->d_name, ".epub") != 0)
			{
				epubname = ptr->d_name;
				break;
			}
		}
		closedir(dir);
	}

	ZaTweener::getInstance()->m_param = string(cwd)+"/data/" + epubname;
	fprintf(stderr,"\nepub file name: %s\n",ZaTweener::getInstance()->m_param.c_str());
	//ZaTweener::getInstance()->m_param = "/accounts/1000/shared/books/TangShi300.epub";

	return zaAppBase::init();
}

zaApp::~zaApp()
{

}
} /* namespace bbcubezone */
