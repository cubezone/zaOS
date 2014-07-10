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

package com.rim.samples.device.helloworlddemo;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.container.*;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.system.*;
import net.rim.blackberry.api.homescreen.HomeScreen;
import javax.microedition.media.control.*;
import javax.microedition.media.*;
import javax.microedition.media.Manager.*;
import java.io.IOException;

/*
 * BlackBerry applications that provide a user interface must extend 
 * UiApplication.
 */

public class HelloWorldDemo extends UiApplication
{ 
    za_Metro m_Metro;  
    public static void main(String[] args)
    {
        HelloWorldDemo theApp = new HelloWorldDemo();       
        theApp.enterEventDispatcher();
    }
    public HelloWorldDemo()
    {
        // Push the main screen instance onto the UI stack for rendering.
        m_Metro = new za_Metro(this);
        pushScreen(m_Metro);
    }    
}
