/*
 * za_SubWay.java
 *
 * ? <your company here>, 2003-2008
 * Confidential and proprietary.
 */

package com.rim.samples.device.helloworlddemo;
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

/**
 * 
 */
final class za_SubWay extends MainScreen
{     
 int m_x=0,m_y = 0;  
 int m_last = 0;
 int m_zoom = 3;
 int m_rote = 0;
 int m_text_y =0;
 char l_map[]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'} ;
 int m_max_x =0,m_max_y=0;
 String m_show="showlist";
 static int ITEM_CNT=3; 
 static  String stationOne[]={
"01","��������վ","3F",
"02","Ԫͨվ","4G",
"03","��ʤ·վ","6G",
"04","������վ","7F",
"05","�л���վ","7E",
"06","��ɽ��վ","8D",
"07","�Ÿ�԰վ","8C",
"08","�½ֿ�վ","8B",
"09","�齭·վ","8A",
"10","��¥վ","89",
"11","������վ","88",
"12","��ģ����·վ","87",
"13","�Ͼ�վվ","A6",
"14","��ɽ����԰վ","C5",
"15","�����Ҿ߸�","C4",
"16","������վ","C3"};
 
 static  String stationOneExt[]={
"01","������վ","7F",
"02","��¡��վ","8G",
"03","������վ","9H",
"04","������վ","AI",
"05","�����Ͼ���վ","AJ",
"06","˫�����վ","BK",
"07","ʤ̫·վ","CL",
"08","�ټҺ�վ","DL",
"09","С����վ","EL",
"10","��ɽ·վ","FL",
"11","��ӡ���վ","GL",
"12","���ߴ��վ","GM",
"13","��ҽ��ѧԺվ","GN",
"14","�Ͼ���Ժվ","GO",
"15","�й�ҩ�ƴ�ѧվ","GP"};

static String stationTwo[]={
"01","�ͷ���վ","3I",
"02","������վ","4H",
"03","Ԫͨվ","4G",
"04","���嶫վ","4E",
"05","��¡���վ","4D",
"06","�����Ŵ��վ","4C",
"07","�ƽ�·վ","4B",
"08","Ī���վ","5B",
"09","������վ","6B",
"10","�Ϻ�·վ","7B",
"11","�½ֿ�վ","8B",
"12","���й�վ","9B",
"13","������վ","AB",
"14","���ʹ�վ","BB",
"15","��ޣ԰վ","CB",
"16","����վ","DB",
"17","Т����վ","EB",
"18","�����վ","FB",
"19","��Ⱥվ","GA",
"20","����·վ","I9",
"21","�ɺ���վ","J8",
"22","ѧ��·վ","K8",
"23","��������վ","L7",
"24","��ҽҩ��ѧ,��ɽ��԰վ","N6",
"25","�ϴ�����У��վ","M5",
"26","����·վ","N4"};

public za_SubWay()
{                
        add(new RichTextField("\n\n\n\n\n\n\n\n\n\n\n",Field.NON_FOCUSABLE) 
        { protected void paint(Graphics graphics)
            {           
               if (m_show =="showlist")   showList(graphics);             
               if (m_show =="showmap")    showMap(graphics); 
            } 
        });    
}  
        
protected void showMap(Graphics graphics)
{    
           int l_x=0 , l_y =0,l_ox=0 , l_oy=0;
           int l_grid=0,l_cir=0;
            graphics.setBackgroundColor(Color.BLACK);
            graphics.clear();
            graphics.setColor(Color.YELLOW); 
            m_max_x=0;                          
            m_max_y=0;            
            l_grid = 4*m_zoom;
            l_cir = 1*m_zoom;
            if (l_cir > 4) l_cir=4;
           for (int i = 0; i <16; i++)
           {
                if (m_rote ==0)
                {l_x = ctod(stationOne[i*ITEM_CNT+2].charAt(0)) * l_grid ;
                l_y = ctod(stationOne[i*ITEM_CNT+2].charAt(1)) * l_grid ;
                }else
                {
                    l_y = -ctod(stationOne[i*ITEM_CNT+2].charAt(0)) * l_grid + 20*l_grid;
                    l_x = ctod(stationOne[i*ITEM_CNT+2].charAt(1)) * l_grid ;
                }  
                if ((m_y+ l_y> 0) && (m_y+ l_y < 240))
                { 
                  if (i>0) graphics.drawLine(m_x+l_ox+l_cir,m_y+ l_oy+l_cir,m_x+l_x+l_cir,m_y+ l_y+l_cir);
                  if (m_zoom>5) 
                   if (m_text_y == l_y)
                     {
                        m_text_y =0;
                        graphics.drawText(stationOne[i*ITEM_CNT+1],m_x+l_x+10,m_y+ l_y -20);
                        }
                     else
                     { m_text_y =l_y;
                        graphics.drawText(stationOne[i*ITEM_CNT+1],m_x+l_x+10,m_y+ l_y +10);
                         }
                  graphics.fillArc(m_x+l_x,m_y+ l_y,l_cir*2+1,l_cir*2+1,0,360);                        
             }
                l_ox=l_x;l_oy=l_y;      
                if (l_x > m_max_x) m_max_x=l_x;
                if (l_y > m_max_y) m_max_y=l_y;
            } 
            
            graphics.setColor(Color.LIGHTGREEN);                                   
            for (int i = 0; i <15; i++)
            {
                if (m_rote ==0)
                {l_x = ctod(stationOneExt[i*ITEM_CNT+2].charAt(0)) * l_grid ;
                 l_y = ctod(stationOneExt[i*ITEM_CNT+2].charAt(1)) * l_grid ;
                }
                else
                {
                    l_y = -ctod(stationOneExt[i*ITEM_CNT+2].charAt(0))* l_grid + 20*l_grid;
                    l_x = ctod(stationOneExt[i*ITEM_CNT+2].charAt(1)) * l_grid ;
                }                
                if ((m_y+ l_y> 0) && (m_y+ l_y < 240))
                {
                if (i>0) graphics.drawLine(m_x+l_ox+l_cir,m_y+ l_oy+l_cir,m_x+l_x+l_cir,m_y+ l_y+l_cir);
                if (m_zoom>5) 
                    if (m_text_y == l_y)
                     {
                        m_text_y =0;
                        graphics.drawText(stationOneExt[i*ITEM_CNT+1],m_x+l_x+10,m_y+ l_y-20);
                        }
                      else
                      {
                          m_text_y = l_y;
                          graphics.drawText(stationOneExt[i*ITEM_CNT+1],m_x+l_x+10,m_y+ l_y+10);
                       }
                    graphics.fillArc(m_x+l_x,m_y+ l_y,l_cir*2+1,l_cir*2+1,0,360);    
               } 
                l_ox=l_x;l_oy=l_y;   
                if (l_x > m_max_x) m_max_x=l_x;
                if (l_y > m_max_y) m_max_y=l_y;         
            }
                        
            graphics.setColor(Color.LIGHTBLUE);
            for (int i = 0; i <25; i++)
            {                
                 if (m_rote ==0)
                {l_x = ctod(stationTwo[i*ITEM_CNT+2].charAt(0)) * l_grid;
                l_y = ctod(stationTwo[i*ITEM_CNT+2].charAt(1)) * l_grid;
                }else
                {
                    l_y = -ctod(stationTwo[i*ITEM_CNT+2].charAt(0)) * l_grid + 20*l_grid;
                    l_x = ctod(stationTwo[i*ITEM_CNT+2].charAt(1)) * l_grid ;
                }  
                if ((m_y+ l_y> 0) && (m_y+ l_y < 240))
                {
                if (i>0) graphics.drawLine(m_x+l_ox+l_cir,m_y+ l_oy+l_cir,m_x+l_x+l_cir,m_y+ l_y+l_cir);
                if (m_zoom>5) 
                  if (m_text_y == l_y)
                     {
                        m_text_y =0;
                        graphics.drawText(stationTwo[i*ITEM_CNT+1],m_x+l_x+10,m_y+ l_y-20);
                     }
                     else
                     {
                        m_text_y = l_y;
                        graphics.drawText(stationTwo[i*ITEM_CNT+1],m_x+l_x+10,m_y+ l_y+10);
                    }
                  
                graphics.fillArc(m_x+l_x,m_y+ l_y,l_cir*2+1,l_cir*2+1,0,360);    
                }
                l_ox=l_x;l_oy=l_y;  
                if (l_x > m_max_x) m_max_x=l_x;
                if (l_y > m_max_y) m_max_y=l_y;   
                 
            }
            m_max_x = m_max_x -200;
            if (m_max_x <0 ) m_max_x=0;
            m_max_y = m_max_y -150;
            if (m_max_y <0 ) m_max_y=0;
    }
    
