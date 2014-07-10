/**
 * Protocol.java
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
package com.rim.samples.device.httpfilterdemo.filter;

import net.rim.device.api.io.FilterBaseInterface;
import java.io.*;
import javax.microedition.io.*;

/**
 * An example of the HttpFilterRegistry apis.
 * This class implements a simple pass through mechanism that writes out the http 
 * response headers to System.out
 */
public final class Protocol implements FilterBaseInterface, HttpConnection
{
    private HttpConnection _subConnection;
    
    /**
     * This function will open a filtered Http Connection.
     * 
     * @see net.rim.device.api.io.FilterBaseInterface#openFilter(String, int, boolean)
     */
    public Connection openFilter( String name, int mode, boolean timeouts ) throws IOException
    {
        _subConnection = (HttpConnection)Connector.open("http:" + name + ";usefilter=false", mode, timeouts);
        if (_subConnection != null) {
            return this;
        }
        
        // Failed to open the sub connection; so let us fail too.
        return null;
    }
    
    /**
     * @see javax.microedition.io.HttpConnection#getURL()
     */
    public String getURL()
    {
        return _subConnection.getURL();
    }

    /**
     * @see javax.microedition.io.HttpConnection#getProtocol()
     */
    public String getProtocol()
    {
        return _subConnection.getProtocol();
    }

    /**
     * @see javax.microedition.io.HttpConnection#getHost()
     */
    public String getHost()
    {
        return _subConnection.getHost();
    }

    /**
     * @see javax.microedition.io.HttpConnection#getFile()
     */
    public String getFile()
    {
        return _subConnection.getFile();
    }

    /**
     * @see javax.microedition.io.HttpConnection#getRef()
     */
    public String getRef()
    {
        return _subConnection.getRef();
    }

    /**
     * @see javax.microedition.io.HttpConnection#getQuery()
     */
    public String getQuery()
    {
        return _subConnection.getQuery();
    }

    /**
     * @see javax.microedition.io.HttpConnection#getPort()
     */
    public int getPort()
    {
        return _subConnection.getPort();
    }

    /**
     * @see javax.microedition.io.HttpConnection#getRequestMethod()
     */
    public String getRequestMethod()
    {
        return _subConnection.getRequestMethod();
    }

    /**
     * @see javax.microedition.io.HttpConnection#setRequestMethod(String)
     */
    public void setRequestMethod(String method) throws IOException
    {
        _subConnection.setRequestMethod(method);
    }

    /**
     * @see javax.microedition.io.HttpConnection#getRequestProperty(String)
     */
    public String getRequestProperty(String key)
    {
        return _subConnection.getRequestProperty(key);
    }

    /**
     * @see javax.microedition.io.HttpConnection#setRequestProperty(String, String)
     */
    public void setRequestProperty(String key, String value) throws IOException
    {
        System.out.println("Request property <key, value>: " + key + ", " + value );
        _subConnection.setRequestProperty(key, value);
    }

    /**
     * @see javax.microedition.io.HttpConnection#getResponseCode()
     */
    public int getResponseCode() throws IOException
    {
        return _subConnection.getResponseCode();
    }

    /**
     * @see javax.microedition.io.HttpConnection#getResponseMessage()
     */
    public String getResponseMessage() throws IOException
    {
        return _subConnection.getResponseMessage();
    }

    /**
     * @see javax.microedition.io.HttpConnection#getExpiration()
     */
    public long getExpiration() throws IOException
    {
        return _subConnection.getExpiration();
    }

    /**
     * @see javax.microedition.io.HttpConnection#getDate()
     */
    public long getDate() throws IOException
    {
        return _subConnection.getDate();
    }

    /**
     * @see javax.microedition.io.HttpConnection#getLastModified()
     */
    public long getLastModified() throws IOException
    {
        return _subConnection.getLastModified();
    }

    /**
     * @see javax.microedition.io.HttpConnection#getHeaderField(String)
     */
    public String getHeaderField(String name) throws IOException
    {
        String value = _subConnection.getHeaderField(name);
        System.out.println("Response property <key, value>: " + name + ", " + value );
        return value;
    }

    /**
     * @see javax.microedition.io.HttpConnection#getHeaderFieldInt(String, int)
     */
    public int getHeaderFieldInt(String name, int def) throws IOException
    {
        return _subConnection.getHeaderFieldInt(name, def);
    }

    /**
     * @see javax.microedition.io.HttpConnection#getHeaderFieldDate(String, long)
     */
    public long getHeaderFieldDate(String name, long def) throws IOException
    {
        return _subConnection.getHeaderFieldDate(name, def);
    }

    /**
     * @see javax.microedition.io.HttpConnection#getHeaderField(int)
     */
    public String getHeaderField(int n) throws IOException
    {
        return _subConnection.getHeaderField(n);
    }

    /**
     * @see javax.microedition.io.HttpConnection#getHeaderFieldKey(int)
     */
    public String getHeaderFieldKey(int n) throws IOException
    {
        return _subConnection.getHeaderFieldKey(n);
    }
 
    /**
     * @see javax.microedition.io.HttpConnection#getType()
     */
    public String getType()
    {
        return _subConnection.getType();
    }

    /**
     * @see javax.microedition.io.HttpConnection#getEncoding()
     */
    public String getEncoding()
    {
        return _subConnection.getEncoding();
    }

    /**
     * @see javax.microedition.io.HttpConnection#getLength()
     */
    public long getLength()
    {
        return _subConnection.getLength();
    }

    /**
     * @see javax.microedition.io.HttpConnection#openInputStream()
     */
    public InputStream openInputStream() throws IOException
    {
        return _subConnection.openInputStream();
    }

    /**
     * @see javax.microedition.io.HttpConnection#openDataInputStream()
     */
    public DataInputStream openDataInputStream() throws IOException
    {
        return _subConnection.openDataInputStream();
    }

    /**
     * @see javax.microedition.io.HttpConnection#openOutputStream()
     */
    public OutputStream openOutputStream() throws IOException
    {
        return _subConnection.openOutputStream();
    }

    /**
     * @see javax.microedition.io.HttpConnection#openDataOutputStream()
     */
    public DataOutputStream openDataOutputStream() throws IOException
    {
        return _subConnection.openDataOutputStream();
    }

    /**
     * @see javax.microedition.io.HttpConnection#close()
     */
    public void close() throws IOException
    {
        _subConnection.close();
    }
    
}
