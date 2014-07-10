package com.zhuxy.za_book;

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
        pushScreen(new za_main());
    }
}
