/**
 * CustomButtonsDemo.java
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

package com.rim.samples.device.custombuttonsdemo;

import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;

/**
 * <p> The CustomButtonsDemo sample demonstrates custom UI fields.
 */
public class CustomButtonsDemo extends UiApplication 
{

    public static void main(String[] args)
    {
        CustomButtonsDemo theApp = new CustomButtonsDemo();
        theApp.enterEventDispatcher();
    }

    /**
     * <p> The default constructor. Creates all the RIM UI components and pushes the 
     * application's root screen onto the UI stack.
     */
    public CustomButtonsDemo()
    {
        // MainScreen is the basic screen or frame class of the RIM UI.
        MainScreen mainScreen = new MainScreen();
        
        // Add a field to the title region of the MainScreen. We use a simple LabelField 
        // here. The ELLIPSIS option truncates the label text with "..." if the text was
        // too long for the space available.
        mainScreen.setTitle(new LabelField("Custom Buttons Demo" , LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH));

        // Add a vertical field manager containing sample custom button fields.
        VerticalFieldManager vfm = new VerticalFieldManager();
        vfm.add(new CustomButtonField("rectangle", CustomButtonField.RECTANGLE, Field.FOCUSABLE));
        vfm.add(new RichTextField(Field.NON_FOCUSABLE));
        vfm.add(new CustomButtonField("triangle", CustomButtonField.TRIANGLE, Field.FOCUSABLE));
        vfm.add(new RichTextField(Field.NON_FOCUSABLE));
        vfm.add(new CustomButtonField("octagon", CustomButtonField.OCTAGON, Field.FOCUSABLE));
        vfm.add(new RichTextField(Field.NON_FOCUSABLE));
        vfm.add(new CustomButtonField("larger rectangle", CustomButtonField.RECTANGLE, Field.FOCUSABLE));
        vfm.add(new RichTextField(Field.NON_FOCUSABLE));
        vfm.add(new CustomButtonField("larger triangle", CustomButtonField.TRIANGLE, Field.FOCUSABLE | DrawStyle.ELLIPSIS));
        vfm.add(new RichTextField(Field.NON_FOCUSABLE));
        vfm.add(new CustomButtonField("larger octagon", CustomButtonField.OCTAGON, Field.FOCUSABLE | DrawStyle.ELLIPSIS));

        mainScreen.add(vfm);

        // We've completed construction of our UI objects. Push the MainScreen instance
        // onto the UI stack for rendering.
        pushScreen(mainScreen);
    }
}
