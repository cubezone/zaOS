/**
 * MediaEngineDemo.java
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
package com.rim.samples.device.mediaengine;

import java.io.*;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;
import net.rim.device.api.system.*;
import net.rim.plazmic.mediaengine.*;

/**
 * A simple example of the MediaEngine API's.  PME files in this sample are version 1.2
 * In Plazmic Composer version 3.0.0.21 export content as SVG.  Open SVG file in a 
 * text editor and change height and width attributes within the svg tag to pixel 
 * values.  If content includes png files you may need to modify the paths in the
 * xlink:href attributes within the image tags as well. Finally, use the command line
 * utility to transcode the SVG to PME format (eg. C:\projectDir>svgc -pme 12 filename.svg).
 */
public final class MediaEngineDemo extends UiApplication
{
    private RichTextField _statusField;
    private MediaDisplayScreen _display;
   
   /**
    * Entry point for application.
    */
    public static void main(String[] args)
    {
         MediaEngineDemo app = new MediaEngineDemo();
         app.enterEventDispatcher();
    }
    
    /**
     * Constructor
     */
    public MediaEngineDemo()
    {
        _display = new MediaDisplayScreen();
        pushScreen(new MediaSampleScreen());
    }

    /**
     * The intro screen, hosting any status info.
     */
    private final class MediaSampleScreen extends MainScreen
    {    
        /**
         * Contructor
         */
        public MediaSampleScreen()
        {
            LabelField title = new LabelField("Media Engine Demo" , LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH);
            setTitle(title);
            
            _statusField = new RichTextField("Please select a PME from the Menu.");
            add(_statusField);
        }         
         
        /**
         * @see net.rim.device.api.ui.Screen#makeMenu(Menu,int)
         */         
        public void makeMenu(Menu menu, int instance)
        {
            // Invoke some content using the jar://url
            menu.add(new MenuItem("PME 1" , 5, 5)
            {
                public void run()
                {
                    // Check for optimal screen dimensions.
                    if((Display.getHeight() != 240) || (Display.getWidth() != 320))
                    {
                        Dialog.alert("Sample has been optimized for a 320 x 240 display. " +
                            "This device has a " + Display.getWidth() + " x " +
                            Display.getHeight() + " display." );
                    }
                    _statusField.setText("Loading, please wait..."); 
                    
                    // Play media in a separate thread.
                    UiApplication.getUiApplication().invokeLater(new Runnable()
                    {
                        public void run()
                        {
                            playMedia("jar:///runner.pme");                           
                            _statusField.setText("Please select a PME from the Menu.");
                        }
                    });                    
                }
            });
            
            // Invoke some content using the jar:///url
            menu.add(new MenuItem("PME 2" , 6, 6) 
            {
                public void run()
                {
                    // Check for optimal screen dimensions.
                    if((Display.getHeight() != 240) || (Display.getWidth() != 320))
                    {
                        Dialog.alert("Sample has been optimized for a 320 x 240 display. " +
                            "This device has a " + Display.getWidth() + " x " +
                            Display.getHeight() + " display.");
                            
                    }
                    _statusField.setText("Loading, please wait..."); 
                                        
                    // Play media after all pending events have been processed.
                    UiApplication.getUiApplication().invokeLater(new Runnable()
                    {
                        public void run()
                        {
                            playMedia("jar:///weather.pme");
                            _statusField.setText("Please select a PME from the Menu.");
                        }
                    });
                }
            });
            
            super.makeMenu(menu, instance);
        }
            
        /**
         * Play some media.
         */
        private void playMedia(String mediaUrl)
        {   
            MediaPlayer player = new MediaPlayer();
            MediaManager manager = new MediaManager();
            MediaListenerImpl listener = new MediaListenerImpl();
            player.addMediaListener(listener);
            manager.addMediaListener(listener);
            
            try
            {
                Object media = manager.createMedia(mediaUrl);
                player.setMedia(media);
    
            }
            catch (IOException ioe)
            {
                System.out.print(ioe.toString());
            }
            catch (MediaException me)
            {
                String msg = "Error during media loading: " + me.getCode() + me.getMessage();
                System.out.println(msg);
                _statusField.setText(_statusField.getText() + msg);
            }
                
            /*parent.*/_display.init((Field)player.getUI(), player);
            pushScreen(/*parent.*/_display);
        }
    }     
       
    /**
     * A MainScreen to display pme content.
     */
    static private final class MediaDisplayScreen extends MainScreen
    {
        private Field _current;
        private MediaPlayer _player;
        
        public MediaDisplayScreen() {}        
        
        public void init(Field f, MediaPlayer player)
        {
            if ( _player != null )
            {
                _player.close();
            }
            
            _player = player;
            
            if ( _current != null ) 
            {
                delete(_current);
            }
            
            _current = f;
            add(f);            
        }
         
         /**
          * Overrides onUiEngineAttached() method in superclass.
          * @param attached True is it is an attach event, false if it is a detach event.
          */            
        public void onUiEngineAttached(boolean attached)
        {
            try
            {
                _player.start();
            }
            catch(MediaException me)
            {
                String msg = "Error during media playback: " + me.getCode() + me.getMessage();
                System.out.println(msg);
            }
        }
        
        /**
         * @see net.rim.device.api.ui.Screen#onClose()
         */
        public boolean onClose()
        {
            boolean retval = super.onClose();
            if(retval)
            {
                _player.close();
            }
            return retval;
        }
    
    
        /**
         * @see net.rim.device.api.ui.Screen#keyChar(char,int,int)
         */
        public boolean keyChar(char key, int status, int time)
        {
            boolean retval = false;  
              
            switch (key)
            {
                case Characters.ESCAPE:
                    UiApplication.getUiApplication().popScreen(this);
                    _player.close();                
                    retval = true;
                    break;
            }  
              
            return retval;
        }
    }
}
