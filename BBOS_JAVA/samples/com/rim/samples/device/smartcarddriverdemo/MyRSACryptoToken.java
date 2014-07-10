/*
 * MyRSACryptoToken.java
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

package com.rim.samples.device.smartcarddriverdemo;


import net.rim.device.api.smartcard.*;
import net.rim.device.api.crypto.*;
import net.rim.device.api.crypto.keystore.*;
import net.rim.device.api.util.*;
import net.rim.device.api.crypto.certificate.x509.*;
import net.rim.device.api.crypto.certificate.*;
import net.rim.device.api.crypto.asn1.*;
import net.rim.device.api.compress.*;
import net.rim.device.api.i18n.*;

/**
 * An implementation of an RSA cryptographic token.
 * 
 * The RIM Crypto API will call this interface when a private key RSA operation is to be
 * performed.  The operation should be delegated to the smart card.
 */
final class MyRSACryptoToken extends RSACryptoToken implements Persistable
{
    private static final String DECRYPT_DESC = "The private key will be used to decrypt encrypted data.";
    private static final String SIGN_DESC = "The private key will be used to generate a digital signature.";
    
    /**
     * Constructs a <code>MyRSACryptoToken</code> object.
     */
    MyRSACryptoToken()
    {
    }
    
    /**
     * Determine if this token does the user authentication for the system.  If not, the
     * <code>KeyStore</code> will prompt for the key store password when the user tries
     * to access the private key.
     * @return true if this token will prompt for the necessary user authentication when
     *  private key access is requested.
     */
    public boolean providesUserAuthentication()
    {
        return true;
    }

    /** 
     * Indicates whether the chosen operation is supported by this CryptoToken using the
     * provided CryptoSytem.
     * <p>
     * @param cryptoSystem The CryptoSystem to check against.
     * @param operation An integer, either KEY_GENERATION, PUBLIC_KEY_OPERATION, PRIVATE_KEY_OPERATION,
     *  or some other value specific to the cryptosystem that indicates the operation to be checked.
     */
    public boolean isSupported( CryptoSystem cryptoSystem, int operation )
    {
        return ( operation == PRIVATE_KEY_OPERATION );
    }

    /**
     * Returns a boolean that determines if the given key and crypto system
     * support RSA encryption.
     * <p>
     * @param cryptoSystem The crypto system to check.
     * @param privateKeyData The private key data.
     * @return A boolean that indicates if the token supports RSA encryption.
     * @throws CryptoTokenException Thrown if an error occurs with a crypto
     *  token or the crypto token is invalid.
     */
    public boolean isSupportedDecryptRSA( RSACryptoSystem cryptoSystem, CryptoTokenPrivateKeyData privateKeyData )
            throws CryptoTokenException
    {
        return privateKeyData instanceof MyCryptoTokenData;
    }

    /**
     * Performs a raw RSA decryption operation.
     * <p>
     * Notes: The token should do a raw RSA private key operation on the input data to
     * reveal the plaintext bytes.  The plaintext bytes will typically be padded; the type
     * of padding will depend on the application which encrypted the data.  Typically PKCS
     * #1 version 2.0 will be used for padding the data, but other schemes (such as OAEP)
     * could be used.  If the token removes the padding, this method will need to re-add the
     * same type of padding before returning.  Data encrypted with BlackBerry's S/MIME
     * implementation currently uses PKCS #1 padding but may use other padding methods in
     * the future.
     * <p>
     * @param cryptoSystem The crypto system associated with the token.
     * @param privateKeyData The RSA private key.
     * @param input The input data.
     * @param inputOffset The offset in the input data to begin reading from.
     * @param output The buffer for the output data.
     * @param outputOffset The offset in the output buffer to begin writing at.
     * @throws CryptoTokenException Thrown if an error occurs with a crypto token or the
     *  crypto token is invalid.
     */
    public void decryptRSA( RSACryptoSystem cryptoSystem,
                            CryptoTokenPrivateKeyData privateKeyData,
                            byte[] input, int inputOffset,
                            byte[] output, int outputOffset )
                throws CryptoTokenException
    {
        try 
        {
            signDecryptHelper( cryptoSystem, privateKeyData, input, inputOffset, output, outputOffset, DECRYPT_DESC, SmartCardSession.DECRYPT_OPERATION );
        } 
        catch ( CryptoUnsupportedOperationException e ) 
        {
            throw new CryptoTokenException( e.toString() );
        }
    }

