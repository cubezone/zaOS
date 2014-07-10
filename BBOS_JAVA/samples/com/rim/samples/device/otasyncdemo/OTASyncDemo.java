/*
 * OTASyncDemo.java
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

package com.rim.samples.device.otasyncdemo;

import java.io.*;
import java.util.*;
import javax.microedition.io.*;
import net.rim.device.api.synchronization.*;
import net.rim.device.api.util.*;
import net.rim.device.api.system.*;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;

/**
 * Sample to demonstrate synchronization of contact data with a simulated BES environment.
 * This sample requires the BlackBerry Sync Server SDK  and the BlackBerry Email 
 * and MDS Services Simulators, available from www.blackberry.com/developers.  
 * For more information on how to use this sample see the Synchronization Server
 * SDK Development Guide bundled with the BlackBerry Sync Server SDK. 
 */

class OTASyncDemo extends UiApplication implements ListFieldCallback
{
    // Members ------------------------------------------------------------------
    private ListField _listField;
    private AddContactAction _addContactAction;
    private RefreshAction _refreshAction;
    
    // Statics ------------------------------------------------------------------
    private static OTAContactCollection _otaContactCollection;
    private static OTASyncDemo _syncDemo;

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
                contact.setGUID( UIDGenerator.getUID() );
                _otaContactCollection.addSyncObject( contact );
            }
            
            reloadContactList();
        }
    }
    
    private class EditContactAction extends MenuItem
    {
        private int _contactIndex;
        
        public EditContactAction( int contactIndex ) 
        {
            super("Edit" , 100000, 10);
            _contactIndex = contactIndex;
        }
        
        public void run() 
        {
            OTAContactData oldContactData = (OTAContactData)_otaContactCollection.getAt(_contactIndex);
            OTAContactScreen screen = new OTAContactScreen( oldContactData );
            UiApplication.getUiApplication().pushModalScreen( screen );
            
            OTAContactData newContactData = screen.getContact();
            
            if( newContactData != null ) 
            {
                _otaContactCollection.updateSyncObject( oldContactData, newContactData );
            }
            
            reloadContactList();
        }
    }
    
    private class DeleteContactAction extends MenuItem 
    {
        private int _deleteIndex;
        
        public DeleteContactAction( int deleteIndex ) 
        {
            super("Delete" , 100000, 10 );
            _deleteIndex = deleteIndex;
        }
        
        public void run() 
        {
            _otaContactCollection.removeSyncObject( (SyncObject)_otaContactCollection.getAt(_deleteIndex) );
            reloadContactList();
        }
    }
    
    private class RefreshAction extends MenuItem 
    {
        public RefreshAction() 
        {
            super("Refresh" , 100000, 10 );
        }
        
        public void run() 
        {
            reloadContactList();
        }
    }
    
    private class OTASyncDemoScreen extends MainScreen
    {
        
        /**
         * @see net.rim.device.api.ui.container.MainScreen#makeMenu(Menu,int)
         */
        protected void makeMenu(Menu menu, int instance)
        {
            menu.add(_addContactAction);
            menu.add(_refreshAction);
            
            if( _otaContactCollection.getSyncObjectCount() > 0 ) 
            {
                EditContactAction _editContactAction = new EditContactAction( _listField.getSelectedIndex() );
                menu.add( _editContactAction );
                
                DeleteContactAction _deleteContactAction = new DeleteContactAction ( _listField.getSelectedIndex() );
                menu.add( _deleteContactAction );
            }        
            
            menu.addSeparator();
            
            super.makeMenu(menu, instance);
        }
    }
            
    
    // Constructor
    public OTASyncDemo() 
    {
        // Create a new screen for the application.
        OTASyncDemoScreen screen = new OTASyncDemoScreen();
                
        _addContactAction = new AddContactAction();
        _refreshAction = new RefreshAction();
        
        screen.setTitle(new LabelField("OTA Sync Demo Contacts" , LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH));
        
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
            _listField.setSize(_otaContactCollection.getSyncObjectCount());            
            
            return true;            
    }    
    
    // ListFieldCallback methods ------------------------------------------------
    /**
     * @see net.rim.device.api.ui.component.ListFieldCallback#drawListRow(ListField,Graphics,int,int,int)
     */
    public void drawListRow(ListField listField, Graphics graphics, int index, int y, int width) 
    {
        if ( listField == _listField && index < _otaContactCollection.getSyncObjectCount())
        {
            OTAContactData contact = (OTAContactData)_otaContactCollection.getAt(index);
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
            // If index is out of bounds an exception will be thrown, but that's the
            // behaviour we want in that case.
            return _otaContactCollection.getAt(index);
        }
        
        return null;
    }
    
    /**
     * @see net.rim.device.api.ui.component.ListFieldCallback#getPreferredWidth(ListField)
     */
    public int getPreferredWidth(ListField listField) 
    {
        // use all the width of the current LCD
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
        
        _otaContactCollection = OTAContactCollection.getInstance();
             
        if (startup) 
        {
            // Enable app for synchronization.
            SyncManager.getInstance().enableSynchronization( _otaContactCollection );                 
        }
        else 
        {
            OTASyncDemo app = new OTASyncDemo();
            app.enterEventDispatcher();
        }
    }       
}
