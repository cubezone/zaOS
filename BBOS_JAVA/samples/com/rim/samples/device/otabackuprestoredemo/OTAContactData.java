/**
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

package com.rim.samples.device.otabackuprestoredemo;

import net.rim.device.api.synchronization.*;
import net.rim.device.api.util.Persistable;

public class OTAContactData implements SyncObject, Persistable
{
    private int _uid;
    private String _first, _last, _email;
    
    public OTAContactData()
    {
    }
    
    public OTAContactData(int uid)
    {
        _uid = uid;
    }
    
    public void setUID(int uid)
    {
        _uid = uid;
    }

    public int getUID()
    {
        return _uid;
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
    
    public void setEmail(String email)
    {
        _email = email;
    }
    
    public String getEmail()
    {
        return _email;
    }
    
    public boolean equals(Object o)
    {
        if(o instanceof OTAContactData)
        {
            if (getFirst().equals(((OTAContactData)o).getFirst()) && (getLast().equals(((OTAContactData)o).getLast())))
            {
                return true;
            }
        }
        
        return false;
    }
}    
