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
		return  "����:"+this.otherpart+"\r\n"+
				"ʱ��:"+this.dt+"\r\n"+
				"ʱ��:"+Integer.toString(this.duration)+"\r\n"+
				"����:"+Integer.toString(this.fee)+"\r\n"+
				"ͨ����:"+this.location
				;		        
	}
	String  descbillall()
	{
		return  "ͨ������:"+Integer.toString(row)+" "+			                
		        "�̶���:"+ formatfee(monthfee+groupfee)+		                	
				"ͨ�ŷ�:"+ Integer.toString(allfee);
	}
	String  descaddup()
	{
		return  
				"����ͨ������:"+Integer.toString(m_groupmin_n) + "  "+
				"���ŷ�����:"+Integer.toString(m_groupmin)+ "\r\n" +
				"����ͨ������:"+Integer.toString(out_n) + "  "+
				"���з�����:"+Integer.toString(out_time) + "\r\n"+
				"����ͨ������:"+Integer.toString(in_n)+ "  "+
				"���з�����:"+Integer.toString(in_time)+ "\r\n"+
				"�ͷ�ͨ������:"+Integer.toString(kf_n) + "  "+
				"�ͷ�������:"+Integer.toString(kf_time)
				;
	}
	//%0 �к�
	int row=0;	
//	%1 �Զ˺���
	String type ="call";//"sms"
	String sub_type ="city";//"text","Bin","MMS"
	String otherpart = "";
//	%2 ������ ,0 :out ; 1 : in;
	int in_out = 0; 
//  ͨ����	
	String location ="location";
	String content ="sms";
//	%3 ʱ��
	String dt = "";
//	%4 ʱ��
	int duration = 0;
//	%5 ����
	int fee = 0;
//	%6 �ܷ���
	int allfee =0;
	//%7 ���д��� 
	int out_n=0;
//	%8 ���з����� 
	int out_time=0;
//	%9 ���д���
	int in_n=0;
//	%A ���з�����
	int in_time=0;
//	%B �ͷ�����
	int kf_n=0;
//	%C �ͷ�������		
	int kf_time=0;
//	%D group����	
	int m_groupmin_n=0;
//	%E group������	
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
