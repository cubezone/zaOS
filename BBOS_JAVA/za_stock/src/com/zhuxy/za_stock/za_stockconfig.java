package com.zhuxy.za_stock;

import net.rim.device.api.ui.MenuItem;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.Dialog;
import net.rim.device.api.ui.component.EditField;
import net.rim.device.api.ui.component.Menu;
import net.rim.device.api.ui.container.MainScreen;


public class za_stockconfig extends MainScreen{

	EditField l_ef = null;	
	EditField l_ef2 = null;	
	EditField l_ef3 = null;	
	za_stock m_rss;
	public za_stockconfig(za_stock l_rss)
	{
		  m_rss = l_rss;		  
		 l_ef =new EditField("Stock:", l_rss.m_symbol, EditField.DEFAULT_MAXCHARS,EditField.FILTER_DEFAULT);
		 add (l_ef);
		 l_ef2 =new EditField("数量: ",String.valueOf(l_rss.m_count), EditField.DEFAULT_MAXCHARS,EditField.FILTER_INTEGER);		 
		 add (l_ef2);
		 l_ef3 =new EditField("金额(分为单位）: ",String.valueOf(l_rss.m_fee), EditField.DEFAULT_MAXCHARS,EditField.FILTER_INTEGER);
		 add (l_ef3);
		 
		 l_ef.setCursorPosition(m_rss.m_symbol.length());
	} 
	  
	public boolean onSavePrompt()
	{
        if( Dialog.ask(Dialog.D_OK_CANCEL,"是否保存?",Dialog.CANCEL) == Dialog.OK)
        {
        	try {
        		m_rss.m_symbol= l_ef.getText();
        		m_rss.m_count = Integer.parseInt(l_ef2.getText());
        		m_rss.m_fee = Integer.parseInt(l_ef3.getText());
				za_db m_db = za_db.getInstanct();
				m_db.open();
				m_db.insert(m_rss); 
				m_db.close();
			} catch (Exception e) {
				za_db.errorDialog(e.toString());
			}		
        }
        return true;
	}

	protected void makeMenu(Menu menu, int instance) {			

		menu.add(new MenuItem("刷新", 20, 20) {
            public void run() 
            {   
	            new myrefresh().start();
        	}});		        
		menu.addSeparator();
	}
	private class myrefresh extends Thread {
		public void run() 
		{
			synchronized (this) {	
				 UiApplication.getUiApplication().invokeLater(new Runnable()
			        {
			            public void run()
			            {
			            	guiUpdate();
			            } 
			        });
			}
		}
		
		public void guiUpdate() 
		{        
        	try {
				sleep(500);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}        	
			m_rss.getStock();
			l_ef.setText(m_rss.m_symbol);
			l_ef2.setText(String.valueOf(m_rss.m_count));
			l_ef3.setText(String.valueOf(m_rss.m_fee));
		}
	}
}