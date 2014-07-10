/*
 * InvokeLocationDocumentScreen.java
 *
 * Copyright � 1998-2008 Research In Motion Ltd.
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
import net.rim.blackberry.api.invoke.Invoke;
import net.rim.blackberry.api.invoke.MapsArguments;

/**
 * A location document allows the application to specify a specific point, multiple
 * points or a route between two points. A location document is simply a string which
 * contains a set of XML tags with attributes that specify a location or route.
 * See the GPS and BlackBerry Maps Development Guide for a full explanation of 
 * the Location Document.
 */
final class InvokeLocationDocumentScreen extends MainScreen
{
    
    /**
     * Constructor
     */
    public InvokeLocationDocumentScreen() 
    {            
        setTitle("Invoke Location Document"); 
        
        RichTextField instructions = new RichTextField("From the menu:\n\nSelect 'View Single Location' to invoke BlackBerry Maps using a single location tag.\n\nSelect 'View Multiple Locations' to invoke BlackBerry Maps using multiple location tags.\n\nSelect 'View Route' to invoke BlackBerry Maps using multiple location tags and the <GetRoute> tag.",Field.READONLY | Field.FOCUSABLE);
        add(instructions);
        
        addMenuItem(viewSingleItem);
        addMenuItem(viewMultipleItem);
        addMenuItem(viewRouteItem);
    }
    
    /**
     * Displays a single location on a map.
     */
    MenuItem viewSingleItem = new MenuItem("View Single Location" , 1000, 10) 
    {
        public void run() 
        {
            String document = "<location-document><location lon='-7938675' lat='4367022' label='Toronto, ON' description='Go Leafs Go!' zoom='10'/></location-document>";
            
            Invoke.invokeApplication(Invoke.APP_TYPE_MAPS, new MapsArguments( MapsArguments.ARG_LOCATION_DOCUMENT, document));
        }
    };
    
    /**
     * Displays multiple locations on a map.
     */
    MenuItem viewMultipleItem = new MenuItem("View Multiple Locations" , 2000, 10) 
    {
        public void run() 
        {
            String document = "<location-document>" +
                            "<location lon='-8030000' lat='4326000' label='Kitchener, ON' description='Kitchener, Ontario, Canada' />" +
                            "<location lon='-7569792' lat='4542349' label='Ottawa, ON'    description='Ottawa, Ontario, Canada' />" +
                            "</location-document>";
                            
            Invoke.invokeApplication(Invoke.APP_TYPE_MAPS, new MapsArguments( MapsArguments.ARG_LOCATION_DOCUMENT, document));

        }
    };

    /**
     * Displays a route between locations on a map.
     */
    MenuItem viewRouteItem = new MenuItem("View Route" , 3000, 10) 
    {
        public void run()
        {
            String document = "<location-document><GetRoute>" + 
                                "<location lon='-8030000' lat='4326000' label='Kitchener, ON' description='Kitchener, Ontario, Canada' />" +
                                "<location lon='-7569792' lat='4542349' label='Ottawa, ON'    description='Ottawa, Ontario, Canada' />" +
                                "</GetRoute></location-document>";
                                
            Invoke.invokeApplication(Invoke.APP_TYPE_MAPS, new MapsArguments( MapsArguments.ARG_LOCATION_DOCUMENT, document));
        }
    };
}

