package com.zhuxy.za_phone;

import net.rim.device.api.ui.Color;
import net.rim.device.api.ui.Font;
import net.rim.device.api.ui.Graphics;
import net.rim.device.api.ui.Ui;

public class za_cdr {
	String m_icon = null;
	public za_cdr()
	{
		
	}

	public za_cdr(int i_row,String i_otherpart,String i_dt,int i_duration,int i_in_out,
			String i_location,String i_cdr_type,String i_cdr_subtype,
			String i_mcc , String i_mnc, String i_lac , String i_cell,String i_content)
	{
		row = i_row;
		otherpart = i_otherpart;
		dt = i_dt;
		duration = i_duration;
		in_out = i_in_out;
		location = i_location;
		cdr_type = i_cdr_type;
		cdr_subtype = i_cdr_subtype;		
		this.mcc = i_mcc;
		this.mnc = i_mnc;
		this.lac = i_lac;
		this.cell = i_cell;
		this.content = i_content;
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
		if (isCall())
		{
		return  "����:����\r\n" +
				"����:"+this.otherpart+"\r\n"+
				"ʱ��:"+this.dt+"       "+
				"ʱ��:"+formatduration(duration)+"\r\n"+
				"����:"+formatfee(fee)+"\r\n"+
				"λ��:"+lac+","+cell+" "+this.location+"\r\n";
		}
		else
		{
		return  "����:����"+ cdr_subtype + "\r\n" +
				"����:"+this.otherpart+"\r\n"+			
				"ʱ��:"+this.dt+"       "+				
				"����:"+formatfee(fee)+"\r\n"+
				"����:"+content+"\r\n"+
				"λ��:"+lac+","+cell+" "+this.location+"\r\n";
		}			
	}
	String  descbillall()
	{
		return  "ͨ������:"+Integer.toString(row) +
				" �̶���:"+ formatfee(monthfee+groupfee)+		                	
				" ͨ�ŷ�:"+ formatfee(allfee);
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
	boolean isSMS()
	{
		return cdr_type.equals("SMS");
	}
	boolean isOut()
	{
		return (in_out==1);
	}
	boolean isCall()
	{
		return cdr_type.equals("Call");
	}
	
	boolean isPushAlert()
	{
		return cdr_subtype.equals("BIN");
	}
	
	String getIcon()
	{
		if (m_icon != null)
			return m_icon;
		
		String l_icon = "in.png";
		if (isCall()) // ����
		{
			if (duration != 0) {
				if (iskefu())
					l_icon = "user.png";
				else if (in_out == 0)
					l_icon = "in.png";
				else
					l_icon = "out.png";
			} else
				l_icon = "zero.png";
		} else if (isSMS()) // ����
		{
			if (isPushAlert())
				l_icon = "web.png";
			else if (in_out == 0)
				l_icon = "sms_in.png";
			else
			    l_icon= "sms_out.png";
		}
		m_icon = l_icon;
		return m_icon;
	}
	
	void paintbill( Graphics g, int index, int y,
			int w)
	{
		int l_pos;
		
		if ( isCall())
		if ( isOut())
			l_pos = 40;
		else 
			l_pos = 80;
		else
			if ( isOut())
				l_pos = 40;
			else 
				l_pos = 90;	
		
		
		g.drawBitmap(0 , y, 360, 110, za_icon.getInstance().getIcon(getIcon()), 0, 0);
	
		y = y + 20;
		//
		g.setColor(Color.BLACK);
		g.drawText("ͨ�ŷ�:" + this.formatfee(this.allfee), l_pos, y+3, 0, w);

		g.drawText("�̶���:"+ this.formatfee(monthfee + groupfee), l_pos, y + 25, 0, w);

		g.drawText("���η���:" + this.formatfee(this.fee), l_pos, y+49, 0, w);			
	
	}
	
	void paintaddup( Graphics g, int index, int y,
			int w)
	{
		int l_pos;
		
		if ( isCall())
		if ( isOut())
			l_pos = 40;
		else 
			l_pos = 80;
		else
			if ( isOut())
				l_pos = 40;
			else 
				l_pos = 90;	
		
		l_pos = l_pos;
		
		g.drawBitmap(0 , y, 360, 110, za_icon.getInstance().getIcon(getIcon()), 0, 0);
	
		y = y + 20;
		//
		g.setColor(Color.BLACK);
		g.drawText( "����ͨ������:"+Integer.toString(m_groupmin_n) + "  "+
				"������:"+Integer.toString(m_groupmin), l_pos, y+3, 0, w);

		g.drawText("����ͨ������:"+Integer.toString(out_n) + "  "+
				"������:"+Integer.toString(out_time), l_pos, y + 25, 0, w);

		g.drawText("����ͨ������:"+Integer.toString(in_n)+ "  "+
				"������:"+Integer.toString(in_time), l_pos, y+49, 0, w);	
	}
	
	void paint( Graphics g, int index, int y,
			int w)
	{
		try {
			int l_pos;
			if ( isCall())
			if ( isOut())
				l_pos = 40;
			else 
				l_pos = 80;
			else
				if ( isOut())
					l_pos = 40;
				else 
					l_pos = 90;			
				
			g.drawBitmap(0  , y, 360, 110, za_icon.getInstance().getIcon(getIcon()), 0, 0);

			y = y + 20;
			//
			g.setColor(Color.BLACK);
			g.drawText(otherpart, l_pos, y+3, 0, w);

			g.setColor(0x00666666);
			// fee
			g.drawText(formatfee( fee), l_pos +195, y+3, 0, w);											

			// billing time 
			if ( isCall())
				g.drawText(formatduration(duration), l_pos+200, y+49, 0, w);	
			
			if (isSMS()) //����
			{
				String l_out = content;

				if (isPushAlert())
				{
					int l_ind = l_out.indexOf("[") ;
					if (l_ind >=0)
						l_out = l_out.substring(l_ind);
				}
				
					if (g.getFont().getAdvance( l_out)> 200)	
						for (int n = 1 ; n < l_out.length(); n ++)
						if (g.getFont().getAdvance( l_out.substring(0,n))>200)	
						{
						      l_out = l_out.substring(0,n)+"...";				
							  break;
						}
				g.drawText(l_out, l_pos, y + 25, 0, w);			
				
			}				
			else
			{
				g.setColor(0x006644FF);
				g.fillRoundRect(l_pos, y+32, Math.min(210,(duration)),5,5,5);			
			}
			// date time
			g.setColor(Color.DARKGRAY);
			g.setFont( Font.getDefault().derive(Font.PLAIN, 7, Ui.UNITS_pt));					
			g.drawText(dt, l_pos , y +49, 0, w);
			g.setFont( Font.getDefault().derive(Font.PLAIN, 9, Ui.UNITS_pt));	

			g.setGlobalAlpha(255);			
			// line
			g.setColor(0x00888888);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//g.drawRoundRect(2, y+28, w, 20, 20, 20);
		//g.drawLine(0, y+59, w, y+59); 	 	
	}
	
	//%0 �к�
	int row=0;	
//	%1 �Զ˺���
	String cdr_type ="call";//"sms"
	String cdr_subtype ="city";//"text","Bin","MMS"
	String otherpart = "";
//	%2 ������ ,0 :out ; 1 : in;
	int in_out = 0; 
//  ͨ����	
	String location ="";
	String content ="";
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
	
	int sms_n = 0;
	String mcc ="";
	String mnc ="";
	String lac ="";
	String cell ="";
	
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
	 
  alter table tab_cdr add column  cdr_type varchar
  alter table tab_cdr add column  cdr_subtype varchar
  
  alter table tab_cdr add column     mcc varchar
  alter table tab_cdr add column     mnc varchar
  alter table tab_cdr add column     lac varchar
  alter table tab_cdr add column     cell varchar
  alter table tab_cdr add column     content varchar  
	 */
	
}
