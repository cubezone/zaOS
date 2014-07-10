/**
 * ContactsDemo.java
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

import net.rim.device.api.system.*;
import net.rim.device.api.ui.container.*;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.util.*;
import java.util.*;

/**
 * A simple sample program that exemplifies use of persistent objects and content 
 * protection.
 */
public class ContactsDemo extends UiApplication implements Context
{
    public static void main(String[] args)
    {
        if ( args.length == 1 && args[0].equals( "autostartup" ) ) 
        {
            // App is being run automatically as a system module at startup, so register a 
            // persistent content listener.
            PersistentContent.addListener( new ContactsPersistentContentListener() );
        } 
        else 
        {
            // App is being run from the ribbon, so execute normally.
            new ContactsDemo().enterEventDispatcher();
        }
    }

    // Members -----------------------------------------------------------------
    private ContactsDemoScreen _mainScreen;
    private ListField _list;
    private MenuItem _closeItem;

    // Statics -----------------------------------------------------------------
    private static PersistentObject _persist;
    private static ContactsDb _db;

    static 
    {
        _persist = PersistentStore.getPersistentObject( 0x8c746bdb8fb74512L ); // com.rim.samples.device.contactsdemo
        
        synchronized( _persist ) 
        {
            if( _persist.getContents() == null ) 
            {
                _persist.setContents( new Vector() );
                _persist.commit();
            }
        }
        
        _db = new ContactsDb( (Vector) _persist.getContents() );
    }


    // Inner classes -----------------------------------------------------------
    /**
     * <p>A holder for a vector of Contact objects.
     * <p>This class acts as a container for the list of contacts and also
     * renders the items to the screen by invoking the contact controller.rener()
     * method with the FOR_LIST hint.
     */
    private static class ContactsDb implements ListFieldCallback
    {
        private Vector _listOfItems;
        private ContactController _controller;

        public ContactsDb( Vector listOfItems )
        {
            _listOfItems = listOfItems;
            _controller = new ContactController();
        }

        public int getNumItems()
        {
            return _listOfItems.size();
        }

        public ContactModel get(int index)
        {
            return (ContactModel)_listOfItems.elementAt(index);
        }

        // Implementations of the ListFieldCallback methods
        /**
         * @see net.rim.device.api.ui.component.ListFieldCallback#drawListRow(ListField,Graphics,int,int,int)
         */
        public void drawListRow(ListField listField, Graphics graphics, int index, int y, int width)
        {
            // Called by the list field when a particular row requires painting.
            if ( index >= _listOfItems.size() )
            {
                // Don't do anything, we don't have that many items.
                return;
            }

            // Load the controller with the item we're interested in.
            _controller.load((ContactModel)_listOfItems.elementAt(index));

            // Draw a list representation.
            graphics.drawText((String)_controller.render(FOR_LIST), 0, y, 0, width);
        }
        
        
        /**
         * @see net.rim.device.api.ui.component.ListFieldCallback#get(ListField , int)
         */
        public Object get(ListField listField, int index)
        {
            // Gets the Object representation for the requested element.
            return (Object)_listOfItems.elementAt(index);
        }
        
        
        /**
         * @see net.rim.device.api.ui.component.ListFieldCallback#getPreferredWidth(ListField)
         */        
        public int getPreferredWidth(ListField listField)
        {
            // Called by the list field.
            return Display.getWidth();
        }
        
        
        /**
         * @see net.rim.device.api.ui.component.ListFieldCallback#indexOfList(ListField , String , int)
         */   
        public int indexOfList(ListField listField, String prefix, int start)
        {
            // Called by the list field to find the first element that starts with a 
            // given prefix.
            return 0; // Not implemented.
        }

        /**
         * Commit a new contact to the persistent store
         */
        public void commit(ContactModel model)
        {
            if ( !_listOfItems.contains(model) )
            {
                _listOfItems.addElement(model);
            }
            
            PersistentObject.commit(_listOfItems);
        }


    }

    /**
     * ContactController
     * The controller for rendering contact models.
     */
    private static class ContactController
    {
        // Data
        private AutoTextEditField _firstNameField;
        private AutoTextEditField _lastNameField;
        private EditField _emailField;
        private EditField _phoneField;

