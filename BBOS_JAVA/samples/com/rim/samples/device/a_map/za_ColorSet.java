/*
 * za_ColorSet.java
 *
 * ? <your company here>, 2003-2008
 * Confidential and proprietary.
 */
package com.rim.samples.device.a_map;
import net.rim.device.api.ui.UiApplication;
import net.rim.device.api.ui.container.*;
import net.rim.device.api.ui.*;
import net.rim.device.api.ui.component.*;
import net.rim.device.api.system.*;
import net.rim.blackberry.api.homescreen.HomeScreen;
import javax.microedition.media.control.*;
import javax.microedition.media.*;
import javax.microedition.media.Manager.*;
import java.io.IOException;

public final  class za_ColorSet extends MainScreen
{
    /**
     * HelloWorldScreen constructor.
     */
     UiApplication m_app;
     LabelField title = new LabelField("Hello World!" , LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH);   
     EditField cmd = new EditField("Input Color(example: E69): " , null, Integer.MAX_VALUE, EditField.FILTER_DEFAULT);  
     int m_y = 0;  
     int m_last = 0;
     char l_map[]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'} ;
     int m_max =0;
     String m_show="colorset";
     int m_led =0;

    public za_ColorSet(UiApplication app)
    {        
        m_app = app;
        setTitle(title);    
        //add(new SeparatorField(SeparatorField.LINE_HORIZONTAL));           
        add(new RichTextField("\n\n\n\n\n\n\n\n\n\n\n",Field.NON_FOCUSABLE) 
        { protected void paint(Graphics graphics)
            {             
                showColorset(graphics);
            } 
        }); 
        setStatus(cmd);        
    }  
    
    protected void showColorset(Graphics graphics)
    {
        int l_color ,l_row, l_col;
            graphics.setBackgroundColor(Color.BLACK);
            graphics.clear();
            for (int r = 0 ; r < 16 ; r ++)
            {
            for (int g = 0 ; g < 16 ; g ++)
            {
            for (int b = 0 ; b < 16 ; b ++)
            {             
              l_row = r*64+g*4+(b/4);              
              l_col = b%4;              
              
              //each cell 20pix * 40pix
              if (m_y+ 20*l_row+20 > 0 && m_y+ 20*l_row+20 < 240)
              {
              l_color =  (r+r*16) * 256*256 + (g+g*16) * 256 + b+b*16;                  
              graphics.setColor(l_color);                
              //8 cell every row;                      
                 graphics.fillRect(80*l_col,m_y+ 20*l_row,80,20);
            
              if (m_y + 20*l_row+10 > -10)
              {
                  graphics.setColor((~l_color)&0x00FFFFFF);    
                  graphics.drawText("#"+l_map[r]+l_map[g]+l_map[b],80*l_col,m_y+ 20*l_row);   
               }      
              }
           }}}//rgb
           m_max = 20*16*16*4-200;
    }                
    
