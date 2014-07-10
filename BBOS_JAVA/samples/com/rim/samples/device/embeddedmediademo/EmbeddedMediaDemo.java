/*
 * EmbeddedMediaDemo.java
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

package com.rim.samples.device.embeddedmediademo;

import java.io.*;
import javax.microedition.media.*; 
import javax.microedition.media.control.*;
import net.rim.device.api.system.*;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;

/**
 * A simple showcase of the javax.microedition.media API's.  We are embedding
 * a media player within a standard UI field and allowing the user to start 
 * and pause the media player and adjust the audio volume. Label fields at the
 * bottom of the screen indicate current volume level, total playing time of
 * the media, and elapsed time when media is paused.
 */
public class EmbeddedMediaDemo extends UiApplication
{      
    // Entry point for this application.     
    public static void main(String[] args)
    {
        new EmbeddedMediaDemo().enterEventDispatcher();        
    }
    
    //Constructor
    public EmbeddedMediaDemo()
    {
        EmbeddedMediaScreen screen = new EmbeddedMediaScreen();
        pushScreen(screen);        
    }
}

/**
 * A UI screen to display our media player.
 */
final class EmbeddedMediaScreen extends MainScreen implements FieldChangeListener , PlayerListener
{
    private Player _player;
    private VolumeControl _volumeControl;
    private RichTextField _statusField;
    private ButtonField _controlButton;
    private Field _videoField;
    private EmbeddedMediaScreen _mainScreen;
    
    private LabelField _currentTime;
    private LabelField _duration;
    private LabelField _volumeDisplay;
    
    private TimerUpdateThread _timerUpdateThread;
            
    // Constructor
    public EmbeddedMediaScreen()
    {     
        _mainScreen = this;
        
        setTitle("Embedded Media Demo"); 
        _statusField = new RichTextField("Loading media, please wait...");
        add(_statusField);
        
        UiApplication.getUiApplication().invokeLater(new Runnable()
        {
            public void run()
            {
                initializeMedia();
                
                // If initialization was successful...
                if(_videoField != null)
                {
                    addFields();
                }
                else
                {
                    _statusField.setText("Error: Could not load media");
                }
            }
        });                      
    }

    /**
     * Method to add UI fields to the main screen.  Only called if media was
     * sucessfully loaded.
     */
    public void addFields()
    {     
        delete(_statusField);
        add(_videoField);
        
        HorizontalFieldManager hfm1 = new HorizontalFieldManager(Field.FIELD_HCENTER);
        _controlButton = new ButtonField("Start");
        _controlButton.setChangeListener(this);
        hfm1.add(_controlButton);
        add(hfm1);      
        
        // Fields to display the duration and the elapsed time.
        HorizontalFieldManager hfm2 = new HorizontalFieldManager(Field.FIELD_HCENTER);
        _currentTime = new LabelField("-");
        _duration = new LabelField("- s");
        _volumeDisplay = new LabelField ("Volume : " +  _volumeControl.getLevel());
        hfm2.add(_currentTime);
        hfm2.add(new LabelField(" / "));
        hfm2.add(_duration);
        hfm2.add(new LabelField("\t\t"));
        hfm2.add(_volumeDisplay);
        add(hfm2);        
    }    
    
    /**
     * Creates a Player based on a specified URL and provides a
     * VolumeControl object.
     */
    public void initializeMedia()
    {         
        try
        {   
            /* For the purpose of this sample we are supplying a URL to a media file
            that is included in the project itself. 
            See the javax.microedition.media.Manager javadoc for more information on 
            handling data residing on a server.
            */
            InputStream is = getClass().getResourceAsStream("/media/BlackBerry.mp4");
            _player = javax.microedition.media.Manager.createPlayer(is, "video/mp4");
            _player.addPlayerListener(this);            
            _player.realize();        
            
            VideoControl vc = (VideoControl) _player.getControl("VideoControl");
            if (vc != null)
            {
                _videoField = (Field) vc.initDisplayMode (VideoControl.USE_GUI_PRIMITIVE, "net.rim.device.api.ui.Field");
                vc.setDisplaySize( _mainScreen.getWidth() , (int) (0.6875 * _mainScreen.getHeight()) ); // Leave room for the LabelFields.
                vc.setVisible(true);
            }    
            
            _volumeControl = (VolumeControl) _player.getControl("VolumeControl");   
                    
        }
        catch(MediaException pe)
        {
            System.out.println(pe.toString());
        }
        catch (IOException ioe)
        {
            System.out.println(ioe.toString());
        }        
    }    
    
