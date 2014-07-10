/*
 *  BluetoothDemo.java
 *  
 *  AUTO_COPYRIGHT_SUB_TAG
 */

package com.zhuxy.za_location;

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
