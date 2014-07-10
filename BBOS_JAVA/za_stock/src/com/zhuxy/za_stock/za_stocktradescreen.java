package com.zhuxy.za_stock;

import net.rim.device.api.ui.MenuItem;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.Dialog;
import net.rim.device.api.ui.component.EditField;
import net.rim.device.api.ui.component.Menu;
import net.rim.device.api.ui.container.MainScreen;


public class za_stocktradescreen  extends MainScreen {
	EditField l_ef = null;	
	EditField l_ef2 = null;	
	za_stock m_stock;
	za_stocktrade m_stocktrade;
	public za_stocktradescreen(za_stock l_rss)
	{
		 m_stock = l_rss;
		 l_ef =new EditField("RSS:", m_stock.m_symbol, EditField.DEFAULT_MAXCHARS,EditField.FILTER_DEFAULT);
		 add (l_ef);
		 l_ef2 =new EditField("标题",m_stock.m_chart_url, EditField.DEFAULT_MAXCHARS,EditField.FILTER_DEFAULT);
		 add (l_ef2);
		 l_ef.setCursorPosition(m_stock.m_symbol.length());
	} 
	  
	public boolean onSavePrompt()
	{
        if( Dialog.ask(Dialog.D_OK_CANCEL,"是否保存?",Dialog.CANCEL) == Dialog.OK)
        {
        	try {
        		m_stock.m_symbol= l_ef.getText();
        		m_stock.m_chart_url = l_ef2.getText();
				za_db m_db = za_db.getInstanct();
				m_db.open();
				m_db.inserttrade(m_stocktrade); 
				m_db.close();
				Dialog.inform("数据已经添加，程序将退出.\r\n 请重新运行程序！");
				System.exit(0);
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
			m_stock.getStock();
			l_ef.setText(m_stock.m_symbol);
			l_ef2.setText(m_stock.m_chart_url);
		}
	}
}