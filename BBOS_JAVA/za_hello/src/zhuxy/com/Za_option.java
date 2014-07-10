package zhuxy.com;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;
import android.widget.ToggleButton;

public class Za_option extends Activity implements OnClickListener  {
		   
	    /** Called when the activity is first created. */
		Button bt = null;
	    @Override
	    public void onCreate(Bundle savedInstanceState) {
	        super.onCreate(savedInstanceState);
	        LinearLayout layout = new LinearLayout(this);
	        layout.setOrientation(LinearLayout.VERTICAL);
	        
	        TextView tv = new TextView(this);
	        tv.setText("服务功能");
	        
	        tv.setTextSize(24);
	        layout.addView(tv);
	     
	         CheckBox cb =new CheckBox(this);
	         cb.setText("开通");
	      //   cb.setPadding(20, 20,20,20);
	         cb.setChecked(true);
	        layout.addView(cb);
	        
	        tv = new TextView(this);
	        tv.setText("选择运营商");
	        tv.setTextSize(24);
	        layout.addView(tv);	       	       
	         
	         RadioGroup rg = new RadioGroup(this);
	         rg.setPadding(10,10,10,10);
	         
	         RadioButton rb = new RadioButton(this);
	         rb.setText("中国移动");	         	         	         
	         rg.addView(rb);
	         rb.setChecked(true);
	         
	         rb = new RadioButton(this);
	         rb.setText("中国联通");	         
	         rg.addView(rb);
	         
	         rb = new RadioButton(this);	         
	         rb.setText("中国电信");
	         rg.addView(rb);	        
	         
	         layout.addView(rg);
	         
	         ToggleButton tb = new ToggleButton(this);	   
		     tb.setText("t button");
		     tb.setOnClickListener(this);  
	         layout.addView(tb);
	         
		     bt = new Button(this);
		     bt.setText("close");
		     bt.setOnClickListener(this);     
	         layout.addView(bt);
	         
	        setContentView(layout);
	    }
	    public void onClick(View v) 
	    {
	    	if (v == bt)
	    	{
	    	  Intent intent = new Intent();
              setResult(RESULT_OK, intent);
	    	  finish();
	    	}
	    }	    
}
