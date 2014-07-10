/*
 * UsbDemo.java
 *
 * Copyright ? 1998-2008 Research In Motion Ltd.
 * 
 * Note: For the sake of simplicity, this sample application may not leverage
 * resource bundles and resource strings.  However, it is STRONGLY recommended
 * that application developers make use of the localization features available
 * within the BlackBerry development platform to ensure a seamless application
 * experience across a variety of languages and geographies.  For more information
 * on localizing your application, please refer to the BlackBerry Java Development
 * Environment Development Guide associated with this release.
 */

package com.rim.samples.device.usbdemo;

import java.io.*;
import java.util.*;
import javax.microedition.io.*;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;
import net.rim.device.api.system.*;
import net.rim.device.api.util.*;

/**
 * A simple example of opening the usb port for communication with a desktop USB 
 * client (one that uses the COM interfaces exposed by BBDevMgr.exe).
 */
public final class UsbDemo extends UiApplication 
{
    
    // Constants ----------------------------------------------------------------
    private static final String CHANNEL = "JDE_USBClient";
    
    // Members ------------------------------------------------------------------
    private RichTextField _output;
    private UsbThread _usbThread;
    
    private MenuItem _connectGCF = new MenuItem("Connect (GCF)", 10, 10) 
    {
        public void run()
        {
            // Cleanup the old thread if present.
            onExit(); 
            
            _usbThread = new GCFUsbThread();
            connect();
        }
    };
    
    private MenuItem _connectLowLevel = new MenuItem("Connect (low level)", 11, 11) 
    {
        public void run()
        {
            // Cleanup old thread if present.
            onExit(); 
            
            _usbThread = new LowLevelUsbThread();
            connect();
        }
    };
    
    
    private class USBScreen extends MainScreen
    {
        
        public USBScreen()
        {
            addMenuItem(_connectGCF);
            addMenuItem(_connectLowLevel);
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
        * 
        * @see net.rim.device.api.ui.Screen#close() 
        */
        public void close()
        {
            onExit();
            
            super.close();
        }
    }
    
    // Statics ------------------------------------------------------------------

    static public final void main(String[] args)
    {
        new UsbDemo().enterEventDispatcher();
    }
    
    // Inner classes ------------------------------------------------------------
    private abstract class UsbThread extends Thread 
    {
        public void run()
        {
            try 
            {
                init();
                
                String s = read("Hello from PC");
                message("received: " + s);
                
                // Write back a hello string.
                s = "Hello from Device";
                write(s);
                                    
                message("wrote: " + s);
                
                // Wait for goodbye.
                s = read("Goodbye from PC");
                message("received: " + s);
                
                s = "Goodbye from Device";
                write(s);
                message("wrote: " + s);
                
                close();
            
            } 
            catch (IOException e) 
            {
                message(e.toString());
            }
        }
        
        abstract protected void init() throws IOException;
        
        abstract protected void write(String s) throws IOException;
        
        abstract protected String read(String match) throws IOException;
        
        abstract public void close();
    }
    
    /**
     * The GCF prepends the length of the data written to the outputstream on each
     * transaction. Your server code should expect two bytes length data prior to 
     * the actual data when the client is using the GCF.
     */
    private final class GCFUsbThread extends UsbThread
    {
        private DataInputStream _dis;
        private DataOutputStream _dos;
        private StreamConnection _sc;
        
        protected void init() throws IOException
        {
            // Using the connector interface.
            _sc = (StreamConnection)Connector.open("comm:USB;channel=" + CHANNEL);
            
            _dis = _sc.openDataInputStream();
            _dos = _sc.openDataOutputStream();
        }
        
        protected void write(String s) throws IOException
        {
            _dos.writeUTF(s);
            _dos.flush();
        }
        
        protected String read(String match) throws IOException
        {
            int len = match.length();
            byte[] data = new byte[len];
            _dis.read(data, 0, len);
            String s = new String(data);
            
            return s.equals(match) ? s : null;
        }
        
        public void close()
        {
            try 
            {
                /*parent.*/message("closing connections...");
                
                if ( _dis != null ) 
                {
                    _dis.close();
                }
                
                if ( _dos != null ) 
                {
                    _dos.close();
                }
                
                if ( _sc != null ) 
                {
                    _sc.close();
                }
                
                /*parent.*/message("connections closed");
            } 
            catch (IOException e) 
            {
                /*parent.*/message(e.toString());
            }
        }
    }
    
    private final class LowLevelUsbThread extends UsbThread implements USBPortListener
    {
        private boolean _dataAvailable;
        private Vector _readQueue;
        private int _channel;
        private USBPort _port;
        
