/*
 * MemoController.java
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

import javax.microedition.pim.*;
import net.rim.blackberry.api.pdap.*;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;

/**
 * Provides access to a memo's data via fields that can be displayed on a screen.
 */
/*package*/ final class MemoController
{
    /*package*/ static final int FOR_VIEW = 0;
    /*package*/ static final int FOR_EDIT = 1;
    /*package*/ static final int FOR_TITLE = 2;
    /*package*/ static final int FOR_ADD = 3;
    
    /*package*/ BlackBerryMemo _memo;
    /*package*/ BasicEditField _titleField;
    /*package*/ BasicEditField _uidField;
    /*package*/ BasicEditField _notesField;    
    
    /**
     * Constructor.  Creates the displayable fields and populates them with all 
     * available data from the provided memo. 
     * @param memo The memo being "controlled".
     */
    /*package*/ MemoController( BlackBerryMemo memo ) 
    {
        _memo = memo;
        
        PIMList list = memo.getPIMList();
        
        _uidField = new BasicEditField( list.getFieldLabel( BlackBerryMemo.UID ) + ": ", "", 128, BasicEditField.FILTER_INTEGER );
        _titleField = new BasicEditField( list.getFieldLabel( BlackBerryMemo.TITLE ) + ": ", "" );
        _notesField = new BasicEditField( list.getFieldLabel( BlackBerryMemo.NOTE ) + ": ", "" );
        
        // Populate the fields with all available data.
        if ( _memo.countValues( BlackBerryMemo.TITLE ) > 0 ) 
        {
            String title = _memo.getString( BlackBerryMemo.TITLE, 0 );
            _titleField.setText( title );
        }
        
        if ( _memo.countValues( BlackBerryMemo.UID ) > 0 ) 
        {
            String uid = _memo.getString( BlackBerryMemo.UID, 0 );
            _uidField.setText( uid );
        }
        
        if ( _memo.countValues( BlackBerryMemo.NOTE ) > 0 ) 
        {
            String notes = _memo.getString( BlackBerryMemo.NOTE, 0 );
            _notesField.setText( notes );
        }
    }    
    
    /**
     * Provides displayable fields containing the memo's data.  Fields may be editable 
     * or non-editable depending on the type of rendering requested. 
     * 
     * @param type Type of rendering.  One of the FOR_* constants.
     * @return Single LabelField if a title is being rendered; otherwise an array of Fields.
     * @throws IllegalArgumentException if the provided type is not one of the FOR_* constants.
     */
    /*package*/ Object render( int type ) 
    {
        switch ( type ) 
        {
            case FOR_TITLE:
                return new LabelField( _titleField.getText(), LabelField.USE_ALL_WIDTH | LabelField.ELLIPSIS );
                
            case FOR_ADD:
                setEditable( true );
                
                return new Field[] { _titleField, _notesField };
                
            case FOR_EDIT:
                setEditable( true );
                _uidField.setEditable( false ); // UID cannot be changed once a memo has been committed.
                
                return new Field[] { _titleField, _notesField };
                
            case FOR_VIEW:
                setEditable( false );
                
                return new Field[] { _uidField, _notesField };
                
            default:
                throw new IllegalArgumentException();
        }
    }    
    
    /**
     * Updates the memos with the data contained in the fields.
     */
    /*package*/ void updateMemo() 
    {
        String s;
        
        if ( _uidField.isEditable() ) 
        {  
            // UID cannot be changed once a memo has been committed.
            s = _uidField.getText();
            
            if ( _memo.countValues( BlackBerryMemo.UID ) > 0 ) 
            {
                _memo.setString( BlackBerryMemo.UID, 0, 0, s );
            } 
            else 
            {
                _memo.addString( BlackBerryMemo.UID, 0, s );
            }
        }
        
        s = _titleField.getText();
        
        if ( _memo.countValues( BlackBerryMemo.TITLE ) > 0 ) 
        {
            _memo.setString( BlackBerryMemo.TITLE, 0, 0, s );
        } 
        else 
        {
            _memo.addString( BlackBerryMemo.TITLE, 0, s );
        }
        
        s = _notesField.getText();
        
        if ( _memo.countValues( BlackBerryMemo.NOTE ) > 0 ) 
        {
            _memo.setString( BlackBerryMemo.NOTE, 0, 0, s );
        } 
        else 
        {
            _memo.addString( BlackBerryMemo.NOTE, 0, s );
        }
    }    
    
    /**
     * Commits the memo to persistent storage. 
     * @return True if the commit was successful; otherwise false.
     */
    /*package*/ boolean commitMemo() 
    {
        try 
        {
            _memo.commit();
            
            return true;
        } 
        catch ( PIMException e ) 
        {
            return false;
        }
    }    
    
    /**
     * Retrieves this controller's memo.
     * @return This controller's memo.
     */
    /*package*/ BlackBerryMemo getMemo() 
    {
        return _memo;
    }    
    
    /**
     * Sets this controller's fields to be editable or non-editable. 
     * @param editable True if fields should be editable; false otherwise.
     */
    private void setEditable( boolean editable ) 
    {
        _uidField.setEditable( editable );
        _titleField.setEditable( editable );
        _notesField.setEditable( editable );
    }
}
