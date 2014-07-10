/*
 * TTTRequestListener.java
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
 * Receives notification of a  user accepting a Session.
 * 
 * @see net.rim.blackberry.api.blackberrymessenger.SessionRequestListener
 */
class TTTRequestListener implements SessionRequestListener 
{
    static TTTRequestListener _instance;
    
    private TTTRequestListener() {}
    
    static TTTRequestListener getInstance() 
    {
        if( _instance == null )
        { 
            _instance = new TTTRequestListener();
        }
            
        return _instance;
    }
    
    /**
     * Implements SessionRequestListener interface method.
     * 
     * @see net.rim.blackberry.api.blackberrymessenger.SessionRequestListener#sessionRequestAccepted(Session)
     */
    public void sessionRequestAccepted( Session session ) 
    {
        Application.getApplication().requestForeground();
        TicTacToeDemo.getGame().newTwoPlayerGame( true, session );
    }
}

