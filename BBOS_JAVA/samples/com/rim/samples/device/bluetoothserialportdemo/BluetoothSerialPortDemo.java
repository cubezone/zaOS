/**
 * BluetoothSerialPortDemo.java
 *
 * Copyright © 1998-2008 Research In Motion Ltd.
 * 
 * Note: For the sake of simplicity, this sample application may not leverage
 * resource bundles and resource strings.  However, it is STRONGLY recommended
 * that application developers make use of the localization features available
 * within the BlackBerry development platform to ensure a seamless application
 * experience across a variety of languages and geographies.  For more information
 * on localizing your application, please refer to the BlackBerry Java Development
 * Environment Development Guide associated with this release.
 */

package com.rim.samples.device.bluetoothserialportdemo;

import java.io.*;import javax.microedition.io.*;
import net.rim.device.api.bluetooth.*;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;
import net.rim.device.api.system.*;
import net.rim.device.api.system.UnsupportedOperationException;  // To disambiguate from java.lang.UnsupportedOperationException.
import net.rim.device.api.util.*;

/**
 * The client side of a simple serial port demonstration app. This application will
 * listen for text on the serial port and render the data when it arrives.
 */
public class BluetoothSerialPortDemo extends UiApplication
{
    // Statics ------------------------------------------------------------------     
    private static final int INSERT = 1;
    private static final int REMOVE = 2;
    private static final int CHANGE = 3;
    private static final int JUST_OPEN = 4;
    private static final int CONTENTS = 5;
    private static final int NO_CONTENTS = 6;

    // Members -------------------------------------------------------------------  
    private EditField _infoField;
    private StreamConnection _bluetoothConnection;
    private DataInputStream _din;
    private DataOutputStream _dout;
    
    
    /**
    * This class represents the main screen for the BluetoothSerialPortDemo 
    * application.
    */ 
    private final class BluetoothDemoScreen extends MainScreen
    {
        
        /**
         * @see net.rim.device.api.ui.container.MainScreen#makeMenu(Menu,int)
         */
        protected void makeMenu(Menu menu, int instance)
        {
            if (_infoField.getTextLength() > 0) 
            {
                menu.add(new MenuItem("Copy Contents", 100000, 10) 
                {
                    public void run() 
                    {
                        Clipboard.getClipboard().put(_infoField.getText());
                    }
                });
            }
            
            super.makeMenu(menu, instance); 
        }
        
                
        /**
         * Prevent the save dialog from being displayed.
         * 
         * @see net.rim.device.api.ui.container.MainScreen#onSavePrompt()
         */
        public boolean onSavePrompt()
        {
            return true;
        }     
        

        /**
         * @see net.rim.device.api.ui.Screen#close()
         */
        public void close() 
        {
            onExit();    
            super.close();
        }        
        
    }
    
    /**
    * Entry point for application.
    */     
    public static void main(String[] args)
    {
        BluetoothSerialPortDemo theApp = new BluetoothSerialPortDemo();
        theApp.enterEventDispatcher();
    }
    

    // Constructor ---------------------------------------------------------------
    public BluetoothSerialPortDemo()
    {
        BluetoothDemoScreen mainScreen = new BluetoothDemoScreen();
        mainScreen.setTitle(new LabelField("Bluetooth Serial Port Demo" , LabelField.USE_ALL_WIDTH));

        _infoField = new EditField(Field.READONLY);
        mainScreen.add(_infoField);

        pushScreen(mainScreen);
        
        invokeLater(new Runnable() 
        {
            public void run() 
            {
                openPort();
            }
        });
    }

    protected void onExit()
    {
        closePort();
    }
    
    // Close the serial port.
    private void closePort() 
    {
       
        if (_bluetoothConnection != null) 
        {
            try 
            {
                _bluetoothConnection.close();
            } 
            catch(IOException ioe) 
            {
            }
        }
        
        if (_din != null) 
        {
            try 
            {
                _din.close();
            } 
            catch(IOException ioe) 
            {
            }
        }
        
        if (_dout != null) 
        {
            try 
            {
                _dout.close();
            } 
            catch(IOException ioe) 
            {
            }
        }
        
        _bluetoothConnection = null;
        _din = null;
        _dout = null;
    }
    
    // Open the serial port.
    private void openPort() 
    {
        
        if (_bluetoothConnection != null)
         {
            closePort();
        }
        
        new InputThread().start();
    }
    
    private class InputThread extends Thread 
    {
  
        public void run() 
        {
            try 
            {
                BluetoothSerialPortInfo[] info = BluetoothSerialPort.getSerialPortInfo();
                
                if( info == null || info.length == 0 )
                 {
                    invokeAndWait( new Runnable() 
                    {
                        public void run() 
                        {
                            Dialog.alert( "No bluetooth serial ports available for connection." );
                            onExit();
                            System.exit(1);
                        }
                    });
                }
    
                _bluetoothConnection = (StreamConnection)Connector.open( info[0].toString(), Connector.READ_WRITE );
                
                _din = _bluetoothConnection.openDataInputStream();
                _dout = _bluetoothConnection.openDataOutputStream();
                
            } 
            catch(IOException e) 
            {
                invokeAndWait( new Runnable() 
                {
                    public void run() 
                    {
                        Dialog.alert("Unable to open serial port");
                        onExit();
                        System.exit(1);
                    }
                });
            } 
            catch( UnsupportedOperationException e ) 
            {
                invokeAndWait( new Runnable() 
                {
                    public void run() 
                    {
                        Dialog.alert("This handheld or simulator does not support bluetooth.");
                        onExit();
                        System.exit(1);
                    }
                });
            }

            try 
            {
                int type, offset, count;
                String value;
                _dout.writeInt(JUST_OPEN);
                _dout.flush();
                
                for (;;) 
                {
                    type = _din.readInt();
                    
                    if (type == INSERT) 
                    {
                        offset = _din.readInt();
                        value = _din.readUTF();
                        insert(value, offset);
                    }
                    else if (type == REMOVE) 
                    {
                        offset = _din.readInt();
                        count = _din.readInt();
                        remove(offset, count);
                    } 
                    else if (type == JUST_OPEN) 
                    {
                        // Send contents to desktop.
                        value = _infoField.getText();
                        
                        if (value == null || value.length() == 0) 
                        {
                            _dout.writeInt(NO_CONTENTS);
                            _dout.flush();
                        } 
                        else 
                        {
                            _dout.writeInt(CONTENTS);
                            _dout.writeUTF(_infoField.getText());
                            _dout.flush();
                        }
                    } 
                    else if (type == CONTENTS) 
                    {
                        String contents = _din.readUTF();
                        synchronized(Application.getEventLock()) 
                        {
                            _infoField.setText(contents);
                        }
                        
                    } 
                    else if (type == NO_CONTENTS) 
                    {
                    } 
                    else 
                    {
                        throw new RuntimeException();
                    }
                }
            } 
            catch(IOException ioe) 
            {
                invokeLater(new Runnable() 
                {
                    public void run() 
                    {
                        Dialog.alert("Problems reading from or writing to serial port.");
                        onExit();
                        System.exit(1);
                    }
                });
            }
        }
        
    }
    
    private void insert(final String msg, final int offset) 
    {
        invokeLater(new Runnable() 
        {
            public void run()
            {
                _infoField.setCursorPosition(offset);
                _infoField.insert(msg);
            }
        });
    }
    
    private void remove(final int offset, final int count) 
    {
        invokeLater(new Runnable()
         {
            public void run() 
            {
                _infoField.setCursorPosition(offset+count);
                _infoField.backspace(count);
            }
        });
    }
}
