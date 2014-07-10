/**
 * NotificationsEngineListenerImpl.java
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

package com.rim.samples.device.notificationsdemo;

import net.rim.device.api.notification.NotificationsEngineListener;
import net.rim.device.api.ui.Screen;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.Dialog;

/**
 * Implementation of the NotificationsEngineListener interface.
 * <p>
 * 
 * This class manages UI notifications. The two most important methods in the Listener are:<br>
 * <b>proceedWithDeferredEvent</b><br>
 * <dd>- Called when: <br>
 * <dd>* Our event is triggered via NotificationsManager.negotiateDeferredEvent()<br>
 * <dd>* Our event is resumed after being overridden by a higher priority item (for example an
 * incoming phone call)
 * <p>
 * <b>deferredEventWasSuperseded</b><br>
 * <dd>- Called when: <br>
 * <dd>* Our event is removed from the event queue via NotificationsManager.cancelDeferredEvent()
 * <dd>* Our event is being overridden by a higher priority item <br>
 * 
 */
class NotificationsEngineListenerImpl implements NotificationsEngineListener
{
    // We need a reference to the UiApplication so that we can display dialogs.
    private UiApplication _app; 

    // We require this variable to ensure that only one Dialog is displayed at
    // any given time.  This global variable is shared between threads.
    private boolean _dialogShowing;

    // Constructor
    public NotificationsEngineListenerImpl( UiApplication app )
    {
        _app = app;
        _dialogShowing = false;
    }

    /**
     * @see net.rim.device.api.notification.NotificationsEngineListener#deferredEventWasSuperseded(long,long,Object,Object)
     */
    public void deferredEventWasSuperseded( long sourceID, long eventID, Object eventReference,
            Object context )
    {
        System.out.println( "deferredEventWasSuperseded" );
    }

    /**
     * @see net.rim.device.api.notification.NotificationsEngineListener#proceedWithDeferredEvent(long,long,Object,Object)
     */
    public void proceedWithDeferredEvent( long sourceID, long eventID, Object eventReference,
            Object context )
    {
        System.out.println( "proceedWithDeferredEvent" );
        
        // We require the boolean variable _dialogShowing in case this method is
        // called when a Dialog is already showing.
        // Example scenario: The Dialog is displayed. An incoming phone call
        // occurs causing deferredEventWasSuperseded() to be invoked. When
        // the phone call is finished, this method is called again as it it
        // still in the queue. In this case, we don`t want another Dialog to
        // be spawned.
        if( !_dialogShowing ) 
        {            
            final Object er = eventReference;

            // We need to have this event occur on our own application thread
            // since we are modifying UI components (displaying a Dialog). 
            _app.invokeLater( new Runnable() {
                public void run()
                {
                    Event e = (Event) er; // It is an error if this cast fails.
                    Dialog d = new Dialog( Dialog.D_OK, "Notification for event id: " + e._eventId,
                            0, null, Screen.DEFAULT_CLOSE );
                    _dialogShowing = true;
                    _app.pushGlobalScreen( d, e._priority, UiApplication.GLOBAL_MODAL );

                    // Dialog is closed at this point, so we cancel the event.                                        
                    e.cancel(); 
                    
                    _dialogShowing = false;
                }
            } );
        }
    }

    /**
     * @see net.rim.device.api.notification.NotificationsEngineListener#notificationsEngineStateChanged(int,long.long,Object,Object)
     */
    public void notificationsEngineStateChanged( int stateInt, long sourceID, long eventID,
            Object eventReference, Object context )
    {
        System.out.println( "notificationsEngineStateChanged" );
    }
}
