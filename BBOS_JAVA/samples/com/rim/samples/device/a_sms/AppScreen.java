/*
 * AppScreen.java
 *
 * Copyright 1998-2008 Research In Motion Ltd.
 * 
 * Note: For the sake of simplicity, this sample application may not leverage
 * resource bundles and resource strings.  However, it is STRONGLY recommended
 * that application developers make use of the localization features available
 * within the BlackBerry development platform to ensure a seamless application
 * experience across a variety of languages and geographies.  For more information
 * on localizing your application, please refer to the BlackBerry Java Development
 * Environment Development Guide associated with this release.
 */

package com.rim.samples.device.a_sms;

import net.rim.device.api.bluetooth.BluetoothSerialPort;
import net.rim.device.api.bluetooth.BluetoothSerialPortInfo;
import net.rim.device.api.ui.MenuItem;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.LabelField;
import net.rim.device.api.ui.component.BitmapField;
import net.rim.device.api.system.Bitmap;
import net.rim.device.api.ui.container.MainScreen;
final class AppScreen extends MainScreen
{
    
    private BluetoothSerialPortInfo[] _portInfo;   
    public AppScreen()
    {
        //setTitle("Media Control");
        add( new LabelField(""));
        add( new LabelField(""));        
        add(new BitmapField( Bitmap.getBitmapResource("pad.png"),FIELD_HCENTER));
        int numDevices = 0;
          
          addMenuItem(
                 new MenuItem("¶ÌÐÅ¼àÌý", 20, 20) {
                  public void run() 
                  {     
                   UiApplication.getUiApplication().pushScreen(new za_sms());
                  }}
           );               
  
    }
    
}
