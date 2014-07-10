/*
 * ViewMemoScreen.java
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

import net.rim.blackberry.api.pdap.*;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;

/**
 * Screen for viewing a memo.
 */
/*package*/ final class ViewMemoScreen extends MainScreen
{
    private MemoController _controller;
    
    private MenuItem _editItem = new EditItem();
    
        
    /**
     * Constructor.  Displays the provided memo's information on the screen.
     *  
     * @param memo The memo to view.
     */
    /*package*/ ViewMemoScreen( BlackBerryMemo memo ) 
    {
        super();
        
        _controller = new MemoController( memo );
        
        // Set the screen's title.
        Field title = (Field) _controller.render( MemoController.FOR_TITLE );
        setTitle( title );
        
        // Add the various memo fields to the screen.
        Field[] fields = (Field[]) _controller.render( MemoController.FOR_VIEW );
        
        for ( int i = 0; i < fields.length; ++i ) 
        {
            add( fields[i] );
        }
        
        // Add the menu item to the screen.
        addMenuItem( _editItem);
    }
    
    ///////////////////////////////////////
    // INNER CLASSES
    ///////////////////////////////////////    
    
    /**
     * Menu item to edit this screen's memo.
     */
    private final class EditItem extends MenuItem
    {
        /**
         * Constructor. 
         * @param memo The memo to edit.
         */
        private EditItem() 
        {
            super("Edit Memo" , 100, 100 );
        }        
        
        /**
         * Pushes an edit screen to the display stack, passing it the memo to edit.  Upon
         * returning from the edit screen, the view screen is popped as well. The user is
         * returned to the main screen.
         */
        public void run() 
        {
            UiApplication app = UiApplication.getUiApplication();
            app.pushModalScreen( new EditMemoScreen( _controller.getMemo(), false ) );  // Blocks until edit screen is popped.
            app.popScreen( ViewMemoScreen.this );  // Now that edit screen is popped, pop this view screen as well.
        }
    }
}
