/*
 * BrowserPlugin.java
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
package com.rim.samples.device.blackberry.browser;

import java.io.IOException;
import java.io.InputStream;

import javax.microedition.io.HttpConnection;

import net.rim.device.api.browser.field.*;
import net.rim.device.api.browser.plugin.*;
import net.rim.device.api.ui.Manager;
import net.rim.device.api.ui.component.LabelField;
import net.rim.device.api.ui.component.SeparatorField;
import net.rim.device.api.ui.container.VerticalFieldManager;

/**
 * To test the plugin - create a file with xxxtest extension and associate that
 * type with application/x-vnd.rim.xxxtest mime type on any web server.
 */
public final class BrowserPlugin  extends BrowserContentProvider implements BrowserPageContext 
{
    
    private static final String[] ACCEPT = {"application/x-vnd.rim.xxxtest"};
    
    /**
     * @see net.rim.device.api.browser.plugin.BrowserContentProvider#getAccept(net.rim.device.api.browser.field.RenderingOptions)
     */
    public String[] getAccept(RenderingOptions context) 
    {   
        // Return subset of getSupportedMimeTypes() if accept depends in rendering options
        // for example HTML can be disabled in the rendering options, and HTMLConverter would remove 
        // html mime types.
        return ACCEPT;
    }
    
    /**
     * @see net.rim.device.api.browser.plugin.BrowserContentProvider#getBrowserContent(net.rim.device.api.browser.plugin.BrowserContentProviderContext)
     */
    public BrowserContent getBrowserContent( BrowserContentProviderContext context) throws RenderingException 
    {
        if (context == null) 
        {
            throw new RenderingException("No Context is passed into Provider");
        }
        
        BrowserContentBaseImpl browserContentBaseImpl = new BrowserContentBaseImpl(context.getHttpConnection().getURL(), null, 
                                                                                                        context.getRenderingApplication(), context.getRenderingSession().getRenderingOptions(), context.getFlags());
        
        VerticalFieldManager vfm = new VerticalFieldManager(Manager.VERTICAL_SCROLL);
                
        vfm.add(new LabelField("Mime type: ") );
        vfm.add(new LabelField(ACCEPT[0]));        
        vfm.add(new SeparatorField());
        vfm.add(new LabelField("Content of the resource file: \n"));
        vfm.add(new SeparatorField());
        
        try 
        {
            HttpConnection conn = context.getHttpConnection();
            InputStream in = conn.openInputStream();
            int numBytes = in.available();
            byte[] data = new byte[numBytes];
            in.read(data, 0, numBytes);
            vfm.add(new LabelField(new String(data)));
            
        } 
        catch (IOException e) 
        {
            e.printStackTrace();
        }
        
        browserContentBaseImpl.setContent(vfm);
        browserContentBaseImpl.setTitle(ACCEPT[0]);
        // Set browser page context, this will tell the browser how to display this field.
        browserContentBaseImpl.setBrowserPageContext(this);
        
        return browserContentBaseImpl;
    }
    
    /**
     * @see net.rim.device.api.browser.plugin.BrowserContentProvider#getSupportedMimeTypes()
     */
    public String[] getSupportedMimeTypes() 
    {
        return ACCEPT;
    }
    
    
    /**
     * @see net.rim.device.api.browser.plugin.BrowserPageContext#getPropertyWithBooleanValue(int, boolean)
     */
    public boolean getPropertyWithBooleanValue(int id, boolean defaultValue) 
    {
        return false;
    }
    
    
    /**
     * @see net.rim.device.api.browser.plugin.BrowserPageContext#getPropertyWithIntValue(int, int)
     */
    public int getPropertyWithIntValue(int id, int defaultValue) 
    {
        if (id == BrowserPageContext.DISPLAY_STYLE) 
        {
            // Disable the scroll bar .
            return BrowserPageContext.STYLE_NO_VERTICAL_SCROLLBAR;
        }
        
        return 0;
    }
    
    
    /**
     * @see net.rim.device.api.browser.plugin.BrowserPageContext#getPropertyWithObjectValue(int, java.lang.Object)
     */
    public Object getPropertyWithObjectValue(int id, Object defaultValue) 
    {
        return null;
    }
    
    /**
     * @see net.rim.device.api.browser.plugin.BrowserPageContext#getPropertyWithStringValue(int, java.lang.String)
     */
    public String getPropertyWithStringValue(int id, String defaultValue) 
    {
        return null;
    }
}
