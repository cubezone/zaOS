/*
 * KeywordFilterDemoScreen.java
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

package com.rim.samples.device.keywordfilterdemo;

import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;
import net.rim.device.api.system.*;
import net.rim.device.api.collection.*;

/**
 * This class represents the main screen for the KeywordFilterDemo application.
 */ 
final class KeywordFilterDemoScreen extends MainScreen
{
    private KeywordFilterDemo _app;
    private PopupScreen _popUp; 
    private EditField _addElementField;    
    private KeywordFilterField _keywordFilterField;    
    
    //Constructor
    /**
     * Creates a new KeywordFilterDemoScreen.
     * @param app The UiApplication creating an instance of this class.
     */
    KeywordFilterDemoScreen(KeywordFilterDemo app)
    {
        // A reference to the UiApplication instance for use in this class.
        _app = app;
        
        // We need a reference to the UiApplication's KeywordFilterField.        
        _keywordFilterField = _app.getKeywordFilterField();
        
        // Add menu item to the screen's menu.
        addMenuItem(addElementItem);
    }
    
    /**
     * Intercepts the ENTER key and displays info screen. 
     * @see net.rim.device.api.ui.Screen#keyChar(char,int,int)
     */   
    protected boolean keyChar(char key, int status, int time)
     {
         if (key == Characters.ENTER)
        {
            displayInfoScreen();           
            return true; // We've consumed the event.    
        }             
        return super.keyChar(key, status, time);
    }    
    
    /**
     * Handles a trackball click.
     * @see net.rim.device.api.ui.Screen#invokeAction(int)
     */
    public boolean invokeAction(int action)
    {        
        switch(action)
        {
            case ACTION_INVOKE: // Trackball click.
                displayInfoScreen();                
                return true; // We've consumed the event.
        }    
        return  super.invokeAction(action);
    }
    
    /**
     * Creates an InfoScreen instance and pushes it onto the
     * stack for rendering.
     */
    void displayInfoScreen()
    {
        // Retrieve the selected Country and use it to invoke a new InfoScreen.        
        Country country = (Country)_keywordFilterField.getSelectedElement(); 
        if(country != null)
        {            
            InfoScreen infoScreen = new InfoScreen(country);
            _app.pushScreen(infoScreen);  
        }
    }
    
    // Inner classes------------------------------------------------------------   
        
    final MenuItem addElementItem = new MenuItem("Add country", 0, 0)
    {       
        public void run()
        { 
            // Clear the search field.
            _keywordFilterField.setKeyword("");             
             
            // Create a Dialog instance which will allow a user to add a new
            // country to the keyword list.
            String[] selections = {"Add","Cancel"};            
            Dialog addDialog = new Dialog("Add Country", selections, null, 0, null);           
            EditField inputField = new EditField("Country: ","");            
            addDialog.add(inputField);           
            
            // Display the dialog and add a new element to the list
            // of countries.
            if(addDialog.doModal() == 0) // User selected "Add".
            {
                _app.addElementToList(new Country(inputField.getText(),"",""));                                                     
            }
        }
    }; 
    
    // A MainScreen class to display secondary information for a
    // selected country.
    private final static class InfoScreen extends MainScreen
    {
        // Constructor
        public InfoScreen(Country country)
        {  
            // Set up and display UI elements.          
            setTitle(country.toString());            
            BasicEditField popField = new BasicEditField("Population: ",country.getPopulation(),20,Field.NON_FOCUSABLE);
            BasicEditField capField = new BasicEditField("Capital: ",country.getCapitalCity(),20,Field.NON_FOCUSABLE);
            add(popField);
            add(capField);
        }        
    }        
}
