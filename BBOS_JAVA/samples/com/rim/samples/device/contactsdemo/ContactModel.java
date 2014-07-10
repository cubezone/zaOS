/*
 * ContactModel.java
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

package com.rim.samples.device.contactsdemo;

import java.util.Vector;
import net.rim.device.api.system.PersistentContent;
import net.rim.device.api.util.Persistable;


/**
 * ContactModel
 * The data model for contacts - these are persistable objects that store their 
 * information encoded according to the device's current Content Protection/Compression
 * security settings.
 */
/*package*/ final class ContactModel implements Persistable
{
    // Data
    private Vector _fields;

    // Fields
    public static final int FIRST_NAME = 0;
    public static final int LAST_NAME = 1;
    public static final int EMAIL_ADDRESS = 2;
    public static final int PHONE_NUMBER = 3;
    
    public static final int NUM_FIELDS = 4;  // Change this if any fields are added/removed.

    public ContactModel()
    {
        _fields = new Vector( NUM_FIELDS ); // Set initial capacity.
        
        for ( int i = 0; i < NUM_FIELDS; ++i )
        {
            _fields.addElement("");
        }
    }


    /**
     * Retrieves an encoded object and returns it as a plaintext string.
     * 
     * @param id The ID of the field from which the encoding should be retrieved.
     * @return The plaintext string.
     */
    public String getField(int id)
    {
        Object encoding = _fields.elementAt( id );
        return PersistentContent.decodeString( encoding );
    }

    
    /**
     * Stores a string as an encoded object.
     * 
     * @param id The ID of the field where the encoding is to be stored.
     * @param value The plaintext string to be encoded and stored.
     */
    public void setField(int id, String value)
    {
        Object encoding = PersistentContent.encode( value );
        _fields.setElementAt( encoding, id );
    }
    
    
    /**
     * Forces a re-encoding of the information stored in this contact model.
     */
    public void reEncode() 
    {
        for ( int i = 0; i < NUM_FIELDS; ++i ) 
        {
            Object encoding = _fields.elementAt( i );
            
            if ( ! PersistentContent.checkEncoding( encoding ) ) 
            {
                encoding = PersistentContent.reEncode( encoding );
                _fields.setElementAt( encoding, i );
            }
        }
    }
}
