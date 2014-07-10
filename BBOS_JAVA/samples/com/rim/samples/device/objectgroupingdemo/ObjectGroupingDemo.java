/*
 * ObjectGroupingDemo.java
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
import net.rim.device.api.ui.*;

/**
 * The application class contains the starting point
 * for this demo and shows how grouping and ungrouping
 * should work.  As well, it shows how an exception is
 * thrown if the object is grouped and the application
 * attempts to modify it.
 */
public class ObjectGroupingDemo extends Application
{
    public static void main( String[] args )
    {
        AddressBook addressBook = AddressBook.getInstance();
        
        // Create some sample address book entries.
        AddressBookRecord record1 = new AddressBookRecord( "Mr.", "Tony", "Hawk" );
        AddressBookRecord record2 = new AddressBookRecord();
        record2.setTitle( "Mrs." );
        record2.setFirstName( "Greta" );
        record2.setLastName( "Shaw" );
        
        addressBook.add( record1 );
        addressBook.add( record2 );
        
        addressBook.remove( record2 );
        addressBook.update( record1, record2 );
        
        // Ensure that the size of the address book is correct.
        if( addressBook.size() != 1 ) {
            throw new RuntimeException();   // We should only have one record left.
        }
        
        // Now, try to update a record entry from the address book directly without ungrouping.
        AddressBookRecord myRecord = addressBook.getRecord( 0 );
        
        // Show that myRecord is currently in a group.
        boolean isGrouped = ObjectGroup.isInGroup( myRecord );
        System.out.println( "Object is grouped? " + isGrouped );
        
        // Try to update the record and catch the resulting exception.
        // Note that this is a runtime exception so we need to explicitly catch it.
        try {
            myRecord.setFirstName( "Elizabeth" );
        } catch( ObjectGroupReadOnlyException e ) {
            System.out.println( "ObjectGroupReadOnlyException caught as expected: " + e );
        }
        
        // Clear up the address book to remove remaining entries.
        addressBook.remove( myRecord );
    }
}
