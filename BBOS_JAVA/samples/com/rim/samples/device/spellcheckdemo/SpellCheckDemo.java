/*
 * SpellcheckDemo.java
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

import net.rim.blackberry.api.spellcheck.*;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;

/**
 * A sample application to showcase the SpellCheck API.  The main screen
 * provides a RichTextField for the purpose of typing in words which can then be
 * spell checked by way of a menu item.  An additional menu item allows for a
 * specified word to be treated as spelled correctly while another menu item
 * allows for a correction to be added to the list of corrections for the
 * specified word. 
 */
class SpellCheckDemo extends UiApplication
{
    private SpellCheckEngine _spellCheckEngine;
    private SpellCheckUI _spellCheckUI;
    
    /**
     * Entry point for application.
     * @param args Command line arguments.
     */
    public static void main(String[] args)
    {
        SpellCheckDemo app = new SpellCheckDemo();
        app.enterEventDispatcher();        
    }    
    
    // Contructor     
    SpellCheckDemo()
    {
        // Create our spell check objects.
        _spellCheckUI = SpellCheckEngineFactory.createSpellCheckUI();
        _spellCheckUI.addSpellCheckUIListener(new SpellCheckListener());        
        _spellCheckEngine = SpellCheckEngineFactory.getEngine();
        
        // Push a new SpellCheckDemoScreen onto the stack for rendering.
        SpellCheckDemoScreen screen = new SpellCheckDemoScreen(this);
        pushScreen(screen);      
    }  
    
    /**
     * This method calls the learnCorrection() method on the SpellCheckEngine.
     * @param text The misspelled word.
     * @param correction The correction to learn.
     */
    public void learnCorrection(String text, String correction)
    {
        _spellCheckEngine.learnCorrection(new StringBuffer(text), new StringBuffer(correction)); 
    }  
    
    /**
     * This method calls the spellCheck() method on the SpellCheckUI.
     * @param field The field to be spell checked.
     */
    public void spellCheck(EditField field)
    {
        _spellCheckUI.spellCheck(field);        
    }
    
    /**
     * This method calls the learnWord() method on the SpellCheckEngine.
     * @param word The word to learn.
     */
    public void learnWord(String word)
    {
        _spellCheckEngine.learnWord(new StringBuffer(word));
    }
}