        protected void init() throws IOException
        {
            _readQueue = new Vector();

            // Register the app for callbacks.
            UsbDemo.this.addIOPortListener(this);
            
            /*parent.*/message("using low level usb interface");
            
            // Register the channel.
            _channel = USBPort.registerChannel(CHANNEL, 1024, 1024);
            /*parent.*/message("Registering channel: " + CHANNEL);
            
            synchronized(this)
            {
                try 
                {
                    // Wait for a channel.
                    if ( _port == null )
                    {
                        this.wait();
                    }                        
                } 
                catch (InterruptedException e) 
                {
                }
            }
        }
        
        protected void write(String s) throws IOException
        {
             _port.write(s.getBytes());
        }
        
        protected String read(String match) throws IOException
        {
            try 
            {
                synchronized(this)
                {
                    if ( !_dataAvailable )
                    {
                        this.wait();
                    }
                    
                    _dataAvailable = false;
                }
            } 
            catch (InterruptedException e) 
            {
                // Not thrown by cldc1.0
            }
            
            // Loop through the queue of data and extract each item.
            try 
            {
                for(;;)
                {
                    byte[] data = null;
                    
                    synchronized(this)
                    {                        
                        data = (byte[])_readQueue.firstElement();
                        
                        // Ensure we always remove the correct object.
                        _readQueue.removeElement(data); 
                    }
                    
                    String s = new String(data);
                    
                    if ( s.equals(match) )
                    {
                        return s;
                    }                                                    
                }
            } 
            catch (NoSuchElementException e) 
            {
                // The read queue is empty! we didn't find our match.
                /*parent.*/message("did not recieve match for " + match);
            }
            
            return null;               
        }
        
        public void close()
        {
            try 
            {
                /*parent.*/message("closing connections...");
                
                if ( _port != null) 
                {
                    _port.close();
                }
                
                // Deregister the channel.
                USBPort.deregisterChannel(_channel); 
                
                /*parent.*/message("connections closed");
                
            } 
            catch (IOException e) 
            {
                /*parent.*/message(e.toString());
            }
        }
        
        // USBPortListener methods --------------------------------------------------
        public int getChannel() 
        {
            return _channel;
        }
    
        public void connectionRequested() 
        {
            message( "lowlevelusb: Connection requested!" );
            
            try 
            {
                _port = new USBPort(_channel);
                
                synchronized(this) 
                {
                    this.notify();
                }
            } 
            catch (IOException e) 
            {
                message(e.toString());
            }
        }
    
        public void dataNotSent() 
        {
            message( "lowlevelusb: Data not sent" );
        }
        
        public void connected()
        {
            message( "lowlevelusb: connected" );
        }
        
        public void disconnected()
        {
            message( "lowlevelusb: disconnected" );
        }
        
    
        public void receiveError(int error)
        {
            message( "lowlevelusb: Got rxError: " + error );
        }
        
        
        public void dataReceived( int length )
        {
            int len;
            DataBuffer db = new DataBuffer();
            
            try 
            {
                byte[] receiveBuffer = new byte[256];
                
                if (0 != (len = _port.read( receiveBuffer, 0, length == -1 ? receiveBuffer.length : length )) ) 
                {
                    db.write(receiveBuffer, 0, len);
                    String data = new String( receiveBuffer, 0, len );
                    message("lowlevelusb: " + data);
                }
                
                synchronized(this)
                {
                    _readQueue.addElement(db.toArray());
                    _dataAvailable = true;
                    this.notify();
                }
            } 
            catch( IOException ex ) 
            {
                throw new RuntimeException( ex.getMessage() );
            }
        }
        
        public void dataSent()
        {
        }
        
        public void patternReceived( byte[] pattern )
        {
            message( "lowlevelusb: Got pattern " + new String(pattern)); //+ pattern[0] + " " + pattern[1] + " " + pattern[2] + " " + pattern[3] );
        }
    }
    
    
    // Constructors -------------------------------------------------------------
    public UsbDemo() 
    {
        
        USBScreen screen = new USBScreen();
        screen.setTitle("Usb Demo");
        
        _output = new RichTextField("<output>");
        
        screen.add(_output);
        
        pushScreen(screen);
    }
    
    private void connect()
    {
        _usbThread.start();
    }
    
    private void message(final String msg)
    {
        invokeLater(new Runnable() 
        {
            public void run() 
            {
                _output.setText(_output.getText() + "\n" + msg);
            }
        });
    }        
    
    public void onExit()
    {
        if ( _usbThread != null ) _usbThread.close();
    }
}
