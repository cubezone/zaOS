/**
 * CookieMenuItem.java
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

package com.rim.samples.device.contactsdemo;

import net.rim.device.api.system.*;
import net.rim.device.api.ui.container.*;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.util.*;
import java.util.*;

/**
 * An abstract class that contains a cookie.
 */
public abstract class CookieMenuItem extends MenuItem
{
    protected Object _cookie;
    
    public CookieMenuItem(String text , int ordinal, int priority, Object cookie) 
    {
        super(text , ordinal, priority);
        _cookie = cookie;
    }

}
