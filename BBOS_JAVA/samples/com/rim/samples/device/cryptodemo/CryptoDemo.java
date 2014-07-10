/**
 * CryptoDemo.java
 * A simple crypto example
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

package com.rim.samples.device.cryptodemo;

import java.io.*;
import net.rim.device.api.crypto.*;
import net.rim.device.api.util.*;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;
import net.rim.device.api.util.*;

/**
 * This class provides demonstrates basic functionality of the crypto library with
 * a very basic compilation of cypto code.  For more information on how to write 
 * crypto code please see the javadocs and check out our tutorial in the Developers
 * Knowledge Base. The javadocs contain additional sample code to assist you.
 */
public class CryptoDemo extends UiApplication
{
    
    private RichTextField _status;

    /**
     * Entry point for Application.
     */
    public static void main( String[] args )
    {
        CryptoDemo theApp = new CryptoDemo();
        theApp.enterEventDispatcher();
    }

    /**
     * Constructor
     */
    public CryptoDemo()
    {
        MainScreen screen = new MainScreen();
        screen.setTitle(new LabelField("Crypto Demo", LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH));

        _status = new RichTextField("Select 'Go' from the menu to perform the test.");
        screen.add(_status);
        
        // Add the menu item.
        screen.addMenuItem(new MenuItem("Go" , 100, 10)
        {
            public void run()
            {
                go();
            }
        });

        pushScreen(screen);
    }

    /**
     * <p> The test method containing the sample code.
     * <p> We want to create a sample that will encrypt and decrypt
     * test data to demonstrate how a simple crypto example can be
     * implemented.
     */
    public void go()
    {
        try 
        {
            // We are going to use TripleDES as the algorithm for encrypting and decrypting 
            // the data. It is a very common algorithm and was chosen for this reason.

            // Here is the data that we are going to encrypt.
            String message = "Using the crypto api is as easy as pie.";

            // Create a new random TripleDESKey.
            TripleDESKey key = new TripleDESKey();

            // Create the encryption engine for encrypting the data.
            TripleDESEncryptorEngine encryptionEngine = new TripleDESEncryptorEngine( key );

            // Due to the fact that in most cases the data that we are going to encrypt will
            // not fit perfectly into the block length of a cipher, we want to use a padding
            // algorithm to pad out the last block (if necessary). We are going to use PKCS5 
            // to do the padding for us.
            PKCS5FormatterEngine formatterEngine = new PKCS5FormatterEngine( encryptionEngine );

            // Use the byte array output stream to catch the encrypted information.
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

            // Create a block encryptor which will help us use the triple des engine.
            BlockEncryptor encryptor = new BlockEncryptor( formatterEngine, outputStream );

            // Encrypt the actual data.
            encryptor.write( message.getBytes() );

            // Close the stream. This forces the extra bytes to be padded out if there were
            // not enough bytes to fill all of the blocks.
            encryptor.close();

            // Get the actual encrypted data.
            byte[] encryptedData = outputStream.toByteArray();

            // End of Encryption.
            //-----------------------------------------------------------------------------------------------
            // Beginning of Decryption.

            // We are now going to perform the decryption.  We want to ensure that the 
            // message we get back is same as the original. Note that since this is a 
            // symmetric algorithm we want to use the same key as before.
            TripleDESDecryptorEngine decryptorEngine = new TripleDESDecryptorEngine( key );

            // Create the unformatter engine that will remove any of the padding bytes.
            PKCS5UnformatterEngine unformatterEngine = new PKCS5UnformatterEngine( decryptorEngine );

            // Set up an input stream to hand the encrypted data to the block decryptor.
            ByteArrayInputStream inputStream = new ByteArrayInputStream( encryptedData );

            // Create the block decryptor passing in the unformatter engine and the 
            // encrypted data.
            BlockDecryptor decryptor = new BlockDecryptor( unformatterEngine, inputStream );

            // Now we want to read from the stream. We are going to read the data 10 bytes 
            // at a time and then add that new data to the decryptedData array.  It is 
            // important to note that for efficiency one would most likely want to use a 
            // larger value than 10.  We use a small value so that we can demonstrate 
            // several iterations through the loop.
            byte[] temp = new byte[10];
            DataBuffer db = new DataBuffer();
            
            for( ;; ) 
            {
                int bytesRead = decryptor.read( temp );
                
                if( bytesRead <= 0 )
                {
                    // We have run out of information to read, bail out of loop.
                    break;
                }
                
                db.write(temp, 0, bytesRead);
            }

            // Now we want to ensure that the decrypted data is the same as the data we 
            // passed into the encryptor.
            byte[] decryptedData = db.toArray();
            
            if( Arrays.equals( message.getBytes(), decryptedData ) ) 
            {
                // They are the same.
                _status.setText("Test Passed.  The message is identical.");
                
            } 
            else 
            {
                // They differ.
                _status.setText("Test Failed.  The messages are different.");
            }
        } 
        catch( CryptoTokenException e ) 
        {
            System.out.println(e.toString());
        } 
        catch (CryptoUnsupportedOperationException e) 
        {
            System.out.println(e.toString());
        } 
        catch( IOException e ) 
        {
            System.out.println(e.toString());
        }
   }
}

