package com.zhuxy.za_bill;


public class za_bill {
	int row;
	String bill_cycle;
	String bill_type;
	String pay_type;
	String bill_time;
	String desc;
	String icon_name;
	String update_time;
	String LAC;	
	String CELL;
	String location;
	String LAC2;	
	String CELL2;
	String location2;	
	String remark;
	int count;
	int fee;
	int totalfee;
	public za_bill(){
		
	};
	
	public za_bill(
			int i_row,
			String i_bill_cycle,
			String i_bill_type,
			String i_pay_type,
			String i_bill_time,
			String i_desc,
			String i_icon_name,
			String i_update_time,
			String i_LAC,
			String i_CELL,
			String i_location,
			String i_LAC2,
			String i_CELL2,
			String i_location2,						
			String i_remark,
			int i_count,
			int i_fee
			){
		row = i_row;
		bill_cycle = i_bill_cycle;
		bill_type= i_bill_type;
		pay_type=   i_pay_type;
		bill_time=  i_bill_time;
		desc = i_desc;
		icon_name=  i_icon_name;
		update_time=i_update_time;
		LAC=        i_LAC;
		CELL=       i_CELL;
		location=   i_location;
		LAC2=       i_LAC2;
		CELL2=      i_CELL2;		
		location2=  i_location2;
		remark = i_remark;
		count = i_count;
		fee = i_fee;
	}
	
	String geticon() 
	{
		return icon_name;
	}

}
/*
	create table tab_bill
(
		id integer primary key,
		bill_cycle varchar,
		bill_type varchar, 
		pay_type varchar,
		bill_time varchar,
		desc varchar,
		icon_name varchar,
		update_time varchar,
		LAC varchar,
		CELL varchar,
		location varchar,
		LAC2 varchar,
		CELL2 varchar,
		location2 varchar,
		remark varchar,
		count integer,
		fee integer
	)
*/
