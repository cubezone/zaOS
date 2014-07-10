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
import java.util.* ;

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
 int m_text_x =0;
 int m_list =0,m_station=0; 
 String m_city="NanJing";
 char l_map[]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'} ;
 int m_max_x =0,m_max_y=0;
 String m_show="showlist";
 static final int ITEM_CNT=3; 
 int colors[]={ 
 Color.YELLOW,
 Color.LIGHTBLUE,
 Color.LIGHTGREEN,
 Color.LIGHTCYAN,
 Color.LIGHTPINK,
 Color.LIGHTSKYBLUE,
 Color.LIGHTSALMON,
 Color.LIGHTSTEELBLUE,
 Color.LIME,
 Color.NAVY
};
 
 static  String subways[]={
 "CITY","","BeiJing",
"SUBWAY","1����","����",
"01","ƻ��԰","1J",
"02","�ų�·","2K",
"03","�˽�����԰","3K",
"04","�˱�ɽ","4K",
"05","��Ȫ·","5K",
"06","�����","6K",
"07","����·","7K",
"08","������","8K",
"09","���²����","9K",
"10","ľ�ص�","BK",
"11","����ʿ·","CK",
"12","������","DK",
"13","����","EK",
"14","�찲����","GK",
"15","�찲�Ŷ�","HK",
"16","������","IK",
"17","����","KK",
"18","������","LK",
"19","������","MK",
"20","��ó","NK",
"21","����·","OK",
"22","�Ļ�","PK",
"23","�Ļݶ�","QK",

"SUBWAY","2����","����",
"01","��ֱ��","DF",
"02","����ׯ","DG",
"03","������","DH",
"04","������","DK",
"05","������","DL",
"06","������","EL",
"07","��ƽ��","FL",
"08","ǰ��","GL",
"09","������","JL",
"10","����վ","KL",
"11","������","LK",
"12","������","LI",
"13","������","LH",
"14","����ʮ��","LG",
"15","��ֱ��","LF",
"16","Ӻ�͹�","JE",
"17","������","IE",
"18","��¥���","FE",
"19","��ˮ̶","EE",
"20","��ֱ��","DF",

"SUBWAY","��ͨ��","����",
"01","�Ļ�","PK",
"02","�Ļݶ�","QK",
"03","�߱���","RK",
"04","��ý��ѧ","SK",
"05","˫��","TK",
"06","��ׯ","UK",
"07","������","VK",
"08","��Է","WL",
"09","��԰","XM",
"10","�ſ���","YN",
"11","��԰","ZO",
"12","�ٺ���","aP",
"13","����","bQ",

"SUBWAY","4����","����",
"01","��������","ER",
"02","������","EQ",
"03","��ұ�","EP",
"04","������վ","EO",
"05","��Ȼͤ","EN",
"06","���п�","EM",
"07","������","EL",
"08","����","EK",
"09","�龳��ͬ","EI",
"10","����","EH",
"11","ƽ����","EG",
"12","�½ֿ�","EF",
"13","��ֱ��","DF",
"14","����԰","BF",
"15","����ͼ���","AF",
"16","κ����","AE",
"17","�����ѧ","AB",
"18","�����ׯ","AA",
"19","�йش�","A9",
"20","������ѧ����","A8",
"21","Բ��԰","97",
"22","��Է","86",
"23","������","76",

"SUBWAY","5����","����",
"01","��ͨԷ��","J1",
"02","��ͨԷ","J2",
"03","��ͨԷ��","J3",
"04","��ˮ��","J4",
"05","��ˮ����","J5",
"06","��Է·��","J6",
"07","����·��","J7",
"08","�������ֱ���","J8",
"09","���������Ͽ�","JA",
"10","��ƽ����","JB",
"11","��ƽ�ﱱ��","JC",
"12","Ӻ�͹�","JE",
"13","������","JF",
"14","������·","JG",
"15","����","JH",
"16","���п�","JI",
"17","����","JK",
"18","������","JL",
"19","������","JN",
"20","��̳����","JO",
"21","�ѻ���","JP",
"22","����Ҥ","JQ",
"23","�μ�ׯ","JR",

"SUBWAY","10����","����",
"01","�͹�","6A", 
"02","���ݽ�","8A",
"03","�����ׯ","AA",
"04","֪����","BA",
"05","֪��·","CA",
"06","������","EA",
"07","ĵ��԰","FA",
"08","������","GA",
"09","������","HA",
"10","������","IA",
"11","���������Ͽ�","JA", 
"12","��ҩ��","LA",
"13","̫����","MA",
"14","��Ԫ��","NB",
"15","������","NC",
"16","ũҵչ����","ND", 
"17","�Ž��","NE",
"18","����¥","NG",
"19","��̨Ϧ��","NI",
"20","��ó","NK",
"21","˫��","NL",
"22","����","NM", 

"SUBWAY","13����","����",
"01","��ֱ��","DF",
"02","������","CC",
"03","֪��·","CA",
"04","�����","C8",
"05","�ϵ�","C6",
"06","������","C5",
"07","����","D4",
"08","������","E4",
"09","��Ӫ","G4",
"10","��ˮ��","J4",
"11","��Է","L5",
"12","������","L7",
"13","��ҩ��","LA",
"14","������","LB",
"15","����","LD",
"16","��ֱ��","LF",

"SUBWAY","������","����",
"01","ɭ�ֹ�԰����","H7",
"02","����ƥ�˹�԰","H8",
"03","��������","H9",
"04","������","HA",

"SUBWAY","��������","����",
"01","��ֱ��","LF",
"02","��Ԫ��","NB",
"03","T3��վ¥","U4",
"04","T2��վ¥","T4",

"CITY","","GuanZhou",
"SUBWAY","1����","����",
"01","���ݶ�վ","A1",
"01","��������","A2",
"01","������·","A3",
"01","���","A4",
"01","��ɽ��","A5",
"01","��ʿ��԰","A6",
"01","ũ����","A7",
"01","��԰ǰ","A8",
"01","���ſ�","A9",
"01","�¼���","AA",
"01","����·","AB",
"01","��ɳ","AC",
"01","����","AD",
"01","������","AE",
"01","�ӿ�","AF",
"SUBWAY","2����","����",
"01","������վ","D1",
"01","ʯ��վ","A1",
"01","�Ὥվ","A1",
"01","����վ","A1",
"01","��Ϫվ","A1",
"01","����վ","A1",
"01","������վ","A1",
"01","��̩·վ","A1",
"01","����վ","A1",
"01","������վ","A1",
"01","�ж���վ","A1",
"01","����㳡վ","A1",
"01","��԰ǰվ","A1",
"01","������վ","A1",
"01","Խ�㹫԰վ","A1",
"01","���ݻ�վվ","A1",
"01","��Ԫ��վ","A1",
"01","���蹫԰վ","A1",
"01","���ƹ�԰վ","A1",
"01","�����Ļ��㳡վ","A1",
"01","����վ","A1",
"01","����վ","A1",
"01","�Ʊ�վ","A1",
"01","�κ�����","A1",

"SUBWAY","3����","����",
"01","��ӿ���վ","E1",
"01","��ɽ","E1",
"01","��ʦ","E1",
"01","�ڶ�","E1",
"01","ʯ����","A1",
"01","������·","A1",
"01","�齭�³�","A1",
"01","�����","A1",
"01","�ʹ�","A1",
"01","����","A1",
"01","����","A1",
"01","�Ü�","A1",
"01","��ʯ","A1",
"01","��Ϫ��¡","A1",
"01","����","A1",
"01","��خ�㳡","A1",

"SUBWAY","4����","����",
"01","������","A1",
"01","��ʤΧ","A1",
"01","����","A1",
"01","��ѧ�Ǳ�","A1",
"01","��ѧ����","A1",
"01","����","A1",
"01","ʯ��","A1",
"01","����","A1",
"01","��ӿ","A1",
"01","��ӿ","A1",
"01","�Ƹ�������","A1",
"01","�Ƹ�","A1",
"01","����","A1",
"01","����","A1",

"SUBWAY","5����","����",
"01","���","A1",
"01","̹β","B1",
"01","��ɽ��","C2",
"01","����","D1",
"01","����","A1",
"01","���ݻ�վ","A1",
"01","С��","A1",
"01","�Խ�","A1",
"01","��ׯ","A1",
"01","����԰","A1",
"01","���","A1",
"01","����ߗ","A1",
"01","�齭�³�","A1",
"01","�Ե�","A1",
"01","̶��","A1",
"01","Ա��","A1",
"01","����·","A1",
"01","������","A1",
"01","����","A1",
"01","��Ϫ","A1",
"01","����","A1",
"01","��ɳ��","A1",
"01","��ɳ��","A1",
"01","�ĳ�","A1",

"CITY","","NanJing",
"SUBWAY","1����","�Ͼ�",
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
"16","������վ","C3",

"SUBWAY","1���ӳ���","�Ͼ�",
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
"15","�й�ҩ�ƴ�ѧվ","GP",

"SUBWAY","2����","�Ͼ�",
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
"26","����·վ","N4",
"END","Game over",""};

