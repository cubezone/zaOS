/*
 * XMLDemoScreen.java
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

package com.rim.samples.device.xmldemo;

import java.io.InputStream;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.MainScreen;
import net.rim.device.api.xml.parsers.*;
import org.w3c.dom.*;


/**
 * The main screen for the application.  Displays the results of parsing the XML file.
 */
/*package*/ final class XMLDemoScreen extends MainScreen
{
    // Statics -------------------------------------------------------------------------------------
    private static String _xmlFileName = "/xml/bookstore.xml";
    
    // Constants -----------------------------------------------------------------------------------
    private static final int _tab = 4;
    
    
    /**
     * This constructor parses the XML file into a W3C DOM document, and displays it 
     * on the screen.
     * 
     * @see Document
     * @see DocumentBuilder
     * @see DocumentBuilderFactory
     */
    public XMLDemoScreen() 
    {
        setTitle( new LabelField( "XML Demo" , LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH ) );
        
        try 
        {
            // Build a document based on the XML file.
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            InputStream inputStream = getClass().getResourceAsStream( _xmlFileName );
            Document document = builder.parse( inputStream );
            
            // Normalize the root element of the XML document.  This ensures that all Text 
            // nodes under the root node are put into a "normal" form, which means that 
            // there are neither adjacent Text nodes nor empty Text nodes in the document.
            // See Node.normalize().
            Element rootElement = document.getDocumentElement();
            rootElement.normalize();
            
            // Display the root node and all its descendant nodes, which covers the entire
            // document.
            displayNode( rootElement, 0 );
        } 
        catch ( Exception e ) 
        {
            System.out.println( e.toString() );
        }
    }
    
    
    /**
     * Displays a node at a specified depth, as well as all its descendants.
     * 
     * @param node The node to display.
     * @param depth The depth of this node in the document tree.
     */
    private void displayNode( Node node, int depth ) 
    {        
        // Because we can inspect the XML file, we know that it contains only XML elements
        // and text, so this algorithm is written specifically to handle these cases.  
        // A real-world application will be more robust, and will handle all node types. 
        // See the entire list in org.w3c.dom.Node.      
        // The XML file is laid out such that each Element node will either have one Text 
        // node child (e.g. <Element>Text</Element>), or >= 1 children consisting of at 
        // least one Element node, and possibly some Text nodes.  Start by figuring out
        // what kind of node we're dealing with.
        if ( node.getNodeType() == Node.ELEMENT_NODE ) 
        {
            StringBuffer buffer = new StringBuffer();
            indentStringBuffer( buffer, depth );
            NodeList childNodes = node.getChildNodes();
            int numChildren = childNodes.getLength();
            Node firstChild = childNodes.item( 0 );
            
            // If the node has only one child and that child is a Text node, then it's of 
            // the form  <Element>Text</Element>, so print 'Element = "Text"'.
            if ( numChildren == 1 && firstChild.getNodeType() == Node.TEXT_NODE ) 
            {
                buffer.append( node.getNodeName() ).append( " = \"" ).append( firstChild.getNodeValue() ).append( '"' );
                add( new RichTextField( buffer.toString() ) );
            } 
            else 
            {
                // The node either has > 1 children, or it has at least one Element node child. 
                // Either way, its children have to be visited.  Print the name of the element
                // and recurse.
                buffer.append( node.getNodeName() );
                add( new RichTextField( buffer.toString() ) );
                
                // Recursively visit all this node's children.
                for ( int i = 0; i < numChildren; ++i ) 
                {
                    displayNode( childNodes.item( i ), depth + 1 );
                }
            }
        } 
        else 
        {
            // Node is not an Element node, so we know it is a Text node.  Make sure it is 
            // not an "empty" Text node (normalize() doesn't consider a Text node consisting
            // of only newlines and spaces to be "empty").  If it is not empty, print it.
            String nodeValue = node.getNodeValue();
            if ( nodeValue.trim().length() != 0 ) 
            {
                StringBuffer buffer = new StringBuffer();
                indentStringBuffer( buffer, depth );
                buffer.append( '"' ).append( nodeValue ).append( '"' );
                add( new RichTextField( buffer.toString() ) );
            }
        }
    }
    
    
    /**
     * Adds leading spaces to the provided string buffer according to the depth of 
     * the node it represents.
     * 
     * @param buffer The string buffer to add leading spaces to.
     * @param depth The depth of the node the string buffer represents.
     */
    private static void indentStringBuffer( StringBuffer buffer, int depth ) 
    {
        int indent = depth * _tab;
        
        for ( int i = 0; i < indent; ++i ) 
        {
            buffer.append( ' ' );
        }
    }
}
