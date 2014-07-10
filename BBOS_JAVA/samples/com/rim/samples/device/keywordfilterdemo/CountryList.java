/**
 * CountryList.java
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

import net.rim.device.api.ui.component .*;
import net.rim.device.api.collection.util.*; 
import net.rim.device.api.util.*;
import java.util.*;

/**
 * Instances of this SortedReadableList class will contain a list of countries
 * derived from a vector of Country objects passed into the constructor.  The
 * class is also a KeywordProvider implementation.
 */
class CountryList extends SortedReadableList implements KeywordProvider
{
    //Constructor
    CountryList(Vector countries)
    {
        super(new CountryListComparator());    
                   
        loadFrom(countries.elements());      
    } 
   
     /**
      * Adds a new element to the list.
      * @param element The element to be added.
      */
    void addElement(Object element)
    {
        doAdd(element);        
    }    
    
   /**
    * @see net.rim.device.api.ui.component.KeywordProvider#getKeywords(Object element) 
    */
    public String[] getKeywords( Object element )
    {        
        if(element instanceof Country )
        {            
            return StringUtilities.stringToWords(element.toString());
        }        
        return null;
    }  
    
    /**
     * A Comparator class used for sorting our Country objects by name.
     */
    final static class CountryListComparator implements Comparator
    {   
        
        public int compare(Object o1, Object o2)
        {
            if((o1.toString().compareTo(o2.toString()))<0)
            {
                return -1;
            }
            if((o1.toString().compareTo(o2.toString()))>0)
            {
                return 1;
            }
            else
            {
                return 0;
            }
            
        }        
    }    
}
