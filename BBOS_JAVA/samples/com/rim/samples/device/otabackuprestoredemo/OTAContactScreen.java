/**
 * OTAContactScreen.java
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
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;
import net.rim.device.api.system.*;
import net.rim.device.api.util.*;

public final class OTAContactScreen extends MainScreen
{
    // Members ------------------------------------------------------------------
    private EditField _first, _last, _email;
    private int _uid = -1;
    private SaveMenuItem _saveMenuItem;   
    private BackMenuItem _backMenuItem; 
    private OTAContactData _contact;
    
    // Inner Classes ------------------------------------------------------------    
    private class SaveMenuItem extends MenuItem
    {
        private SaveMenuItem()
        {
            super("Save" , 100000, 5);
        }
        
        public void run()
        {            
            // If successful, return to contact list.
            if (onSave())
            {
                UiApplication uiapp = UiApplication.getUiApplication();
                uiapp.popScreen(uiapp.getActiveScreen());
            }
        }
    }
    
    private static class BackMenuItem extends MenuItem
    {
        private BackMenuItem()
        {
            super("Back" , 100000, 5);
        }
        
        public void run()
        {
            UiApplication uiapp = UiApplication.getUiApplication();
            uiapp.popScreen(uiapp.getActiveScreen());
        }
    }
    
    // Constructor
    public OTAContactScreen() 
    {
        _saveMenuItem = new SaveMenuItem();
        
        setTitle(new LabelField("Contact" , LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH));
        
        _first = new EditField("First: " , "");
        add(_first);
        
        _last = new EditField("Last: " , "");
        add(_last);
        
        _email = new EditField("Email: " , "", BasicEditField.DEFAULT_MAXCHARS, BasicEditField.FILTER_EMAIL);
        add(_email);
    }
    
    public OTAContactScreen(OTAContactData contact, boolean editable)
    {
        this();
        
        _backMenuItem = new BackMenuItem();
        
        _contact = contact;
        _first.setText(_contact.getFirst());
        _first.setEditable(editable);
        _last.setText(_contact.getLast());
        _last.setEditable(editable);
        _email.setText(_contact.getEmail());
        _email.setEditable(editable);
        _uid = contact.getUID();
    }
    
    public OTAContactData getContact()
    {
        return _contact;
    }
    
    /**
     * @see net.rim.device.api.ui.Screen#onSave()
     */
    protected boolean onSave()
    {
        String firstName = _first.getText().trim();
        String lastName = _last.getText().trim();
        String email = _email.getText().trim();
        
        // Check that first or last name and email has been entered.
        if ((firstName.length() == 0 && lastName.length() == 0) || email.length() == 0)
        {
            Dialog.inform("Please enter a first or last name and an email address.");
            
            return false;
        }
        else
        {
            if( _uid == -1 ) 
            {
                // uid == -1 -> This is a new contact.
                _contact = new OTAContactData();
            }
            
            _contact.setFirst(firstName);
            _contact.setLast(lastName);
            _contact.setEmail(email);
         
            return true;        
        }        
    }
    
    // Menu handling ------------------------------------------------------------
    /**
      * @see net.rim.device.api.ui.container.MainScreen#makeMenu(Menu,int)
      */
    protected void makeMenu(Menu menu, int instance)
    {
        // If we are viewing a contact, we aren't able to edit it. In that case we
        // just want a menu item enabling us to go back to the contact list.
        if(_contact == null || _uid != -1)
        {
            menu.add(_saveMenuItem);
        }
        else
        {
            menu.add(_backMenuItem);
        }
        
        super.makeMenu(menu, instance);
    }         
}
