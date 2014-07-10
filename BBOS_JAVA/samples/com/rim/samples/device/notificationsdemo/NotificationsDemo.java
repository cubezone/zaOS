/**
 * NotificationsDemo.java
 * 
 * Copyright ? 1998-2008 Research In Motion Ltd.
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

import net.rim.device.api.notification.NotificationsConstants;
import net.rim.device.api.notification.NotificationsManager;
import net.rim.device.api.ui.MenuItem;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.RichTextField;
import net.rim.device.api.ui.container.MainScreen;

/**
 * An example of use of the Notifications API. This application has an alternate
 * entry point in which the app is registered as a notification source on device
 * startup.  Immediate and deferred events are generated via a UI menu item and
 * the Event.fire() method. 
 */
public final class NotificationsDemo extends UiApplication
{    
    // com.rim.samples.device.notificationsdemo.NOTIFICATIONS_ID_1
    public static final long NOTIFICATIONS_ID_1 = 0xdc5bf2f81374095L; 

    public static void main( String[] args )
    {
        if( args.length > 0 && args[ 0 ].equals( "autostartup" ) )
        {
            NotificationsDemo nd = new NotificationsDemo();
            nd.registerNotificationObjects();
            
            // Keep this instance around for rendering
            // Notification dialogs.
            nd.enterEventDispatcher(); 
        }
        else
        {
            // Start a new app instance for GUI operations.
            new NotificationsDemo().showGui();
        }
    }
    
    private void showGui()
    {
        pushScreen( new NotificationsDemoScreen() );
        enterEventDispatcher();
    }
    
    private void registerNotificationObjects()
    {
        // A source is registered to tell the system that our application will
        // be sending notification events.  This will will cause a new user
        // editable configuration to be added to the Profiles application. 
        NotificationsManager.registerSource( NOTIFICATIONS_ID_1, new Object()
        {
            public String toString()
            {
                return "Notifications Demo";
            }
        }, NotificationsConstants.IMPORTANT );
        
        // Our NotificationsEngineListener implementation will display a dialog
        // to the user when a deferred event is triggered.
        NotificationsManager.registerNotificationsEngineListener( NOTIFICATIONS_ID_1,
                new NotificationsEngineListenerImpl( this ) );        
                
        // Our Consequence implementation will invoked whenever an immediate
        // event occurs.        
        NotificationsManager.registerConsequence(ConsequenceImpl.ID, new ConsequenceImpl());
    }
    
    /**
     * The MainScreen class for our UiApplication. 
     */
    private static class NotificationsDemoScreen extends MainScreen
    {
        private long _eventId;

        public NotificationsDemoScreen()
        {
            // Initialize UI components.            
            setTitle( "Notifications Demo" );
            add( new RichTextField( "Trigger notification from menu." ) );
            addMenuItem( _notifyItem );
        }

        // A menu item to generate immediate and deferred events.
        MenuItem _notifyItem = new MenuItem( "Notify (ID1)", 100000, 25 ) {
            public void run()
            {
                int trigger = NotificationsConstants.MANUAL_TRIGGER;

                // The timeout parameter is IGNORED unless the TRIGGER
                // is OUT_OF_HOLSTER_TRIGGER.
                long timeout = -1;

                Event e = new Event( NotificationsDemo.NOTIFICATIONS_ID_1, _eventId, 500, timeout,
                        trigger );
                _eventId++;
                e.fire();
            }
        };
    }
}
