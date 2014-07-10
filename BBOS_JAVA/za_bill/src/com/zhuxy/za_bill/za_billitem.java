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
	insert into tab_billitem select 1,"交通","train.png",0 ;
	insert into tab_billitem select 2,"饮食","bread.png",0 ;
	insert into tab_billitem select 3,"住宿","home.png",0 ;
	insert into tab_billitem select 4,"通信","music.png",0 ;
	insert into tab_billitem select 5,"其他","music.png",0 ;

	insert into tab_billitem select 107,"出租车","car.png",1 ;
	insert into tab_billitem select 108,"飞机","plane.png",1 ;
	insert into tab_billitem select 109,"火车","train.png",1 ;
	insert into tab_billitem select 110,"大巴","train.png",1 ;
	insert into tab_billitem select 111,"地铁","train.png",1 ;
	insert into tab_billitem select 112,"轮渡","train.png",1 ;
	insert into tab_billitem select 113,"其他","train.png",1 ;

	insert into tab_billitem select 214,"正餐","bread.png",2 ;
	insert into tab_billitem select 215,"快餐","McDs.png",2 ;
	insert into tab_billitem select 216,"饮料","coco.png",2 ;
	insert into tab_billitem select 217,"零食","bread.png",2 ;
	insert into tab_billitem select 218,"水果","ananas.png",2 ;
	
	insert into tab_billitem select 320,"汉庭","home.png",3 ;
	insert into tab_billitem select 321,"锦江之星","home.png",3 ;
	insert into tab_billitem select 322,"如家","home.png",3 ;
	insert into tab_billitem select 323,"其他","home.png",3 ;
	
	insert into tab_billitem select 424,"手机","dc.png",4 ;
	insert into tab_billitem select 425,"固话","dc.png",4 ;
	insert into tab_billitem select 426,"电器","dc.png",4 ;
	insert into tab_billitem select 427,"其他","dc.png",4 ;
	
	insert into tab_billitem select 528,"娱乐","guitar.png",5 ;
	insert into tab_billitem select 529,"服装","guitar.png",5 ;
	insert into tab_billitem select 530,"其他","guitar.png",5 ;

*/