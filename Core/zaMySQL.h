/*
 * zaMySQL.h
 *
 *  Created on: 2012-8-25
 *      Author: Administrator
 */

#ifndef ZAMYSQL_H_
#define ZAMYSQL_H_
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sqlite3.h"

#if defined _WIN32_
#include <windows.h>
LARGE_INTEGER start,end,hz;
#else
//	#include <sys/time.h>
//	timeval *tv=NULL;
//	timezone *tz=NULL;
//	double start=0.0;
//	double end=0.0;
#endif

namespace bbcubezone {

class zaMySQL {
public:
	zaMySQL();
	virtual ~zaMySQL();
	sqlite3 *db;
	char *errmsg;
	char **m_strTable;
	FILE *pFile;

	 int m_row;
	 int m_column;

private:
	static zaMySQL * m_sql;

public: static zaMySQL * getInstance()
	{
		if (m_sql == NULL)
			m_sql = new zaMySQL();
		return m_sql;
	}
	void delete_record(char *table,char *expression);
	void close_database();
	void exec(const char * isql);
	void createbookdb();
	int getreadhis(char * bookname, int * page, int * filepos);
	int getreadhis(char * bookurl);
	int getcatelog(const char* bookname);
	int deleteBookmark(char *bookurl);

	void insert_into_table(char *table,char *record);
	void create_table(const char *table);
	void create_database(const char *name);
	void optimize_database(char *name);
	void print_table(char *table);
	void begin_transaction(void);
	void commit_transaction(void);

	static void freeInstance()
	{
		if (m_sql)
			delete m_sql;
	}

};



} /* namespace bbcubezone */
#endif /* ZAMYSQL_H_ */
