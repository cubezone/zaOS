/*
 * LoaderApp.java
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

import net.rim.device.api.browser.plugin.BrowserContentProviderRegistry;

/**
 * App to load the browser plugin.
 */
final class LoaderApp 
{
    public static void libMain( String[] args ) 
    { 
        BrowserContentProviderRegistry converterRegistry = BrowserContentProviderRegistry.getInstance();
        
        if (converterRegistry != null) 
        {           
            converterRegistry.register(new BrowserPlugin());            
        }
    }
}
