package com.zhuxy.za_phone;

import java.util.Calendar;

import net.rim.device.api.i18n.SimpleDateFormat;
import net.rim.device.api.system.Display;
import net.rim.device.api.ui.Ui;
import net.rim.device.api.ui.UiApplication;

public class za_app extends UiApplication
{
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM");
	za_main m_bill = new za_main(sdf.format(Calendar.getInstance().getTime()));
    public static void main(String[] args)
    {
    	za_app app = new za_app();
        app.enterEventDispatcher();        
    } 
    
    private za_app() 
    {	
    	int directions = Display.DIRECTION_PORTRAIT;
    	Ui.getUiEngineInstance().setAcceptableDirections(directions);                	       	    	
    	pushScreen(m_bill);
    }
    
   public void activate() 
    {
        super.activate();
        
        if ( m_bill != null ) 
        {
 //       	m_bill.initlist(m_bill.m_month);
        }
    }
    
   
}
