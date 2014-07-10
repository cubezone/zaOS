/*
 * ContactsPersistentContentListener.java
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

import java.util.Vector;
import net.rim.device.api.system.*;


/**
 * Persistent content listener for the Contacts app.  Listens for changes to the 
 * device's Content Protection/Compression security settings and re-encodes the 
 * database accordingly.  Changes to the device's state are ignored.
 */
/*package*/ final class ContactsPersistentContentListener implements PersistentContentListener
{
    /**
     * Called when the state of the device changes (unlocked/locking/locked insecure/
     * locked secure). This app doesn't care about these state changes because data 
     * is always encoded inside the contact models; thus, there is no need to encode
     * or decode them during locking and unlocking.
     * 
     * @param state The device's new state.
     * 
     * @see net.rim.device.api.system.PersistentContentListener#persistentContentStateChanged(int)
     */
    public void persistentContentStateChanged( int state ) 
    {
        // Ignored
    }
    
    
    /**
     * Called when the device's Content Protection/Compression security settings are 
     * changed. Re-encodes the Contacts app's database accordingly (if one exists).
     * 
     * @param generation Used to determine if the user has changed the content protection 
     * settings since the listener was notified.
     * 
     * @see net.rim.device.api.system.PersistentContentListener#persistentContentModeChanged(int)
     */
    public void persistentContentModeChanged( int generation ) 
    {
        PersistentObject persist = PersistentStore.getPersistentObject( 0x8c746bdb8fb74512L ); // com.rim.samples.device.contactsdemo
        
        // No persistent object found; nothing to re-encode.
        if ( persist == null ) 
        {  
            return;
        }
        
        synchronized( persist ) 
        {
            Vector models = (Vector) persist.getContents();
            
            // Database is empty; nothing to re-encode.
            if ( models == null ) 
            {  
                return;
            }
            
            int numModels = models.size();
            
            for ( int i = 0; i < numModels; ++i ) 
            {
                ContactModel model = (ContactModel) models.elementAt( i );
                model.reEncode();
                if ( generation != PersistentContent.getModeGeneration() ) 
                {
                    // Device's Content Protection/Compression security settings have changed again
                    // since the listener was last notified.  Abort this re-encoding because it will
                    // have to be done again anyway according to the new Content Protection/Compression
                    // security settings.
                    break;
                }
            }
            
            persist.commit();  // Commit the updated database to the persistent store.
        }
    }
}
