/*
 *  BluetoothDemo.java
 *  
 *  AUTO_COPYRIGHT_SUB_TAG
 */

package com.rim.samples.device.a_lac;

import net.rim.device.api.ui.UiApplication;

public class a_lac extends UiApplication
{
    public static void main(String[] args)
    {
        a_lac app = new a_lac();
        app.enterEventDispatcher();
    }

    private a_lac()
    {
        pushScreen(new AppScreen());
    }
}
