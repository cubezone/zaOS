package com.zhuxy.za_bill;

public class za_billitem {
		int id =0;
		String billitem;
		String type;
		String iconname;
		int parentid = 0;
		String itemname;
		
		public  za_billitem(
			int i_id,
			String i_billitem,
			String i_iconname,
			int i_parentid
			)
		{
			id = i_id;
			billitem = i_billitem;
			iconname = i_iconname;
			parentid = i_parentid;
		};
		public boolean isdir()
		{
			return (id <100);
		}
}
/*	
 create table tab_billitem
 
(
	id int primary key,
	billitem varchar,
	iconname varchar,
	parentid int
)
	insert into tab_billitem select 1,"��ͨ","train.png",0 ;
	insert into tab_billitem select 2,"��ʳ","bread.png",0 ;
	insert into tab_billitem select 3,"ס��","home.png",0 ;
	insert into tab_billitem select 4,"ͨ��","music.png",0 ;
	insert into tab_billitem select 5,"����","music.png",0 ;

	insert into tab_billitem select 107,"���⳵","car.png",1 ;
	insert into tab_billitem select 108,"�ɻ�","plane.png",1 ;
	insert into tab_billitem select 109,"��","train.png",1 ;
	insert into tab_billitem select 110,"���","train.png",1 ;
	insert into tab_billitem select 111,"����","train.png",1 ;
	insert into tab_billitem select 112,"�ֶ�","train.png",1 ;
	insert into tab_billitem select 113,"����","train.png",1 ;

	insert into tab_billitem select 214,"����","bread.png",2 ;
	insert into tab_billitem select 215,"���","McDs.png",2 ;
	insert into tab_billitem select 216,"����","coco.png",2 ;
	insert into tab_billitem select 217,"��ʳ","bread.png",2 ;
	insert into tab_billitem select 218,"ˮ��","ananas.png",2 ;
	
	insert into tab_billitem select 320,"��ͥ","home.png",3 ;
	insert into tab_billitem select 321,"����֮��","home.png",3 ;
	insert into tab_billitem select 322,"���","home.png",3 ;
	insert into tab_billitem select 323,"����","home.png",3 ;
	
	insert into tab_billitem select 424,"�ֻ�","dc.png",4 ;
	insert into tab_billitem select 425,"�̻�","dc.png",4 ;
	insert into tab_billitem select 426,"����","dc.png",4 ;
	insert into tab_billitem select 427,"����","dc.png",4 ;
	
	insert into tab_billitem select 528,"����","guitar.png",5 ;
	insert into tab_billitem select 529,"��װ","guitar.png",5 ;
	insert into tab_billitem select 530,"����","guitar.png",5 ;

*/