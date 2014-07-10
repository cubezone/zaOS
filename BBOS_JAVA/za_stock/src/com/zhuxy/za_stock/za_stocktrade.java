package com.zhuxy.za_stock;

public class za_stocktrade {
	public za_stocktrade( 
		int	id ,String symbol, String count,String fee,String dt)
	{
		m_id = id;
		m_symbol = symbol;
		m_count = count;
		m_fee = fee;
		m_datetime = dt;
	}
	
	int m_id;
	String m_symbol;
	String m_type; //buy ,sell
	String m_count;
	String m_fee;
	String m_datetime;
}

//  create table tab_stock 
//(id integer primary key,
// symbol varchar,
//symbol varchar,
//type varchar,
//count varchar,
//fee varchar,
//datetime varchar,
//);
