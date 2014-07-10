/*
 * PointScreen.java
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

package com.rim.samples.device.gpsdemo;

import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.*;
import net.rim.device.api.io.*;
import net.rim.device.api.system.*;
import javax.microedition.io.*;
import java.util.*;
import java.io.*;
import javax.microedition.location.*;
import com.rim.samples.device.gpsdemo.GPSDemo.WayPoint;

/*
* PointScreen is a screen derivative that renders the saved WayPoints.
*/
public class PointScreen extends MainScreen implements ListFieldCallback
{
    private Vector _points;
    private ListField _listField;
    
    public PointScreen(Vector points)
    {
        
        LabelField title = new LabelField("Previous WayPoints", LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH);
         setTitle(title);
         
        _points = points;
        _listField = new ListField();   
        _listField.setCallback(this);  
        add(_listField);
        
        reloadWayPointList();
    }    
    
    private void reloadWayPointList()
    {           
            // Refreshes wayPoint list on screen.
            _listField.setSize(_points.size());            
    }
       
    // ListFieldCallback methods -----------------------------------------------------------------------------------
    /**
     * @see net.rim.device.api.ui.component.ListFieldCallback#drawListRow(ListField , Graphics , int , int , int)
     */
    public void drawListRow(ListField listField, Graphics graphics, int index, int y, int width) 
    {
        if ( listField == _listField && index < _points.size())
        {
            String name = "Waypoint " + index;
            graphics.drawText(name, 0, y, 0, width);
        }
    }
    
    /**
     * @see net.rim.device.api.ui.component.ListFieldCallback#get(ListField , int)
     */
    public Object get(ListField listField, int index)
    {
        if ( listField == _listField )
        {
            // If index is out of bounds an exception will be thrown, but that's the behaviour we want in that case.
            return _points.elementAt(index);
        }
        
        return null;
    }
    
    /**
    * @see net.rim.device.api.ui.component.ListFieldCallback#getPreferredWidth(ListField)
    */
    public int getPreferredWidth(ListField listField) 
    {
        // Use all the width of the current LCD.
        return Display.getWidth();
    }
    
    /**
    * @see net.rim.device.api.ui.component.ListFieldCallback#indexOfList(ListField , String , int)
    */
    public int indexOfList(ListField listField, String prefix, int start) 
    {
        return -1; // Not implemented.
    }   
    
    // Menu items ---------------------------------------------------------------
    private class ViewPointAction extends MenuItem
    {
        private int _index;
        
        public ViewPointAction( int index )
        {
            super("View" , 100000, 10);
            _index = index;
        }
        
        public void run()
        {
            ViewScreen screen = new ViewScreen( (WayPoint)_points.elementAt(_index), _index) ;
            UiApplication.getUiApplication().pushModalScreen( screen );            
        }
    }
    
    private class DeletePointAction extends MenuItem
    {
        private int _index;
        
        public DeletePointAction( int index )
        {
            super("Delete" , 100000, 10);
            _index = index;
        }
        
        public void run()
        {
            GPSDemo.removeWayPoint((WayPoint)_points.elementAt(_index));  
            reloadWayPointList();    
        }
    }    
    
    /**
     * @see net.rim.device.api.ui.container.MainScreen#makeMenu(Menu,int)
     */
    protected void makeMenu(Menu menu, int instance)
    {        
        if( _points.size() > 0 ) 
        {
            ViewPointAction viewPointAction = new ViewPointAction( _listField.getSelectedIndex() );
            menu.add( viewPointAction );
            menu.addSeparator();
            
            DeletePointAction deletePointAction = new DeletePointAction( _listField.getSelectedIndex() );
            menu.add( deletePointAction );
        }        
        
        super.makeMenu(menu, instance);
    }
    
    /**
     * Renders a particular Waypoint
     */
    private static class ViewScreen extends MainScreen 
    {
        private MenuItem _cancel;
        
        public ViewScreen(WayPoint point, int count)
        {
            super();  
                             
            LabelField title = new LabelField("Waypoint" + count , LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH);        
            setTitle(title);
                                   
            Date date = new Date(point._startTime);
            String startTime = date.toString();
            date = new Date(point._endTime);
            String endTime = date.toString();
            
            float avgSpeed = point._distance/(point._endTime - point._startTime);
            
            add(new BasicEditField("Start: " , startTime, 30, Field.READONLY));
            add(new BasicEditField("End: " , endTime, 30, Field.READONLY));
            add(new BasicEditField("Horizontal Distance (m): " , Float.toString(point._distance), 30, Field.READONLY));
            add(new BasicEditField("Vertical Distance (m): " , Float.toString(point._verticalDistance), 30, Field.READONLY));
            add(new BasicEditField("Average Speed(m/s): " , Float.toString(avgSpeed), 30, Field.READONLY));
        }        

        private class CancelMenuItem extends MenuItem 
        {
            public CancelMenuItem()
            {
                // Reuse an identical resource below.
                super("Cancel" , 300000, 10);
            }
            
            public void run()
            {
                UiApplication uiapp = UiApplication.getUiApplication();
                uiapp.popScreen(ViewScreen.this);
            }
        };               
         
        protected void makeMenu( Menu menu, int instance )
        {
            if ( _cancel == null )
            {
                 _cancel = new CancelMenuItem(); // Create on demand.
            }
            
            menu.add(_cancel);
            
            super.makeMenu(menu, instance);
        }
    }    
}
