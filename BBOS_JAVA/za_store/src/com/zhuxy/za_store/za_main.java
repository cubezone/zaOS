package com.zhuxy.za_store;

import net.rim.device.api.ui.Field;
import net.rim.device.api.ui.FieldChangeListener;

import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.ButtonField;

import net.rim.device.api.ui.container.MainScreen;

final public class za_main extends MainScreen
{
    za_main() 
    {
    	  setTitle("Store & Sqllit ≤‚ ‘");
    	  ButtonField  btf_store =  new ButtonField("Store");
    	  ButtonField  btf_sqllit =  new ButtonField("Sqllit");
    	  add( btf_store);
    	  add( btf_sqllit );
    	  FieldChangeListener listener = new FieldChangeListener() {
    	         public void fieldChanged(Field field, int context) {
    	             ButtonField buttonField = (ButtonField) field;    	             
    	             if (buttonField.getLabel().equals("Store"))
    	            	 UiApplication.getUiApplication().pushScreen(new za_store()); 
    	             if (buttonField.getLabel().equals("Sqllit"))
						try {
							UiApplication.getUiApplication().pushScreen(new za_sqllit());
						} catch (Exception e) {							
							e.printStackTrace();
						}        	            	 
    	         } 
    	     };
    	     
    	  btf_store.setChangeListener(listener)  ;
    	  btf_sqllit.setChangeListener(listener)  ;
    	  
    }
}
