/*
 * MemoryDemoMainScreen.java
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
import net.rim.device.api.lowmemory.*;
import net.rim.device.api.system.Characters;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.ui.container.MainScreen;
import net.rim.device.api.system.*;
import net.rim.device.api.ui.container.DialogFieldManager;
import net.rim.device.api.ui.container.PopupScreen;


/**
 * The main screen for the application.  It displays either a list of customer records,
 * or a list of order records, and provides a menu item to switch between the two.
 */
/*package*/ final class MemoryDemoMainScreen extends MainScreen implements ListFieldCallback, LowMemoryListener
{
    // Members -------------------------------------------------------------------------------------
    private CustomerList _customerList;
    private MyListField _customerListField;
    private OrderList _orderList;
    private MyListField _orderListField;
    private UiApplication _app;
    private MenuItem _simulateLmmLowItem;
    private MenuItem _simulateLmmMediumItem;
    private MenuItem _simulateLmmHighItem;
    private MenuItem _viewCustomerRecordsItem;
    private MenuItem _viewOrderRecordsItem;
    private ProgressBarDialog _progressDialog;
         
    private boolean _viewingCustomerRecords;
    
    // Constants -----------------------------------------------------------------------------------
    private static final int MAX_RECORDS = 1000;


    /**
     * This constructor builds the main screen, prepares menu items for display, 
     * and shows the list of customer records.
     */
    public MemoryDemoMainScreen() 
    {
        super();
        
        setTitle( new LabelField( "Customer Records" , LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH ) );
        
        // Get and display the customer list.
        _customerList = CustomerList.getInstance();
        _customerListField = new MyListField( _customerList.getNumCustomerRecords() );
        _customerListField.setCallback( this );
        add( _customerListField );
        
        // Get the order list.
        _orderList = OrderList.getInstance();
        _orderListField = new MyListField( _orderList.getNumOrderRecords() );
        _orderListField.setCallback( this );
        
        _app = UiApplication.getUiApplication();
        
        // Prepare menu items.
        _simulateLmmLowItem = new SimulateLmmLow();
        _simulateLmmMediumItem = new SimulateLmmMedium();
        _simulateLmmHighItem = new SimulateLmmHigh();
        _viewCustomerRecordsItem = new ViewCustomerRecords();
        _viewOrderRecordsItem = new ViewOrderRecords();
               
        _viewingCustomerRecords = true;
                
        LowMemoryManager.addLowMemoryListener( this );
    }
    

    /**
     * Called when the main screen (and thus, the application) closes.  Removes this 
     * screen as a low memory listener, and commits both the customer and order lists 
     * to the persistent store.
     * 
     * @see net.rim.device.api.ui.Screen#onClose()
     */
    public boolean onClose() 
    {
        LowMemoryManager.removeLowMemoryListener( this );
        _customerList.commit();
        _orderList.commit();
        
        return super.onClose();
    }


    /**
     * Intercepts the ENTER key and displays this screen's menu.
     * 
     * @see net.rim.device.api.ui.Screen#keyChar(char,int,int)
     */
    protected boolean keyChar( char key, int status, int time ) 
    {
        if ( key == Characters.ENTER ) 
        {
            return onMenu( 0 );
        }
        
        return super.keyChar( key, status, time );
    }
    
    
    /**
     * Displays this screen's menu.  Adds options to simulate the Low Memory Manager,
     * and to switch between viewing the customer list and the order list.
     * 
     * @see net.rim.device.api.ui.Screen#makeMenu(Menu,int)
     */
    protected void makeMenu( Menu menu, int instance ) 
    {
        super.makeMenu( menu, instance );
        
        menu.add( _simulateLmmLowItem );
        menu.add( _simulateLmmMediumItem );
        menu.add( _simulateLmmHighItem );
        
        if ( _viewingCustomerRecords ) 
        {
            menu.add( _viewOrderRecordsItem );
        } 
        else 
        {
            menu.add( _viewCustomerRecordsItem );
        }
    }
    
    
    // ListFieldCallback methods -------------------------------------------------------------------
    
    /**
     * @see net.rim.device.api.ui.component.ListFieldCallback#drawListRow(ListField,Graphics,int,int,int)
     */
    public void drawListRow( ListField listField, Graphics graphics, int index, int y, int width ) 
    {
        Object object = get( listField, index );
        
        graphics.drawText( object.toString(), 0, y, 0, width );
    }
    
    
    /**
     * @see net.rim.device.api.ui.component.ListFieldCallback#getPreferredWidth(ListField)
     */
    public int getPreferredWidth( ListField listField ) 
    {
        return Display.getWidth();
    }
    
    
    /**
     * @see net.rim.device.api.ui.component.ListFieldCallback#get(ListField , int)
     */
    public Object get( ListField listField, int index ) 
    {
        if ( listField == _customerListField ) 
        {
            return _customerList.getCustomerRecordAt( index );
        } 
        else 
        {
            return _orderList.getOrderRecordAt( index );
        }
    }
    
    
    /**
     * @see net.rim.device.api.ui.component.ListFieldCallback#indexOfList(ListField , String , int)
     */
    public int indexOfList( ListField listField, String prefix, int start ) 
    {
        return -1; // Not implemented.
    }
    
    
    // LowMemoryListener methods -------------------------------------------------------------------
    
    /**
     * This method is called when the system is running low on memory.  Applications
     * should mark some objects as recoverable, depending on the priority, in order 
     * to free up some memory.
     * 
     * @param priority The priority of the memory cleanup.
     * 
     * @return True if any objects were marked as recoverable; otherwise false.
     * 
     * @see net.rim.device.api.lowmemory.LowMemoryListener#freeStaleObject(int)
     */
    public boolean freeStaleObject( int priority ) 
    {
        boolean freedData = false;
        
        switch ( priority ) 
        {
            case LowMemoryListener.LOW_PRIORITY:
            {
                // Low priority; application should consider releasing transitory variables and 
                // any variables that are currently unnecessary for complete functionality, such as
                // cached data.  This sample application does not cache any variables, so no data 
                // is recovered.
                break;
            }
            
            case LowMemoryListener.MEDIUM_PRIORITY:
            {
                // Medium priority; application should consider removing stale data, such as 
                // very old email messages or old calendar appointments.  This application traverses
                // the list of order records, and removes any that occurred more than 15 years ago, 
                // i.e., very old (stale) order records.
                int numYearsAgo = 15;
                
                Calendar calendar = Calendar.getInstance();
                calendar.setTime( new Date() );
                int year = calendar.get( Calendar.YEAR );
                calendar.set( Calendar.YEAR, year - numYearsAgo );
                freedData = _orderList.removeStaleOrderRecords( calendar.getTime().getTime() );
                _orderListField.setSize( _orderList.getNumOrderRecords() );
                
                break;
            }
            
            case LowMemoryListener.HIGH_PRIORITY:
            {
                // High priority; application should remove objects on a Least Recently Used basis. 
                // The application should remove *all* its stale objects to reduce the amount of 
                // memory consumed on the handheld.  This application traverses the list of customer 
                // records, and removes any that haven't been accessed in the last 10 years, 
                // i.e., the least recently used customer records.
                int numYearsAgo = 10;
                
                Calendar calendar = Calendar.getInstance();
                calendar.setTime( new Date() );
                int year = calendar.get( Calendar.YEAR );
                calendar.set( Calendar.YEAR, year - numYearsAgo );
                freedData = _customerList.removeStaleCustomerRecords( calendar.getTime().getTime() );
                _customerListField.setSize( _customerList.getNumCustomerRecords() );
                
                break;
            }
        }
        
        return freedData;
    }
    
    
    // Private Inner Classes -----------------------------------------------------------------------
    /**
     * List field that has a custom context menu.
     */
    private final class MyListField extends ListField
    {
        public MyListField( int numEntries ) 
        {
            super( numEntries );
        }
        
        
        /**
         * Displays this list field's custom context menu.  If there is at least one item
         * in the list, there are options to view, edit, and delete it (as well as delete 
         * them all).  If there are less than the maximum number of records, there is an 
         * option to fill up the list with random data.
         * 
         * @return The newly-created context menu.
         */
        public ContextMenu getContextMenu() 
        {
            ContextMenu contextMenu = super.getContextMenu();
            
            if ( getSize() > 0 ) 
            {
                int index = getSelectedIndex();
                contextMenu.addItem( new View( index, this ) ); 
                contextMenu.addItem( new Edit( index, this ) );
                contextMenu.addItem( new Delete( index, this ) );
                contextMenu.addItem( new DeleteAll( this ) );
            }
            
            if ( getSize() < /*outer.*/MAX_RECORDS ) 
            {
                contextMenu.addItem( new Populate( this ) );
            }
            
            return contextMenu;
        }
    }
    
    
    /**
     * A menu item to view a record.
     */
    private final class View extends MenuItem
    {
        private int _index;
        private MyListField _listField;
        
        public View( int index, MyListField listField ) 
        {
            super( "View" , 101, 100 );
            _index = index;
            _listField = listField;
        }
        
        
        /**
         * Displays either a customer record or an order record, depending on which 
         * list field was displayed when this menu item was selected.
         */
        public void run() 
        {
            if ( _listField == _customerListField ) 
            {
                CustomerRecord customerRecord = (CustomerRecord) /*outer.*/get( _listField, _index );
                MemoryDemoCustomerScreen screen = new MemoryDemoCustomerScreen( customerRecord, false );
                /*outer.*/_app.pushModalScreen( screen );
                customerRecord = screen.getUpdatedCustomerRecord();
                
                if ( customerRecord != null ) 
                {
                    /*outer.*/_customerList.replaceCustomerRecordAt( _index, customerRecord );
                }
            } 
            else 
            {
                OrderRecord orderRecord = (OrderRecord) /*outer.*/get( _listField, _index );
                MemoryDemoOrderScreen screen = new MemoryDemoOrderScreen( orderRecord, false );
                /*outer.*/_app.pushModalScreen( screen );
                orderRecord = screen.getUpdatedOrderRecord();
                
                if ( orderRecord != null ) 
                {
                    /*outer.*/_orderList.replaceOrderRecordAt( _index, orderRecord );
                }
            }
        }
    }
    
    
    /**
     * A menu item to edit a record.
     */
    private final class Edit extends MenuItem
    {
        private int _index;
        private MyListField _listField;
        
        public Edit( int index, MyListField listField ) 
        {
            super( "Edit" , 102, 102 );
            _index = index;
            _listField = listField;
        }
        
        
        /**
         * Edits either a customer record or an order record, depending on which list
         * field was displayed when this menu item was selected.
         */
        public void run() 
        {
            if ( _listField == _customerListField ) 
            {
                CustomerRecord customerRecord = (CustomerRecord) /*outer.*/get( _listField, _index );
                MemoryDemoCustomerScreen screen = new MemoryDemoCustomerScreen( customerRecord, true );
                /*outer.*/_app.pushModalScreen( screen );
                customerRecord = screen.getUpdatedCustomerRecord();
                
                if ( customerRecord != null ) 
                {
                    /*outer.*/_customerList.replaceCustomerRecordAt( _index, customerRecord );
                }
            } 
            else 
            {
                OrderRecord orderRecord = (OrderRecord) /*outer.*/get( _listField, _index );
                MemoryDemoOrderScreen screen = new MemoryDemoOrderScreen( orderRecord, true );
                /*outer.*/_app.pushModalScreen( screen );
                orderRecord = screen.getUpdatedOrderRecord();
                
                if ( orderRecord != null ) 
                {
                    /*outer.*/_orderList.replaceOrderRecordAt( _index, orderRecord );
                }
            }
        }
    }
    
    
    /**
     * A menu item to delete a record.
     */
    private final class Delete extends MenuItem
    {
        private int _index;
        private MyListField _listField;
        
        public Delete( int index, MyListField listField ) 
        {
            super( "Delete" , 103, 103 );
            _index = index;
            _listField = listField;
        }
        
        
        /**
         * Deletes either a customer record or an order record, depending on which list 
         * field was displayed when this menu item was selected.
         */
        public void run() 
        {
            if ( Dialog.ask( Dialog.D_DELETE ) == Dialog.DELETE ) 
            {
                if ( _listField == _customerListField ) 
                {
                    CustomerRecord customerRecord = (CustomerRecord) /*outer.*/get( _listField, _index );
                    /*outer.*/_customerList.deleteCustomerRecord( customerRecord );
                    /*outer.*/_customerListField.setSize( /*outer.*/_customerList.getNumCustomerRecords() );
                } 
                else 
                {
                    OrderRecord orderRecord = (OrderRecord) /*outer.*/get( _listField, _index );
                    /*outer.*/_orderList.deleteOrderRecord( orderRecord );
                    /*outer.*/_orderListField.setSize( /*outer.*/_orderList.getNumOrderRecords() );
                }
            }
        }
    }
    
    
    /**
     * A menu item to delete all records in a list field.
     */
    private final class DeleteAll extends MenuItem
    {
        private MyListField _listField;
        
        public DeleteAll( MyListField listField ) 
        {
            super( "Delete All" , 104, 104 );
            _listField = listField;
        }
        
        
        /**
         * Either deletes all customer records or deletes all order records, depending 
         * on which list field was displayed when this menu item was selected.
         */
        public void run() 
        {
            if ( Dialog.ask( Dialog.D_DELETE ) == Dialog.DELETE ) 
            {
                if ( _listField == _customerListField ) 
                {
                    /*outer.*/_customerList.deleteAllCustomerRecords();
                    /*outer.*/_customerListField.setSize( 0 );
                } 
                else 
                {
                    /*outer.*/_orderList.deleteAllOrderRecords();
                    /*outer.*/_orderListField.setSize( 0 );
                }
            }
        }
    }
    
    
    /**
     * A menu item to populate a list field.
     */
    private final class Populate extends MenuItem
    {
        private MyListField _listField;
        
        public Populate( MyListField listField ) 
        {
            super( "Populate" , 100000, 100000 );
            _listField = listField;
        }
        
        
        /**
         * Populates either the customer list or the order list, depending on which list
         * field was displayed when this menu item was selected.
         */
        public void run() 
        {
            if ( _listField == _customerListField ) 
            { 
            
                _progressDialog  = new ProgressBarDialog("Generating customer records..." , _customerList.getNumRecordsToAdd(MAX_RECORDS));           

                new Thread(new Runnable()
                {
                    public void run()
                    {
                        /*outer.*/_customerList.populate(MAX_RECORDS ,  _progressDialog);
                        
                        // Since all GUI operations must be executed on the event dispatch thread , we 
                        // use invokeLater() to call run() on the event dispatch thread after all 
                        // pending events are processed.
                        UiApplication.getUiApplication().invokeLater(new Runnable() 
                        {
                            public void run() 
                            {
                                /*outer.*/_customerListField.setSize( /*outer.*/_customerList.getNumCustomerRecords() );
                            }
                        });
                    }
                }).start();    

                        
            }
            else 
            {
                _progressDialog = new ProgressBarDialog("Generating order records..." , _orderList.getNumRecordsToAdd(MAX_RECORDS));
                          
                new Thread(new Runnable()
                {
                    public void run()
                    {
                        /*outer.*/_orderList.populate( MAX_RECORDS , _progressDialog );
                        
                        UiApplication.getUiApplication().invokeLater(new Runnable() 
                        {
                            public void run() 
                            {
                                /*outer.*/_orderListField.setSize( /*outer.*/_orderList.getNumOrderRecords() );
                            }
                        });
                        
                    }
                }).start();
            }
        }
   }
   

    /**
    * Creates a popup dialog box containing a gauge field , displays the 
    * progress as the list is populated because it might take a while.
    */    
    class ProgressBarDialog implements CountAndSortListener
    {
        private DialogFieldManager _manager;
        private PopupScreen _popupScreen;
        private GaugeField _gaugeField;
        private LabelField _lbfield;
        
        private int _max;
        private int _stepSize;
        
        /**
        * Constructor
        * 
        * @param title      Text to display on _popupScreen.
        * @param max        Maximum value of the range _gaugeField can display.
        */
        public ProgressBarDialog(String title , int max)
        {
            _max = max; // Number of records to be added.
            
            // Make sure that ( _max / 100 ) is at least as big as one.
            _stepSize = Math.max( _max / 100 , 1 );
                        
            _manager = new DialogFieldManager();
            _popupScreen = new PopupScreen(_manager);
            _gaugeField = new GaugeField( null , 0 , _max , 0 , GaugeField.PERCENT);
            _lbfield = new LabelField(title , Field.USE_ALL_WIDTH);
                         
            _manager.addCustomField(_lbfield);
            _manager.addCustomField(_gaugeField);
            
            UiApplication.getUiApplication().pushScreen(_popupScreen);  
        }

        public void counterUpdated(int counter) 
        {
            // Update _gaugeField if at least one percent of the records have been processed
            // since the last time _gaugeField was updated. So if we have 60,000 records
            // to add , _gaugeField is updated once every 600 calls to counterUpdated().
            // Similarly , if we have 50 records to add , an update occurs once every 
            // 50/100 = 0.5 calls = every call to counterUpdated().
            // This is done to optimize the code, when the progress dialog is called.
            if ( counter % _stepSize == 0 )
            {
                _gaugeField.setValue(counter + 1);
            }
        }
        
        
        public void sortingStarted()
        {
            // Remove _gaugeField and change the text displayed on _popupScreen to 
            // "Sorting records..." .
            UiApplication.getUiApplication().invokeLater(new Runnable() 
            {
                public void run() 
                {
                    _manager.deleteCustomField(_gaugeField);
                    _lbfield.setText("Sorting records...");
                 }
             });
        }
        
        public void sortingFinished()
        {
            // Remove _popupScreen from the stack.
            UiApplication.getUiApplication().invokeLater(new Runnable() 
            {
                public void run() 
                {
                    UiApplication.getUiApplication().popScreen(_popupScreen) ; 
                }
             });        
        }
    }

    
    /**
     * A menu item to simulate the execution of the Low Memory Manager with Low priority.
     */
    private final class SimulateLmmLow extends MenuItem
    {
        public SimulateLmmLow() 
        {
            super( "Simulate LMM Low" , 300000, 300000 );
        }
        
        public void run() 
        {
            /*outer.*/freeStaleObject( LowMemoryListener.LOW_PRIORITY );
        }
    }
    
    
    /**
     * A menu item to simulate the execution of the Low Memory Manager with Medium priority.
     */
    private final class SimulateLmmMedium extends MenuItem
    {
        public SimulateLmmMedium() 
        {
            super( "Simulate LMM Medium" , 300001, 300001 );
        }
        
        public void run() 
        {
            /*outer.*/freeStaleObject( LowMemoryListener.MEDIUM_PRIORITY );
        }
    }
    
    
    /**
     * A menu item to simulate the execution of the Low Memory Manager with High priority.
     */
    private final class SimulateLmmHigh extends MenuItem
    {
        public SimulateLmmHigh() 
        {
            super( "Simulate LMM High" , 300002, 300002 );
        }
        
        public void run() 
        {
            /*outer.*/freeStaleObject( LowMemoryListener.HIGH_PRIORITY );
        }
    }
    
    
    /**
     * A menu item to display the customer record list on the screen.
     */
    private final class ViewCustomerRecords extends MenuItem
    {
        public ViewCustomerRecords() 
        {
            super( "View Customer Records" , 200000, 200000 );
        }
        
        public void run() 
        {
            /*outer.*/_viewingCustomerRecords = true;
            /*outer.*/setTitle( new LabelField("Customer Records", LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH ) );
            /*outer.*/delete( _orderListField );
            /*outer.*/add( _customerListField );
        }
    }
    
    
    /**
     * A menu item to display the order record list on the screen.
     */
    private final class ViewOrderRecords extends MenuItem
    {
        public ViewOrderRecords() 
        {
            super( "View Order Records" , 200000, 200000 );
        }
        
        public void run() 
        {
            /*outer.*/_viewingCustomerRecords = false;
            /*outer.*/setTitle( new LabelField( "Order Records", LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH ) );
            /*outer.*/delete( _customerListField );
            /*outer.*/add( _orderListField );
        }
    }
}

interface CountAndSortListener
{
    public void counterUpdated(int counter);
    public void sortingStarted();
    public void sortingFinished();
}


