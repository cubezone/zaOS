package com.zhuxy.a_sms;

import java.util.Calendar;

import net.rim.device.api.i18n.SimpleDateFormat;
import net.rim.device.api.ui.UiApplication;

public class Za_main extends UiApplication
{
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");	
	Za_sms_bak m_sms = new Za_sms_bak(sdf.format(Calendar.getInstance().getTime()));
    public static void main(String[] args)
    {
    	Za_main app = new Za_main();
        app.enterEventDispatcher();
    }

    private Za_main()
    {    	
    	int directions = net.rim.device.api.system.Display.DIRECTION_PORTRAIT;
    	net.rim.device.api.ui.Ui.getUiEngineInstance().setAcceptableDirections(directions);                	       	
        pushScreen(m_sms);
    }
    public void activate() 
    {
        super.activate();
        
        if ( m_sms != null ) 
        {
        	m_sms.initlist(Za_sms_bak.m_month);
        }
    }
}