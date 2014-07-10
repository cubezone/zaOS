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
"SUBWAY","1号线","北京",
"01","苹果园","1J",
"02","古城路","2K",
"03","八角游乐园","3K",
"04","八宝山","4K",
"05","玉泉路","5K",
"06","五棵松","6K",
"07","万寿路","7K",
"08","公主坟","8K",
"09","军事博物馆","9K",
"10","木樨地","BK",
"11","南礼士路","CK",
"12","复兴门","DK",
"13","西单","EK",
"14","天安门西","GK",
"15","天安门东","HK",
"16","王府井","IK",
"17","东单","KK",
"18","建国门","LK",
"19","永安里","MK",
"20","国贸","NK",
"21","大望路","OK",
"22","四惠","PK",
"23","四惠东","QK",

"SUBWAY","2号线","北京",
"01","西直门","DF",
"02","车公庄","DG",
"03","阜成门","DH",
"04","复兴门","DK",
"05","长椿街","DL",
"06","宣武门","EL",
"07","和平门","FL",
"08","前门","GL",
"09","崇文门","JL",
"10","北京站","KL",
"11","建国门","LK",
"12","朝阳门","LI",
"13","建国门","LH",
"14","东四十条","LG",
"15","东直门","LF",
"16","雍和宫","JE",
"17","安定门","IE",
"18","鼓楼大街","FE",
"19","积水潭","EE",
"20","西直门","DF",

"SUBWAY","八通线","北京",
"01","四惠","PK",
"02","四惠东","QK",
"03","高碑店","RK",
"04","传媒大学","SK",
"05","双桥","TK",
"06","管庄","UK",
"07","八里桥","VK",
"08","北苑","WL",
"09","果园","XM",
"10","九棵树","YN",
"11","梨园","ZO",
"12","临河里","aP",
"13","土桥","bQ",

"SUBWAY","4号线","北京",
"01","公益西桥","ER",
"02","角门西","EQ",
"03","马家堡","EP",
"04","北京南站","EO",
"05","陶然亭","EN",
"06","菜市口","EM",
"07","宣武门","EL",
"08","西单","EK",
"09","灵境胡同","EI",
"10","西四","EH",
"11","平安里","EG",
"12","新街口","EF",
"13","西直门","DF",
"14","动物园","BF",
"15","国家图书馆","AF",
"16","魏公村","AE",
"17","人民大学","AB",
"18","海淀黄庄","AA",
"19","中关村","A9",
"20","北京大学东门","A8",
"21","圆明园","97",
"22","西苑","86",
"23","北宫门","76",

"SUBWAY","5号线","北京",
"01","天通苑北","J1",
"02","天通苑","J2",
"03","天通苑南","J3",
"04","立水桥","J4",
"05","立水桥南","J5",
"06","北苑路北","J6",
"07","大屯路东","J7",
"08","惠新西街北口","J8",
"09","惠新西街南口","JA",
"10","和平西桥","JB",
"11","和平里北街","JC",
"12","雍和宫","JE",
"13","北新桥","JF",
"14","张自忠路","JG",
"15","东四","JH",
"16","灯市口","JI",
"17","东单","JK",
"18","崇文门","JL",
"19","磁器口","JN",
"20","天坛东门","JO",
"21","蒲黄榆","JP",
"22","刘家窑","JQ",
"23","宋家庄","JR",

"SUBWAY","10号线","北京",
"01","巴沟","6A", 
"02","苏州街","8A",
"03","海淀黄庄","AA",
"04","知春里","BA",
"05","知春路","CA",
"06","西土城","EA",
"07","牡丹园","FA",
"08","健德门","GA",
"09","北土城","HA",
"10","安贞门","IA",
"11","惠新西街南口","JA", 
"12","芍药居","LA",
"13","太阳宫","MA",
"14","三元桥","NB",
"15","亮马桥","NC",
"16","农业展览馆","ND", 
"17","团结湖","NE",
"18","呼家楼","NG",
"19","金台夕照","NI",
"20","国贸","NK",
"21","双井","NL",
"22","劲松","NM", 

