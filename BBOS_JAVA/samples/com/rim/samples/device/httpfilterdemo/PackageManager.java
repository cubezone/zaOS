/**
 * PackageManager.java
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
package com.rim.samples.device.httpfilterdemo;

import net.rim.device.api.io.http.HttpFilterRegistry;

/**
 * An example of the HttpFilterRegistry apis.
 * 
 * This class runs on startup of the device and registers the necessary 
 * http filters.
 */
final class PackageManager
{
    public static void libMain(String[] args) 
    {
        HttpFilterRegistry.registerFilter("content.blackberry.com", "com.rim.samples.device.httpfilterdemo.precanned", true);
        HttpFilterRegistry.registerFilter("www.blackberry.com", "com.rim.samples.device.httpfilterdemo.filter");
    }
}
