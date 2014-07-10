/*
 * BlackBerryMapsDemo.java
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

package com.rim.samples.device.blackberrymapsdemo;

import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;

/**
 * This sample features a main screen including menu items which display respective 
 * screens highlighting specific aspects of the BlackBerry Maps API's.  Each of these
 * screens offer menu items that will invoke the BlackBerry Maps application in some 
 * manner. See the GPS and BlackBerry Maps Development Guide for more information.
 */
class BlackBerryMapsDemo extends UiApplication
{    
    /**
     * Entry point for the application.
     */
    public static void main(String[] args)
    {
        BlackBerryMapsDemo app = new BlackBerryMapsDemo();
        app.enterEventDispatcher();        
    }
    
    /**
     * Constructor
     */
    public BlackBerryMapsDemo()
    {
        BlackBerryMapsDemoScreen screen = new BlackBerryMapsDemoScreen();
        pushScreen(screen);        
    }        
}


/**
 * The main screen for the application.  Additional screens can be launched via
 * menu items.
 */
final class BlackBerryMapsDemoScreen extends MainScreen
{
        
    BlackBerryMapsDemo _app;
    
    public BlackBerryMapsDemoScreen()
    {        
        setTitle("BlackBerry Maps Demo");  
        
        _app = (BlackBerryMapsDemo)UiApplication.getUiApplication();    
           
        RichTextField rtf = new RichTextField("Select an option from the menu.\n\nNOTE: Using BlackBerry Maps within the BlackBerry simulator requires the MDS simulator to be running." ,Field.NON_FOCUSABLE);
        add(rtf); 
        
        addMenuItem(invokeContactItem);
        addMenuItem(invokeDefaultItem);
        addMenuItem(invokeLocationDocumentItem);
        addMenuItem(invokeMapViewItem);        
    }

    
    /////////////////////////
    ///  MenuItem classes ///
    /////////////////////////
    
    /**
     * Displays an InvokeContactScreen.
     */     
    MenuItem invokeContactItem  = new MenuItem("Invoke Contact" , 0 , 0)
    {
        public void run()
        {
            InvokeContactScreen invokeContactScreen = new InvokeContactScreen();
            _app.pushScreen(invokeContactScreen);
        }        
    };    
    
    /**
     * Displays an InvokeDefaultScreen.
     */
    MenuItem invokeDefaultItem  = new MenuItem("Invoke Default" ,0 , 0)
    {
        public void run()
        {
            InvokeDefaultScreen invokeDefaultScreen = new InvokeDefaultScreen();
            _app.pushScreen(invokeDefaultScreen);
        }        
    };    
    
    /**
     * Displays an InvokeLocationDocumentScreen.
     */
    MenuItem invokeLocationDocumentItem  = new MenuItem("Invoke Location Document" , 0 , 0)
    {
        public void run()
        {
            InvokeLocationDocumentScreen invokeLocationDocumentScreen = new InvokeLocationDocumentScreen();
            _app.pushScreen(invokeLocationDocumentScreen);
        }        
    };
    
    /**
     * Displays an InvokeMapViewScreen.
     */
    MenuItem invokeMapViewItem  = new MenuItem("Invoke Map View" ,0 , 0)
    {
        public void run()
        {
            InvokeMapViewScreen invokeMapViewScreen = new InvokeMapViewScreen();
            _app.pushScreen(invokeMapViewScreen);
        }        
    };    
}
