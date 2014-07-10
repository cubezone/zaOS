/* 
 * BrowserContentManagerDemo.java
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
package com.rim.samples.device.blackberry.browser;

import java.io.IOException;

import javax.microedition.io.HttpConnection;

import net.rim.device.api.browser.field.*;
import net.rim.device.api.io.http.HttpHeaders;
import net.rim.device.api.system.Application;
import net.rim.device.api.ui.Field;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.LabelField;
import net.rim.device.api.ui.component.Status;
import net.rim.device.api.ui.container.MainScreen;
import net.rim.device.api.system.*;

/**
 * This sample application demonstrates how to render web content using
 * the BrowserContentManager class and the RenderingApplication interface.
 */

final public class BrowserContentManagerDemo extends UiApplication implements RenderingApplication 
{    
    private static final String REFERER = "referer";   
    
    private BrowserContentManager _browserContentManager;
    private HttpConnection  _currentConnection;       
    private MainScreen _mainScreen;
    
    /***************************************************************************
     * Main.
     **************************************************************************/
    public static void main(String[] args) 
    {
        BrowserContentManagerDemo app = new BrowserContentManagerDemo();
        app.enterEventDispatcher();
    }
    
    /**
     * Constructor.
     */
     private BrowserContentManagerDemo() 
     {               
        _browserContentManager = new BrowserContentManager( 0 );
        RenderingOptions renderingOptions = _browserContentManager.getRenderingSession().getRenderingOptions();

        // Turn off images in html.
        renderingOptions.setProperty(RenderingOptions.CORE_OPTIONS_GUID, RenderingOptions.SHOW_IMAGES_IN_HTML, false);
        
        _mainScreen = new MainScreen();
        _mainScreen.add(new LabelField("Label before the content", Field.FOCUSABLE));
              
        _mainScreen.add(_browserContentManager);
        
        _mainScreen.add(new LabelField("Label after the content", Field.FOCUSABLE));                
        pushScreen(_mainScreen);
                
        PrimaryResourceFetchThread thread = new PrimaryResourceFetchThread("http://www.google.com", null, null, null, this);
        thread.start();  
    }
    
     public void processConnection(HttpConnection connection, Event e) 
     {               
         // Cancel previous request.
         if (_currentConnection != null) 
         {
             try 
             {
                 _currentConnection.close();
             } 
             catch (IOException e1) 
             {
             }
         }
         
         _currentConnection = connection;
         
        try 
        {
            _browserContentManager.setContent(connection, this, e);
        } 
        finally 
        {
            SecondaryResourceFetchThread.doneAddingImages();
        }
    }
     
     /**
      * @see net.rim.device.api.browser.RenderingApplication#eventOccurred(net.rim.device.api.browser.Event)
      */
     public Object eventOccurred(Event event) 
     {
         int eventId = event.getUID();

         switch (eventId) 
         {
             case Event.EVENT_URL_REQUESTED : 
             {

                 UrlRequestedEvent urlRequestedEvent = (UrlRequestedEvent) event;    
                 String absoluteUrl = urlRequestedEvent.getURL();
     
                 HttpConnection conn = null;
                 PrimaryResourceFetchThread thread = new PrimaryResourceFetchThread(urlRequestedEvent.getURL(),
                                                                                          urlRequestedEvent.getHeaders(), 
                                                                                          urlRequestedEvent.getPostData(),
                                                                                          event, this);
                 thread.start();
     
                 break;

             } 
             case Event.EVENT_BROWSER_CONTENT_CHANGED: 
             {                
                     
                 // Browser field title might have changed update title.
                 BrowserContentChangedEvent browserContentChangedEvent = (BrowserContentChangedEvent) event; 
             
                 if (browserContentChangedEvent.getSource() instanceof BrowserContent) 
                 { 
                     BrowserContent browserField = (BrowserContent) browserContentChangedEvent.getSource(); 
                     final String newTitle = browserField.getTitle();
                     if (newTitle != null) 
                     {
                         Application.getApplication().invokeAndWait(new Runnable() 
                         {
                             public void run() 
                             {
                                 _mainScreen.setTitle(newTitle);
                             }
                         });
                     }
                 }                   

                 break;                

             } 
             case Event.EVENT_REDIRECT : 
             {
                     RedirectEvent e = (RedirectEvent) event;
                     String referrer = e.getSourceURL();
                                         
                     switch (e.getType()) 
                     {
                         case RedirectEvent.TYPE_SINGLE_FRAME_REDIRECT :
                             // Show redirect message.
                             Application.getApplication().invokeAndWait(new Runnable() 
                             {
                                 public void run() 
                                 {
                                     Status.show("You are being redirected to a different page...");
                                 }
                             });

                             break;

                         case RedirectEvent.TYPE_JAVASCRIPT :
                             break;
                             
                         case RedirectEvent.TYPE_META :
                             // MSIE and Mozilla don't send a Referer for META Refresh.
                             referrer = null;     
                             break;
                             
                         case RedirectEvent.TYPE_300_REDIRECT :
                             // MSIE, Mozilla, and Opera all send the original
                             // request's Referer as the Referer for the new
                             // request.
                             Object eventSource = e.getSource();
                             if (eventSource instanceof HttpConnection) 
                             {
                                 referrer = ((HttpConnection)eventSource).getRequestProperty(REFERER);
                             }
                             break;
                     }
                     
                     HttpHeaders requestHeaders = new HttpHeaders();
                     requestHeaders.setProperty(REFERER, referrer);
                     PrimaryResourceFetchThread thread = new PrimaryResourceFetchThread(e.getLocation(), requestHeaders,null, event, this);
                     thread.start();
                     break;

             } 
             case Event.EVENT_CLOSE :
                 // TODO: close the appication
                 break;
             
             case Event.EVENT_SET_HEADER :        // No cache support.
             case Event.EVENT_SET_HTTP_COOKIE :   // No cookie support.
             case Event.EVENT_HISTORY :           // No history support.             
             case Event.EVENT_EXECUTING_SCRIPT :  // No progress bar is supported.
             case Event.EVENT_FULL_WINDOW :       // No full window support.
             case Event.EVENT_STOP :              // No stop loading support.
             default :
         }

         return null;
     }

