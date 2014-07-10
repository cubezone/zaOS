/**
 * ContactScreen.java
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

package com.rim.samples.device.syncdemo;

import java.io.*;
import java.util.*;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;
import net.rim.device.api.system.*;
import net.rim.device.api.util.*;

public final class ContactScreen extends MainScreen
{
    // Members ------------------------------------------------------------------
    private EditField _first, _last, _email;
    private SaveMenuItem _saveMenuItem;    
    private ContactData _contact;
    
    // Inner classes ------------------------------------------------------------    
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
    
    // Constructor
    public ContactScreen() 
    {
        _saveMenuItem = new SaveMenuItem();
        
        setTitle(new LabelField("Add Contact" , LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH));
        
        _first = new EditField("First: " , "");
        add(_first);
        
        _last = new EditField("Last: " , "");
        add(_last);
        
        _email = new EditField("Email: " , "", BasicEditField.DEFAULT_MAXCHARS, BasicEditField.FILTER_EMAIL);
        add(_email);
        
        addMenuItem(_saveMenuItem);
    }
    
    public ContactData getContact()
    {
        return _contact;
    }
    
    /**
     *
     * @see net.rim.device.api.ui.Screen#onSave()
     */
    protected boolean onSave()
    {
        String firstName = _first.getText().trim();
        String lastName = _last.getText().trim();
        String email = _email.getText().trim();
        
        // Check that first or last name and email has been entered.
        if (( firstName.length() == 0 && lastName.length() == 0 ) || email.length() == 0)
        {
            Dialog.inform("First or Last Name and Email required");
            return false;
        }
        else
        {
            _contact = new ContactData();
            
            _contact.setFirst(firstName);
            _contact.setLast(lastName);
         
            return true;        
        }        
    }

}
