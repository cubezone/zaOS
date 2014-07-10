/**
 * 
 * HelloWorld.java
 * The sentinal sample!
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

package com.zhuxy.a_map;
import net.rim.device.api.ui.UiApplication;


/*
 * BlackBerry applications that provide a user interface must extend 
 * UiApplication.
 */

public class za_app extends UiApplication
{ 
    za_main m_Metro;  
    public static void main(String[] args)
    {
    	za_app theApp = new za_app();       
        theApp.enterEventDispatcher();
    }
    public za_app()
    {
        // Push the main screen instance onto the UI stack for rendering.
        m_Metro = new za_main(this);
        pushScreen(m_Metro);
    }    
}
