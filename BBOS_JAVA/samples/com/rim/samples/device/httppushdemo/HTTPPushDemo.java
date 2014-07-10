/**
 * HTTPPushDemo.java
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

package com.rim.samples.device.httppushdemo;

import java.io.*;
import javax.microedition.io.*;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;
import net.rim.device.api.system.*;
import net.rim.device.api.util.*;
import net.rim.device.api.io.http.*;

/**
 * The client side of a simple HTTP Push system. 
 * This application will listen for image data on the specified port and
 * render the data when it arrives.
 */
public class HTTPPushDemo extends UiApplication
{
    // Constants ----------------------------------------------------------------
    private static final String URL = "http://:100"; // PORT 100.
    private static final int CHUNK_SIZE = 256;

    // Members ------------------------------------------------------------------
    private ListeningThread _listeningThread;
    private HTTPPushDemoScreen _mainScreen;
    private RichTextField _infoField;
    private RichTextField _imageField;

    
    public static void main(String[] args)
    {
        HTTPPushDemo theApp = new HTTPPushDemo();
        theApp.enterEventDispatcher();
    }
    
    
    // Constructor --------------------------------------------------------------
    public HTTPPushDemo()
    {
        _mainScreen = new HTTPPushDemoScreen();
        _mainScreen.setTitle(new LabelField("HTTP Push Demo" , LabelField.USE_ALL_WIDTH));

        _infoField = new RichTextField();
        _mainScreen.add(_infoField);

        _mainScreen.add(new SeparatorField());

        _imageField = new RichTextField();
        _mainScreen.add(_imageField);

        // Spin off the listening thread.
        _listeningThread = new ListeningThread();
        _listeningThread.start();

        _infoField.setText("HTTP Listen object started");

        pushScreen(_mainScreen);
    }
    

    // Inner Classes ------------------------------------------------------------
    private class ListeningThread extends Thread
    {
        private boolean _stop = false;
        private StreamConnectionNotifier _notify;

        public synchronized void stop()
        {
            _stop = true;
            try 
            {
                // Close the connection so the thread will return.
                _notify.close(); 
            } 
            catch (IOException e) 
            {
                System.err.println(e.toString());
            } 
            catch (NullPointerException e) 
            {
                // The notify object likely failed to open, due to an IOException.
            }
        }

        public void run()
        {

            StreamConnection stream = null;
            InputStream input = null;
            MDSPushInputStream pushInputStream=null;
            
            while (!_stop)
            {
            try 
                {
                    
                    // Synchronize here so that we don't end up creating a connection that is never closed.
                    synchronized(this)  
                    {
                        // Open the connection once (or re-open after an IOException),  so we don't end up 
                        // in a race condition, where a push is lost if it comes in before the connection 
                        // is open again. We open the url with a parameter that indicates that we should 
                        // always use MDS when attempting to connect.
                        _notify = (StreamConnectionNotifier)Connector.open(URL + ";deviceside=false");
                    }
                    
                    while (!_stop)
                    {
                        
                        // NOTE: the following will block until data is received.
                        stream = _notify.acceptAndOpen();
                        
                        try 
                        {
                            input = stream.openInputStream();
                            pushInputStream= new MDSPushInputStream((HttpServerConnection)stream, input);

                            // Extract the data from the input stream.
                         
                            DataBuffer db = new DataBuffer();
                            byte[] data = new byte[CHUNK_SIZE];
                            int chunk = 0;
                            
                            while ( -1 != (chunk = input.read(data)) )
                            {
                                db.write(data, 0, chunk);
                            }
                            
                            updateMessage(data);
                            
                            // This method is called to accept the push.
                            pushInputStream.accept();

                            input.close();
                            stream.close();

                            data = db.getArray();
                            

                        } 
                        catch (IOException e1) 
                        {
                            // A problem occurred with the input stream , however, the original 
                            // StreamConnectionNotifier is still valid.
                            System.err.println(e1.toString());

                            if ( input != null ) 
                            {
                                try 
                                {
                                    input.close();
                                } 
                                catch (IOException e2) 
                                {
                                }
                            }
                            
                            if ( stream != null )
                            {
                                try 
                                {
                                    stream.close();
                                } 
                                catch (IOException e2) 
                                {
                                }
                            }
                        }
                    }
                    
                    _notify.close();
                    _notify = null;   
                    
                } 
                catch (IOException ioe)
                {
                    // Likely the stream was closed. Catches the exception thrown by 
                    // _notify.acceptAndOpen() when this program exits.
                    
                    if ( _notify != null ) 
                    {
                        try 
                        {
                            _notify.close();
                            _notify = null;
                        } 
                        catch ( IOException e ) 
                        {
                        }
                    }
                }
            }
        }
    }


    private void updateMessage(final byte[] data)
    {
        Application.getApplication().invokeLater(new Runnable() 
        {
            public void run() 
            {
                // Query the user to load the received message.
                String[] choices = {"Ok" , "Cancel" };
                
                if ( 0 != Dialog.ask("New message received. Do you want to render it?" , choices, 0) )
                {
                    return;
                }
                
                _infoField.setText("Text received - size:  " + data.length);

                try 
                {
                   _imageField.setText(new String(data));
                }
                catch (Exception e) 
                {
                    Dialog.inform(e.toString());
                    System.err.println(e.toString());
                }
            }
        });
    }

    protected void onExit()
    {
        // Kill the listening thread.
        _listeningThread.stop();
        
        try 
        {
            _listeningThread.join();
        } 
        catch (InterruptedException e) 
        {
            System.err.println(e.toString());
        }

    }
    
    
    private class HTTPPushDemoScreen extends MainScreen
    {
        
        /**
         * @see net.rim.device.api.ui.Screen#close()
         */
        public void close()
        {
            onExit();
            
            super.close();
        }
    }
}
