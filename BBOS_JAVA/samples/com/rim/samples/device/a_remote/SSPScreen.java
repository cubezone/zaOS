/*
 * SSPScreen.java
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

package com.rim.samples.device.a_remote;

import java.io.IOException;
import net.rim.device.api.bluetooth.BluetoothSerialPort;
import net.rim.device.api.bluetooth.BluetoothSerialPortInfo;
import net.rim.device.api.bluetooth.BluetoothSerialPortListener;
import net.rim.device.api.util.Arrays;
import net.rim.device.api.util.DataBuffer;
import net.rim.device.api.system.KeypadListener;
import net.rim.device.api.ui.MenuItem;
import net.rim.device.api.ui.Color;
import net.rim.device.api.ui.Graphics;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.RichTextField;
import net.rim.device.api.ui.component.Status;
import net.rim.device.api.ui.container.MainScreen;
import net.rim.device.api.system.Display;

/**
 * 
 */
class SPPScreen extends MainScreen implements BluetoothSerialPortListener
{
    private RichTextField _rtf;
    private int _channel;
    private StringBuffer _data;
    private byte[] _receiveBuffer = new byte[1024];
    private BluetoothSerialPort _port;
    private boolean _loopback;
    private static boolean _dataSent = true;
    private String _deviceName;
    private BluetoothSerialPortInfo info;
    private DataBuffer _db;

    public SPPScreen(BluetoothSerialPortInfo in_info)
    {
        // Fill a 1k array with the a character.
        Arrays.fill(_receiveBuffer, (byte)'a');
       info = in_info;
        // Initialize the buffers.
        _data = new StringBuffer();
        _data.append("Media Control V1.5.0\n\n朱兴宇\n\ndaemon@wo.com.cn\n\n2010/07/20\n\n\n\n\n>");
        _db = new DataBuffer();

    
            if(info == null)
            {
                // Open a port to listen for incoming connections.
                _rtf = new RichTextField("Connect external device and then type something...", RichTextField.NON_FOCUSABLE);
                //_port = new BluetoothSerialPort("Hi there", BluetoothSerialPort.BAUD_115200, BluetoothSerialPort.DATA_FORMAT_PARITY_NONE | BluetoothSerialPort.DATA_FORMAT_STOP_BITS_1 | BluetoothSerialPort.DATA_FORMAT_DATA_BITS_8, BluetoothSerialPort.FLOW_CONTROL_NONE, 1024, 1024, this);
                _deviceName = "unknown";
            }
            else
            {
                // Connect to the selected device.
                _rtf = new RichTextField(_data.toString(),RichTextField.USE_ALL_HEIGHT| RichTextField.FOCUSABLE){
                protected void paint(Graphics graphics)
                {             
                    graphics.setBackgroundColor(Color.BLACK);
                    graphics.clear();
                    graphics.setColor(0x0030FF00);                     
                    super.paint(graphics);
                } 
                };
                //_port = new BluetoothSerialPort(info, BluetoothSerialPort.BAUD_115200, BluetoothSerialPort.DATA_FORMAT_PARITY_NONE | BluetoothSerialPort.DATA_FORMAT_STOP_BITS_1 | BluetoothSerialPort.DATA_FORMAT_DATA_BITS_8, BluetoothSerialPort.FLOW_CONTROL_NONE, 1024, 1024, this);              s
                _deviceName = info.getDeviceName();
                openblue() ;                              
            }
                 
        add(_rtf);        
        // Add menu items to the screen.
        addMenuItem(_closeSP);
        addMenuItem(_openSP);
        addMenuItem(_dtr);
        //addMenuItem(_dsrOn);  
        //addMenuItem(_dsrOff);
        //addMenuItem(_enableLoopback);           
         //addMenuItem(_disableLoopback); 
        //addMenuItem(_send1k);
        _rtf.setFocus();
        _rtf.setCursorPosition(_rtf.getTextLength());
                
    }

