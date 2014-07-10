/*
 * XMLDemo.java
 * 
 * A sample application demonstrating how to parse an XML file.
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

package com.rim.samples.device.xmldemo;

import net.rim.device.api.ui.UiApplication;


/**
 * The main class for the application.
 */
public final class XMLDemo extends UiApplication
{
    /**
     * This constructor simply pushes the main screen onto the display stack.
     */
    private XMLDemo() 
    {
        pushScreen( new XMLDemoScreen() );
    }
    
    
    /**
     * Entry point for the application.
     * 
     * @param args Command-line arguments (not used).
     */
    public static void main( String[] args ) 
    {
        new XMLDemo().enterEventDispatcher();
    }
}
