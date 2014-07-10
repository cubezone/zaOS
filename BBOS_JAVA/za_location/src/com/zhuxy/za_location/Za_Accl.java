package com.zhuxy.za_location;

import net.rim.device.api.system.AccelerometerSensor;
import net.rim.device.api.system.Application;
import net.rim.device.api.system.Display;
import net.rim.device.api.system.AccelerometerSensor.Channel;
import net.rim.device.api.ui.Graphics;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.component.BasicEditField;
import net.rim.device.api.ui.component.Dialog;
import net.rim.device.api.ui.component.RichTextField;
import net.rim.device.api.ui.container.MainScreen;

final class za_Accl extends MainScreen
{
	 Channel rawDataChannel = AccelerometerSensor.openRawDataChannel( Application.getApplication() );
     // create raw sample vector with three components - X, Y, Z
     short[] xyz = new short[ 3 ];
     boolean running=true;
     refretacc l_thread = new refretacc();
     acccanver l_map = new acccanver();
     RichTextField l_rich = new RichTextField("显示重力信息\r\n\r\n\r\n\r\n");
     za_Accl()
     {
    	 setTitle("重力信息");    
    	 add(l_rich); 
    	 add(l_map); 
    	 if (AccelerometerSensor.isSupported())
    	  l_thread.start();
    	 else
    	  updateContent("设备不支持重力");
     }
     public boolean onSavePrompt()
     {
         return true;
     }
       public boolean  onClose()
     {
        if( Dialog.ask(Dialog.D_OK_CANCEL,"确实要退出?",Dialog.CANCEL) == Dialog.OK)
        {
          running = false;
         l_thread.interrupt();     
         return super.onClose();
        }
        else
         return false;
     }
       private void updateContent(final String text)
       {
           // This will create significant garbage, but avoids threading issues
           // (compared with creating a static Runnable and setting the text).
           UiApplication.getUiApplication().invokeLater(new Runnable() 
           {
               public void run()
               {
                   l_rich.setText(text);
                   invalidate();
                   doPaint();
               }
           });
       }
     private class acccanver extends BasicEditField
     {
    	 acccanver()
    	 {
    		 
    	 }

         public int getPreferredHeight() 
         {
        	 return Display.getHeight()-l_rich.getHeight();
         }
         public int getPreferredWidth() 
         {
        	 return Display.getWidth();
         }
         
         public void layout(int width, int height)
         {
             super.layout(width, getPreferredHeight());

             setExtent(width, getPreferredHeight());

         }
    	 protected  void paint(Graphics graphics)         
    	 {
    		 graphics.setBackgroundColor(0x000000);
    		 graphics.clear();
    		 graphics.setColor(0xFF0000);    		 
    		 graphics.fillRoundRect(
    		  Display.getWidth()/2 - xyz[0]/5,
    		  180 + xyz[1]/5,
    		  10,10,10,10);    		 
    	 }
     }
     
	  private class refretacc extends Thread
	  {
		String l_out="\r\n";  
	    private static final int TIMEOUT = 300; //1秒钟采集一次
	   	public void run()
		 {
		     // open channel
		     while(running)
		     {
		         // read acceleration
		         rawDataChannel.getLastAccelerationData( xyz );
		         // process the acceleration
		         l_out =  "X:"+String.valueOf(xyz[0]);
		         l_out += "Y:"+String.valueOf(xyz[1]);
		         l_out += "Z:"+String.valueOf(xyz[2]);
		         // sleep for maintaining query rate
		         updateContent(l_out);
		         try {
					sleep( TIMEOUT );
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		     }
		     // close the channel to stop sensor query routine
		     rawDataChannel.close();
		 }
	}
}
