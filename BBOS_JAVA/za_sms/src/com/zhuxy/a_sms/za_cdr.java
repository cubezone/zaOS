package com.zhuxy.a_sms;

public class za_cdr {
	public za_cdr()
	{
		
	}

	public za_cdr(int i_row,String i_otherpart,String i_dt,int i_duration,int i_in_out,
			String i_location)
	{
		row = i_row;
		otherpart = i_otherpart;
		dt = i_dt;
		duration = i_duration;
		in_out = i_in_out;
		location = i_location;
	}
	
	String formatfee(int i_fee)
	{
		StringBuffer ls_allfee = new StringBuffer(200);
		ls_allfee.append(i_fee / 100).append(".");
		if ((i_fee % 100) < 10)
			ls_allfee.append("0");
		ls_allfee.append(i_fee % 100);		
		return  ls_allfee.toString();
	}
	
	String formatduration(int duration)
	{
		StringBuffer ls_duration = new StringBuffer(200);
		ls_duration.append(duration / 60).append("'");
		if ((duration % 60) < 10)
			ls_duration.append("0");
		ls_duration.append(duration % 60);		
		return  ls_duration.toString();
	}
	
	boolean iskefu()
	{
		return otherpart.equals("10010");
	}
	String  desccdr()
	{
		return  "号码:"+this.otherpart+"\r\n"+
				"时间:"+this.dt+"\r\n"+
				"时长:"+Integer.toString(this.duration)+"\r\n"+
				"费用:"+Integer.toString(this.fee)+"\r\n"+
				"通话地:"+this.location
				;		        
	}
	String  descbillall()
	{
		return  "通话次数:"+Integer.toString(row)+" "+			                
		        "固定费:"+ formatfee(monthfee+groupfee)+		                	
				"通信费:"+ Integer.toString(allfee);
	}
	String  descaddup()
	{
		return  
				"集团通话次数:"+Integer.toString(m_groupmin_n) + "  "+
				"集团分钟数:"+Integer.toString(m_groupmin)+ "\r\n" +
				"主叫通话次数:"+Integer.toString(out_n) + "  "+
				"主叫分钟数:"+Integer.toString(out_time) + "\r\n"+
				"被叫通话次数:"+Integer.toString(in_n)+ "  "+
				"被叫分钟数:"+Integer.toString(in_time)+ "\r\n"+
				"客服通话次数:"+Integer.toString(kf_n) + "  "+
				"客服分钟数:"+Integer.toString(kf_time)
				;
	}
	//%0 行号
	int row=0;	
//	%1 对端号码
	String type ="call";//"sms"
	String sub_type ="city";//"text","Bin","MMS"
	String otherpart = "";
//	%2 主被叫 ,0 :out ; 1 : in;
	int in_out = 0; 
//  通话地	
	String location ="location";
	String content ="sms";
//	%3 时间
	String dt = "";
//	%4 时长
	int duration = 0;
//	%5 费用
	int fee = 0;
//	%6 总费用
	int allfee =0;
	//%7 主叫次数 
	int out_n=0;
//	%8 主叫分钟数 
	int out_time=0;
//	%9 被叫次数
	int in_n=0;
//	%A 被叫分钟数
	int in_time=0;
//	%B 客服次数
	int kf_n=0;
//	%C 客服分钟数		
	int kf_time=0;
//	%D group次数	
	int m_groupmin_n=0;
//	%E group分钟数	
	int m_groupmin=0;
	
	int monthfee = 0;
	int groupfee = 0;
	
	
	/*create table tab_cdr
	 (id integer primary key,
	  otherpart varchar,
	  dt varchar,
	  duration integer,
	  in_out integer,
	  location varchar);
	  insert into tab_cdr select null,"18602510000","2010/10/10 10:10:10",
	  140,0,"MNC:460 LAC:50089";
	  	  insert into tab_cdr select null,"18602510000","2010/10/10 10:10:10",
	  240,1,"MNC:460 LAC:50089";
	  	  insert into tab_cdr select null,"18602510000","2010/10/10 10:10:10",
	  6000,1,"MNC:460 LAC:50089";
	 
	 */
	
}