"SUBWAY","13号线","北京",
"01","西直门","DF",
"02","大钟寺","CC",
"03","知春路","CA",
"04","五道口","C8",
"05","上地","C6",
"06","西二旗","C5",
"07","龙泽","D4",
"08","回龙观","E4",
"09","霍营","G4",
"10","立水桥","J4",
"11","北苑","L5",
"12","望京西","L7",
"13","芍药居","LA",
"14","光熙门","LB",
"15","柳芳","LD",
"16","东直门","LF",

"SUBWAY","奥运线","北京",
"01","森林公园南门","H7",
"02","奥林匹克公园","H8",
"03","奥体中心","H9",
"04","北土城","HA",

"SUBWAY","机场快线","北京",
"01","东直门","LF",
"02","三元桥","NB",
"03","T3航站楼","U4",
"04","T2航站楼","T4",

"CITY","","GuanZhou",
"SUBWAY","1号线","广州",
"01","广州东站","A1",
"01","体育中心","A2",
"01","体育西路","A3",
"01","杨箕","A4",
"01","东山口","A5",
"01","烈士陵园","A6",
"01","农讲所","A7",
"01","公园前","A8",
"01","西门口","A9",
"01","陈家祠","AA",
"01","长寿路","AB",
"01","黄沙","AC",
"01","芳村","AD",
"01","花地湾","AE",
"01","坑口","AF",
"SUBWAY","2号线","广州",
"01","广州南站","D1",
"01","石壁站","A1",
"01","会江站","A1",
"01","南浦站","A1",
"01","洛溪站","A1",
"01","南洲站","A1",
"01","东晓南站","A1",
"01","江泰路站","A1",
"01","昌岗站","A1",
"01","江南西站","A1",
"01","市二宫站","A1",
"01","海珠广场站","A1",
"01","公园前站","A1",
"01","纪念堂站","A1",
"01","越秀公园站","A1",
"01","广州火车站站","A1",
"01","三元里站","A1",
"01","飞翔公园站","A1",
"01","白云公园站","A1",
"01","白云文化广场站","A1",
"01","萧岗站","A1",
"01","江夏站","A1",
"01","黄边站","A1",
"01","嘉禾望岗","A1",

"SUBWAY","3号线","广州",
"01","天河客运站","E1",
"01","五山","E1",
"01","华师","E1",
"01","岗顶","E1",
"01","石牌桥","A1",
"01","体育西路","A1",
"01","珠江新城","A1",
"01","赤岗塔","A1",
"01","客村","A1",
"01","大塘","A1",
"01","沥滘","A1",
"01","厦滘","A1",
"01","大石","A1",
"01","汉溪长隆","A1",
"01","市桥","A1",
"01","番禺广场","A1",

"SUBWAY","4号线","广州",
"01","车陂南","A1",
"01","万胜围","A1",
"01","官洲","A1",
"01","大学城北","A1",
"01","大学城南","A1",
"01","新造","A1",
"01","石碁","A1",
"01","海傍","A1",
"01","低涌","A1",
"01","东涌","A1",
"01","黄阁汽车城","A1",
"01","黄阁","A1",
"01","蕉门","A1",
"01","金洲","A1",

"SUBWAY","5号线","广州",
"01","滘口","A1",
"01","坦尾","B1",
"01","中山八","C2",
"01","西场","D1",
"01","西村","A1",
"01","广州火车站","A1",
"01","小北","A1",
"01","淘金","A1",
"01","区庄","A1",
"01","动物园","A1",
"01","杨箕","A1",
"01","五羊邨","A1",
"01","珠江新城","A1",
"01","猎德","A1",
"01","潭村","A1",
"01","员村","A1",
"01","科韵路","A1",
"01","车陂南","A1",
"01","东圃","A1",
"01","三溪","A1",
"01","鱼珠","A1",
"01","大沙地","A1",
"01","大沙东","A1",
"01","文冲","A1",

"CITY","","NanJing",
"SUBWAY","1号线","南京",
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
"16","迈皋桥站","C3",

"SUBWAY","1号延长线","南京",
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
"15","中国药科大学站","GP",

"SUBWAY","2号线","南京",
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
"26","经天路站","N4",
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
