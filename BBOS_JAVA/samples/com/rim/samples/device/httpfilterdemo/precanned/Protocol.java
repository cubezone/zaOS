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
package com.rim.samples.device.httpfilterdemo.precanned;

import net.rim.device.api.io.FilterBaseInterface;
import java.io.*;
import javax.microedition.io.*;
import net.rim.device.api.io.http.*;
import net.rim.device.api.util.StringUtilities;

/**
 * An example of the HttpFilterRegistry apis.
 */
public final class Protocol implements FilterBaseInterface, HttpConnection
{
    private String         _url;
    private String         _requestMethod;
    private HttpHeaders    _requestHeaders;
    private HttpHeaders    _responseHeaders;
    private byte[]         _resultData;
    
    private final static byte[] PAGE_DATA = "<html><body>This is a simple page that contains two links to precanned <a href=\"http://content.blackberry.com/italic.html\">Italic</a> and <a href=\"http://content.blackberry.com/bold.html\">Bold</a> content.</body></html>".getBytes();
    private final static byte[] BOLD_PAGE_DATA = "<html><body>This is a simple page that contains <b>bold</b> content.</body></html>".getBytes();
    private final static byte[] ITALIC_PAGE_DATA = "<html><body>This is a simple page that contains <i>italic</i> content.</body></html>".getBytes();
    
    /**
     * This function will open a filtered Http Connection.
     * 
     * @see net.rim.device.api.io.FilterBaseInterface#openFilter(String, int, boolean)
     */
    public Connection openFilter( String name, int mode, boolean timeouts ) throws IOException
    {
        _url = name.substring(2);
        _requestHeaders = new HttpHeaders();
        _responseHeaders = new HttpHeaders();
        _responseHeaders.setProperty(HttpProtocolConstants.HEADER_CONTENT_TYPE, "text/html");
        
        // Attempt to parse for the file name.
        int slashIndex = name.indexOf('/', 2);
        if (slashIndex != -1) {
            
            // There is a slash; now get the path and file name and match against predefined
            // strings.
            String file = name.substring(slashIndex+1);
            if (StringUtilities.startsWithIgnoreCase(file, "italic.html")) 
            {
                _resultData = ITALIC_PAGE_DATA;
            } 
            else if (StringUtilities.startsWithIgnoreCase(file, "bold.html")) 
            {
                _resultData = BOLD_PAGE_DATA;
            }
        }
        
        // If we haven't found a match; return default page.
        if (_resultData == null) 
        {
            _resultData = PAGE_DATA;
        }
        
        return this;
    }
    
    /**
     * @see javax.microedition.io.HttpConnection#getURL()
     */
    public String getURL()
    {
        return "http://" + _url;
    }

    /**
     * @see javax.microedition.io.HttpConnection#getProtocol()
     */
    public String getProtocol()
    {
        return "http";
    }

    /**
     * @see javax.microedition.io.HttpConnection#getHost()
     */
    public String getHost()
    {
        return "www.blackberry.net";
    }

    /**
     * @see javax.microedition.io.HttpConnection#getFile()
     */
    public String getFile()
    {
        return "";
    }

    /**
     * @see javax.microedition.io.HttpConnection#getRef()
     */
    public String getRef()
    {
        return "";
    }

    /**
     * @see javax.microedition.io.HttpConnection#getQuery()
     */
    public String getQuery()
    {
        return "";
    }

    /**
     * @see javax.microedition.io.HttpConnection#getPort()
     */
    public int getPort()
    {
        return 80;
    }

    /**
     * @see javax.microedition.io.HttpConnection#getRequestMethod()
     */
    public String getRequestMethod()
    {
        return (_requestMethod == null) ? "GET" : _requestMethod;
    }

    /**
     * @see javax.microedition.io.HttpConnection#setRequestMethod(String)
     */
    public void setRequestMethod(String method) throws IOException
    {
        _requestMethod = method;
    }

    /**
     * @see javax.microedition.io.HttpConnection#getRequestProperty(String)
     */
    public String getRequestProperty(String key)
    {
        return _requestHeaders.getPropertyValue(key);
    }

    /**
     * @see javax.microedition.io.HttpConnection#setRequestProperty(String, String)
     */
    public void setRequestProperty(String key, String value) throws IOException
    {
        _requestHeaders.setProperty(key, value);
    }

    /**
     * @see javax.microedition.io.HttpConnection#getResponseCode()
     */
    public int getResponseCode() throws IOException
    {
        return 200;
    }

