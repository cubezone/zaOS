/**
 * SocketDemo.java
 * 
 * Copyright � 1998-2008 Research In Motion Ltd.
 * 
 * Note: For the sake of simplicity, this sample application may not leverage
 * resource bundles and resource strings.  However, it is STRONGLY recommended
 * that application developers make use of the localization features available
 * within the BlackBerry development platform to ensure a seamless application
 * experience across a variety of languages and geographies.  For more information
 * on localizing your application, please refer to the BlackBerry Java Development
 * Environment Development Guide associated with this release.
 */

package com.rim.samples.device.socketdemo;

import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;
import net.rim.device.api.ui.*;

import java.io.*;
import javax.microedition.io.*;

import net.rim.device.api.system.Characters;
import net.rim.device.api.system.RadioInfo;

/**
 * This sample enables client/server communication using a simple implementation 
 * of TCP sockets. The client application allows the user to select direct TCP as
 * the connection method.  If direct TCP is not selected, a proxy TCP connection
 * is opened using the BlackBerry MDS Connection Service. The server application 
 * can be found in com/rim/samples/server/socketdemo. 
 */
class SocketDemo extends UiApplication
{
    
    // Constants ----------------------------------------------------------------------------------------------------------
     
    // Using a static doesn't cost a hashtable lookup for each use (faster), 
    // but it does occupy storage for the life of the app.
    private static String URL;
    private static String HELLO = "Hello";
    private static String GOODBYE = "GoodbyeAndFarewell";

    // Members ------------------------------------------------------------------------------------------------------------
    
    private boolean _isRunning;
    
    private MenuItem _go = new MenuItem("Go" , 100, 10)
    {
        public void run()
        {
            // Don't do anything unless there is a host name in the _host field.
            if (_host.getText().length() > 0)
            {
                URL = "socket://" + _host.getText() + ":4444" + (_useDirectTcpField.getChecked() ? ";deviceside=true" : "");
                synchronized(getLockObject())
                {
                    if ( !_isRunning )
                    {
                        _isRunning = true;
                        new ConnectThread().start();
                    }
                }
            }
            else
            {
                Dialog.ask(Dialog.D_OK, "Please enter a valid host name" );
            }
        }
    };
    
    // Need to get the local host name from the user because access to 'localhost' 
    // and 127.* is restricted.
    private EditField _host = new EditField("Local Host: " , "");    
    private CheckboxField _useDirectTcpField = new CheckboxField("Use Direct TCP" , RadioInfo.getNetworkType() == RadioInfo.NETWORK_IDEN);
    private RichTextField _rtf = new RichTextField();    
    private StringBuffer _message = new StringBuffer();   


    /**
     * Entry point for application.
     * @param Command line arguments.
     */
    public static void main(String[] args)
    {
        SocketDemo app = new SocketDemo();
        app.enterEventDispatcher();
    }
    
    // Constructor
    private SocketDemo()
    {
        // Create a new screen for the application.
        SocketDemoScreen screen = new SocketDemoScreen();
        screen.setTitle(new LabelField("Socket Demo" , LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH));
        
        // Add UI elements to the screen.
        screen.add(new RichTextField("Enter local host name in the field below and select 'Go' from the menu." ,Field.NON_FOCUSABLE));
        screen.add(new SeparatorField(SeparatorField.LINE_HORIZONTAL));
        screen.add(_host);
        screen.add(_useDirectTcpField);
        screen.add(_rtf);

        // Push the screen onto the UI stack for rendering.
        pushScreen(screen);
    }
    
    /**
     * Method to display a message to the user.
     * @param msg The message to display.
     */
    private void updateDisplay(final String msg)
    {
        invokeLater(new Runnable() 
        {
            public void run()
            {
                _message.append(msg);
                _message.append('\n');
                _rtf.setText(_message.toString());
            }
        });
    }

    /**
     * Returns a reference to the application instance.
     * @return The reference to the application instance.
     */
    private Object getLockObject()
    {
        return this;
    }

    // Inner classes ------------------------------------------------------------------------------------------------------
    
    // This class represents the main screen for our app.
    private class SocketDemoScreen extends MainScreen
    {
        /**
         *@see net.rim.device.api.ui.Screen#makeMenu(Menu,int)
         */     
        protected void makeMenu(Menu menu, int instance)
        {
            if (!_isRunning)
            {
                menu.add(_go);
            }
            
            menu.addSeparator();
            
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
         * Handles the user pressing ENTER while the 
         * 'use direct tcp' CheckboxField has focus. 
         * 
         * @see net.rim.device.api.ui.Screen#keyChar(char,int,int)
         * 
         */
        protected boolean keyChar( char key, int status, int time )
        {
            if ( key == Characters.ENTER )
            {
                Field fieldWithFocus = getFieldWithFocus(); 
                
                if(fieldWithFocus == _useDirectTcpField)
                {
                        if(_useDirectTcpField.getChecked())
                        {
                                _useDirectTcpField.setChecked(false);
                        }
                        else
                        {
                                _useDirectTcpField.setChecked(true);
                        } 
                                           
                    return true; // We've consumed the event.                
                }            
            }
            
            return super.keyChar( key, status, time ); // We'll let super handle the event.
        }        
    }
    
    /**
     * A private inner class to manage the socket.
     * <p>Not static since we access some methods in our parent.
     */
    private class ConnectThread extends Thread
    {
        // Members --------------------------------------------------------------------------------------------------------
        
        private InputStreamReader _in;
        private OutputStreamWriter _out;

        // Methods --------------------------------------------------------------------------------------------------------
        
        /**
         * Pass some data to the server and wait for a response.
         * @param data The data to send.
         */
        private void exchange(String data) throws IOException
        {
            // Cache the length locally for better efficiency.
            int length = data.length();
            
            // Create an input array just big enough to hold the data (we're expecting the 
            // same string back that we send).
            char[] input = new char[length];
            _out.write(data, 0, length);

            // Read character by character into the input array - we're only reading length
            // characters.
            for (int i = 0; i < length; ++i) // Pre-increment is more efficient, as is caching the loop invariant.
            {
                input[i] = (char)_in.read();
            }

            // Hand the data to the parent class for updating the GUI. By explicitly 
            // creating the stringbuffer we can save a few object creations.
            StringBuffer s = new StringBuffer();
            s.append("Received: ") ;
            s.append(input, 0, length);
            updateDisplay(s.toString());
        }

        /**
         * Implementation of Thread.
         */
        public void run()
        {
            StreamConnection connection = null;
            
            try
            {
                updateDisplay("Opening Connection...");
                connection = (StreamConnection)Connector.open(URL);
                updateDisplay("Connection open");

                _in = new InputStreamReader(connection.openInputStream());
                _out = new OutputStreamWriter(connection.openOutputStream());
                char[] input = new char[1024];

                // Send the HELLO string.
                exchange(HELLO);

                // Execute further data exchange here...

                // Send the GOODBYE string.
                exchange(GOODBYE);
    
                // Close the current connection.
                _in.close();
                _out.close();
                connection.close();
                
                updateDisplay("Done!");
            }
            catch(IOException e)
            {
                System.err.println(e.toString());
            }
            
            synchronized(getLockObject())
            {
                _isRunning = false;
            }
        }
    }   
}

