/*
 * MemoApiDemo.java
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

package com.rim.samples.device.memoapidemo;

import javax.microedition.pim.*;
import net.rim.blackberry.api.pdap.*;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;

/**
 * Demo application that shows how to use BlackBerry's memo extension of 
 * the PIM API.
 */
public final class MemoApiDemo extends UiApplication
{
        
    /**
     * Application entry point.  Determines if the application is being run 
     * automatically as a system module at startup, or as a GUI from desktop.
     * In the case of the former, it registers a PIMListListener; otherwise,
     * it launches the GUI. 
     * 
     * @param args Command-line arguments.
     */
    public static void main( String[] args ) 
    {
        if ( args != null && args.length > 0 && args[0].equals( "init" ) ) 
        {
            // Running as a system module automatically at startup; register 
            // a PIMListListener.
            PIM p = PIM.getInstance();
            
            try 
            {
                BlackBerryPIMList memoList = (BlackBerryPIMList) p.openPIMList( BlackBerryPIM.MEMO_LIST, BlackBerryPIM.READ_WRITE );
                memoList.addListener( new MemoListListener() );
            } 
            catch ( PIMException e ) 
            {
                // Can't add listener.
            }
        } 
        else 
        {
            // Running normally; start the GUI.
            new MemoApiDemo().enterEventDispatcher();
        }
    }    
    
    /**
     * Constructor.  Creates and displays the application's main screen.
     */
    private MemoApiDemo() 
    {
        MainScreen mainScreen = new MemoMainScreen();
        
        mainScreen.setTitle( new LabelField("Memo API Demo", LabelField.USE_ALL_WIDTH | LabelField.ELLIPSIS ));
        pushScreen( mainScreen );
    }
}
