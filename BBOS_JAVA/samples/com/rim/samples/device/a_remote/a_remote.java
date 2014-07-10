/*
 *  BluetoothDemo.java
 *  
 *  AUTO_COPYRIGHT_SUB_TAG
 */

package com.rim.samples.device.a_remote;

import net.rim.device.api.ui.UiApplication;

public class a_remote extends UiApplication
{
    public static void main(String[] args)
    {
        a_remote app = new a_remote();
        app.enterEventDispatcher();
    }

    private a_remote()
    {
        pushScreen(new AppScreen());
    }
}
