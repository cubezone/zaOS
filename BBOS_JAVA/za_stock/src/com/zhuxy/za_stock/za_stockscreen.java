package com.zhuxy.za_stock;

import net.rim.device.api.browser.field2.BrowserField;
import net.rim.device.api.ui.MenuItem;
import net.rim.device.api.ui.TransitionContext;
import net.rim.device.api.ui.Ui;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.UiEngineInstance;
import net.rim.device.api.ui.component.Dialog;
import net.rim.device.api.ui.component.Menu;
import net.rim.device.api.ui.container.MainScreen;

public class za_stockscreen extends MainScreen {

	za_stock m_stock = null;
	za_wall l_wall  = new za_wall();
	za_wall l_wall2  = new za_wall();
	BrowserField m_bf = new BrowserField();

	public za_stockscreen(za_stock i_stock) {

		m_stock = i_stock;
		
		m_bf.requestContent("http://www.google.com"+m_stock.m_chart_url);
		add(m_bf);
		
		l_wall.addTitle(m_stock.m_symbol);
		l_wall.add(m_stock.m_company);
		l_wall.add("�ּ�: "+m_stock.m_last);
		l_wall.add("����: "+m_stock.m_perc_change+"%");
		l_wall.add("���: "+m_stock.m_high);
		l_wall.add("���: "+m_stock.m_low);
		l_wall.add("�ɽ���: "+m_stock.m_volume);
		l_wall.add("����ʱ��:"+m_stock.m_current_date_utc +" " +m_stock.m_current_time_utc);

		add(l_wall);
		
		l_wall2.addTitle("��ʷ��Ϣ");
		l_wall2.add("����: "+m_stock.m_open);
		l_wall2.add("��������: "+m_stock.m_y_close);		
		l_wall2.add("cnt: "+ m_stock.m_count);
		l_wall2.add("price: "+ m_stock.formatfee(m_stock.m_fee));
		add(l_wall2);	
		
		
		
	}
	
	protected void makeMenu(Menu menu, int instance) {		
			menu.add(new MenuItem("ˢ��", 20, 20) {
	            public void run() 
	            {     	
	            	new Cthd().start();	
	        	}});		        
				menu.addSeparator();
		  }
	
	private class Cthd extends Thread {
		public void run() 
		{
			synchronized (this) { 				
				 UiApplication.getUiApplication().invokeLater(new Runnable()
			        {
			            public void run()
			            {
			            	m_stock.m_last = "������...";	
			            	za_stockscreen.this.invalidate();
			            	m_stock.getStock();   
			            	l_wall.set(0,m_stock.m_company);
							l_wall.set(1,"�ּ�: "+m_stock.m_last);
							l_wall.set(2,"����: "+m_stock.m_perc_change +"%");
							l_wall.set(3,"���: "+m_stock.m_high);
							l_wall.set(4,"���: "+m_stock.m_low);
							l_wall.set(5,"�ɽ���: "+m_stock.m_volume);
							l_wall.set(6,"����ʱ��:"+m_stock.m_current_date_utc +" " +m_stock.m_current_time_utc);
							l_wall2.set(0,"����: "+m_stock.m_open);
							l_wall2.set(1,"��������: "+m_stock.m_y_close);							
							l_wall2.set(3,"cnt: "+ m_stock.m_count);
							l_wall2.set(4,"price: "+ m_stock.formatfee(m_stock.m_fee));
							m_bf.requestContent("http://www.google.com"+m_stock.m_chart_url);
					        UiApplication.getUiApplication().relayout();		 
			            } 
			   });			      		       
			}
		}
	}
}