    /**
     * Implementation of FieldChangeListener.
     * @param field The field that changed.
     * @param context Information specifying the origin of the change.
     * 
     * @see net.rim.device.api.ui.FieldChangeListener#fieldChanged(Field , int)
     */
    public void fieldChanged(Field field, int context)
    {              
        if (_controlButton.getLabel().equals("Start"))
        {   
            try
            {   
                // Start/resume the media player.
                _player.start();
                
                _timerUpdateThread = new TimerUpdateThread();
                _timerUpdateThread.start();
            }
            catch(MediaException pe)
            {
                System.out.println(pe.toString());
            } 
        }
        else
        {
            try
            {
                // Stop/pause the media player.
                _player.stop();             
                
                _timerUpdateThread.stop();
            }
            catch(MediaException pe)
            {
                System.out.println(pe.toString());
            }
        }                   
    }    
    
    /**
     * @see net.rim.device.api.ui.Screen#keyControl(char,int,int)
     */
    protected boolean keyControl(char c, int status, int time)
    {        
        // Capture volume control key press and adjust volume accordingly.
        switch( c )
        {
            case Characters.CONTROL_VOLUME_DOWN:
                _volumeControl.setLevel(_volumeControl.getLevel() - 10);          
                return true;
                
            case Characters.CONTROL_VOLUME_UP:
                _volumeControl.setLevel(_volumeControl.getLevel() + 10);                           
                return true;
        }
        
        return super.keyControl( c, status, time );
    }    
    
    /**
     * @see javax.microedition.media.PlayerListener#playerUpdate(Player,String,Object)
     */
    public void playerUpdate(Player player, final String event, Object eventData)
    {
        UiApplication.getUiApplication().invokeLater(new Runnable()
        {
            public void run()
            {
                if (event.equals(VOLUME_CHANGED))
                {
                    _volumeDisplay.setText("Volume : " + _volumeControl.getLevel());
                }
                else if (event.equals(STARTED ))
                {
                    _currentTime.setText(" ");
                    _controlButton.setLabel("Pause");      
                }    
                else if (event.equals(STOPPED))
                {
                    _currentTime.setText(_player.getMediaTime()/1000000 + "");
                    _controlButton.setLabel("Start");              
                }                       
                else if (event.equals(DURATION_UPDATED))
                {
                    _duration.setText(_player.getDuration()/1000000 + " s");       
                }           
                else if (event.equals(END_OF_MEDIA))
                {
                    _controlButton.setLabel("Start");        
                }
            }           
        });
    }

    /**
     * @see net.rim.device.api.ui.Screen#invokeAction(int)
     */   
    protected boolean invokeAction(int action)
    {
        boolean handled = super.invokeAction(action); 
                    
        if(!handled)
        {
            switch(action)
            {
                case ACTION_INVOKE: // Trackball click.
                {         
                    return true;
                }
            }
        }        
        return handled;                
    }    
    
    /**
     * We override this method to prevent Save dialog from being displayed.
     * 
     * @see net.rim.device.api.ui.container.MainScreen#onSavePrompt()
     */   
    protected boolean onSavePrompt()
    {
        return true;
    }    
    
    private class TimerUpdateThread extends Thread
    {
        private boolean _threadCanRun;

        public void run()
        {
            _threadCanRun = true;
            while( _threadCanRun ) {
                UiApplication.getUiApplication().invokeLater( new Runnable() {
                    public void run()
                    {
                        _currentTime.setText( _player.getMediaTime() / 1000000 + "" );
                    }
                } );
                
                try {
                    Thread.sleep( 500L );
                } catch( InterruptedException e ) {
                }
            }
        }

        public void stop()
        {
            _threadCanRun = false;
        }
    }
}    

