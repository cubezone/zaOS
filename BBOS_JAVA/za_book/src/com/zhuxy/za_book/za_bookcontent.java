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

insert into tab_book values( null, 1,0,"《老子》第一章",1);
insert into tab_book values( null, 1,1,"道可道，非常道。名可名，非常名。",2);
insert into tab_book values( null, 1,1,"无名天地之始；有名万物之母。",3);
insert into tab_book values( null, 1,1,"故常无，欲以观其妙；常有，欲以观其徼。 ",4);
insert into tab_book values( null, 1,1,"此两者，同出而异名，同谓之玄。玄之又玄，众妙之门。 ",5);
insert into tab_book values( null, 1,0,"《老子》第二章 ",6);
insert into tab_book values( null, 1,6,"天下皆知美之为美，斯恶已。皆知善之为善，斯不善已。",7);
insert into tab_book values( null, 1,6,"有无相生，难易相成，长短相形，高下相盈，音声相和，前后相随。恒也。",8);
insert into tab_book values( null, 1,6,"是以圣人处无为之事，行不言之教；万物作而弗始，生而弗有，为而弗恃，功成而不居。夫唯弗居，是以不去。 ",9);


*/
}
