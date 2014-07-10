/**
 * Context.java - Interface
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

/**
 * Context
 * <p>This interface defines some context values for use by the ContactController 
 * class in ContactsDemo.java
 * Contexts are used to provide hints to the controller about what it should return
 * from various method calls.
 */
public interface Context 
{
    public static final int FOR_EDIT = 100;
    public static final int FOR_READ = 110;
    public static final int FOR_LIST = 120;
    public static final int FOR_TITLE = 130;
}