    protected boolean navigationClick(int status,int time)
    {
        _rtf.setFocus();
        _rtf.setCursorPosition(_rtf.getTextLength());
        
        // Send the key if a Bluetooth connection has been established.
        if(_port != null)
        {
             writeData((byte)'^');
            _data.append('^');
            _rtf.setText(_data.toString());        
        }    
        return true;
    }    
    
     protected boolean navigationMovement(int dx, int dy, int status,int time)
    {
        String msg ="$99";
        if ( (KeypadListener.STATUS_KEY_HELD_WHILE_ROLLING&status) > 0 )
         return super.navigationMovement(dx,dy,status,time);
        
        _rtf.setFocus();
        _rtf.setCursorPosition(_rtf.getTextLength());
        msg = "$";
        msg = msg + Integer.toString(dx+5);
        msg = msg + Integer.toString(dy+5);        
                        
        // Send the key if a Bluetooth connection has been established.
        if(_port != null)
        {
             writeData(msg.getBytes(),0,msg.length());
            _data.append(msg);
            _rtf.setText(_data.toString());        
        }    
        return true;
    }
    // Invoked when a connection is established.
    public void deviceConnected(boolean success)
    {
        if (!success)               
            Status.show("连接失败:" + _deviceName);
    }

    // Invoked when a connection is closed.
    public void deviceDisconnected()
    {
        Status.show("断开连接: " + _deviceName);
    }

    // Invoked when the drt state changes.
    public void dtrStateChange(boolean high)
    {
        //Status.show("DTR: " + high);
        if (high)        
            Status.show("已连接:" + _deviceName);  
        else
            Status.show("未连接");
    }

    // Invoked when data has been received.
    public void dataReceived(int length)
    {
        int len;
        try
        {
            // Read the data that arrived.
            if((len = _port.read(_receiveBuffer, 0, length == -1 ? _receiveBuffer.length : length)) != 0)
            {
                // If loopback is enabled write the data back.
                if(_loopback)
                {
                    writeData(_receiveBuffer, 0, len);
                }
                else
                {
                    if(len == 1 && _receiveBuffer[0] == '\r')
                    {
                        _receiveBuffer[1] = '\n';
                        ++len;
                    }
                }

                // Update the screen with the new data that arrived.
                _data.append(new String( _receiveBuffer, 0, len,"GB2312"));
                if (_data.length()>350)
                   _data.delete(0,50);
                _rtf.setText(_data.toString());
            }
        } catch(IOException ioex)
        {
            // Catch and re-throw the exception.
            throw new RuntimeException(ioex.toString());
        }
    }

    // Invoked after all data in the buffer has been sent.
    public void dataSent()
    {
        // Set the _dataSent flag to true to allow more data to be written.
        _dataSent = true;

        // Call sendData in case there is data waiting to be sent.
        sendData();
    }


    /*
     * Invoked when a key is pressed.   
     * @see net.rim.device.api.ui.Screen#keyChar(char,int,int)
     */
    public boolean keyChar(char key, int status, int time)
    {
        _rtf.setFocus();
        _rtf.setCursorPosition(_rtf.getTextLength());
        
        // Send the key if a Bluetooth connection has been established.
        if(_port != null)
        {
            if(key == '\n')
            {
                writeData((byte)'\r');
            }
            else
            {
                writeData((byte)key);
            }
            // Update the screen adding the character just pressed.
            
            _data.append(key);
            _rtf.setText(_data.toString());
            
        }
        return true;
    }

    // Add a byte to the DataBuffer.
    private void writeData(byte theData)
    {
        synchronized(_db)
        {
            _db.write(theData);

            // Call sendData to send the data.
            sendData();
        }
    }

    // Add a byte array to the DataBuffer.
    private void writeData(byte[] theData, int offset, int length)
    {
        synchronized(_db)
        {
            _db.write(theData, offset, length);

            // Call sendData to send the data.
            sendData();
        }
    }

