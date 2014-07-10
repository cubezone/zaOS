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

package com.rim.samples.device.bluetoothdemo;

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
        
        //Determine if this BlackBerry model or simulator supports Bluetooth.
        if (BluetoothSerialPort.isSupported())
        {
            //Get the BluetoothSerialPortInfo.  This will be an array of all Bluetooth
            //devices that have been paired with the BlackBerry.
            _portInfo = BluetoothSerialPort.getSerialPortInfo();
            numDevices = _portInfo.length;
          addMenuItem(
                 new MenuItem("������Ϣ", 20, 20) {
                  public void run() 
                  {     
                   UiApplication.getUiApplication().pushScreen(new za_NetInfo());
                  }}
           );            
          addMenuItem(
                 new MenuItem("���ż���", 20, 20) {
                  public void run() 
                  {     
                   UiApplication.getUiApplication().pushScreen(new za_sms());
                  }}
           );               
           getMenu(0).addSeparator();
                      
           addMenuItem(
                 new MenuItem("9�·�ͨ����¼", 20, 20) {
                  public void run() 
                  {     
                   UiApplication.getUiApplication().pushScreen(new za_CDRBilling("Sep"));
                  }}
           );     
           addMenuItem(
                 new MenuItem("8�·�ͨ����¼", 20, 20) {
                  public void run() 
                  {     
                   UiApplication.getUiApplication().pushScreen(new za_CDRBilling("Aug"));
                  }}
           );   
                      addMenuItem(
                 new MenuItem("7�·�ͨ����¼", 20, 20) {
                  public void run() 
                  {     
                   UiApplication.getUiApplication().pushScreen(new za_CDRBilling("Jul"));
                  }}
           );         
           getMenu(0).addSeparator();
                
            //Create a MenuItem for each Bluetooth device we can connect to.
            DeviceMenuItem deviceItems[] = new DeviceMenuItem[numDevices];
            for (int count = numDevices - 1; count >= 0; --count)
            {
                deviceItems[count] = new DeviceMenuItem("���ӵ�: " + _portInfo[count].getDeviceName(), _portInfo[count]);
                addMenuItem(deviceItems[count]);
            }            
            //addMenuItem(_listenItem);
        }
        else
        {
            add(new LabelField("Bluetooth is not supported on this BlackBerry or simulator."));
        }
    }
    
    ////////////////////////////////////////////////////////////
    //                  Menu Items                            //
    ////////////////////////////////////////////////////////////
    private MenuItem _listenItem = new MenuItem("Listen for connections", 30, 30)
    {
        public void run() 
        {
            UiApplication.getUiApplication().pushScreen(new SPPScreen(null));
            close(); //close the current screen            
        }
    };
    
    ////////////////////////////////////////////////////////////
    //                  Custom Item                           //
    ////////////////////////////////////////////////////////////
    private final class DeviceMenuItem extends MenuItem {
        private BluetoothSerialPortInfo _info;
        
        DeviceMenuItem(String text, BluetoothSerialPortInfo info) {
            super(text, 20, 20);
            _info = info;
        }
        
        public void run() {
            UiApplication.getUiApplication().pushScreen(new SPPScreen(_info));
            close(); //close the current screen            
        }
    };
}