class Ccity
{
 String m_cityname;
 Vector m_lines;
}

class Cline
{
 String m_linename;
 Vector m_stations;
}

class Cstation
{
 String m_stationname;
 String m_position;
}

class Cmetro
{
  String m_application;
  Vector m_citys;
}

Cmetro m_metro= new Cmetro();

public za_SubWay()
{      
       Ccity l_city=null;
       Cline l_line=null;
       Cstation l_station=null;  
       for (int i = 0 ;i < 10000; i ++)
       {
             if (subways[i*ITEM_CNT]=="END") break;                           
             if (subways[i*ITEM_CNT]=="CITY") 
             {                 
                 l_city = new Ccity();
                 m_metro.m_citys.addElement(l_city);
                 l_city.m_cityname =subways[i*ITEM_CNT+2];
             }
             if (subways[i*ITEM_CNT]=="SUBWAY")  
             {
                l_line = new Cline();
                l_line.m_linename =subways[i*ITEM_CNT+1];
                l_city.m_lines.addElement(l_line);
             }
             else
             {
                 l_station = new Cstation();
                 l_station.m_stationname=subways[i*ITEM_CNT+1];
                 l_station.m_position=subways[i*ITEM_CNT+2];
                 l_line.m_stations.addElement(l_station); 
              }
               
       } 
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
           int l_x=0 , l_y =0,l_ox=0 , l_oy=0,l_pass=0,l_station=0,l_line=0;
           int l_grid=0,l_cir=0,l_pos =0;
            graphics.setBackgroundColor(Color.BLACK);
            graphics.clear();
            graphics.setColor(Color.YELLOW); 
            m_max_x=0;                          
            m_max_y=0;            
            l_grid = 4*m_zoom;
            l_cir = 1*m_zoom;
            if (l_cir > 4) l_cir=4;
           
             for (int i = 0; i <10000; i++)
            {
               if (subways[i*ITEM_CNT]=="END") break;               
               if (l_pass==1)
               {
                if (subways[i*ITEM_CNT]=="CITY") break;
                if (subways[i*ITEM_CNT]=="SUBWAY") 
                {
                   graphics.setColor(colors[l_line]);
                   l_line ++;
                   l_station=0;
                   m_text_y =0;m_text_x =0;
                }
                else
                {
                if (m_rote ==0)
                {l_x = ctod(subways[i*ITEM_CNT+2].charAt(0)) * l_grid;
                l_y = ctod(subways[i*ITEM_CNT+2].charAt(1)) * l_grid;
                }else
                {
                    l_y = -ctod(subways[i*ITEM_CNT+2].charAt(0)) * l_grid + 20*l_grid;
                    l_x = ctod(subways[i*ITEM_CNT+2].charAt(1)) * l_grid ;
                }  
                if ((m_y + l_y> -100) && (m_y+ l_y < 240+100))
                {
                if (l_station>0) graphics.drawLine(m_x+l_ox+l_cir,m_y+ l_oy+l_cir,m_x+l_x+l_cir,m_y+ l_y+l_cir);
                if (m_zoom>5) 
                  if ((m_text_y == l_y))
                  {
                        l_pos ++;
                        if (l_pos%2==0)
                           graphics.drawText(subways[i*ITEM_CNT+1],m_x+l_x+10,m_y+ l_y - 20);
                        else
                           graphics.drawText(subways[i*ITEM_CNT+1],m_x+l_x+10,m_y+ l_y + 10);                                                   
                  }
                  else
                  {
                           graphics.drawText(subways[i*ITEM_CNT+1],m_x+l_x+10,m_y+ l_y +10);
                   }                  
                    graphics.fillArc(m_x+l_x,m_y+ l_y,l_cir*2+1,l_cir*2+1,0,360);    
                    m_text_y = l_y;m_text_x = l_x; 
                }
                l_ox=l_x;l_oy=l_y;  
                if (l_x > m_max_x) m_max_x=l_x;
                if (l_y > m_max_y) m_max_y=l_y;                                 
                    l_station ++;                                
                 }                               
               } 
               else if ((subways[i*ITEM_CNT]=="CITY") && (subways[i*ITEM_CNT+2]==m_city))
                    l_pass =1;                
            }
            
            m_max_x = m_max_x -200;
            if (m_max_x <0 ) m_max_x=0;
            m_max_y = m_max_y -150;
            if (m_max_y <0 ) m_max_y=0;
     
    }
    
    protected int ctod(char c)
    {
        if (c >='a')  return c - 'a'+10+26;
        if (c >='A')  return c - 'A'+10;
        if (c < 'A')  return c - '0';
        return 0;
    }
    protected void showList(Graphics graphics)
    {    
      int l_pass=0,l_station=0,l_line=0;
            graphics.setBackgroundColor(Color.BLACK);
            graphics.clear();
            graphics.setColor(Color.YELLOW);
            
             for (int i = 0; i <10000; i++)
            {
               if (subways[i*ITEM_CNT]=="END")  break;
                
               if (l_pass==1)
               {
                if (subways[i*ITEM_CNT]=="CITY") 
                    break;
                if (m_list==l_station) 
                    graphics.drawText( "=>",10,m_y+ 20*m_list);
                if (subways[i*ITEM_CNT]=="SUBWAY") 
                {
                   graphics.setColor(colors[l_line]);
                   graphics.drawText(subways[i*ITEM_CNT+1]+"--"+subways[i*ITEM_CNT+2],40,m_y+ 20*l_station);  
                   l_line ++;l_station ++;
                }
                else
                {
                    if ((m_y+ 20*l_station+20 > 0) && (m_y+ 20*l_station < 240))
                    graphics.drawText(subways[i*ITEM_CNT]+" "+subways[i*ITEM_CNT+1],40,m_y+ 20*l_station);  
                    l_station ++;                                
                 }                               
               } 
               else if ((subways[i*ITEM_CNT]=="CITY") && (subways[i*ITEM_CNT+2]==m_city))
                    l_pass =1;                
            } 
            m_station = l_station;           
    }
    
    protected void makeMenu(Menu menu, int instance)
    {         
            for (int i = 0; i <10000; i++)
            {
               if (subways[i*ITEM_CNT]=="END") break;      
               if  (subways[i*ITEM_CNT]=="CITY")
               menu.add(new MenuItem(subways[i*ITEM_CNT+2] , 100, 10){
               public void run(){m_list =0;m_y = 0;m_city=this.toString(); invalidate(); doPaint(); }});
           }                      
            super.makeMenu(menu, instance);
    }

    protected boolean navigationClick(int status,
                                           int time)
    {
          if (m_show=="showmap") 
                                 {  m_show="showlist";
                              }
                              else {m_show="showmap"; 
                               } 
          invalidate();
          doPaint();
          return true;
    }    
    protected boolean  navigationMovement(int dx, int dy, int status,int time)
    {
        if (m_show=="showmap")
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
         }
         else
         {
             if (dy>0) m_list = m_list + dy*dy;
             if (dy<0) m_list = m_list - dy*dy;
             if (m_list < 0) m_list = 0; 
             if (m_list > m_station-1) m_list =m_station-1;            
             if (m_list*20+20 >= -m_y+240) m_y = -(m_list*20+20-240);
             if (m_list*20 < -m_y) m_y =   - (m_list*20);
         }   

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
