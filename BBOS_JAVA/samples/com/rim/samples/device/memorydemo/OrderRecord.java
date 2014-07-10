/*
 * OrderRecord.java
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

package com.rim.samples.device.memorydemo;

import java.util.*;
import net.rim.device.api.util.Persistable;


/**
 * Represents an order record for a fictional business.
 */
/*package*/ final class OrderRecord implements Persistable
{
    // Members -------------------------------------------------------------------------------------
    private long _date;       // The date this ordered was placed on.
    private String _company;  // The company from which this order was made.
    private String _product;  // The product that was ordered.
    private int _numOrdered;  // The number of units ordered.
    
    
    /**
     * This constructor simply fills in the data values in this record.
     * 
     * @param date The date this order was placed on.
     * @param company The company this order was placed with.
     * @param product The product that was ordered.
     * @param numOrdered The number of units ordered.
     */
    public OrderRecord( long date, String company, String product, int numOrdered ) 
    {
        _date = date;
        _company = company;
        _product = product;
        _numOrdered = numOrdered;
    }
    
    
    /**
     * Retrieves the date on this order record.
     * 
     * @return The date on this order record.
     */
    public long getDate() 
    {
        return _date;
    }
    
    
    /**
     * Sets the date on this order record.
     * 
     * @param date This order record's new date.
     */
    public void setDate( long date ) 
    {
        _date = date;
    }
    
    
    /**
     * Retrieves the company on this order record.
     * 
     * @return The company on this order record.
     */
    public String getCompany() 
    {
        return _company;
    }
    
    
    /**
     * Sets the company on this order record.
     * 
     * @param company This order record's new company.
     */
    public void setCompany( String company ) 
    {
        _company = company;
    }
    
    
    /**
     * Retrieves the product on this order record.
     * 
     * @return The product on this order record.
     */
    public String getProduct() 
    {
        return _product;
    }
    
    
    /**
     * Sets the product on this order record.
     * 
     * @param product This order record's new product.
     */
    public void setProduct( String product ) 
    {
        _product = product;
    }
    
    
    /**
     * Retrieves this order record's number of units.
     * 
     * @return The number of units on this order record.
     */
    public int getNumOrdered() 
    {
        return _numOrdered;
    }
    
    
    /**
     * Sets this order record's number of units.
     * 
     * @param numOrdered This order record's new number of units.
     */
    public void setNumOrdered( int numOrdered ) 
    {
        _numOrdered = numOrdered;
    }
    
    
    /**
     * Retrieves a string representation of this order record.
     * 
     * @return The string representation.
     */
    public String toString() 
    {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime( new Date( _date ) );
        
        int day = calendar.get( Calendar.DAY_OF_MONTH );
        int month = calendar.get( Calendar.MONTH ) + 1;
        int year = calendar.get( Calendar.YEAR );
        
        StringBuffer buffer = new StringBuffer(); 
        
        buffer.append( day ).append( '/' ).append( month ).append( '/' ).append( year ).append( ": " ).append( _numOrdered )
              .append( " " ).append( _product ).append( "s from " ).append( _company );
              
        return buffer.toString();
    }
}
