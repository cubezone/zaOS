/*
 * MyCryptoTokenData.java
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

package com.rim.samples.device.smartcarddriverdemo;

import net.rim.device.api.crypto.*;
import net.rim.device.api.smartcard.*;
import net.rim.device.api.util.*;

/**
 * Stores the location of the private key file on the smart card, as well as which
 * smart card the private key is stored on.
 */
final class MyCryptoTokenData implements CryptoTokenPrivateKeyData, Persistable
{
    /**
     * The smart card the private key is stored on.
     */
    private SmartCardID _id;
    
    /**
     * The file location of the private key on the smart card.
     */
    private byte _file;

    /**
     * Constructs a <code>MyCryptoTokenData</code> object.
     * @param id which smart card contains the private key
     * @param file which file on the smart card contains the private key
     */
    public MyCryptoTokenData( SmartCardID id, byte file )
    {
        _id = id;
        _file = file;
    }

    /**
     * Get the <code>SmartCardID</code>, which indicates which smart card the private
     * key is stored on.
     * @return the <code>SmartCardID</code> of the smart card which the private key is
     *  stored on.
     */
    public SmartCardID getSmartCardID()
    {
        return _id;
    }

    /**
     * Gets the private key file location on the card.
     * @return the private key file location on the card.
     */
    public byte getFile()
    {
        return _file;
    }
}

