/**
 * A simple SMS send and receive demo.
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

package com.rim.samples.device.smsdemo;

import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;
import net.rim.device.api.io.*;
import net.rim.device.api.system.*;

import javax.microedition.io.*;
import java.util.*;
import java.io.*;
import javax.wireless.messaging.*;

/**
 * <p>A simple demo of SMS send and receive. This program requires an associated
 * server component,  you can find this component at com.rim.samples.server.smsdemo
 * <p>This application makes use of SIGNED APIs and therefore requires signing to 
 * function on the device.
 */
public class SmsDemo extends UiApplication  
{
    
    // Constants ----------------------------------------------------------------
    private static final int MAX_PHONE_NUMBER_LENGTH = 32;


    // Members ------------------------------------------------------------------
    private EditField _sendText;
    private EditField _address; // A phone number for outbound SMS messages.
    private EditField _status;
    private ListeningThread _listener;
    private SendThread _sender;
    private StringBuffer _statusMsgs = new StringBuffer(); // Cached for improved performance.
    private MessageConnection _mc;
    private boolean _stop = false;

    private MenuItem _sendMenuItem = new MenuItem("Send", 100, 10) 
    {
        public void run()
        {
            String text = _sendText.getText();
            String addr = _address.getText();
            
            if ( text.length() > 0 && addr.length() > 0)
            {
                send(addr, text);
            }
        }
    };


    // Statics ------------------------------------------------------------------
    private static String _openString = "sms://:3590"; // See Connector implementation notes.

    public static void main(String[] args)
    {
        
        // Create a new instance of the application and start 
        // the application on the event thread.
        SmsDemo sms  = new SmsDemo();
        sms.enterEventDispatcher();
    }


    // Inner Classes ------------------------------------------------------------
    private class ListeningThread extends Thread
    {
        public synchronized void stop()
        {
            _stop = true;
            
            try 
            {
                if( _mc != null )
                {
                    // Close the connection so the thread will return.
                    _mc.close(); 
                }
            } 
            catch (IOException e) 
            {
                System.err.println(e.toString());
            }
        }

        public void run()
        {
            try 
            {
                _mc = (MessageConnection)Connector.open(_openString); // Closed by the stop() method.
                
                for(;;)
                {
                    if ( _stop )
                    {
                        return;
                    }
                    
                    Message m = _mc.receive();

                    receivedSmsMessage(m);
                }
            } 
            catch (IOException e)
            {
                // Likely the stream was closed.
                System.err.println(e.toString());
            }
        }
    }

    /**
     * A simple abstraction of an sms message, used by the SendThread class.
     */
    private static final class SmsMessage
    {
        private String _address;
        private String _msg;

        public SmsMessage(String address, String msg)
        {
            _address = address;
            _msg = msg;
        }
        
        public Message toMessage(MessageConnection mc)
        {
            TextMessage m = (TextMessage) mc.newMessage(MessageConnection.TEXT_MESSAGE , "//" + _address + ":3590");
            m.setPayloadText(_msg);
            
            return m;
        }
    }

    /**
     * A thread to manage outbound transactions.
     */
    private class SendThread extends Thread
    {
        // Members --------------------------------------------------------------
        private static final int TIMEOUT = 500; // ms

        
        // Create a vector of SmsMessage objects with an initial capacity of 5
        // (unlikely that, in this implementation, more than 5 msgs will be 
        // queued at any one time).
        private Vector _msgs = new Vector(5); 

        private volatile boolean _start = false;

        // Methods --------------------------------------------------------------
        // Requests are queued.
        public synchronized void send(String address, String msg)
        {
            _start = true;
            _msgs.addElement(new SmsMessage(address, msg));
        }

        // Shutdown the thread.
        public synchronized void stop()
        {
            _stop = true;
            
            try 
            {
                if ( _mc != null )
                {
                    _mc.close();
                }
            } 
            catch (IOException e ) 
            {
                System.err.println(e);
                updateStatus(e.toString());
            }
        }

        public void run()
        {

            for(;;)
            {
                // Thread control.
                while( !_start && !_stop)
                {
                    // Sleep for a bit so we don't spin.
                    try 
                    {
                        sleep(TIMEOUT);
                    } 
                    catch (InterruptedException e) 
                    {
                        System.err.println(e.toString());
                    }
                }
                
                // Exit condition.
                if ( _stop )
                {
                    return;
                }

                while(true)
                {
                    try 
                    {
                        SmsMessage sms = null;
                        
                        synchronized (this)
                        {
                            if ( !_msgs.isEmpty() )
                            {
                                sms = (SmsMessage)_msgs.firstElement();
                                
                                // Remove the element so we don't send it again.
                                _msgs.removeElement(sms); 
                            }
                            else
                            {
                                _start = false;
                                break;
                            }
                        }
                        
                        _mc.send(sms.toMessage(_mc));

                    } 
                    catch (IOException e) 
                    {
                        System.err.println(e);
                        updateStatus(e.toString());
                    }
                }
            }
        }
    }
    
    private class SmsDemoScreen extends MainScreen
    {
        
        public SmsDemoScreen()
        {
            setTitle(new LabelField("SMS Demo", LabelField.USE_ALL_WIDTH));
            
            _address = new EditField("Destination:", "", MAX_PHONE_NUMBER_LENGTH, EditField.FILTER_PHONE);
            add(_address);
            _sendText = new EditField("Message:", "");
            add(_sendText);
            add(new SeparatorField());
    
            _status = new EditField();
            add(_status);
            
            addMenuItem(_sendMenuItem);
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
        * Close application
        * 
        * @see net.rim.device.api.ui.Screen#close() 
        */
        public void close()
        {
            _listener.stop();
            _sender.stop();
            
            super.close();
        }
    }

    // Constructor
    public SmsDemo()
    {        
        _listener = new ListeningThread();
        _listener.start();

        _sender = new SendThread();
        _sender.start();
        
        SmsDemoScreen screen = new SmsDemoScreen();
        pushScreen(screen);
    }

    /**
     * Update the GUI with the data just received.
     */
    private void updateStatus(final String msg)
    {
        invokeLater(new Runnable() 
        {
            public void run()
            {
                
                // Clear the string buffer.
                _statusMsgs.delete(0, _statusMsgs.length()); 
                
                _statusMsgs.append(_status.getText());
                _statusMsgs.append('\n');
                _statusMsgs.append(msg);
                _status.setText(_statusMsgs.toString());
            }
        });

    }

    /**
     * Some simple formatting for a received sms message.
     */
    private void receivedSmsMessage(Message m)
    {
        String address = m.getAddress();
        String msg = null;
        
        if ( m instanceof TextMessage )
        {
            TextMessage tm = (TextMessage) m;
            msg = tm.getPayloadText();
        }
        
        StringBuffer sb = new StringBuffer();
        sb.append("Received:");
        sb.append('\n');
        sb.append("Destination:");
        sb.append(address);
        sb.append('\n');
        sb.append("Data:");
        sb.append(msg);
        sb.append('\n');

        updateStatus(sb.toString());
    }

    private void send(String addr, String data)
    {
        _sender.send(addr, data);
    }
}
