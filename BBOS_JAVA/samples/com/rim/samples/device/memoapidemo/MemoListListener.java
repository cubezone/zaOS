/*
 * MemoListListener.java
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

package com.rim.samples.device.memoapidemo;

import javax.microedition.pim.*;
import net.rim.blackberry.api.pdap.*;

/**
 * Simple listener that prints status message to standard output when 
 * PIMList events occur.
 */
/*package*/ final class MemoListListener implements PIMListListener
{
    
    /**
     * Called when a memo is added to the memo list. 
     * @param item The memo that was added.
     */
    public void itemAdded( PIMItem item ) 
    {
        StringBuffer buffer = new StringBuffer("The following memo was added:");
        addMemoInfo( buffer, item );
        System.out.println( buffer.toString() );
    }    
    
    /**
     * Called when a memo is removed from the memo list. 
     * @param item The memo that was removed.
     */
    public void itemRemoved( PIMItem item ) 
    {
        StringBuffer buffer = new StringBuffer("The following memo was removed:");
        addMemoInfo( buffer, item );
        System.out.println( buffer.toString() );
    }    
    
    /**
     * Called when a memo is replaced with another memo. 
     * @param oldItem The memo being replaced.
     * @param newItem The replacement memo.
     */
    public void itemUpdated( PIMItem oldItem, PIMItem newItem ) 
    {
        StringBuffer buffer = new StringBuffer("The following memo was replaced:");
        addMemoInfo( buffer, oldItem );
        buffer.append("\n\n");
        buffer.append("The replacement memo is:");
        addMemoInfo( buffer, newItem );
        System.out.println( buffer.toString() );
    }    
    
    /**
     * Convenience method to add a memo's information to a string buffer. 
     * @param buffer The string buffer to hold the memo's information.
     * @param memo The memo whose information is being added to the string buffer.
     */
    private void addMemoInfo( StringBuffer buffer, PIMItem memo ) 
    {
        PIMList list = memo.getPIMList();
        
        if ( memo.countValues( BlackBerryMemo.TITLE ) > 0 ) 
        {
            buffer.append( "\n" );
            buffer.append( list.getFieldLabel( BlackBerryMemo.TITLE ) + ": " );
            buffer.append( memo.getString( BlackBerryMemo.TITLE, 0 ) );
        }
        
        if ( memo.countValues( BlackBerryMemo.UID ) > 0 ) 
        {
            buffer.append( "\n" );
            buffer.append( list.getFieldLabel( BlackBerryMemo.UID ) + ": " );
            buffer.append( memo.getString( BlackBerryMemo.UID, 0 ) );
        }
        
        if ( memo.countValues( BlackBerryMemo.NOTE ) > 0 ) 
        {
            buffer.append( "\n" );
            buffer.append( list.getFieldLabel( BlackBerryMemo.NOTE ) + ": " );
            buffer.append( memo.getString( BlackBerryMemo.NOTE, 0 ) );
        }
    }
}
