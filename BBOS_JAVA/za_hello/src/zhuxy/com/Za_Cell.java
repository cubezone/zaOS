package zhuxy.com;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.telephony.TelephonyManager;
import android.telephony.cdma.CdmaCellLocation;
import android.telephony.gsm.GsmCellLocation;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;

public class Za_Cell extends Activity 	implements OnClickListener  {
		   
	   int cellID, lac;
		String l_out = " ";
		String l_tmp = " ";
	    /** Called when the activity is first created. */
	    @Override
	    public void onCreate(Bundle savedInstanceState) {
	        super.onCreate(savedInstanceState);
	        TextView tv = new TextView(this);
	  
	        LinearLayout layout = new LinearLayout(this);
	        Button bt = new Button(this);
	        bt.setText("close");
	        bt.setOnClickListener(this); 
	        layout.setOrientation(LinearLayout.VERTICAL);	   
	       
	        layout.addView(tv);
	        layout.addView(bt);	   	       
	        
	     TelephonyManager tm  = 
	        (TelephonyManager) getSystemService(Context.TELEPHONY_SERVICE);
	    
	     /*      WallpaperManager wallpaperManager = WallpaperManager.getInstance(this);
	        Bitmap bt =Bitmap.createBitmap(400,800, Bitmap.Config.ALPHA_8);    
	    
	    	wallpaperManager.setWallpaperOffsetSteps(100, 100);        	
	  */
	        if (tm !=  null)
	        {
	        	l_tmp =  tm.getDeviceId();
	           l_out += "\r\nEMEI:"+ l_tmp;
	        
	        if (tm.getPhoneType()== TelephonyManager.PHONE_TYPE_NONE)
	        {
	        	l_out += "\r\n无效的locaiton";
	        }
	        else if (tm.getPhoneType()== TelephonyManager.PHONE_TYPE_GSM)
	        {
	        	l_out += "\r\n手机类型:GSM";
	        	l_out += "\r\nNetworkOperatorName:" + tm.getNetworkOperatorName();
	        	l_out += "\r\ngetNetworkOperator:" + tm.getNetworkOperator();
	        	GsmCellLocation location = (GsmCellLocation) tm.getCellLocation();
		        if (location ==null)
		        {
		        	l_out += "\r\n无效的locaiton";	
		        }
		        else
		        {
		        	cellID = location.getCid();
			        lac = location.getLac();
			        l_out += "\r\nCELLID:"+String.valueOf(cellID);
			        l_out += "\r\nLac:"+String.valueOf(lac);
		        }
	        }
	        else if (tm.getPhoneType()== TelephonyManager.PHONE_TYPE_CDMA)
	        {
	        	l_out += "\r\n手机类型:CDMA";
	        	CdmaCellLocation location = (CdmaCellLocation) tm.getCellLocation();
	        	if (location ==null)
	  	        {
	  	        	l_out += "\r\n无效的locaiton";	
	  	        }
	  	        else
	  	        { 
	  	        	cellID = location.getBaseStationId();  	        
			        lac = location.getNetworkId();
			        l_out += "\r\nCELLID:"+String.valueOf(cellID);
			        l_out += "\r\nLac:"+String.valueOf(lac);
	  	        }
	        }
	       }
	        else
	        	l_out = "null tm";
	       tv.setText(l_out);
	        setContentView(layout);
	    }
	    public void onClick(View v) 
	    {
	    	  Intent intent = new Intent();
              setResult(RESULT_OK, intent);
	    	  finish();
	    }	    
}
