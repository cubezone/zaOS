/*
 * EditMemoScreen.java
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

package com.rim.samples.device.memoapidemo;

import java.io.*;
import net.rim.blackberry.api.pdap.*;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;

/**
 * Screen that allows a memo to be edited.  Used for both new and existing memos.
 */
/*package*/ final class EditMemoScreen extends MainScreen
{
    private MemoController _controller;
    private SaveItem _saveMenuItem = new SaveItem();
      
    /**
     * Constructor.  Adds an appropriate title, depending on whether we're creating
     * a new memo or editing an existing one.  It then adds the memo's fields to the
     * screen so the user can edit the memo content.
     * 
     * @param memo The memo being created or edited.
     * @param newMemo True if a new memo is being created; false if an existing memo 
     *                is being edited.
     */
    /*package*/ EditMemoScreen( BlackBerryMemo memo, boolean newMemo ) 
    {
        super();
        
        _controller = new MemoController( memo );
        
        String title;
        
        if ( newMemo ) 
        {
            title = "Add Memo" ;
        } 
        else 
        {
            title = "Edit Memo" ;
        }
        
        setTitle( new LabelField( title, LabelField.USE_ALL_WIDTH | LabelField.ELLIPSIS ) );
        
        Field[] fields = (Field[]) _controller.render( newMemo ? MemoController.FOR_ADD : MemoController.FOR_EDIT );
        
        for ( int i = 0; i < fields.length; ++i ) 
        {
            add( fields[i] );
        }
        
        // Add the menu item.
        addMenuItem( _saveMenuItem );
    }
    
    /**
     * Override superclass's method to provide custom validation of screen data. 
     * We could have done this by extending LabelField and overriding isDataValid()
     * there. In that case, this method would not be necessary since 
     * Screen.isDataValid() calls all of it's child field's isDataValid() methods. 
     * 
     * @return True if screen data is valid; otherwise false;
     */
    public boolean isDataValid() 
    {
        // Can't save a memo without a title.
        LabelField title = (LabelField) _controller.render( MemoController.FOR_TITLE );
        
        if ( title.getText().length() == 0 ) 
        {
            Dialog.alert("Title must have a value.");
            return false;
        }        
        return true;
    }    
    
    /**
     * Saves the screen's data to its associated memo, and commits the memo to 
     * persistent storage. 
     * 
     * @throws IOException if a problem was encountered while committing the memo.
     */
    public void save() throws IOException 
    {
        _controller.updateMemo();
        
        if ( ! _controller.commitMemo() ) 
        {
            throw new IOException();
        }
    }    
    
    /////////////////// INNER CLASSES /////////////////////////////    
    
    /**
     * Represents a menu item for saving the screen's memo.
     */
    private final class SaveItem extends MenuItem
    {
        /**
         * Constructor.
         */
        private SaveItem() 
        {
            super("Save Memo" , 100, 100 );
        }        
        
        /**
         * Attempts to save the screen's data to its associated memo. If successful, 
         * the edit screen is popped from the display stack.
         */
        public void run() 
        {
            if ( EditMemoScreen.this.onSave() ) 
            {
                UiApplication.getUiApplication().popScreen( EditMemoScreen.this );
            }
        }
    }
}
