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
"01","奥体中心站","3F",
"02","元通站","4G",
"03","中胜路站","6G",
"04","安德门站","7F",
"05","中华门站","7E",
"06","三山街站","8D",
"07","张府园站","8C",
"08","新街口站","8B",
"09","珠江路站","8A",
"10","鼓楼站","89",
"11","玄武门站","88",
"12","新模范马路站","87",
"13","南京站站","A6",
"14","红山动物园站","C5",
"15","高力家具港","C4",
"16","迈皋桥站","C3"};
 
 static  String stationOneExt[]={
"01","安德门站","7F",
"02","天隆寺站","8G",
"03","软件大道站","9H",
"04","花神庙站","AI",
"05","高铁南京南站","AJ",
"06","双龙大道站","BK",
"07","胜太路站","CL",
"08","百家湖站","DL",
"09","小龙湾站","EL",
"10","竹山路站","FL",
"11","天印大道站","GL",
"12","龙眠大道站","GM",
"13","南医大学院站","GN",
"14","南京交院站","GO",
"15","中国药科大学站","GP"};

static String stationTwo[]={
"01","油坊桥站","3I",
"02","雨润大街站","4H",
"03","元通站","4G",
"04","奥体东站","4E",
"05","兴隆大街站","4D",
"06","集庆门大街站","4C",
"07","云锦路站","4B",
"08","莫愁湖站","5B",
"09","汉中门站","6B",
"10","上海路站","7B",
"11","新街口站","8B",
"12","大行宫站","9B",
"13","西安门站","AB",
"14","明故宫站","BB",
"15","苜蓿园站","CB",
"16","下马坊站","DB",
"17","孝陵卫站","EB",
"18","钟灵街站","FB",
"19","马群站","GA",
"20","金马路站","I9",
"21","仙鹤门站","J8",
"22","学则路站","K8",
"23","仙林中心站","L7",
"24","中医药大学,羊山公园站","N6",
"25","南大仙林校区站","M5",
"26","经天路站","N4"};

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
