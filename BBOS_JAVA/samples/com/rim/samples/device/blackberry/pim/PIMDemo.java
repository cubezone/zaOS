/**
 * PIMDemo.java
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

package com.rim.samples.device.blackberry.pim;

import net.rim.device.api.ui.*;

/**
 * Sample to demonstrate functionality of Personal Information Management (PIM) API's.  
 * EventScreen class allows an event to be saved and alerts invitees via email. 
 * ContactListScreen class displays a list of potential invitees.  
 * ContactScreen screen allows additional contacts to be added to the Address Book.
 */
public final class PIMDemo extends UiApplication
{    
    // Constants ----------------------------------------------------------------
    // private static String ARG_STARTUP = "startup";
    
    // Members ------------------------------------------------------------------
    private EventScreen _eventScreen;
   
   // Entry point for application
    public static void main(String[] args)
    {
        new PIMDemo().enterEventDispatcher();
    }    
    
    // Constructor
    private PIMDemo()
    {   
        // Create a new EventScreen and push screen onto stack.
        _eventScreen = new EventScreen();        
        pushScreen(_eventScreen); 
    }
}