    /**
     * @see javax.microedition.io.HttpConnection#getResponseMessage()
     */
    public String getResponseMessage() throws IOException
    {
        return "OK";
    }

    /**
     * @see javax.microedition.io.HttpConnection#getExpiration()
     */
    public long getExpiration() throws IOException
    {
        String value = getHeaderField( HttpProtocolConstants.HEADER_EXPIRES );
        if (value != null) 
        {
            try 
            {
                return HttpDateParser.parse( value );
            } 
            catch (Exception e) 
            {
            }
        }
        
        return 0;
    }

    /**
     * @see javax.microedition.io.HttpConnection#getDate()
     */
    public long getDate() throws IOException
    {
        String value = getHeaderField( HttpProtocolConstants.HEADER_DATE );
        if ( value != null) 
        {
            try 
            {
                return HttpDateParser.parse( value );
            } 
            catch (Exception e) 
            {
            }
        }
        
        return 0;
    }

    /**
     * @see javax.microedition.io.HttpConnection#getLastModified()
     */
    public long getLastModified() throws IOException
    {
        // Return current time.
        return System.currentTimeMillis();
    }

    /**
     * @see javax.microedition.io.HttpConnection#getHeaderField(String)
     */
    public String getHeaderField(String name) throws IOException
    {
        return _responseHeaders.getPropertyValue(name);
    }

    /**
     * @see javax.microedition.io.HttpConnection#getHeaderFieldInt(String, int)
     */
    public int getHeaderFieldInt(String name, int def) throws IOException
    {
        String value = _responseHeaders.getPropertyValue(name);
        try 
        {
            if (value != null) 
            {
                return Integer.parseInt( value );
            }
        } 
        catch( NumberFormatException e ) 
        {
        }
        
        return def;
    }

    /**
     * @see javax.microedition.io.HttpConnection#getHeaderFieldDate(String, long)
     */
    public long getHeaderFieldDate(String name, long def) throws IOException
    {
        String value = _responseHeaders.getPropertyValue(name);
        
        try 
        {
            if (value != null) 
            {
                return HttpDateParser.parse( value );
            }
        } 
        catch( Exception e ) 
        {
        }
        
        return def;
    }

    /**
     * @see javax.microedition.io.HttpConnection#getHeaderField(int)
     */
    public String getHeaderField(int n) throws IOException
    {
        return _responseHeaders.getPropertyValue(n);
    }

    /**
     * @see javax.microedition.io.HttpConnection#getHeaderFieldKey(int)
     */
    public String getHeaderFieldKey(int n) throws IOException
    {
        return _responseHeaders.getPropertyKey(n);
    }
 
    /**
     * @see javax.microedition.io.HttpConnection#getType()
     */
    public String getType()
    {
        try 
        {
            return getHeaderField( HttpProtocolConstants.HEADER_CONTENT_TYPE );
        } 
        catch( IOException e ) 
        {
            return null;
        }
    }

    /**
     * @see javax.microedition.io.HttpConnection#getEncoding()
     */
    public String getEncoding()
    {
        try 
        {
            return getHeaderField( HttpProtocolConstants.HEADER_CONTENT_ENCODING );
        } 
        catch( IOException e ) 
        {
            return null;
        }
    }

    /**
     * @see javax.microedition.io.HttpConnection#getLength()
     */
    public long getLength()
    {
        try 
        {
            return getHeaderFieldInt(HttpProtocolConstants.HEADER_CONTENT_LENGTH, -1);
        } 
        catch (IOException e)
        {
        }
        
        return -1;
    }

    /**
     * @see javax.microedition.io.HttpConnection#openInputStream()
     */
    public InputStream openInputStream() throws IOException
    {
        return new ByteArrayInputStream(_resultData);
    }

    /**
     * @see javax.microedition.io.HttpConnection#openDataInputStream()
     */
    public DataInputStream openDataInputStream() throws IOException
    {
        return new DataInputStream(openInputStream());
    }

    /**
     * @see javax.microedition.io.HttpConnection#openOutputStream()
     */
    public OutputStream openOutputStream() throws IOException
    {
        return new ByteArrayOutputStream();
    }

    /**
     * @see javax.microedition.io.HttpConnection#openDataOutputStream()
     */
    public DataOutputStream openDataOutputStream() throws IOException
    {
        return new DataOutputStream(openOutputStream());
    }

    /**
     * @see javax.microedition.io.HttpConnection#close()
     */
    public void close() throws IOException
    {
    }
    
}
