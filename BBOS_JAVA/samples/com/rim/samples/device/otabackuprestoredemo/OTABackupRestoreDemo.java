/**
 * OTABackupRestoreDemo.java
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

package com.rim.samples.device.otabackuprestoredemo;

import java.io.*;
import java.util.*;
import javax.microedition.io.*;
import net.rim.device.api.synchronization.*;
import net.rim.device.api.util.*;
import net.rim.device.api.system.*;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;
import net.rim.device.api.collection.*;

class OTABackupRestoreDemo extends UiApplication implements ListFieldCallback
{
    // Members ------------------------------------------------------------------
    private static ListField _listField;
    private static AddContactAction _addContactAction;

    // Statics ------------------------------------------------------------------
    private static OTABackupRestoreDemo _demo;
    private static OTABackupRestoreContactCollection _contacts;

    // Inner Classes ------------------------------------------------------------    
    private class AddContactAction extends MenuItem
    {
        public AddContactAction()
        {            
            super("Add" , 100000, 10);
        }
     
        public void run()
        {
            OTAContactScreen screen = new OTAContactScreen();
            UiApplication.getUiApplication().pushModalScreen(screen);
            
            OTAContactData contact = screen.getContact();
            
            if (contact != null)
            {
                // Create a unique id for the contact - required for ota sync.
                contact.setUID(UIDGenerator.getUID());
                
                // Add the contact to the collection.
                _contacts.addSyncObject(contact);
            }
            
            reloadContactList();
        }
    }
    
    private static class ViewContactAction extends MenuItem
    {
        private int _index;
        
        public ViewContactAction(int index)
        {
            super("View" , 100000, 5);
            _index = index;
        }
        
        public void run()
        {
            OTAContactScreen screen = new OTAContactScreen(_contacts.contactAt(_index), false);
            UiApplication.getUiApplication().pushModalScreen(screen);
        }
    }
    
    private static class EditContactAction extends MenuItem
    {
        private int _index;
        
        public EditContactAction( int index )
        {
            super( "Edit" , 100000, 6 );
            _index = index;
        }
        
        public void run()
        {
            OTAContactData oldContact = _contacts.contactAt(_index);
            OTAContactScreen screen = new OTAContactScreen( oldContact, true );
            UiApplication.getUiApplication().pushModalScreen( screen );
            
            // Get the newly updated contact.
            OTAContactData newContact = screen.getContact();
            
            // Update the contact in the collection.
            _contacts.updateSyncObject( oldContact, newContact );
        }
    }
    
    private static class OTABackupRestoreDemoScreen extends MainScreen
    {
        
        /**
         * @see net.rim.device.api.ui.container.MainScreen#makeMenu(Menu,int)
         */
        protected void makeMenu(Menu menu, int instance)
        {
            menu.add(_addContactAction);        
            
            menu.addSeparator();
            
            int index = _listField.getSelectedIndex();
            
            if(index >= 0)
            {
                menu.add(new ViewContactAction(index));
                menu.add(new EditContactAction(index));
            }
            
            menu.addSeparator();
            
            super.makeMenu(menu, instance);
        }
    }
                  
    
    // Constructor
    public OTABackupRestoreDemo() 
    {
        
        // Create a new screen for the application.
        OTABackupRestoreDemoScreen screen = new OTABackupRestoreDemoScreen();
                
        _addContactAction = new AddContactAction();
        
        screen.setTitle(new LabelField("OTA Backup/Restore Contacts" , LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH));
        
        _listField = new ListField();        
        _listField.setCallback(this);        
        screen.add(_listField);

        // Push the screen onto the UI stack for rendering.
        pushScreen(screen);        
        
        reloadContactList();
    }    
    
    private boolean reloadContactList()
    {           
            // Refreshes contact list on screen.
            _listField.setSize(_contacts.size());            
            
            return true;            
    }
    
    // ListFieldCallback methods ------------------------------------------------    
    /**
     * @see net.rim.device.api.ui.component.ListFieldCallback#drawListRow(ListField,Graphics,int,int,int)
     */
    public void drawListRow(ListField listField, Graphics graphics, int index, int y, int width) 
    {
        if ( listField == _listField && index < _contacts.size())
        {
            OTAContactData contact = _contacts.contactAt(index);
            String personal = contact.getFirst() + " " + contact.getLast();
            graphics.drawText(personal, 0, y, 0, width);
        }
    }
    
    /**
     * @see net.rim.device.api.ui.component.ListFieldCallback#get(ListField , int)
     */
    public Object get(ListField listField, int index)
    {
        if ( listField == _listField )
        {
            // If index is out of bounds an exception will be thrown, but that's the behaviour
            // we want in that case.
            return _contacts.contactAt(index);
        }
        
        return null;
    }
    
    
    /**
     * @see net.rim.device.api.ui.component.ListFieldCallback#getPreferredWidth(ListField)
     */
    public int getPreferredWidth(ListField listField) 
    {
        // Use all the width of the current LCD.
        return Display.getWidth();
    }
 
 
    /**
     * @see net.rim.device.api.ui.component.ListFieldCallback#indexOfList(ListField , String , int)
     */        
    public int indexOfList(ListField listField, String prefix, int start) 
    {
        return -1; // Not implemented.
    }            
    
    
    public static void main(String[] args) 
    {
        boolean startup = false;
        
        for (int i=0; i<args.length; ++i) 
        {
            if (args[i].startsWith("init")) 
            {
                startup = true;
            }
        }
        
        // Get the collection enabled for ota backup/restore.
        _contacts = OTABackupRestoreContactCollection.getInstance();
             
        if (startup) 
        {
            // Enable app for synchronization.
            SyncManager.getInstance().enableSynchronization(_contacts);                 
        }
        else 
        {            
            OTABackupRestoreDemo app = new OTABackupRestoreDemo();
            app.enterEventDispatcher();
        }
    }       
}
