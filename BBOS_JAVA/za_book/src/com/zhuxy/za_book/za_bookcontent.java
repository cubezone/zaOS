package com.zhuxy.za_book;

public class za_bookcontent {	
	
	public int m_id;
	public int m_bookid;
	public int m_pseq;
	public String m_content;
	public int m_seq;	
	
	public za_bookcontent (int id ,int bookid ,int pseq, String content, int seq)
	{
		m_id  = id ;
		m_bookid = bookid;
		m_pseq = pseq;
		m_content = content;
		m_seq = seq;		
	}
/*
 drop table tab_book;
 create table tab_book
  (id integer primary key ,bookid integer,pseq integer, content varchar ,seq integer);

insert into tab_book values( null, 1,0,"�����ӡ���һ��",1);
insert into tab_book values( null, 1,1,"���ɵ����ǳ��������������ǳ�����",2);
insert into tab_book values( null, 1,1,"�������֮ʼ����������֮ĸ��",3);
insert into tab_book values( null, 1,1,"�ʳ��ޣ����Թ�������У����Թ����衣 ",4);
insert into tab_book values( null, 1,1,"�����ߣ�ͬ����������ͬν֮������֮����������֮�š� ",5);
insert into tab_book values( null, 1,0,"�����ӡ��ڶ��� ",6);
insert into tab_book values( null, 1,6,"���½�֪��֮Ϊ����˹���ѡ���֪��֮Ϊ�ƣ�˹�����ѡ�",7);
insert into tab_book values( null, 1,6,"����������������ɣ��������Σ�������ӯ��������ͣ�ǰ�����档��Ҳ��",8);
insert into tab_book values( null, 1,6,"����ʥ�˴���Ϊ֮�£��в���֮�̣�����������ʼ���������У�Ϊ�����ѣ����ɶ����ӡ���Ψ���ӣ����Բ�ȥ�� ",9);


*/
}
