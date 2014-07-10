/*
 * TTTService.java
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

package com.rim.samples.device.tictactoedemo;

import net.rim.blackberry.api.blackberrymessenger.*;
import net.rim.device.api.system.Application;


/**
 * A class to be registered with BlackBerry Messenger. The Service will appear
 * in BlackBerry Messenger's menu under the "Start Service..." menu item.
 * This will allow you to start a game of Tic Tac Toe with the contact you're 
 * in a conversation with.
 * 
 * @see net.rim.blackberry.api.blackberrymessenger.Service
 */
class TTTService implements Service
{
    private static TTTService _instance;
    
    private TTTService() {}
    
    static TTTService getInstance() 
    {
        if( _instance == null )
        { 
            _instance = new TTTService();
        }
            
        return _instance;
    }
    
    /**
     * Implements Service interface method.
     * 
     * @see net.rim.blackberry.api.blackberrymessenger.Service#start(MessengerContact)
     */
    public void start( MessengerContact contact ) 
    {
        Application.getApplication().requestForeground();
        TicTacToeDemo.getGame().requestTwoPlayerGame( contact );
    }
}