        private ContactModel _theModel;

        public ContactController()
        {
            this (null);
        }

        public ContactController(ContactModel model)
        {
            _firstNameField = new AutoTextEditField("First: " , "");
            _lastNameField = new AutoTextEditField("Last: " , "");
            _emailField = new EditField("Email: " , "", Integer.MAX_VALUE, BasicEditField.FILTER_DEFAULT);
            _phoneField = new EditField("Phone: " , "", Integer.MAX_VALUE, BasicEditField.FILTER_PHONE);
            load(model);
        }

        public boolean load(ContactModel model)
        {
            if ( null == model )
            {
                // Create a new model.
                _theModel = new ContactModel();
            }
            else
            {
                _theModel = model;
                
                _firstNameField.setText(model.getField(ContactModel.FIRST_NAME));
                _lastNameField.setText(model.getField(ContactModel.LAST_NAME));
                _emailField.setText(model.getField(ContactModel.EMAIL_ADDRESS));
                _phoneField.setText(model.getField(ContactModel.PHONE_NUMBER));
            }
            
            return true;
        }

        public Object render(int context)
        {
            Object o = null;
            switch (context)
            {
                case FOR_READ:
                    {
                        // Set all the objects to read only.
                        setEditable(false);
                        Object[] array = {_emailField, _phoneField}; // The names are part of the title.
                        o = new ObjectEnumerator(array);
                    }
                    break;
                    
                case FOR_EDIT:
                    {
                        setEditable(true);
                        Object[] array = {_firstNameField, _lastNameField, _emailField, _phoneField};
                        o = new ObjectEnumerator(array);
                    }
                    break;
                    
                case FOR_TITLE:
                
                case FOR_LIST:
                    o = _theModel.getField(ContactModel.FIRST_NAME) + " " + _theModel.getField(ContactModel.LAST_NAME);
                    break;
            }
            
            return o;
        }

        private void setEditable(boolean flag)
        {
            _firstNameField.setEditable(flag);
            _lastNameField.setEditable(flag);
            _emailField.setEditable(flag);
            _phoneField.setEditable(flag);
        }

        /**
         * Commits the object to the device's persistent store.
         */
        public void commit()
        {
            // Store the data from the fields.
            _theModel.setField(ContactModel.FIRST_NAME, _firstNameField.getText());
            _theModel.setField(ContactModel.LAST_NAME, _lastNameField.getText());
            _theModel.setField(ContactModel.EMAIL_ADDRESS, _emailField.getText());
            _theModel.setField(ContactModel.PHONE_NUMBER, _phoneField.getText());
            _db.commit(_theModel);
        }

    }

    /**
     * Menu items - runnables.
     */

    /**
     * Add item - adds a new menu item to the mix.
     */
    private class Add extends MenuItem
    {
        private ContactModel _model;

        public Add()
        {
            super("Add" , 100, 10);
            
            // Create the new model.
            _model = new ContactModel();
        }

        public void run()
        {
            ContactController controller = new ContactController(_model);

            // Create a new screen for add.
            final MainScreen screen = new MainScreen()
            {
                
               /**
                 * Prevent the save dialog from being displayed.
                 * 
                 * @see net.rim.device.api.ui.container.MainScreen#onSavePrompt()
                 */
                public boolean onSavePrompt()
                {
                    return true;
                }  
                
            };
            
                
            screen.setTitle(new LabelField("New Contact"));

            // Get the various fields for edit.
            for ( Enumeration e = (Enumeration)controller.render(FOR_EDIT); e.hasMoreElements() ;)
            {
                screen.add((Field)e.nextElement());
            }

            // Create menu items.
            MenuItem saveItem = new CookieMenuItem("Save" , 100, 10, controller) 
            {
                public void run() 
                {
                    ((ContactController)_cookie).commit();
                    _list.setSize(_db.getNumItems());
                    
                    popScreen(screen); // A method on the ContactsDemo class.
                }
            };

            MenuItem cancelItem = new CookieMenuItem("Cancel" , 110, 10, controller) 
            {
                public void run() 
                {
                    if ( Dialog.SAVE == Dialog.ask(Dialog.D_SAVE) )
                    {
                        ((ContactController)_cookie).commit();
                        _list.setSize(_db.getNumItems());
                    }
                    
                    popScreen(screen);
                }
            };
            
            // Add them to the screen.
            screen.addMenuItem( saveItem );
            screen.addMenuItem( cancelItem );
            

            pushScreen(screen); // A method on the ContactsDemo class.
        }

    }

