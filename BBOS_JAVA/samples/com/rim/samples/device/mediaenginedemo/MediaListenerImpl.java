/*
 * MediaListenerImpl.java
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

import net.rim.plazmic.mediaengine.*;
import net.rim.plazmic.mediaengine.io.*;

/**
 * The MediaListener implementation.
 */
public final class MediaListenerImpl implements MediaListener
{
    /**
     * @see net.rim.plazmic.mediaengine.MediaListener#mediaEvent(Object, int, int, Object)
     */
    public void mediaEvent(Object sender, int event, int eventParam, Object data)
    {
        switch(event)
        {
            case MEDIA_REQUESTED:
                System.out.println("Media requested");
                break;
                
            case MEDIA_COMPLETE:
                System.out.println("Media completed");
                break;
                
            case MEDIA_REALIZED:
                System.out.println("Media realized");
                break;
                
            case MEDIA_IO:
            {
                LoadingStatus s = (LoadingStatus)data;
                
                switch(s.getStatus())
                {
                    case LoadingStatus.LOADING_STARTED:
                        System.out.println("Loading in progress");
                        break;
                        
                    case LoadingStatus.LOADING_READING:
                        System.out.println("Parsing in progress");
                        break;
                        
                    case LoadingStatus.LOADING_FINISHED:
                        System.out.println("Loading completed");
                        break;
                        
                    case LoadingStatus.LOADING_FAILED:
                        String errorName = null;
                        int code = s.getCode();
                        
                        switch (code)
                        {
                            case MediaException.INVALID_HEADER:
                                errorName = "nvalid header"+ "/n" + s.getSource();
                                break;
                                
                            case MediaException.REQUEST_TIMED_OUT:
                                errorName = "Request timed out" + "\n" + s.getSource();
                                break;
                                
                            case MediaException.INTERRUPTED_DOWNLOAD:
                                break;
                                
                            case MediaException.UNSUPPORTED_TYPE:
                                errorName = "Unsupported type" + s.getMessage() + "\n" + s.getSource();
                                break;
                                
                            default:
                            {
                                if (code > 200)
                                {
                                    // A code > 200 indicates an HTTP error.
                                    errorName = "URL not found";
                                }
                                else
                                {
                                    // Default unidentified error.
                                    errorName = "Loading Failed";
                                }
                                    errorName += "\n" + s.getSource() + "\n"
                                    + s.getCode() + ": " + s.getMessage();
                                    break;
                            }
                        }
                        
                        System.out.println(errorName);
                        break;
                        
                } // End switch s.getStatus().
                
                break;
            }
        }
    }
}
