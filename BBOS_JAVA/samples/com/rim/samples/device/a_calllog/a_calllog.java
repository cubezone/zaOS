/*
 *  BluetoothDemo.java
 *  
 *  AUTO_COPYRIGHT_SUB_TAG
 */

package com.rim.samples.device.a_calllog;

import net.rim.device.api.ui.UiApplication;

public class a_calllog extends UiApplication
{
    public static void main(String[] args)
    {
        a_calllog app = new a_calllog();
        app.enterEventDispatcher();
    }
    private a_calllog()
    {
        pushScreen(new AppScreen());
    }
}
