/*
 * zaMySQL.cpp
 *
 *  Created on: 2012-8-25
 *      Author: Administrator
 */

#include "zaMySQL.h"

namespace bbcubezone {

zaMySQL * zaMySQL::m_sql = NULL;

zaMySQL::zaMySQL() {
	// TODO Auto-generated constructor stub
	m_strTable = NULL;
}

zaMySQL::~zaMySQL() {
	// TODO Auto-generated destructor stub
}


void error(const char *error)
{
	fprintf(stderr,"%s",error);
//   printf("%s\n",error);
}

void zaMySQL::create_database(const char *name)
{
     int handle;
     	 handle=sqlite3_open(name,&db);
     if(handle)
     {
        error(sqlite3_errmsg(db));
     }
     else
    	 fprintf(stderr,"create or open database:%s successfully!\n",name);
}

void zaMySQL::optimize_database(char *name)
{
    sqlite3_exec(db,"PRAGMA synchronous = OFF",0,0,&errmsg);//如果有定期备份的机制，而且少量数据丢失可接受，用OFF
    sqlite3_exec(db,"PRAGMA page_size = 4096",0,0,&errmsg);//只有在未创建数据库时才能设置
    sqlite3_exec(db,"PRAGMA cache_size = 8000",0,0,&errmsg); //建议改为8000
    sqlite3_exec(db,"PRAGMA case_sensitive_like=1",0,0,&errmsg);//搜索中文字串

    if(NULL != errmsg)
      error(errmsg);
}
void zaMySQL::create_table(const char *table)
{
      char create[128]="create table ";
      char *section=(char *)"(name varchar(20) primary key,age integer,sex varchar);";
      strcat(create,table);
      strcat(create,section);
      printf("%s\n",create);
      sqlite3_exec(db,create,0,0,&errmsg);
   // printf("%s",errmsg);
      if(NULL != errmsg)
      error(errmsg);
}
void zaMySQL::insert_into_table(char *table,char *record)
{
     char insert[128]="insert into \"";
     char *section=(char *)" values(";
     char *semi=(char *)");";
     strcat(insert,table);
     strcat(insert,"\"");
     strcat(insert,section);
     strcat(insert,record);
     strcat(insert,semi);
     sqlite3_exec(db,insert,0,0,&errmsg);
//     printf("%s\n",insert);
     if(NULL!=errmsg)
     error(errmsg);
}

int zaMySQL::deleteBookmark(char * bookurl)
{
	 char * l_sql ;
	 l_sql = sqlite3_mprintf("delete from tab_bookmark where hash = %Q ;",bookurl);
	 sqlite3_exec(db,l_sql,0,0,&errmsg);
	 sqlite3_free(l_sql);
	 l_sql = sqlite3_mprintf("delete from tab_catelog where bookname = %Q ;",bookurl);
	 sqlite3_exec(db,l_sql,0,0,&errmsg);
	 sqlite3_free(l_sql);
	 return 0;
}

int zaMySQL::getreadhis(char * bookurl)
{
	if(m_strTable)
	{
		sqlite3_free_table(m_strTable);
		m_strTable  = NULL;
	}

	char * l_sql ;

	 if (bookurl)
		 l_sql = sqlite3_mprintf("select * From tab_bookmark where hash = %Q ;",bookurl);
	 else
		 l_sql = sqlite3_mprintf("select * From tab_bookmark order by lasttime desc;");

	   sqlite3_get_table(db,l_sql,&m_strTable,&m_row,&m_column,&errmsg);
	   if(NULL!=errmsg)
	    error(errmsg);
	   if (bookurl)
		   fprintf(stderr,"zaMySQL::getreadhis row=%d,column=%d  %s\n",m_row,m_column,bookurl);
	   else
	   	   fprintf(stderr,"zaMySQL::getreadhis all row=%d,column=%d\n",m_row,m_column );

	   sqlite3_free(l_sql);

	   if (m_row < 1 )
		   return 0;
	   else
		   return 1;
}


int zaMySQL::getcatelog(const char * bookname)
{
	if(m_strTable)
	{
		sqlite3_free_table(m_strTable);
		m_strTable  = NULL;
	}

	 char * l_sql ;
	 l_sql =sqlite3_mprintf("select sid,title,url From tab_catelog where bookname = %Q ;",bookname);

	   sqlite3_get_table(db,l_sql,&m_strTable,&m_row,&m_column,&errmsg);
	   if(NULL!=errmsg)
	    error(errmsg);
	   fprintf(stderr,"zaMySQL::getcatelog row=%d,column=%d %s\n",m_row,m_column,bookname);
	   sqlite3_free(l_sql);
	   //sqlite3_free_table(m_strTable);
	   if (m_row < 1 )
		   return 0;
	   else
		   return 1;
}

void zaMySQL::createbookdb()
{
	exec("create table tab_bookmark ("
			"bookURL varchar(255),"
			"lasttime varchar(30),"
			"hash varchar(255),"
			"corver varchar(255),"
			"bookname varchar(100),"
			"author varchar(100),"
			"page varchar(10),"
			"filepos varchar(20),"
			"xmlpath varchar(255)"
			")"
			";");
	exec("create index ind_tab_bookmark on tab_bookmark(bookURL);");
	exec("create index ind_tab_bookmark2 on tab_bookmark(hash);");
	exec("create table tab_catelog ("
			"bookname varchar (100),"
			"sid varchar (10),"
			"title varchar(255), "
			"url varchar(255) );");
	exec("create index ind_tab_catelog on tab_catelog(bookname);");
}


int zaMySQL::getreadhis(char * bookname, int * page, int * filepos)
{
	   char * l_sql;
	   l_sql= sqlite3_mprintf("select * From tab_bookmark where bookURL = \"%s\";",bookname);
	   sqlite3_get_table(db,l_sql,&m_strTable,&m_row,&m_column,&errmsg);
	   if(NULL!=errmsg)
	    error(errmsg);
	   fprintf(stderr,"zaMySQL::getreadhis  row=%d,column=%d %s\n ",m_row,m_column,bookname);
	   int i=0;
	   for(i=0;i<(m_row+1)*m_column;i++)
	   {
		  if (i == 6+m_column)
			  *page = atoi(m_strTable[i]);
		  if (i == 7+m_column)
			  *filepos = atoi(m_strTable[i]);

		  fprintf(stderr,"zaMySQL::getreadhis %s \n", m_strTable[i]);
	   }
	   sqlite3_free(l_sql);
	   sqlite3_free_table(m_strTable);
	   m_strTable = NULL;

	   if (m_row < 1 )
		   return 0;
	   else
		   return 1;
}
void zaMySQL::print_table(char *table)
{
   char sql[64]="SELECT * FROM ";
   char *semi=(char *)";";
   strcat(sql,table);
   strcat(sql,semi);


   sqlite3_get_table(db,sql,&m_strTable,&m_row,&m_column,&errmsg);
   if(NULL!=errmsg)
    error(errmsg);
   printf("zaMySQL::print_table row=%d,column=%d\n",m_row,m_column);
   int i=0;
   for(i=0;i<(m_row+1)*m_column;i++)
   {
	  fprintf(stderr,"%s \n", m_strTable[i]);
   }
   sqlite3_free_table(m_strTable);
   m_strTable = NULL;
}

void zaMySQL::delete_record(char *table,char *expression)
{
   char deletes[64]="delete from ";
   char where[32]=" where ";
   strcat(deletes,table);
   strcat(where,expression);
   strcat(where,";");
   if(NULL!=expression)
   strcat(deletes,where);
   sqlite3_exec(db,deletes,0,0,&errmsg);
   if(NULL!=errmsg)
   	 {
   		 error(errmsg);
   		 sqlite3_free(errmsg);
   	 }
}

void zaMySQL::exec(const char * isql)
{
	// to avoid sql hack. convert isql to ex_sql, outside;
	// char *ex_sql = sqlite3_mprintf("%s",isql);
	 sqlite3_exec(db,isql,0,0,&errmsg);
	//sqlite3_free(ex_sql);
	 if(NULL!=errmsg)
	 {
		 error(errmsg);
		 sqlite3_free(errmsg);
	 }
}


void zaMySQL::close_database()
{
   sqlite3_close(db);
}
void zaMySQL::begin_transaction(void)
{
   sqlite3_exec(db,"begin;",0,0,&errmsg);
   if(NULL!=errmsg)
   	 {
   		 error(errmsg);
   		 sqlite3_free(errmsg);
   	 }
}
void zaMySQL::commit_transaction(void)
{
   sqlite3_exec(db,"commit;",0,0,&errmsg);
   sqlite3_exec(db,"rollback;",0,0,&errmsg);
   if(NULL!=errmsg)
   	 {
   		 error(errmsg);
   		 sqlite3_free(errmsg);
   	 }
}

//void begin_watch(void)
//{
//#if defined _WIN32_
//     //start=GetTickCount();
//     QueryPerformanceFrequency(&hz);
//     QueryPerformanceCounter(&start);
//#else
//     gettimeofday(tv,tz);
//     start=tv->tv_sec*1000+(double)tv->tv_usec/1000000;
//#endif
//}
//void stop_watch(int type)
//{
//    char *prefix=(char *)malloc(64);
//#if defined _WIN32_
//   //end=GetTickCount();
//   QueryPerformanceCounter(&end);
//#else
//   gettimeofday(tv,tz);
//   end=tv->tv_sec*1000+(double)tv->tv_usec/1000000;
//#endif
//
//    switch(type)
//    {
//    case 1:
//       prefix="create databse";
//       break;
//    case 2:
//       prefix="create table";
//       break;
//    default:
//       sprintf(prefix,"insert %d records",type);
//       break;
//    }
//#if defined _WIN32_
//    fprintf(pFile,"%-25s 耗时：%lfms\n",prefix,((float)(end.QuadPart-start.QuadPart)/hz.QuadPart)*1000);
//    if(2<type)
//    fprintf(pFile,"\n\n");
//    fflush(pFile);
//    printf("耗时：%lfms\n",((float)(end.QuadPart-start.QuadPart)/hz.QuadPart)*1000);
//
//#else
//
//    fprintf(pFile,"%-25s 耗时：%lfms\n",prefix,end-start);
//    if(2<type)
//    fprintf(pFile,"\n\n");
//    fflush(pFile);
//     printf("耗时：%fms\n",end-start);
//
//#endif
//}


//void main3()
//{
//
//   int i=0;
//   float start=0,end=0;
//   char database[64];
//   char tablename[64];
//   int count=0;
//
//    pFile=fopen("log.txt","w+");
//    if(!pFile)
//    {
//        exit(0);
//    }
//while(1)
//{
//
//     printf("input the databse name:");
//     scanf("%s",&database);
//     begin_watch();
//     create_database(database);
//     stop_watch(1);
//
//     optimize_database(database);
//
//     printf("input the table name:");
//     scanf("%s",&tablename);
//     begin_watch();
//   create_table(tablename);
//   stop_watch(2);
//
//   printf("input the record numbers:");
//     scanf("%d",&count);
//   begin_watch();
//   begin_transaction();
//   for(i=0;i<count;i++)
//       insert_into_table(tablename,"NULL,23,1");
//   commit_transaction();
//     stop_watch(count);
//
////   print_table("student");
//   //delete_record("student","age=24");
//     //print_table("student");
//     close_database("student");
//   }
//   fcolse(pFile);
//}


} /* namespace bbcubezone */