     /**
      * @see net.rim.device.api.browser.RenderingApplication#getAvailableHeight(net.rim.device.api.browser.BrowserContent)
      */
     public int getAvailableHeight(BrowserContent browserField) 
     {
         // Field has full screen.
         return Display.getHeight();
     }


     /**
      * @see net.rim.device.api.browser.RenderingApplication#getAvailableWidth(net.rim.device.api.browser.BrowserContent)
      */
     public int getAvailableWidth(BrowserContent browserField) 
     {
         // Field has full screen.
         return Display.getWidth();
     }

     /**
      * @see net.rim.device.api.browser.RenderingApplication#getHistoryPosition(net.rim.device.api.browser.BrowserContent)
      */
     public int getHistoryPosition(BrowserContent browserField) 
     {
         // No history support.
         return 0;
     }


     /**
      * @see net.rim.device.api.browser.RenderingApplication#getHTTPCookie(java.lang.String)
      */
     public String getHTTPCookie(String url) 
     {
         // No cookie support.
         return null;
     }

     /**
      * @see net.rim.device.api.browser.RenderingApplication#getResource(net.rim.device.api.browser.RequestedResource,
      *      net.rim.device.api.browser.BrowserContent)
      */
     public HttpConnection getResource( RequestedResource resource, BrowserContent referrer) 
     {
         if (resource == null) 
         {
             return null;
         }

         // Check if this is cache-only request.
         if (resource.isCacheOnly()) 
         {
             // No cache support.
             return null;
         }

         String url = resource.getUrl();

         if (url == null) 
         {
             return null;
         }

         // If referrer is null we must return the connection.
         if (referrer == null) 
         {
             HttpConnection connection = Utilities.makeConnection(resource.getUrl(), resource.getRequestHeaders(), null);
             return connection;
             
         } 
         else 
         {
             
             // If referrer is provided we can set up the connection on a separate thread.
             SecondaryResourceFetchThread.enqueue(resource, referrer);
             
         }

         return null;
     }

     /**
      * @see net.rim.device.api.browser.RenderingApplication#invokeRunnable(java.lang.Runnable)
      */
     public void invokeRunnable(Runnable runnable) 
     {         
         (new Thread(runnable)).start();
     }    
}

class PrimaryResourceFetchThread extends Thread 
{
    
    private BrowserContentManagerDemo _application;
    private Event _event;
    private byte[] _postData;
    private HttpHeaders _requestHeaders;
    private String _url;
    
    PrimaryResourceFetchThread(String url, HttpHeaders requestHeaders, byte[] postData, Event event, BrowserContentManagerDemo application) 
    {
        _url = url;
        _requestHeaders = requestHeaders;
        _postData = postData;
        _application = application;
        _event = event;
    }

    public void run() 
    {
        HttpConnection connection = Utilities.makeConnection(_url, _requestHeaders, _postData);
        _application.processConnection(connection, _event);        
    }
}