    protected int ctod(char c)
    {
        if (c >='A')  return c - 'A'+10;
        if (c < 'A')  return c - '0';
        return 0;
    }
    protected void showList(Graphics graphics)
    {    
            graphics.setBackgroundColor(Color.BLACK);
            graphics.clear();
            graphics.setColor(Color.YELLOW);
            for (int i = 0; i <16; i++)
            if ((m_y+ 20*i+20 > 0) && (m_y+ 20*i < 240))
             graphics.drawText(stationOne[i*ITEM_CNT]+" "+stationOne[i*ITEM_CNT+1],10,m_y+ 20*i);          
      
            graphics.setColor(Color.LIGHTGREEN);
            for (int i = 0; i <15; i++)
            if ((m_y+ 20*(16+i)+20 > 0) && (m_y+ 20*(16+i) < 240))
            graphics.drawText(stationOneExt[i*ITEM_CNT]+" "+stationOneExt[i*ITEM_CNT+1],10,m_y+ 20*(16+i));                 
                        
            graphics.setColor(Color.LIGHTBLUE);
            for (int i = 0; i <25; i++)
            if ((m_y+ 20*(31+i)+20 > 0) && (m_y+ 20*(31+i) < 240))
             graphics.drawText(stationTwo[i*ITEM_CNT]+" "+stationTwo[i*ITEM_CNT+1],10,m_y+ 20*(31+i));                
            
            m_max_y=20*55-240;
    }
    
