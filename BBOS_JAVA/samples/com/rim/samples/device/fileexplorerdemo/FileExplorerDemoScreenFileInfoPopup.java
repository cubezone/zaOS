/*
 * FileExplorerDemoScreenFileInfoPopup.java
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

package com.rim.samples.device.fileexplorerdemo;

import net.rim.device.api.io.MIMETypeAssociations;
import net.rim.device.api.system.Characters;
import net.rim.device.api.ui.component.LabelField;
import net.rim.device.api.ui.component.SeparatorField;
import net.rim.device.api.ui.container.PopupScreen;
import net.rim.device.api.ui.container.VerticalFieldManager;

/**
 * PopupScreen that displays information about a file.
 */
/*package*/ final class FileExplorerDemoScreenFileInfoPopup extends PopupScreen
{
    /**
     * Constructor.
     * 
     * @param fileholder Used to retrieve the file information.
     */
    FileExplorerDemoScreenFileInfoPopup(FileExplorerDemoFileHolder fileholder) 
    {
        super(new VerticalFieldManager());
        add(new LabelField("File Information"));
        add(new SeparatorField());
        add(new LabelField(fileholder.getFileName()));
        add(new LabelField(""));

        // Use the MIMETypeAssociations class to determine information about the file.
        add(new LabelField("MIME Type: " + MIMETypeAssociations.getMIMEType(fileholder.getFileName())));
    }

    
    /**
     * Overrides the default.  Closes the popup screen when the Escape key is pressed.
     * 
     * @see net.rim.device.api.ui.Screen#keyChar(char,int,int)
     */
    public boolean keyChar(char c, int status, int time)
    {
        if (c == Characters.ESCAPE) 
        {
            close();
            return true;
        }
        
        return super.keyChar(c, status, time);
    }
}