    // Sends the data currently in the DataBuffer.
    private void sendData()
    {
        // Ensure we have data to send.
        if (_db.getArrayLength() > 0)
        {
            // Ensure the last write call has resulted in the sending of the data
            // prior to calling write again.  Calling write in sequence without waiting
            // for the data to be sent can overwrite existing requests and result in
            // data loss.
            if (_dataSent)
            {
                try
                {
                    // Set the _dataSent flag to false so we don't send any more
                    // data until it has been verified that this data was sent.
                    _dataSent = false;

                    synchronized(_db)
                    {
                        // Write out the data in the DataBuffer and reset the DataBuffer.
                        _port.write(_db.getArray(), 0, _db.getArrayLength());
                        _db.reset();
                    }
                }
                catch (IOException ioex)
                {
                    // Reset _dataSent to true so we can attempt another data write.
                    _dataSent = true;
                    System.out.println("Failed to write data. Exception: " + ioex.toString());
                }
            }
            else
            {
                System.out.println("Can't send data right now, data will be sent after dataSent notify call.");
            }
        }
    }
    
    private void openblue()    
    {
       if (_port == null)
      {
        try
        {
            _port = new BluetoothSerialPort(info, BluetoothSerialPort.BAUD_115200, BluetoothSerialPort.DATA_FORMAT_PARITY_NONE | BluetoothSerialPort.DATA_FORMAT_STOP_BITS_1 | BluetoothSerialPort.DATA_FORMAT_DATA_BITS_8, BluetoothSerialPort.FLOW_CONTROL_NONE, 1024, 1024, this);
        }
        catch(IOException ex)
        {
            Status.show("Error: " + ex.getMessage());
        }   
      }
    }
    
    ////////////////////////////////////////////////////////////
    //                  Menu Items                            //
    ////////////////////////////////////////////////////////////
        
    private MenuItem _closeSP = new MenuItem("退出", 20, 20)
    {
        public void run() 
        {
            if (_port != null)
            {
                _port.close();                
            }           
           UiApplication.getUiApplication().pushScreen(new AppScreen());
           close();
           // System.exit(0);
        }
    };
      
    private MenuItem _openSP = new MenuItem("重新连接", 20, 20)
    {
        public void run() 
        {
            if (_port == null)
            {   
                openblue();                   
            }            
        }
    };
    
    private MenuItem _dtr = new MenuItem("连接状态", 30, 30)
    {
        public void run() 
        {
            try
            {
                if (_port.getDtr())
                    Status.show("已连接:" + _deviceName);
                else
                    Status.show("未连接.");
                //Status.show("DTR: " + _port.getDtr());
            }
            catch(IOException ioex)
            {
                Status.show("Error: " + ioex.toString());
            }
        }
    };
 /*   
    private MenuItem _dsrOn = new MenuItem("DSR on", 40, 40)
    {
        public void run() 
        {
            Status.show( "DSR on" );
            try
            {
                _port.setDsr(true);
            }
            catch(IOException ioex)
            {
                Status.show("Error: " + ioex.toString());
            }                
        }
    };
    
    private MenuItem _dsrOff = new MenuItem("DSR off", 50, 50)
    {
        public void run() 
        {
            Status.show("DSR off");
            try
            {
                _port.setDsr(false);
            }
            catch(IOException ioex)
            {
                Status.show("Error: " + ioex.toString());
            }
        }
    };
    
    private MenuItem _enableLoopback = new MenuItem("Enable loopback", 60, 60)
    {
        public void run() 
        {
            _loopback = true;
        }
    };
    
    private MenuItem _disableLoopback = new MenuItem("Disable loopback", 70, 70)
    {
        public void run() 
        {
            _loopback = false;
        }
    };
    
    private MenuItem _send1k = new MenuItem("Send 1k", 80, 80)
    {
        public void run() 
        {
            writeData(_receiveBuffer, 0, _receiveBuffer.length);
        }
    };
    */
}
