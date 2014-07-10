/*
 * CustomerRecord.java
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

package com.rim.samples.device.memorydemo;

import net.rim.device.api.lowmemory.LowMemoryManager;
import net.rim.device.api.util.*;


/**
 * Represents a customer record for a fictional business.
 */
/*package*/ final class CustomerRecord implements Persistable
{
    // Members -------------------------------------------------------------------------------------
    private String _firstName;
    private String _lastName;
    private long _lastAccessDate;
    
    
    /**
     * This constructor just fills in the data values in this record.
     * 
     * @param firstName The customer's first name.
     * @param lastName The customer's last name.
     * @param lastAccessDate The date this customer record was last accessed.
     */
    public CustomerRecord( String firstName, String lastName, long lastAccessDate ) 
    {
        _firstName = firstName;
        _lastName = lastName;
        _lastAccessDate = lastAccessDate;
    }
    
    
    /**
     * Retrieve's this customer record's first name.
     * 
     * @return The customer's first name.
     */
    public String getFirstName() 
    {
        return _firstName;
    }
    
    
    /**
     * Sets this customer record's first name.
     * 
     * @param firstName The new first name.
     */
    public void setFirstName( String firstName ) 
    {
        _firstName = firstName;
    }
    
    
    /**
     * Retrieve's this customer record's last name.
     * 
     * @return The customer's last name.
     */
    public String getLastName() 
    {
        return _lastName;
    }
    
    
    /**
     * Sets this customer record's last name.
     * 
     * @param lastName The new last name.
     */
    public void setLastName( String lastName ) 
    {
        _lastName = lastName;
    }
    
    
    /**
     * Retrieves the date of the last time this customer record was accessed.
     * 
     * @return The "last accessed" date.
     */
    public long getLastAccessDate() 
    {
        return _lastAccessDate;
    }
    
    
    /**
     * Sets the date of the last time this customer record was accessed.
     * 
     * @param lastAccessDate The new "last accessed" date.
     */
    public void setLastAccessDate( long lastAccessDate ) 
    {
        _lastAccessDate = lastAccessDate;
    }
    
    
    /**
     * Returns a string representation of this customer record.
     * 
     * @return The string representation.
     */
    public String toString() 
    {
        return _lastName + ", " + _firstName;
    }
}
