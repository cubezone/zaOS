package com.zhuxy.za_bill;

import net.rim.device.api.system.Display;
import net.rim.device.api.ui.Ui;
import net.rim.device.api.ui.UiApplication;


/*
 * BlackBerry applications that provide a user interface must extend 
 * UiApplication.
 */

public class za_app extends UiApplication
{ 
    public static void main(String[] args)
    {
    	za_app theApp = new za_app();       
        theApp.enterEventDispatcher();
    }
    public za_app()
    {
    	int directions = Display.DIRECTION_PORTRAIT;
    	Ui.getUiEngineInstance().setAcceptableDirections(directions); 
        pushScreen(new za_main());
    }    
}

