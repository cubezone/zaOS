/*
 * Country.java
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
 
package com.rim.samples.device.keywordfilterdemo;

/**
 * A class to encapsulate data related to a given country of the world.
 */
class Country
{
    private String _countryName;
    private String _population;
    private String _capitalCity;
    
    // Constructor
    Country(String countryName, String population, String capitalCity)
    {
        _countryName = countryName;
        _population = population;
        _capitalCity = capitalCity;          
    }
    
    // Accessor methods---------------------------------------------------------
    
    String getPopulation()
    {
        return _population;
    }
    
    String getCapitalCity()
    {
        return _capitalCity;
    }     
    
    public String toString()
    {
        return _countryName;
    }
}
