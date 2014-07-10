/*
 * OTAContactData.java
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

package com.rim.samples.device.otasyncdemo;

import net.rim.device.api.synchronization.*;
import net.rim.device.api.util.Persistable;

public class OTAContactData implements SyncObject, Persistable
{
    private int _guid = 0;
    private String _first, _last, _email, _phone;
    
    public OTAContactData()
    {
        _first = "";
        _last = "";
        _email = "";
        _phone = "";
    }
    
    public OTAContactData(int guid)
    {
        this();
        _guid = guid;
    }

    public int getGUID()
    {
        return _guid;
    }
    
    public int getUID() 
    {
        return _guid;
    }
    
    public void setGUID( int guid)
    {
        _guid = guid;
    }
    
    public void setFirst(String first)
    {
        _first = first;
    }
    
    public String getFirst()
    {
        return _first;
    }
    
    public void setLast(String last)
    {
        _last = last;
    }
    
    public String getLast()
    {
        return _last;
    }
    
    public void setEmail( String email ) 
    {
        _email = email;
    }
    
    public String getEmail() 
    {
        return _email;
    }
    
    public void setPhone( String phone ) 
    {
        _phone = phone;
    }
    
    public String getPhone() 
    {
        return _phone;
    }
    
    public boolean equals(Object o)
    {
        if(o instanceof OTAContactData)
        {
            if (getGUID() == ((OTAContactData)o).getGUID())
            {
                return true;
            }
        }
        
        return false;
    }
}    