    private class Edit extends MenuItem
    {
        private ContactModel _model;

        public Edit(ContactModel model)
        {
            super("Edit" , 100, 10);
            _model = model;
        }

        public void run()
        {
            ContactController controller = new ContactController(_model);

            final MainScreen screen = new MainScreen()
            {
                
               /**
                 * Prevent the save dialog from being displayed.
                 * 
                 * @see net.rim.device.api.ui.container.MainScreen#onSavePrompt()
                 */
                public boolean onSavePrompt()
                {
                    return true;
                }  
                
            };
            
            screen.setTitle(new LabelField("Edit Contact"));

            // Add the save and cancel items.
            // Get the various fields for edit.
            for ( Enumeration e = (Enumeration)controller.render(FOR_EDIT); e.hasMoreElements() ;)
            {
                screen.add((Field)e.nextElement());
            }
            
            // Create menu items.
            MenuItem saveItem = new CookieMenuItem("Save" , 100, 10, controller) 
            {
                public void run() 
                {
                    ((ContactController)_cookie).commit();
                    _list.setSize(_db.getNumItems());
                    
                    popScreen(screen); // A method on the ContactsDemo class.
                }
            };
            

            MenuItem cancelItem = new CookieMenuItem("Cancel" , 110, 10, controller) 
            {
                public void run() 
                {
                    if ( Dialog.SAVE == Dialog.ask(Dialog.D_SAVE) )
                    {
                        ((ContactController)_cookie).commit();
                        _list.setSize(_db.getNumItems());
                    }
                    
                    popScreen(screen);
                }
            };
            
            // Add them to the screen.
            screen.addMenuItem( saveItem );
            screen.addMenuItem( cancelItem );

            pushScreen(screen); // A method on the ContactsDemo class.
        }
    }

    /**
     * View item - views the entry.
     */
    private class View extends MenuItem
    {
        private ContactModel _model;

        public View(ContactModel model)
        {
            super("View" , 100, 10);
            
            _model = model; // Add using a predefined model.
        }

        public void run()
        {
            ContactController controller = new ContactController(_model);

            // Create a new screen for add.
            final MainScreen screen = new MainScreen();
            screen.setTitle(new LabelField(controller.render(FOR_TITLE)));

            // Get the various fields for edit.
            for ( Enumeration e = (Enumeration)controller.render(FOR_READ); e.hasMoreElements() ;)
            {
                screen.add((Field)e.nextElement());
            }

            // Create a menu item.
            Edit edit = new Edit(_model) 
            {
                public void run()
                {
                    popScreen(screen);
                    
                    super.run();
                }
            };

            // Add it to the screen.
            screen.addMenuItem( edit );

            pushScreen(screen); // A method on the ContactsDemo class.

        }

    }
    
    private class ContactsDemoScreen extends MainScreen
    {
        /**
         * @see net.rim.device.api.ui.container.MainScreen#makeMenu(Menu,int)
         */
        protected void makeMenu(Menu menu, int instance)
        {
            Add add = new Add();
            menu.add(add);
    
            if ( _db.getNumItems() > 0 )
            {
                View view = new View(_db.get(_list.getSelectedIndex()));
                menu.add(view);
    
                Edit edit = new Edit(_db.get(_list.getSelectedIndex()));
                menu.add(edit);
            }
    
            super.makeMenu(menu, instance);
        }
        
        
    }

    // Class methods ---------------------------------------------------------------------

    public ContactsDemo()
    {
        _mainScreen = new ContactsDemoScreen();

        _mainScreen.setTitle(new LabelField("Contacts Demo" , LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH ));

        // Add the list of contacts.
        _list = new ListField(_db.getNumItems());
        _list.setCallback(_db);
        _mainScreen.add(_list);

        pushScreen(_mainScreen); // Push the main screen - a method on the UiApplication class.
    }
}
