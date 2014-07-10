/*
 * ActiveTextFieldsDemo.java
 *
 * Copyright � 1998-2008 Research In Motion Ltd.
 * 
 * Note: For the sake of simplicity, this sample application may not leverage
 * resource bundles and resource strings.  However, it is STRONGLY recommended
 * that application developers make use of the localization features available
 * within the BlackBerry development platform to ensure a seamless application
 * experience across a variety of languages and geographies.  For more information
 * on localizing your application, please refer to the BlackBerry Java Development
 * Environment Development Guide associated with this release.
 */

package com.rim.samples.device.activetextfieldsdemo;

import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;
import net.rim.device.api.system.*;
import net.rim.blackberry.api.stringpattern.*;
import net.rim.blackberry.api.menuitem.*; 


  /** 
  * Sample to demonstrate functionality of active text fields and PatternRepository 
  * API. Upon startup of device a regular expression is registered with the String
  * Pattern Repository.  If pattern is encountered in an active text field in a 
  * device application, the text will be underlined and specified context menu 
  * items will be available. If a menu item is invoked, this application will be 
  * invoked and a handler screen will display information corresponding to the 
  * matched pattern. This application also provides a GUI demo screen with 
  * an ActiveAutoTextEditField.
  */
public class ActiveTextFieldsDemo extends UiApplication
{
    private static ApplicationMenuItem[] _menuItems = new ApplicationMenuItem[2];
    private RichTextField _trackingNumber; 
    private RichTextField _statusLocation;  
       
    
    /**
     * Entry point for application 
     */  
    public static void main(String[] args)
    {        
        if(args != null && args.length > 0)
        {
            // When device starts we want to register our regular expression in 
            // the PatternRepository.
            if (args[0].equals("autostartup"))
            {
                // Assign menu items to ApplicationMenuItem array.
                _menuItems[0] = statusItem;
                _menuItems[1] = locationItem;          
                
              /*  
              * First we create an ApplicationDescriptor referencing this application. Then we
              * register a regular expression and associate our ApplicationDescriptor along with
              * our menu items. When a nine digit number is typed in an active text field the 
              * matched pattern will be highlighted and the additional menu items will be 
              * available. The menu items will launch an instance of this appplication when 
              * invoked.
              */ 
                ApplicationDescriptor appDesc = new ApplicationDescriptor(ApplicationDescriptor.currentApplicationDescriptor(),"Active Text Fields",new String[]{"pattern-recognized"});
                PatternRepository.addPattern(appDesc,"[0-9]{9}",PatternRepository.PATTERN_TYPE_REGULAR_EXPRESSION,_menuItems);           
            }
            
            // This block will execute when one of our application menu items is invoked.  
            else if(args[0].equals("pattern-recognized"))
            {
                /* We don't want to launch the demo version of this app, we just want to throw up
                   a screen displaying status or location information.  Therefore we pass false 
                   into constructor. */ 
                ActiveTextFieldsDemo app = new ActiveTextFieldsDemo(false);           
                app.enterEventDispatcher();
            }
        }
        
        // This block will execute if the user starts this application from the desktop.
        else 
        { 
            // We want to launch the demo version of this application, pass true to constructor.
            ActiveTextFieldsDemo app = new ActiveTextFieldsDemo(true);           
            app.enterEventDispatcher();
        } 
    }    
    
    
    /**
    * Constructor
    * @param isDemoApp  Flag to indicate whether application was invoked explicitly 
    *                    from the desktop or by invoking a menu item.
    */
    ActiveTextFieldsDemo(boolean isDemoApp)
    {
        
        /* Display a MainScreen that simply allows user to type a 9 digit number into an
           ActiveAutoTextEditField to demonstrate the pattern recognition functionality. */
        if(isDemoApp)
        {
            ActiveTextFieldsScreen demoScreen = new ActiveTextFieldsScreen();
            pushScreen(demoScreen);        
        }
        
       /*If the user invoked one of our application menu items we want to display a 
          MainScreen providing tracking information. */
        else
        {
            
            HandlerScreen handlerScreen = new HandlerScreen();
            pushScreen(handlerScreen);
            
            /* When this application is launched we want to make it visible by bringing
              it to the foreground. */
            ApplicationManager.getApplicationManager().requestForeground(getProcessId());
        }
    }
    
    /* Anonymous inner classes to extend abstract class ApplicationMenuItem.  The run()
    *  method will execute upon selection of the menu item.  In a real world situation
    *  the application would send the highlighted transaction number back to a server 
    *  and retrieve the status and location information.
    */ 
    static ApplicationMenuItem statusItem = new ApplicationMenuItem(0)
    {
        
       /**
        * Sets the label and text in the display fields of the handler screen.
        * 
        * @param context The String representation of the context object is displayed.
        */  
        public Object run(Object context)
        {
            ((ActiveTextFieldsDemo)UiApplication.getUiApplication())._trackingNumber.setLabel("Status for tracking No: ");
            ((ActiveTextFieldsDemo)UiApplication.getUiApplication())._trackingNumber.setText(context.toString());
            ((ActiveTextFieldsDemo)UiApplication.getUiApplication())._statusLocation.setText("< In Progress >");
            return null;
        }
        
        public String toString()
        {
            return "Status";   
        }
    };
    
    static ApplicationMenuItem locationItem = new ApplicationMenuItem(1) 
    {
        /**
        * Sets the label and text in the display fields of the handler screen.
        * 
        * @param context The String representation of the context object is displayed.
        */  
        public Object run(Object context)
        {
            ((ActiveTextFieldsDemo)UiApplication.getUiApplication())._trackingNumber.setLabel("Location for tracking No: ");
            ((ActiveTextFieldsDemo)UiApplication.getUiApplication())._trackingNumber.setText(context.toString());
            ((ActiveTextFieldsDemo)UiApplication.getUiApplication())._statusLocation.setText("< 39.3� N 76.6� W >");
            return null;
        }
        public String toString()
        {
            return "Location";   
        }
    };   
    
    
    /**
    * The screen that is displayed when one of our application menu items is invoked.
    */
    final class HandlerScreen extends MainScreen 
    {
       
       // Constructor
       public HandlerScreen()
       {            
           // Set the screen title.
           setTitle("Active Text Fields Handler");
            
           // These are the fields that will display the tracking information.
           _trackingNumber = new RichTextField();            
           add(_trackingNumber);
           _statusLocation = new RichTextField();
           add(_statusLocation);                    
       }                    
    }      
}

/**
* The screen for the demo version of this application.
*/
final class ActiveTextFieldsScreen extends MainScreen 
{
    
    // Constructor    
    public ActiveTextFieldsScreen()
    {        
        // Set the screen title.
        setTitle("Active Text Fields Demo");
        
        // Add instructions.
        add(new RichTextField("Type a nine digit number in the Transaction No. field. Pattern will be hyperlinked and status and location menu items will be available.\n"));
                    
        // Add an ActiveAutoTextEditField.
        ActiveAutoTextEditField activeField = new ActiveAutoTextEditField("Transaction No: ", null);
        add(activeField);
        activeField.setFocus();            
    }
    
    /**
     * Prevent the save dialog from being displayed.
     * 
     * @see net.rim.device.api.ui.container.MainScreen#onSavePrompt()
     */
    public boolean onSavePrompt()
    {
        return true;
    }                  
}  
