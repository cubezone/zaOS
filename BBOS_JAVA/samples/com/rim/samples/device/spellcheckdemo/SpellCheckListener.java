/*
 * SpellCheckListener.java
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

package com.rim.samples.device.spellcheckdemo;

import net.rim.device.api.ui.container.*;
import net.rim.device.api.ui.component.*;
import net.rim.blackberry.api.spellcheck.*;
import net.rim.device.api.ui.*;

/**
 * Implementation of AbstractSpellCheckUIListener.  A listener for events on the
 * SpellCheckUI. The listener can be used for as little as determining when each
 * field is spell checked and as much as determining corrections to misspelled
 * words.
 */
class SpellCheckListener extends AbstractSpellCheckUIListener
{
    /**
     * @see net.rim.blackberry.api.spellcheck.AbstractSpellCheckUIListener#wordLearned(SpellCheckUI ui, StringBuffer word)  
     */
    public int wordLearned(SpellCheckUI ui, StringBuffer word)  
    {
        UiApplication.getUiApplication().invokeLater(new popUpRunner("Word learned")); 
        return SpellCheckUIListener.LEARNING_ACCEPT;
    }     
    
    /**
     * @see net.rim.blackberry.api.spellcheck.AbstractSpellCheckUIListener#wordIgnored(SpellCheckUI ui, StringBuffer word, boolean ignoreAll)  
     */
    public int wordIgnored(SpellCheckUI ui, StringBuffer word, boolean ignoreAll)
    {
        UiApplication.getUiApplication().invokeLater(new popUpRunner("Word ignored"));         
        return 0;        
    }
    
    /**
     * @see net.rim.blackberry.api.spellcheck.AbstractSpellCheckUIListener#wordCorrectionLearned(SpellCheckUI ui, StringBuffer word, StringBuffer correction)
     */
    public int wordCorrectionLearned(SpellCheckUI ui, StringBuffer word, StringBuffer correction)
    { 
        UiApplication.getUiApplication().invokeLater(new popUpRunner("Correction learned"));         
        return SpellCheckUIListener.LEARNING_ACCEPT;
    }   
    
    /**
     * @see net.rim.blackberry.api.spellcheck.AbstractSpellCheckUIListener#spellCheckStarted(SpellCheckUI ui, Field field)
     */
    public boolean spellCheckStarted(SpellCheckUI ui, Field field)
    {
        VerticalFieldManager vfm = new VerticalFieldManager(Field.FIELD_HCENTER);
        StatusScreen popUp = new StatusScreen(vfm);                   
        RichTextField rtf = new RichTextField("Spell check started", RichTextField.USE_TEXT_WIDTH | Field.NON_FOCUSABLE);            
        popUp.add(rtf);
        popUp.show(1500);   
        return true;            
    }
    
    /**
     * @see net.rim.blackberry.api.spellcheck.AbstractSpellCheckUIListener#misspelledWordFound(SpellCheckUI ui, Field field, int offset, int len)
     */     
    public int misspelledWordFound(SpellCheckUI ui, Field field, int offset, int len)
    {
        UiApplication.getUiApplication().invokeLater(new popUpRunner("Misspelled word found")); 
        return SpellCheckUIListener.ACTION_OPEN_UI;       
    } 
    
    /**
     * A runnable class which displays an instance of StatusScreen for a
     * specified interval.
     */
    static final class popUpRunner implements Runnable
    {
        StatusScreen _popUp;
        RichTextField _rtf;
                
        public popUpRunner(String msg)
        {
             VerticalFieldManager vfm = new VerticalFieldManager();
             _popUp = new StatusScreen(vfm);
             _rtf = new RichTextField(msg, RichTextField.USE_TEXT_WIDTH | Field.NON_FOCUSABLE);            
        }
        
        public void run()
        {            
            _popUp.add(_rtf);
            _popUp.show(1500); // Display for 1.5 seconds.          
        }
    }     
       
    /**
     * Extends PopupScreen class providing a method for pushing the screen and
     * dismissing after a specified interval. 
     */
    static final class StatusScreen extends PopupScreen 
    {
        private StatusScreenPopper _popupPopper;
       
        public StatusScreen(Manager manager)
        {
            //super(manager,Field.FIELD_HCENTER);            
            super(manager);            
            _popupPopper = new StatusScreenPopper(this);
        }         
        public void show(int time)
        {
            UiApplication app = UiApplication.getUiApplication();
            app.invokeLater(_popupPopper,(long)time,false);
            app.pushModalScreen(this);            
        }
    }
    
    /**
     * A runnable class that can be invoked after a specified interval.
     */
    static final class StatusScreenPopper implements Runnable
    {
        private PopupScreen _popup;
        
        public StatusScreenPopper(PopupScreen popup)
        {
            _popup = popup;
        }
        public void run()
        {
            Ui.getUiEngine().popScreen(_popup);            
        }
    }    
}
