package com.zhuxy.za_weather;


import net.rim.device.api.system.Bitmap;
import net.rim.device.api.ui.Font;
import net.rim.device.api.ui.MenuItem;
import net.rim.device.api.ui.Ui;
import net.rim.device.api.ui.component.BitmapField;
import net.rim.device.api.ui.component.Menu;
import net.rim.device.api.ui.component.RichTextField;
import net.rim.device.api.ui.component.SeparatorField;
import net.rim.device.api.ui.container.HorizontalFieldManager;
import net.rim.device.api.ui.container.MainScreen;

public class za_weatherscreen  extends MainScreen{		
		
		za_weather m_weather = null;
	   public za_weatherscreen(za_weather l_wt)
	   {	   
		    m_weather = l_wt;
		    init();						
	   }
	   public void init()
	  {
		   RichTextField l_rich = null;
	 		    
		    l_rich = new RichTextField("");
			l_rich.setFont(Font.getDefault().derive(Font.PLAIN, 9, Ui.UNITS_pt));
												
			add(l_rich);
			l_rich.setText(m_weather.info());
			add(new SeparatorField());
			
			HorizontalFieldManager l_hfm = new HorizontalFieldManager();
			l_rich = new RichTextField();
			l_rich.setFont(Font.getDefault().derive(Font.PLAIN, 9, Ui.UNITS_pt));
			l_rich.setText(m_weather.infocur());
			
			BitmapField l_bmp = new BitmapField( Bitmap.getBitmapResource(m_weather.icon()),FIELD_HCENTER);
			l_bmp.setSpace(10,30);
			l_hfm.add(l_bmp);
			 
			l_hfm.add(l_rich);
			add(l_hfm);
			for (int n = 0 ; n < m_weather.m_forecast.size() ; n ++)
			{
				za_forecast_conditions l_fc = (za_forecast_conditions)m_weather.m_forecast.elementAt(n);
				add(new SeparatorField());
				
				l_hfm = new HorizontalFieldManager();
				l_rich = new RichTextField();
				l_rich.setFont(Font.getDefault().derive(Font.PLAIN, 9, Ui.UNITS_pt));
				l_rich.setText(l_fc.info());
				l_bmp = new BitmapField( Bitmap.getBitmapResource(l_fc.icon()),FIELD_HCENTER);
				l_bmp.setSpace(10,6);
				l_hfm.add(l_bmp);
				l_hfm.add(l_rich);				
				add(l_hfm);
			}
	   }
	   
	   protected void makeMenu(Menu menu, int instance) {		
		menu.add(new MenuItem("刷新", 20, 20) {
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
					try {
						wait(200);		
						za_weatherscreen.this.deleteAll();
						za_weatherscreen.this.invalidate();
						m_weather.getweather();
		            	init();	
					} catch (InterruptedException e) {
						za_db.errorDialog("更新数据出现异常");							
					}
				}
			}		
		}

}


