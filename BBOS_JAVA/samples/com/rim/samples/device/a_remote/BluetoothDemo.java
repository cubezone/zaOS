/*
 *  BluetoothDemo.java
 *  
 *  AUTO_COPYRIGHT_SUB_TAG
 */

package com.rim.samples.device.bluetoothdemo;

import net.rim.device.api.ui.UiApplication;

public class BluetoothDemo extends UiApplication
{
    public static void main(String[] args)
    {
        BluetoothDemo app = new BluetoothDemo();
        app.enterEventDispatcher();
    }

    private BluetoothDemo()
    {
        pushScreen(new AppScreen());
    }
}
