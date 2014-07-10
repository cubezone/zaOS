package com.zhuxy.za_stock;


import net.rim.device.api.ui.UiApplication;


public class za_app extends UiApplication
{
    public static void main(String[] args) 
    {
    	za_app app = new za_app();
        app.enterEventDispatcher();
    }
    private za_app() 
    {
    	int directions = net.rim.device.api.system.Display.DIRECTION_PORTRAIT;
    	net.rim.device.api.ui.Ui.getUiEngineInstance().setAcceptableDirections(directions); 
        pushScreen(new za_main());
    }
}