    /**
     * Performs a raw RSA signature operation.
     * <p>
     * Notes: The token should do a raw RSA private key operation on the input data. The
     * input data will typically be padded; the type of padding will depend on the application
     * requesting the signature.  Typically PKCS #1 version 2.0 will be used for padding the
     * data, but other schemes (such as PSS or ANSI X9.31) could be used.  If the token requires
     * that the padding be removed before signing, this method will need to detect the type of
     * padding currently being used and remove it.  The token should only re-apply the same type
     * of padding which was originally applied to the data.  If the token is unable to re-apply
     * the same type of padding, a CryptoUnsupportedOperationException should be thrown.  Signature
     * requests which come from BlackBerry's S/MIME implementation currently use PKCS #1 padding
     * but may use other padding methods in the future.
     * <p>
     * @param cryptoSystem The crypto system associated with the token.
     * @param privateKeyData The RSA private key.
     * @param input The input data.
     * @param inputOffset The offset in the input data to begin reading from.
     * @param output The buffer for the output data.
     * @param outputOffset The offset in the output buffer to begin writing at.
     * @throws CryptoTokenException Thrown if an error occurs with the crypto token or the crypto
     *  token is invalid.
     * @throws CryptoUnsupportedOperationException Thrown if a call is made to an unsupported
     *  operation or if the token does not support signing due to the type of padding around the
     *  encoded message.
     */
    public void signRSA(    RSACryptoSystem cryptoSystem, 
                            CryptoTokenPrivateKeyData privateKeyData, 
                            byte[] input, int inputOffset,
                            byte[] output, int outputOffset )
            throws CryptoTokenException, CryptoUnsupportedOperationException
    {
        signDecryptHelper( cryptoSystem, privateKeyData, input, inputOffset, output, outputOffset, SIGN_DESC, SmartCardSession.SIGN_OPERATION );
    }

    /**
     * A helper method for signing and decrypting since the operations are very similar.
     */
    private void signDecryptHelper( RSACryptoSystem cryptoSystem, 
                                    CryptoTokenPrivateKeyData privateKeyData, 
                                    byte[] input, int inputOffset,
                                    byte[] output, int outputOffset,
                                    String accessReason,
                                    int operation )
            throws CryptoTokenException, CryptoUnsupportedOperationException
    {
        SmartCardSession smartCardSession = null;
        try 
        {
            
            if( privateKeyData instanceof MyCryptoTokenData ) 
            {
                SmartCardID smartCardID = ((MyCryptoTokenData) privateKeyData ).getSmartCardID();
                smartCardSession = SmartCardFactory.getSmartCardSession( smartCardID );
                
                if ( smartCardSession instanceof MyCryptoSmartCardSession ) 
                {
                    MyCryptoSmartCardSession mySmartCardSession = ( MyCryptoSmartCardSession )smartCardSession;
                    
                    // We must provide the user authentication since we returned true from providesUserAuthentication()
                    // Also, the smart card PIN is required for private key access.
                    mySmartCardSession.loginPrompt( accessReason, operation );
                    
                    mySmartCardSession.signDecrypt( cryptoSystem, (MyCryptoTokenData)privateKeyData, input, inputOffset, output, outputOffset );

                    return;
                }
            }
            
            throw new RuntimeException();

        } 
        catch ( SmartCardSessionClosedException e ) 
        {
            throw new CryptoTokenCancelException( e.toString() );
        } 
        catch ( SmartCardCancelException e ) 
        {
            throw new CryptoTokenCancelException( e.toString() );
        } 
        catch( SmartCardRemovedException e ) 
        {
            throw new CryptoTokenCancelException( e.toString() );
        } 
        catch ( SmartCardException e ) 
        {
            throw new CryptoTokenException( e.toString() );
        } 
        finally 
        {
            if ( smartCardSession != null ) 
            {
                smartCardSession.close();
            }
        }
    }
}