    protected void makeMenu(Menu menu, int instance)
    {      
            menu.add(new MenuItem("List" , 100, 10){
            public void run(){m_show="showlist"; invalidate(); doPaint(); }});
            menu.add(new MenuItem("Map" , 100, 10){
            public void run(){m_show="showmap"; invalidate(); doPaint(); }});            
            super.makeMenu(menu, instance);
    }

    protected boolean  navigationMovement(int dx, int dy, int status,int time)
    {
          if (m_last == 0 )
            m_y = m_y - 20*dy; 
          if (m_last ==1 || m_last==-1 )
            m_y = m_y - 40*dy;
          if (m_last ==2 || m_last==-2)
            m_y = m_y - 80*dy;
          if (m_last > 2 || m_last < -2)
            m_y = m_y - 160*dy;
                   
          if (m_last == 0 )
            m_x = m_x - 20*dx; 
          if (m_last ==1 || m_last==-1 )
            m_x = m_x - 40*dx;
          if (m_last ==2 || m_last==-2)
            m_x = m_x - 80*dx;
          if (m_last > 2 || m_last < -2)
            m_x = m_x - 160*dx;

           m_last = dy;
          if (m_last < dx) m_last=dx;
          
          
          if (m_y > 0 ) m_y = 0;
          if (m_x > 0 ) m_x = 0;

          if (m_y < -m_max_y)
            m_y = -m_max_y;
            
          if (m_x < -m_max_x)
            m_x = -m_max_x;
            
          invalidate();
          doPaint();
       return super.navigationMovement( dx, dy, status,time ); // We'll let super handle the event.
    }
                                 
    protected boolean keyChar( char key, int status, int time )
    {
        boolean ret;        
        if ( key == Characters.ENTER) return true;    
        if (key == Characters.LATIN_SMALL_LETTER_O)// zoom in 
        {
          m_x = (m_x-180)/m_zoom*(m_zoom*2)+180;
          m_y = (m_y-120)/m_zoom*(m_zoom*2)+120;         
            m_zoom = m_zoom *2;
        }
        if (key == Characters.LATIN_SMALL_LETTER_I) // zoom out
        if (m_zoom >2)
        {
          m_x = (m_x-180)/m_zoom*(m_zoom/2)+180;
          m_y = (m_y-120)/m_zoom*(m_zoom/2)+120;
          m_zoom =m_zoom/2;        
        }
        if (key == Characters.LATIN_SMALL_LETTER_R) 
        {
            if (m_rote ==1) 
                m_rote= 0;
            else m_rote =1;
        }
          invalidate();
          doPaint();
        ret = super.keyChar( key, status, time ); // We'll let super handle the event.                       
        return ret;
    }         
   
    public boolean onSavePrompt()
    {
        return true;
    }      

    public void close()
    {     
        super.close();
    }   
}