  protected void makeMenu(Menu menu, int instance)
  {
          menu.add(new MenuItem("LED ON" , 100, 10){
          public void run(){
          int pattern[] = { 
            Color.VIOLET, 80, 50, 
            Color.INDIGO, 80, 50,
            Color.RED, 80, 50,
            Color.BLACK, 80, 50};
            
   /*         LED.setState(LED.LED_TYPE_STATUS, LED.STATE_ON);
              LED.setState(LED.LED_TYPE_STATUS, LED.STATE_BLINKING); 
              LED.setColorConfiguration(500,500,0x00FFFF00);*/         
              LED.setColorPattern(LED.LED_TYPE_STATUS,pattern,true);}}
          );              
            menu.add(new MenuItem("LED OFF" , 100, 10){
            public void run(){LED.setState(LED.LED_TYPE_STATUS, LED.STATE_OFF);}});
            
            menu.add(new MenuItem("Vibrate" , 100, 10){
             public void run(){                
            net.rim.device.api.system.Alert.startVibrate(1000);}});
            menu.addSeparator();          
            
            menu.add(new MenuItem("Alert 1" , 100, 10){
                    // The TUNE (bar 1 and 2 of Islamey by Balakirev).
    private static final short BFlat = 466; // 466.16
    private static final short AFlat = 415; // 415.30
    private static final short A = 440; // 440.00
    private static final short GFlat = 370; // 369.99
    private static final short DFlat = 554; // 554.37
    private static final short C = 523; // 523.25
    private static final short F = 349; // 349.32
    private static final short TEMPO = 125;
    private static final short d16 = 1 * TEMPO; // Duration of a 16th note, arbitrary, in ms.
     private static final short d8 = d16 << 1; // Duration of an eigth note, arbitrary, in ms.
     private  static final short dpause = 10; // 10 ms pause
     private static  final short pause = 0; // Zero frequency pause

    private static final int VOLUME = 100; // % volume
            public void run(){
             final short[] TUNE = new short[] { BFlat, d16, pause, dpause, BFlat, d16, pause,
            dpause, BFlat, d16, pause, dpause, BFlat, d16, pause, dpause, A, d16, pause, dpause,
            BFlat, d16, pause, dpause, GFlat, d16, pause, dpause, GFlat, d16, pause, dpause, A,
            d16, pause, dpause, BFlat, d16, pause, dpause, DFlat, d16, pause, dpause, C,
            d16, pause, dpause, // Bar 1
            AFlat, d16, pause, dpause, AFlat, d16, pause, dpause, AFlat, d16, pause, dpause, AFlat,
            d16, pause, dpause, F, d16, pause, dpause, GFlat, d16, pause, dpause, AFlat, d16,
            pause, dpause, BFlat, d16, pause, dpause, AFlat, d16, pause, dpause, F, d8 + d16 // Bar 2
    };
    net.rim.device.api.system.Alert.startAudio(TUNE,VOLUME);   
    net.rim.device.api.system.Alert.startBuzzer( TUNE, VOLUME );}});
                                   
   menu.add(new MenuItem("Alert 2" , 100, 10){
   public void run(){
    byte tempo = 30; // set tempo to 120 bpm 
    byte d = 8;      // eighth-note 

    byte C4 = ToneControl.C4;; 
    byte D4 = (byte)(C4 + 2); // a whole step 
    byte E4 = (byte)(C4 + 4); // a major third 
    byte G4 = (byte)(C4 + 7); // a fifth 
    byte rest = ToneControl.SILENCE; // rest 

    byte[] mySequence = {
        ToneControl.VERSION, 1,   // version 1
        ToneControl.TEMPO, tempo, // set tempo
        ToneControl. SET_VOLUME,90,
        ToneControl.BLOCK_START, 0,   // start define "A" section
        E4,d, D4,d, C4,d, E4,d,       // content of "A" section
        E4,d, E4,d, E4,d, rest,d,           
        ToneControl.BLOCK_END, 0,     // end define "A" section
        ToneControl.PLAY_BLOCK, 0,    // play "A" section
        D4,d, D4,d, D4,d, rest,d,     // play "B" section
        E4,d, G4,d, G4,d, rest,d,
        ToneControl.PLAY_BLOCK, 0,    // repeat "A" section
        D4,d, D4,d, E4,d, D4,d, C4,d, // play "C" section
        D4,d, G4,d, E4,d, D4,d, C4,d, // play "C" section
        rest,d,C4,d,rest,d,C4,d,rest,d  
    }; 
 try {
       javax.microedition.media.Player p = javax.microedition.media.Manager.createPlayer(javax.microedition.media.Manager.TONE_DEVICE_LOCATOR); 
        p.realize(); 
        ToneControl c = (ToneControl)p.getControl("ToneControl"); 
      //  VolumeControl v = (VolumeControl)p.getControl("VolumeControl");
      //s  v.setLevel(90);
        c.setSequence(mySequence); 
        p.start(); 
 } catch (IOException ioe) {
 } catch (MediaException me) {}
}});
            menu.addSeparator();    
                  

            super.makeMenu(menu, instance);
    }


    protected boolean  navigationMovement(int dx,
                                     int dy,
                                     int status,
                                     int time)
    {
          if (m_last == 0 )
            m_y = m_y - 5*dy; 
          if (m_last ==1 || m_last==-1 )
            m_y = m_y - 18*dy;
          if (m_last ==2 || m_last==-2)
            m_y = m_y - 40*dy;
          if (m_last > 2 || m_last < -2)
            m_y = m_y - 75*dy;
          m_last = dy;
          
          m_y = m_y -200*dx;
          if (m_y > 0 ) 
           m_y = 0;
          if (m_y < -m_max)
            m_y = -m_max;
         invalidate();
        doPaint();
       return super.navigationMovement( dx, dy, status,time ); // We'll let super handle the event.
    }
                                 
    protected boolean keyChar( char key, int status, int time )
    {
        char r='0',g='0',b='0';
        boolean ret;
        
        if ( key == Characters.ENTER) return true;
        if ( m_show=="showlist" ) return true;
        
        ret = super.keyChar( key, status, time ); // We'll let super handle the event.
                
        if( key == Characters.LATIN_SMALL_LETTER_H)
        {
            m_led=0;
            LED.setState(LED.STATE_OFF);
        }
        if( key == Characters.LATIN_SMALL_LETTER_J)
        {
            m_led=1;
            LED.setState(LED.STATE_ON);            
        }
                       
        {              
            if (cmd.getText().length()==3)
            {
            r = cmd.getText().charAt(0);
            g = cmd.getText().charAt(1);
            b = cmd.getText().charAt(2);
            }
            if (cmd.getText().length()==2)
            {
            r = cmd.getText().charAt(0);
            g = cmd.getText().charAt(1);
            b = '0';
            }
            if (cmd.getText().length()==1)
            {
            r = cmd.getText().charAt(0);
            g = '0';
            b = '0';
            }                        
            for (int i=0; i < 16 ; i++)
            {if (l_map[i]==r) r=(char)i;
            if (l_map[i]==g) g= (char)i;
            if (l_map[i]==b) b= (char)i;}
            m_y = -(r*64+g*4+(b/4))*20; 
            if (m_y < -m_max) m_y = -m_max;
            invalidate();
            doPaint();
           
        }  
        return ret;
    }         
    
    public boolean onSavePrompt()
    {
        return true;
    }      

    public void close()
    {
        LED.setState(LED.STATE_OFF);          
       super.close();
    }   
}
