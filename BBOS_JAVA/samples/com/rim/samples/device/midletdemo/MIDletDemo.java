/**
 * MIDletDemo.java
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

package com.rim.samples.device.midletdemo;

import java.util.*;
import java.io.*;
import javax.microedition.midlet.*;
import javax.microedition.lcdui.*;
import java.lang.*;

/**
 * An Example MIDlet.
 * The application must extend the MIDlet class to allow the application management
 * software to control the MIDlet.
 */
public class MIDletDemo extends MIDlet implements CommandListener
{
    private Alert _alert;
    private int _time;
    private Form _form;
    private Display _display;
    private UpdateThread _updateThread;

    /**
     * The thread that updates the explosion dialog box.
     */
    private class UpdateThread extends Thread
    {
        private boolean _disarmed;
        public void run()
        {
            _disarmed = false;
            int i = _time;
            while (i > 0 && !_disarmed)
            {
                try
                {
                    _alert.setString(Integer.toString(i));
                    synchronized(this)
                    {
                            this.wait(1000);
                    }

                    System.out.println("timeout in:" +i);
                }
                catch(InterruptedException e)
                {
                    System.out.println("MyMidlet: Exception: " + e);
                }
                
                i--;
            }
            
            if(!_disarmed)
            {
                _alert.setString("BOOM");
            }
        }
        
        public void disarm()
        {
            _disarmed = true;
        }
    }

    /**
     * Thread that pops up the program's main dialog box.
     */
    private class GoCommand extends Command implements Runnable
    {
        public GoCommand(String label, int type, int priority)
        {
            super(label, type, priority);
        }

        public void run()
        {
            _alert.setString(Integer.toString(_time));
            _alert.setTimeout(_time * 1000 + 5000);

            _updateThread = new UpdateThread();
            _updateThread.start();
            _display.setCurrent(_alert, _form);
        }
    }
    
    /**
     * <p>The default constructor. Creates a simple screen and a command with an alert 
     * dialog box which pops up when the command is selected.
     */
    public MIDletDemo()
    {
        _alert = new Alert("The Thermonuclear Device has been activated!\nTo disarm the device, dismiss this Alert.\nDevice will detonate in:");
        _alert.setCommandListener(this);
        _time = 10;

        // Create a simple screen.
        _form = new Form("Thermo-Nuclear Event");
        _form.append("Choose 'Go' from the menu.");
        _display = Display.getDisplay(this);

        // Add our command.
        _form.addCommand(new GoCommand("Go", Command.SCREEN, 1));

        _form.setCommandListener(this);
        _display.setCurrent(_form);
    }

    public void commandAction(Command c, Displayable s)
    {
        if ( c instanceof Runnable )
        {
            ((Runnable)c).run();
        }
        
        if( c == Alert.DISMISS_COMMAND )
        {
            _updateThread.disarm();
        }
    }

    /**
     * <p>Signals the MIDlet that it has entered the Active state.
     */
    public void startApp()
    { 
        // Not implemented. 
    }

    /**
     * <p>Signals the MIDlet to stop and enter the Pause state.
     */
    public void pauseApp()
    {
        // Not implemented. 
    }

    /**
     * <p>Signals the MIDlet to terminate and enter the Destroyed state.
     * @param unconditional When set to true, the MIDlet must cleanup and release all 
     * resources. Otherwise, the MIDlet may throw a MIDletStateChangeException to 
     * indicate it does not want to be destroyed at this time.
     */
    public void destroyApp(boolean unconditional)
    {
        // Not implemented. 
    }
}
