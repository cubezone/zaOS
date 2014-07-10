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
static String subways[]={
"GT","沪宁高铁","00",
"SUBWAY","沪宁高铁","上海",
"STATION","南京","D8",
"STATION","仙林","E2",
"STATION","宝华山","E3",
"STATION","镇江","E4",
"STATION","丹徒","E5",
"STATION","丹阳","E6",
"STATION","常州","E7",
"STATION","戚墅堰","E8",
"STATION","惠山","E9",
"STATION","无锡","EA",
"STATION","无锡新区","EB",
"STATION","苏州新区","EC",
"STATION","苏州","ED",
"STATION","苏州园区","EE",
"STATION","阳澄湖","EF",
"STATION","昆山南","EG",
"STATION","花桥","EH",
"STATION","安亭北","EI",
"STATION","南翔北","EJ",
"STATION","上海西","EK",
"STATION","上海","GF",
"STATION","共康路","EM",

"CITY","上海","GF",
"SUBWAY","1号线","上海",
"STATION","莘庄","C1",
"STATION","外环路","C2",
"STATION","莲花路","C3",
"STATION","锦江乐园","C4",
"STATION","上海南站","C5",
"STATION","漕宝路","C6",
"STATION","上海体育馆","C7",
"STATION","徐家汇","C8",
"STATION","衡山路","C9",
"STATION","常熟路","CA",
"STATION","陕西南路","CB",
"STATION","黄陂南路","CC",
"STATION","人民广场","CD",
"STATION","新闸路","CE",
"STATION","汉中路","CF",
"STATION","上海火车站","CG",
"STATION","中山北路","CH",
"STATION","延长路","CI",
"STATION","上海马戏城","CJ",
"STATION","汶水路","CK",
"STATION","彭浦新村","CL",
"STATION","共康路","CM",
"STATION","通河新村","CN",
"STATION","呼兰路","CO",
"STATION","共富新村","CP",
"STATION","宝安公路","CR",
"STATION","友谊西路","CS",
"STATION","富 锦 路","CT",

"SUBWAY","2号线","上海",
"STATION","浦东国际机场","E1",
"STATION","海天三路","E2",
"STATION","远东大道","E3",
"STATION","凌空路","E4",
"STATION","川沙","E5",
"STATION","华夏东路","E6",
"STATION","创新中路","E7",
"STATION","唐镇","E8",
"STATION","广兰路","E9",
"STATION","站名","EA",
"STATION","","EB",
"STATION","广兰路","EC",
"STATION","金科路","ED",
"STATION","张江高科","EE",
"STATION","龙阳路","EF",
"STATION","世纪公园","EG",
"STATION","上海科技馆","EH",
"STATION","世纪大道","EI",
"STATION","东昌路","EJ",
"STATION","陆家嘴","EK",
"STATION","南京东路","EL",
"STATION","人民广场","EM",
"STATION","南京西路","EN",
"STATION","静安寺","EO",
"STATION","江苏路","EP",
"STATION","中山公园","ER",
"STATION","娄山关路","ES",
"STATION","威宁路","ET",
"STATION","北新泾","EU",
"STATION","淞虹路","EV",
"STATION","虹桥2号航站楼?","EW",
"STATION","虹桥火车站","EX",
"STATION","徐泾东","EY",

"SUBWAY","3号线","上海",
"STATION","上海南站","F1",
"STATION","石龙路","F2",
"STATION","龙漕路","F3",
"STATION","漕溪路","F4",
"STATION","宜山路","F5",
"STATION","虹桥路","F6",
"STATION","延安西路","F7",
"STATION","中山公园","F8",
"STATION","金沙江路","F9",
"STATION","曹杨路","FA",
"STATION","镇坪路","FB",
"STATION","中潭路","FC",
"STATION","上海站","FD",
"STATION","宝山路","FE",
"STATION","东宝兴路","FF",
"STATION","虹口足球场","FG",
"STATION","赤峰路","FH",
"STATION","大柏树","FI",
"STATION","江湾镇","FJ",
"STATION","殷高西路","FK",
"STATION","长江南路","FL",
"STATION","淞发路","FM",
"STATION","张华浜","FN",
"STATION","淞滨路","FO",
"STATION","水产路","FP",
"STATION","宝杨路","FR",
"STATION","友谊路","FS",
"STATION","铁力路","FT",
"STATION","江杨北路","FU",

"SUBWAY","4号线","上海",
"STATION","宜山路","H1",
"STATION","上海体育馆","H2",
"STATION","上海体育场","H3",
"STATION","东安路","H4",
"STATION","大木桥路","H5",
"STATION","鲁班路","H6",
"STATION","西藏南路","H7",
"STATION","南浦大桥","H8",
"STATION","塘桥","H9",
"STATION","蓝村路","HA",
"STATION","浦电路","HB",
"STATION","世纪大道","HC",
"STATION","浦东大道","HD",
"STATION","杨树浦路","HE",
"STATION","大连路","HF",
"STATION","临平路","HG",
"STATION","海伦路","HH",
"STATION","宝山路","HI",
"STATION","上海火车站","HJ",
"STATION","中潭路","HK",
"STATION","镇坪路","HL",
"STATION","曹杨路","HM",
"STATION","金沙江路","HN",
"STATION","中山公园","HO",
"STATION","延安西路","HP",
"STATION","虹桥路","HR",

"SUBWAY","5号线","上海",
"STATION","莘庄","J1",
"STATION","春申路","J2",
"STATION","银都路","J3",
"STATION","颛桥","J4",
"STATION","北桥","J5",
"STATION","剑川路","J6",
"STATION","东川路","J7",
"STATION","金平路","J8",
"STATION","华宁路","J9",
"STATION","文井路","JA",
"STATION","闵行开发区","JB",


"SUBWAY","6号线","上海",
"STATION","港城路","K1",
"STATION","外高桥保税区北","K2",
"STATION","航津路","K3",
"STATION","外高桥保税区南","K4",
"STATION","洲海路","K5",
"STATION","五洲大道","K6",
"STATION","东靖路","K7",
"STATION","巨峰路","K8",
"STATION","五莲路","K9",
"STATION","博兴路","KA",
"STATION","金桥路","KB",
"STATION","云山路","KC",
"STATION","德平路","KD",
"STATION","北洋泾路","KE",
"STATION","民生路","KF",
"STATION","源深体育中心","KG",
"STATION","世纪大道","KH",
"STATION","浦电路","KI",
"STATION","蓝村路","KJ",
"STATION","上海儿童医学中心","KK",
"STATION","临沂新村","KL",
"STATION","高科西路","KM",
"STATION","东明路","KN",
"STATION","高青路","KO",
"STATION","华夏西路","KP",
"STATION","上南路","KR",
"STATION","灵岩南路","KS",
"STATION","济阳路（未启用）","KT",

"SUBWAY","7号线","上海",
"STATION","花木路","L1",
"STATION","龙阳路","L2",
"STATION","芳华路","L3",
"STATION","锦绣路","L4",
"STATION","杨高南路","L5",
"STATION","高科西路","L6",
"STATION","云台路","L7",
"STATION","耀华路","L8",
"STATION","长清路","L9",
"STATION","后滩","LA",
"STATION","船厂路","LB",
"STATION","东安路","LC",
"STATION","肇嘉浜路","LD",
"STATION","常熟路","LE",
"STATION","静安寺","LF",
"STATION","昌平路","LG",
"STATION","长寿路","LH",
"STATION","镇坪路","LI",
"STATION","岚皋路","LJ",
"STATION","新村路","LK",
"STATION","大华三路","LL",
"STATION","行知路","LM",
"STATION","大场镇","LN",
"STATION","场中路","LO",
"STATION","上大路","LP",
"STATION","南陈路","LR",
"STATION","上海大学","LS",

"SUBWAY","8号线","上海",
"STATION","航天博物馆","M1",
"STATION","联航路","M2",
"STATION","江月路","M3",
"STATION","浦江镇","M4",
"STATION","芦恒路","M5",
"STATION","凌兆新村","M6",
"STATION","济阳路（未启用）","M7",
"STATION","杨思","M8",
"STATION","成山路","M9",
"STATION","耀华路","MA",
"STATION","周家渡（未启用）","MB",
"STATION","西藏南路","MC",
"STATION","陆家浜路","MD",
"STATION","老西门","ME",
"STATION","大世界","MF",
"STATION","人民广场","MG",
"STATION","曲阜路","MH",
"STATION","中兴路","MI",
"STATION","西藏北路","MJ",
"STATION","虹口足球场","MK",
"STATION","曲阳路","ML",
"STATION","四平路","MM",
"STATION","鞍山新村","MN",
"STATION","江浦路","MO",
"STATION","黄兴路","MP",
"STATION","延吉中路","MR",
"STATION","黄兴公园","MS",
"STATION","翔殷路","MT",
"STATION","嫩江路","MU",
"STATION","市光路","MV",

"SUBWAY","9号线","上海",
"STATION","杨高中路","O1",
"STATION","世纪大道","O2",
"STATION","商城路","O3",
"STATION","小南门","O4",
"STATION","陆家浜","O5",
"STATION","马当路","O6",
"STATION","打浦桥","O7",
"STATION","嘉善路","O8",
"STATION","肇嘉浜路","O9",
"STATION","徐家汇","OA",
"STATION","宜山路","OB",
"STATION","桂林路","OC",
"STATION","漕河泾开发区","OD",
"STATION","合川路","OE",
"STATION","星中路","OF",
"STATION","七宝","OG",
"STATION","中春路","OH",
"STATION","九亭","OI",
"STATION","泗泾","OJ",
"STATION","佘山","OK",
"STATION","洞泾","OL",
"STATION","松江大学城","OM",
"STATION","松江新城","ON",

"SUBWAY","11号线","上海",
"STATION","江苏路","P1",
"STATION","隆德路","P2",
"STATION","曹杨路","P3",
"STATION","枫桥路","P4",
"STATION","真如","P5",
"STATION","上海西站","P6",
"STATION","李子园","P7",
"STATION","祁连山路","P8",
"STATION","武威路","P9",
"STATION","桃浦新村","PA",
"STATION","南翔","PB",
"STATION","马陆","PC",
"STATION","嘉定新城","PD",
"STATION","白银路","PE",
"STATION","嘉定西","PF",
"STATION","嘉定北","PG",
"STATION","上海赛车场","PH",
"STATION","昌吉东路(未启用)","PI",
"STATION","上海汽车城","PJ",
"STATION","安亭","PK",
    
"CITY","北京","B4",
"SUBWAY","1号线","北京",
"STATION","苹果园","1J",
"STATION","古城路","2K",
"STATION","八角游乐园","3K",
"STATION","八宝山","4K",
"STATION","玉泉路","5K",
"STATION","五棵松","6K",
"STATION","万寿路","7K",
"STATION","公主坟","8K",
"STATION","军事博物馆","9K",
"STATION","木樨地","BK",
"STATION","南礼士路","CK",
"STATION","复兴门","DK",
"STATION","西单","EK",
"STATION","天安门西","GK",
"STATION","天安门东","HK",
"STATION","王府井","IK",
"STATION","东单","KK",
"STATION","建国门","LK",
"STATION","永安里","MK",
"STATION","国贸","NK",
"STATION","大望路","OK",
"STATION","四惠","PK",
"STATION","四惠东","QK",

"SUBWAY","2号线","北京",
"STATION","西直门","DF",
"STATION","车公庄","DG",
"STATION","阜成门","DH",
"STATION","复兴门","DK",
"STATION","长椿街","DL",
"STATION","宣武门","EL",
"STATION","和平门","FL",
"STATION","前门","GL",
"STATION","崇文门","JL",
"STATION","北京站","KL",
"STATION","建国门","LK",
"STATION","朝阳门","LI",
"STATION","建国门","LH",
"STATION","东四十条","LG",
"STATION","东直门","LF",
"STATION","雍和宫","JE",
"STATION","安定门","IE",
"STATION","鼓楼大街","FE",
"STATION","积水潭","EE",
"STATION","西直门","DF",

"SUBWAY","八通线","北京",
"STATION","四惠","PK",
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

"CITY","广州","KE",
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
"STATION","天河客运站","E1",
"STATION","五山","E1",
"STATION","华师","E1",
"STATION","岗顶","E1",
"STATION","石牌桥","A1",
"STATION","体育西路","A1",
"STATION","珠江新城","A1",
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

"CITY","南京","D8",
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

//网格
static int m_x=0,m_y = 0;            // 画板的偏移量
static int m_ox=0,m_oy = 0;            // 画板的偏移量
static int m_zoom_x = 0,m_zoom_y = 0;  // 画板的放大倍数偏移量
static double m_ozoom = 0;  // 画板的放大倍数偏移量
static double m_zoom  = 1;           //放大倍数
static int m_level   = 0 ;           //

static class CCell 
{
   String m_position="AA";//位置信息;
   String m_cityposition="00";//位置信息;

         // 1,2,3,4,5        zoom 城市
        // 5,7,8.9.10       zoom 地铁线
        // 11,12,13.14.15   zoom 地铁     

   int m_index=0;          //序号
   int m_rote=0;
   int m_color=Color.RED;   
   int m_gird=4;   
   int m_size = 60;
   
 protected void debug(Graphics graphics,String str,int x, int  y)
 {
     if (1==2)
      graphics.drawText(str,x,y);
 };   
 
  protected int get_x()
 {
   return (int)(ctod(m_position.charAt(0))  * m_gird * m_zoom);
 };   
   protected int get_y()
 {
    return  (int)(ctod(m_position.charAt(1)) * m_gird * m_zoom);
 }; 
   
 protected int ctod(char c)
 {
        if (c >='a')  return c - 'a'+10+26;
        if (c >='A')  return c - 'A'+10;
        if (c < 'A')  return c - '0';
        return 0;
 }   

}

//地铁站
static class Cstation extends CCell
{
    String m_stationname="station";
    public void draw(Graphics graphics , int type, int textpos)
    {
        if (type==1) 
            drawmap(graphics,textpos);
        if (type==2) 
            drawlist(graphics);
    }
    
    public void drawmap(Graphics graphics, int textpos)
    {
        int l_x ,l_y;  
        int l_cir = Math.min(3,(int)(2*m_zoom));
        debug(graphics,"S",10,110);
        l_x = get_x();
        l_y = get_y();    
       if (m_zoom > 4)  
        graphics.fillArc(m_x+l_x-l_cir, m_zoom_y+m_y+l_y-l_cir, 2*l_cir+1,2*l_cir+1,0,360);  
        if (m_zoom > 6)   
        { if (textpos==1)
           graphics.drawText(m_stationname,m_x + l_x + 10,m_zoom_y+m_y +l_y + 10);
          if (textpos==2)
           graphics.drawText(m_stationname,m_x + l_x + 10,m_zoom_y+m_y +l_y - 20);           
        }
    } 
    
    public void drawlist(Graphics graphics )
    {  
        int l_y = 20*m_index;    
        if(( l_y < m_y+240) && ( l_y +m_y >0) )
        graphics.drawText(m_stationname,m_x + 10,m_zoom_y +m_y + l_y + 10);                 
    } 
    
    public boolean visiable()
    {
       if ((  m_zoom_y +m_y+ get_y() > -50 )&& ( m_zoom_y +m_y+get_y() < 240+50)
           && (m_x+get_x() < 360+50)&& (m_x+get_x() > -50))
        return true; 
      else
        return false;
    }
}

//线路
static class Cline extends CCell
{
    String m_linename = "line";
    Vector m_stations = new Vector();
    public void draw(Graphics graphics,int type)
    {
        int l_p=0;
        debug(graphics,"L",10,90);
        graphics.setColor(m_color);
        for (int i = 0 ; i < m_stations.size(); i++)
        {
        if ( ((Cstation) m_stations.elementAt(i)).visiable())
         {   
           if ( l_p == ((Cstation) m_stations.elementAt(i)).get_y())
           {
             ((Cstation) m_stations.elementAt(i)).draw(graphics,type,2);
             l_p = 0;
            }
           else
           {
             ((Cstation) m_stations.elementAt(i)).draw(graphics,type,1);
             l_p = ((Cstation) m_stations.elementAt(i)).get_y();
           }
                                 
          if (i> 0)
          {
             graphics.drawLine(((Cstation) m_stations.elementAt(i-1)).get_x()+m_x,
            ((Cstation) m_stations.elementAt(i-1)).get_y()+m_zoom_y +m_y,
            ((Cstation) m_stations.elementAt(i)).get_x()+m_x,
            ((Cstation) m_stations.elementAt(i)).get_y()+m_zoom_y +m_y);
           }          
         }
        }
    }
}

//城市
static class Ccity extends CCell
{
    String m_cityname = "city";
    Vector m_lines = new Vector();
    boolean m_GT = false;
    public void draw(Graphics graphics ,int type)
    {  
        graphics.setColor(m_color);        
        if (m_level ==0 && !m_GT )//显示城市
        {
            int l_x ,l_y;  
            int l_cir = Math.min(4,(int)(2*m_zoom));
            debug(graphics,"C",10,50);            
            l_x = get_x();
            l_y = get_y();
            graphics.fillArc(m_x+l_x,m_zoom_y +m_y+l_y, l_cir*2+1,l_cir*2+1,0,360);         
            graphics.drawText(m_cityname,m_x + l_x + 10,m_y + l_y + 10);    
       }
       if (m_level == 1 || m_GT)//城市显示 显示高铁
        {
            debug(graphics,"C2",10,50);
            for (int i = 0 ; i < m_lines.size(); i++)
                ((Cline)(m_lines.elementAt(i))).draw(graphics,type);
        }
        else  debug(graphics,"C3",10,50);
    }  
}

//
static class Cmetro extends CCell
{
  String m_metro = "metro";
  Vector m_citys  = new Vector();
  String m_city ="";
  Ccity m_act_city = null;
  Cstation m_act_station = null;
  Ccity l_city=null;
  Cline l_line=null;
  Cstation l_station=null; 
   
  char l_map[]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'} ;

 static final int ITEM_CNT=3; 
 int colors[] = { 
 Color.YELLOW,
 Color.LIGHTBLUE,
 Color.LIGHTGREEN,
 Color.LIGHTCYAN,
 Color.LIGHTPINK,
 Color.LIGHTSKYBLUE,
 Color.LIGHTSALMON,
 Color.LIGHTSTEELBLUE,
 Color.LIGHTGREY,
 Color.LIGHTCORAL,
 Color.LIGHTSEAGREEN,
 Color.MAROON};

public void init(String[] subways)
{  
    int c=0,u=0;
    for (int i = 0 ;i < 10000; i ++)
       {
             if (subways[i*ITEM_CNT]=="END") 
                break;                           
             if (subways[i*ITEM_CNT]=="CITY" ||(subways[i*ITEM_CNT]=="GT") ) 
             {    
                 c=0;u=0;                  
                 l_city = new Ccity();                 
                 l_city.m_cityname =subways[i*ITEM_CNT+1];
                 if (subways[i*ITEM_CNT]=="GT")
                    l_city.m_GT = true;
                 if (m_city == "") m_city = l_city.m_cityname;
                 l_city.m_position =subways[i*ITEM_CNT+2];
                 
                 m_citys.addElement(l_city);
             }
            else if (subways[i*ITEM_CNT]=="SUBWAY")  
             {  
                c++;u++;               
                l_line = new Cline();    
                l_line.m_linename =subways[i*ITEM_CNT+1]; 
                l_line.m_color=colors[c];
                
                l_city.m_lines.addElement(l_line);
             }
            else
             {                 
                 u++;
                 l_station               = new Cstation(); 
                 l_station.m_index       = u;
                 if (l_city.m_GT) l_station.m_size = 1;
                 l_station.m_stationname = subways[i*ITEM_CNT+1];
                 l_station.m_position    = subways[i*ITEM_CNT+2];
                 l_station.m_color       = colors[c];
                 l_line.m_stations.addElement(l_station);
                 
              }              
       } 
  }
  
  public void draw(Graphics graphics,int type )
  {
    graphics.setBackgroundColor(Color.BLACK);
    graphics.clear();       
    for (int i = 0; i <m_citys.size(); i++)
    {
       debug(graphics,"City",10,20);
       l_city = (Ccity)(m_citys.elementAt(i));
       
       if (m_level==0) //显示总体
            l_city.draw(graphics,type);
            
       if (m_level == 1)//显示城市
       {
            if (l_city.m_cityname == m_city)              
               l_city.draw(graphics,type);
       }
    }
  } 
  
public void movebackground( int dx, int dy)
{ 
     m_x = m_x + 20*dx*Math.abs(dx);
     m_y = m_y + 20*dy*Math.abs(dy);      
}

public void zoom(int a,int b)
{ 
     m_x = (int)((m_x - 160)/m_zoom * m_zoom * a/b)+160;
     m_y = (int)((m_y - 120)/m_zoom * m_zoom * a/b)+120;
     
     m_zoom = m_zoom * a / b;   
     //根据当前屏幕3600*240的中心点进行zoom;           
           
     if ((m_level == 1) && (m_zoom  < 0.2))
         { m_x=m_ox;m_y =m_oy;m_zoom=m_ozoom;m_level=0;}        
     else if ((m_level == 0) && (m_zoom< 1))
         {m_zoom = 1;}                
    else if ((m_level == 0) && (m_zoom> 60))  
         { m_ozoom= m_zoom;m_ox=m_x;m_oy=m_y; m_x=0;m_y =0; m_zoom=1;m_level=1;}        
/*     
      if (m_zoom >= 1)
     {   
         m_zoom_x = -(int)(160*m_zoom)+ 160 ;
         m_zoom_y =  -(int)(120*m_zoom) + 120 ;
      }
     if (m_zoom < 1)
     {  
         m_zoom_x = 180 - (int)(180*m_zoom);
         m_zoom_y = 120 - (int)(120*m_zoom);  
     }   
  */
}
       
   public void rote()
  {       
      
  }
  
  public void changeCity(String cityname)
  {
      m_city=cityname;
  }
}

Ccity l_city=null;
Cline l_line=null;
Cstation l_station=null;  
       
Cmetro m_metro= new Cmetro();
String m_show ="showmap";
RichTextField m_background;

public za_SubWay()
    { 
        m_metro.init(subways);                     
        /*m_background =new RichTextField("\n\n\n\n\n\n\n\n\n\n\n",Field.NON_FOCUSABLE) 
        {   protected void paint(Graphics graphics)
            {           
                   if (m_show =="showmap") 
                        m_metro.draw(graphics,1);           
                   if (m_show =="showlist")  
                        m_metro.draw(graphics,2);
            } 
         };
        add(m_background);    */
    }  

      protected void paint(Graphics graphics)
            {           
                   if (m_show =="showmap") 
                        m_metro.draw(graphics,1);           
                   if (m_show =="showlist")  
                        m_metro.draw(graphics,2);
            } 
            
    protected void makeMenu(Menu menu, int instance)
    {         
        for (int i = 0; i <m_metro.m_citys.size(); i++)
        {
                menu.add(new MenuItem(((Ccity)(m_metro.m_citys.elementAt(i))).m_cityname , 100, 10)
                {
                public void run()
                { 
                    m_metro.changeCity(this.toString()); 
                    invalidate(); doPaint(); 
                }});
        }                      
        super.makeMenu(menu, instance);
    }
 
    protected boolean navigationClick(int status,int time)
    {
            if (m_show=="showmap") 
            { 
                m_show="showlist";             
            }
            else  
                m_show="showmap";
                        
            //invalidate();
           // doPaint();          
            return true;
    }    

    protected boolean navigationMovement(int dx, int dy, int status,int time)
    {
        m_metro.movebackground(-dx,-dy);
        invalidate();
        doPaint();
        return super.navigationMovement( dx, dy, status,time ); // We'll let super handle the event.
    }
                                 
    protected boolean keyChar( char key, int status, int time )
    {
        boolean ret;        
        if ( key == Characters.ENTER) 
            return true;    
        if (key == Characters.LATIN_SMALL_LETTER_O)// zoom in 
           m_metro.zoom(5,4);          
        if (key == Characters.LATIN_SMALL_LETTER_I) // zoom out
           m_metro.zoom(4,5);          
        if (key == Characters.LATIN_SMALL_LETTER_R) 
            m_metro.rote(); 
                    
        invalidate();
        doPaint();
        return super.keyChar( key, status, time ); // We'll let super handle the event.                       
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
