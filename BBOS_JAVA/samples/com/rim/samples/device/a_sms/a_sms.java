/*
 *  BluetoothDemo.java
 *  
 *  AUTO_COPYRIGHT_SUB_TAG
 */

package com.rim.samples.device.a_sms;

import net.rim.device.api.ui.UiApplication;

public class a_sms extends UiApplication
{
    public static void main(String[] args)
    {
        a_sms app = new a_sms();
        app.enterEventDispatcher();
    }

    private a_sms()
    {
        pushScreen(new AppScreen());
    }
}
