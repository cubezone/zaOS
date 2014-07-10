package com.zhuxy.za_rss;

import java.io.UnsupportedEncodingException;

import net.rim.device.api.browser.field2.BrowserField;
import net.rim.device.api.ui.Color;
import net.rim.device.api.ui.Font;
import net.rim.device.api.ui.MenuItem;
import net.rim.device.api.ui.Ui;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.Menu;
import net.rim.device.api.ui.component.RichTextField;
import net.rim.device.api.ui.container.HorizontalFieldManager;
import net.rim.device.api.ui.container.MainScreen;
import net.rim.device.api.ui.decor.BackgroundFactory;

public class za_rssitemscreen extends MainScreen {

	za_rssitem m_stock = null;
	RichTextField l_rich = null;
	RichTextField m_cnt= null;
	BrowserField browserField = new BrowserField();
	public za_rssitemscreen(za_rssitem i_stock) {
		m_stock = i_stock;		
		
		l_rich = new RichTextField("");		
		l_rich.setFont(Font.getDefault().derive(Font.BOLD, 12, Ui.UNITS_pt));
		l_rich.setText("\r\n"+m_stock.m_title+"\r\n");
		add(l_rich);
			
		l_rich = new RichTextField();
		l_rich.setFont(Font.getDefault().derive(Font.PLAIN,9, Ui.UNITS_pt));		
		l_rich.setText(m_stock.m_pubDate);
		add(l_rich);					
		
		
		m_cnt = new RichTextField();
		m_cnt.setFont(Font.getDefault().derive(Font.PLAIN, 12, Ui.UNITS_pt));		
		m_cnt.setText(m_stock.formatdesc(200));
		add(m_cnt);

			
		l_rich = new RichTextField();
		l_rich.setFont(Font.getDefault().derive(Font.PLAIN, 9, Ui.UNITS_pt));
		l_rich.setText(m_stock.m_link);
		add(l_rich);
		
		l_rich = new RichTextField("<<"){
			public boolean trackwheelClick(int status, int time) {
				za_rssitemscreen.this.close();
				return true;
			}
		};
		l_rich.setFont(Font.getDefault().derive(Font.PLAIN, 8, Ui.UNITS_pt));		
		
		add(l_rich);
		
		HorizontalFieldManager l_hfm = new HorizontalFieldManager();
		add(l_hfm);
				
		add (browserField);		
		
		new mythread().start();
	}

	private class mythread extends Thread {
		public void run() 
		{
			synchronized (this) {									
				 UiApplication.getUiApplication().invokeLater(new Runnable()
			        {
			            public void run()
			            {
			            	if (!m_stock.m_read)
			            		m_stock.updateread();
			            	m_cnt.setText(m_stock.formatdesc());	
			            } 
			        });
			}
		}
	}
	
	protected void makeMenu(Menu menu, int instance) {			

		menu.add(new MenuItem("Web模式", 20, 20) {
            public void run() 
            {   
            	String l_out = "<html><head>" +
    			"<style>body{font:32px}</style></head><body>"+	
    			m_stock.m_description+"</body></html>";
            	try {            		
					browserField.displayContent(l_out.getBytes("UTF-8"),
							"text/html; charset=UTF-8"
							,m_stock.m_link );
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
        	}});		
//		menu.add(new MenuItem("tt", 20, 20) {
//            public void run() 
//            {               	
//            	String l_out = "<html><head>" +
//    			"<style>body{font:32px}</style></head><body>"+	
//    			"中文 输入"+"</body></html>";
//            	try {
//					browserField.displayContent(l_out.getBytes("utf-8"),"text/html; charset=utf-8"
//							, m_stock.m_link);
//				} catch (UnsupportedEncodingException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
//        	}});		
		menu.addSeparator();
	}
	
}

