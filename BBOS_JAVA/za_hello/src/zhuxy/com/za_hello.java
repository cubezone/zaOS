package zhuxy.com;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.Typeface;
import android.net.Uri;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.AnalogClock;
import android.widget.Toast;
import android.widget.ListView;

public class za_hello extends Activity 	implements OnClickListener  {

	Button btn1=null;
	Button btn2=null;
	Button btn3=null;
	Button btn4=null;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
    	super.onCreate(savedInstanceState);
        
    	getWindow().setFlags(
    			WindowManager.LayoutParams.FLAG_FULLSCREEN,
    			WindowManager.LayoutParams.FLAG_FULLSCREEN); 
    //	requestWindowFeature(Window.FEATURE_NO_TITLE);  
    	              
        ScrollView sv = new ScrollView(this);
        
        LinearLayout layout = new LinearLayout(this);
        
        layout.setOrientation(LinearLayout.VERTICAL);
        btn1 = new Button(this);
        btn1.setText("设置");
        btn1.setOnClickListener(this); 
        
        btn2 = new Button(this);
        btn2.setText("Click");
        btn2.setOnClickListener(this);      
        btn2.setWidth(100);
        btn2.setTextColor(0xFF00FF00);
        btn2.setTextSize(40);
        
        btn3 = new Button(this);
        btn3.setText("基站信息");
        btn3.setTextColor(Color.RED);
        btn3.setOnClickListener(this); 
        
        btn4 = new Button(this);
        btn4.setText("退出");
        btn4.setOnClickListener(this); 
         
         AnalogClock ac = new AnalogClock(this);
       
         
         ListView lv = new ListView(this);
        /* 
         TextView tvv= new TextView(this);
         tvv.setText("LVA");
         lv.addHeaderView(tvv);

         tvv= new TextView(this);
         tvv.setText("LVB");
         lv.addView(tvv);
         
         tvv= new TextView(this);
         tvv.setText("LVC");
         lv.addFooterView(tvv);
       */
         
         layout.addView(ac);
         layout.addView(lv);
         layout.addView(btn2);                      
         layout.addView(btn3);
         layout.addView(btn1);
         layout.addView(btn4);
         
         Za_TextView mtv = null;
         for (int n = 0 ; n <400 ; n ++)
         { 	mtv = new Za_TextView(this);
         	mtv.text2Text = "自定义列表"+String.valueOf(n);
         	if (n%2==0) 
         	{
         		if (n < 200)
         		mtv.brush.setColor(0xFF0000AA+0x100*n);  
         		else
         		mtv.brush.setColor(0xFF0000AA+0x10000*(n-200)); 	
         	}
         	layout.addView(mtv);
         }
         sv.addView(layout);
     
        setContentView(sv);
     //   setContentView(tv);
     //  setContentView(R.layout.main);
    }
    

	@Override    
    public void onClick(View v) 
    {
    	if (v == btn4)
    	{
    		 finish();
    	}
    	if (v == btn1)
    	{
    		 Intent myIntent = new Intent(v.getContext(), Za_option.class);
             startActivityForResult(myIntent, 0);
    	}
    	if (v == btn3)
    	{
    		 Intent myIntent = new Intent(v.getContext(), Za_Cell.class);
             startActivityForResult(myIntent, 0);
    	}
    	
    	if (v == btn2)
    	{
         if (btn2.getText().equals("Click"))        
    	 btn2.setText("Click again");
         else
         btn2.setText("Click");
         Uri uri = Uri.parse("smsto:0800000123"); 
         Intent it = new Intent(Intent.ACTION_VIEW, uri); 
         it.putExtra("sms_body", "短信测试!"); 
         it.setType("vnd.android-dir/mms-sms"); 
         startActivity(it); 
    	}
    	Toast toast = new Toast(getApplicationContext());
    	TextView tv = new TextView(this);    	
    	tv.setText(((Button)v).getText());
    	tv.setTextSize(24);
    	tv.setTextColor(0xFF0000FF);
    	toast.setGravity(Gravity.BOTTOM, 0, 0);
    	toast.setView(tv);
        toast.show();

    }
    
	public class Za_TextView extends View
	{
		  Paint pen;
		  Paint brush;  
		  String text2Text;   
		      int ascent;   
		        
		  
		public Za_TextView(Context context)  
		{
			  super(context);   
			  initialize();   			  
		}
		
		protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {   
		     setMeasuredDimension(measureWidth(widthMeasureSpec),   
		             measureHeight(heightMeasureSpec));   
		 }   

		 private int measureWidth(int measureSpec) {   
		     int result = 0;   
		     int specMode = MeasureSpec.getMode(measureSpec);   
		     int specSize = MeasureSpec.getSize(measureSpec);   

		     if (specMode == MeasureSpec.EXACTLY) {   
		         // We were told how big to be   
		         result = specSize;   
		     } else {   
		         // Measure the text   
		         result = (int) pen.measureText(text2Text) + getPaddingLeft()   
		                 + getPaddingRight();   
		         if (specMode == MeasureSpec.AT_MOST) {   
		             // Respect AT_MOST value if that was what is called for by measureSpec   
		             result = Math.min(result, specSize);   
		         }   
		     }   

		     return result;   
		 }   

		 /**  
		  * Determines the height of this view  
		  * @param measureSpec A measureSpec packed into an int  
		  * @return The height of the view, honoring constraints from measureSpec  
		  */  
		 private int measureHeight(int measureSpec) {   
		     int result = 0;   
		     int specMode = MeasureSpec.getMode(measureSpec);   
		     int specSize = MeasureSpec.getSize(measureSpec);   

		     ascent = (int) pen.ascent();   
		     if (specMode == MeasureSpec.EXACTLY) {   
		         // We were told how big to be   
		          result = specSize;   
		      } else {   
		          // Measure the text (beware: ascent is a negative number)   
		          result = (int) (-ascent + pen.descent()) + getPaddingTop()   
		                  + getPaddingBottom();   
		          if (specMode == MeasureSpec.AT_MOST) {   
		              // Respect AT_MOST value if that was what is called for by measureSpec   
		              result = Math.min(result, specSize);   
		          }   
		      }   
		      return result+20;   
		  }   
		     
		  @Override  
		  protected void onDraw(Canvas canvas) {   		   
		      canvas.drawLine(0, 1,400, 1, pen);
		      canvas.drawRect(0, 1, 400, 50, brush);
		      canvas.drawText(text2Text, getPaddingLeft()+18, getPaddingTop() - ascent+10, pen);   
		      super.onDraw(canvas);    
		  }   
		  //load default setting on Text2View   
		  private final void initialize() {   
			  pen = new Paint();   
			  pen.setAntiAlias(true);   
			  pen.setTextSize(20);   		     
			  pen.setColor(Color.WHITE);		
			  brush = new Paint();
			  brush.setColor(Color.BLACK);
		      //setPadding(3, 3, 3, 3);   
		    }   
		
	}
 
};

