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

package com.rim.samples.device.blackberry.pim;

import java.io.*;
import java.util.*;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;
import net.rim.device.api.system.*;
import net.rim.device.api.util.*;

// The pim packages .
import javax.microedition.pim.*;
import net.rim.blackberry.api.pdap.*;

public final class ContactScreen extends MainScreen 
{
    // Members ------------------------------------------------------------------
    private EditField _first, _last, _email, _home, _home2;
    private SaveMenuItem _saveMenuItem;    
    
    // Inner classes ------------------------------------------------------------    
    private class SaveMenuItem extends MenuItem
    {
        private SaveMenuItem()
        {
            super("Save Contact" , 100000, 5);
        }
        
        public void run()
        {            
            // If successful, return to contact list.
            if(onSave())
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
        
        setTitle(new LabelField("Create Contact" , LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH));
        
        _first = new EditField("First: " , "");
        add(_first);
        
        _last = new EditField("Last: " , "");
        add(_last);
        
        _email = new EditField("Email: " , "", BasicEditField.DEFAULT_MAXCHARS, BasicEditField.FILTER_EMAIL);
        add(_email);
        
        _home = new EditField("Home: " , "", BasicEditField.DEFAULT_MAXCHARS, BasicEditField.FILTER_PHONE);
        add(_home);
        
        _home2 = new EditField("Home2: " , "", BasicEditField.DEFAULT_MAXCHARS, BasicEditField.FILTER_PHONE);
        add(_home2);
        
        addMenuItem(_saveMenuItem);
    }
    
    /**
     * @see net.rim.device.api.ui.Screen#onSave()
     */
    protected boolean onSave()
    {
        String firstName = _first.getText().trim();
        String lastName = _last.getText().trim();
        String email = _email.getText().trim();
        String home = _home.getText().trim();
        String home2 = _home2.getText().trim();
        
        // Check that first or last name and email has been entered.
        if((firstName.length() == 0 && lastName.length() == 0) || email.length() == 0)
        {
            Dialog.inform("First or Last Name and Email required");
            
            return false;
        }
        else
        {
            // Save the contact.
            try 
            {
                ContactList contactList = (ContactList)PIM.getInstance().openPIMList(PIM.CONTACT_LIST, PIM.WRITE_ONLY);
                Contact contact = contactList.createContact();               
                String[] name = new String[contactList.stringArraySize(Contact.NAME)];                
                
                /*
                 * This section adds values to selective PIM items.  Additional items can be added
                 * for Contact or BlackBerryContact fields.  Please refer to javadocs.
                 */
                if(firstName.length() != 0) 
                {
                    name[Contact.NAME_GIVEN] = firstName;
                }
                
                if(lastName.length() != 0)
                {
                    name[Contact.NAME_FAMILY] = lastName;
                }
                
                contact.addStringArray(Contact.NAME, Contact.ATTR_NONE, name);
                
                if(home.length() != 0)
                {
                    contact.addString(Contact.TEL,Contact.ATTR_HOME,home);
                }
                
                if(home2.length() != 0)
                {
                    contact.addString(Contact.TEL,BlackBerryContact.ATTR_HOME2,home2);
                }
                
                if(email.length() != 0)
                {
                    // Perform email validation here.
                    contact.addString(Contact.EMAIL, Contact.ATTR_HOME, email);
                }             
                                
                // Persist data to contact list.
                contact.commit();                
                
                // Instruct caller to return to contact list.
                return true;
            }
            catch (PIMException e)
            {
                return false;
            }
        }        
    }   
}
