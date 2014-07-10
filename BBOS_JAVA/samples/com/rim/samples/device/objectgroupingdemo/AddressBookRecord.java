/*
 * AddressBookRecord.java
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

package com.rim.samples.device.objectgroupingdemo;

import net.rim.device.api.system.*;
import net.rim.device.api.util.*;

/**
 * This class represents the record object for the address book
 * record sample code.  It is a persistent object and is intended
 * to showcase how grouping would be applied to this object.
 */
public class AddressBookRecord implements Persistable
{
    private String _title;          // The title of the address book record.
    private String _firstName;      // The first name of the address book record.
    private String _lastName;       // The last name of the address book record.

    /**
     * Create an empty version of the AddressBookRecord.
     */
    public AddressBookRecord()
    {
        _title = "";
        _firstName = "";
        _lastName = "";
    }

    /**
     * Create a new AddressBookRecord with the specified title, first name and last name.
     * @param title the title of the AddressBookRecord.  It cannot be null.
     * @param firstName the first name of the AddressBookRecord.  It cannot be null.
     * @param lastName the last name of the AddressBookRecord.  It cannot be null.
     * @throws IllegalArgumentException if any of the parameters are null.
     */
    public AddressBookRecord( String title, String firstName, String lastName )
    {
        if( title == null || firstName == null || lastName == null ) {
            throw new IllegalArgumentException();
        }
        _title = title;
        _firstName = firstName;
        _lastName = lastName;
    }
    
    /**
     * Returns the title of the AddressBookRecord.
     * @return the titel of the AddressBookRecord.
     */
    public String getTitle()
    {
        return _title;
    }
    
    /**
     * Returns the first name of the AddressBookRecord.
     * @return the first name of the AddressBookRecord.
     */
    public String getFirstName()
    {
        return _firstName;
    }
    
    /**
     * Returns the last name of the AddressBookRecord.
     * @return returns the last name of the AddressBookRecord.
     */
    public String getLastName()
    {
        return _lastName;
    }    
    
    /**
     * Sets the title of the AddressBookRecord.
     * @param title the new title of the AddressBookRecord.
     */
    public void setTitle( String title )
    {
        _title = title;
    }
    
    /**
     * Sets the first name of the AddressBookRecord.
     * @param firstName the new first name of the AddressBookRecord.
     */
    public void setFirstName( String firstName )
    {
        _firstName = firstName;
    }
    
    /**
     * Sets the last name of the AddressBookRecord.
     * @param lastName the new last name of the AddressBookRecord.
     */
    public void setLastName( String lastName )
    {
        _lastName = lastName;
    }

    // Javadocs copied from super class.
    public boolean equals( Object obj )
    {
        if( obj == this ) return true;
        if( obj instanceof AddressBookRecord ) {
            AddressBookRecord other = (AddressBookRecord)obj;
            if( !other._title.equals( _title )) return false;
            if( !other._firstName.equals( _firstName )) return false;
            if( !other._lastName.equals( _lastName )) return false;
            return true;
        }
        return false;
    }
}         
