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
public final  class za_SubWay extends MainScreen
{     
static String subways[]={
   
"CITY","上海","EC","4","180",
"SUBWAY","1号线","上海","4","180",
"STATION","莘庄","4S","4","180",
"STATION","外环路","5R","4","180",
"STATION","莲花路","5Q","4","180",
"STATION","锦江乐园","6Q","4","180",
"STATION","上海南站","6P","4","180",
"STATION","漕宝路","7O","4","180",
"STATION","上海体育馆","7M","4","180",
"STATION","徐家汇","7L","4","180",
"STATION","衡山路","8L","4","180",
"STATION","常熟路","8K","4","180",
"STATION","陕西南路","9K","4","180",
"STATION","黄陂南路","AK","4","180",
"STATION","人民广场","AJ","4","180",
"STATION","新闸路","AH","4","180",
"STATION","汉中路","9H","4","180",
"STATION","上海火车站","9G","4","180",
"STATION","中山北路","AF","4","180",
"STATION","延长路","AE","4","180",
"STATION","上海马戏城","AD","4","180",
"STATION","汶水路","AC","4","180",
"STATION","彭浦新村","AA","4","180",
"STATION","共康路","A9","4","180",
"STATION","通河新村","A8","4","180",
"STATION","呼兰路","A7","4","180",
"STATION","共富新村","A6","4","180",
"STATION","宝安公路","A4","4","180",
"STATION","友谊西路","A3","4","180",
"STATION","富锦路","A2","4","180",

"SUBWAY","2号线","上海","4","180",
"STATION","浦东国际机场","KR","4","180",
"STATION","海天三路","KR","4","180",
"STATION","远东大道","JQ","4","180",
"STATION","凌空路","IQ","4","180",
"STATION","川沙","IQ","4","180",
"STATION","华夏东路","HP","4","180",
"STATION","创新中路","HO","4","180",
"STATION","唐镇","GO","4","180",
"STATION","广兰路","GO","4","180",
"STATION","金科路","FO","4","180",
"STATION","张江高科","EO","4","180",
"STATION","龙阳路","EO","4","180",
"STATION","世纪公园","DN","4","180",
"STATION","上海科技馆","DM","4","180",
"STATION","世纪大道","DK","4","180",
"STATION","东昌路","CJ","4","180",
"STATION","陆家嘴","CJ","4","180",
"STATION","南京东路","BJ","4","180",
"STATION","人民广场","AJ","4","180",
"STATION","南京西路","9J","4","180",
"STATION","静安寺","8J","4","180",
"STATION","江苏路","8I","4","180",
"STATION","中山公园","7I","4","180",
"STATION","娄山关路","6I","4","180",
"STATION","威宁路","5H","4","180",
"STATION","北新泾","5G","4","180",
"STATION","淞虹路","4G","4","180",
"STATION","虹桥2号航站楼","3H","4","180",
"STATION","虹桥火车站","3I","4","180",
"STATION","徐泾东","2I","4","180",

"SUBWAY","3号线","上海","4","180",
"STATION","上海南站","6P","4","180",
"STATION","石龙路","7P","4","180",
"STATION","龙漕路","7O","4","180",
"STATION","漕溪路","7M","4","180",
"STATION","宜山路","6K","4","180",
"STATION","虹桥路","6J","4","180",
"STATION","延安西路","6I","4","180",
"STATION","中山公园","6G","4","180",
"STATION","金沙江路","7F","4","180",
"STATION","曹杨路","8F","4","180",
"STATION","镇坪路","8F","4","180",
"STATION","中潭路","9F","4","180",
"STATION","上海站","AG","4","180",
"STATION","宝山路","BG","4","180",
"STATION","东宝兴路","BF","4","180",
"STATION","虹口足球场","BE","4","180",
"STATION","赤峰路","CE","4","180",
"STATION","大柏树","CD","4","180",
"STATION","江湾镇","CC","4","180",
"STATION","殷高西路","CB","4","180",
"STATION","长江南路","CA","4","180",
"STATION","淞发路","C9","4","180",
"STATION","张华浜","D8","4","180",
"STATION","淞滨路","D7","4","180",
"STATION","水产路","D6","4","180",
"STATION","宝杨路","D5","4","180",
"STATION","友谊路","D4","4","180",
"STATION","铁力路","D3","4","180",
"STATION","江杨北路","D2","4","180",

"SUBWAY","4号线","上海","4","180",
"STATION","宜山路","61","4","180",
"STATION","上海体育馆","72","4","180",
"STATION","上海体育场","83","4","180",
"STATION","东安路","84","4","180",
"STATION","大木桥路","85","4","180",
"STATION","鲁班路","96","4","180",
"STATION","西藏南路","A7","4","180",
"STATION","南浦大桥","B8","4","180",
"STATION","塘桥","C9","4","180",
"STATION","蓝村路","CA","4","180",
"STATION","浦电路","CB","4","180",
"STATION","世纪大道","HC","4","180",
"STATION","浦东大道","HD","4","180",
"STATION","杨树浦路","HE","4","180",
"STATION","大连路","HF","4","180",
"STATION","临平路","HG","4","180",
"STATION","海伦路","HH","4","180",
"STATION","宝山路","HI","4","180",
"STATION","上海火车站","HJ","4","180",
"STATION","中潭路","HK","4","180",
"STATION","镇坪路","HL","4","180",
"STATION","曹杨路","HM","4","180",
"STATION","金沙江路","HN","4","180",
"STATION","中山公园","HO","4","180",
"STATION","延安西路","HP","4","180",
"STATION","虹桥路","HR","4","180",

"SUBWAY","5号线","上海","4","180",
"STATION","莘庄","J1","4","180",
"STATION","春申路","J2","4","180",
"STATION","银都路","J3","4","180",
"STATION","颛桥","J4","4","180",
"STATION","北桥","J5","4","180",
"STATION","剑川路","J6","4","180",
"STATION","东川路","J7","4","180",
"STATION","金平路","J8","4","180",
"STATION","华宁路","J9","4","180",
"STATION","文井路","JA","4","180",
"STATION","闵行开发区","JB","4","180",

"SUBWAY","6号线","上海","4","180",
"STATION","港城路","K1","4","180",
"STATION","外高桥保税区北","K2","4","180",
"STATION","航津路","K3","4","180",
"STATION","外高桥保税区南","K4","4","180",
"STATION","洲海路","K5","4","180",
"STATION","五洲大道","K6","4","180",
"STATION","东靖路","K7","4","180",
"STATION","巨峰路","K8","4","180",
"STATION","五莲路","K9","4","180",
"STATION","博兴路","KA","4","180",
"STATION","金桥路","KB","4","180",
"STATION","云山路","KC","4","180",
"STATION","德平路","KD","4","180",
"STATION","北洋泾路","KE","4","180",
"STATION","民生路","KF","4","180",
"STATION","源深体育中心","KG","4","180",
"STATION","世纪大道","KH","4","180",
"STATION","浦电路","KI","4","180",
"STATION","蓝村路","KJ","4","180",
"STATION","上海儿童医学中心","KK","4","180",
"STATION","临沂新村","KL","4","180",
"STATION","高科西路","KM","4","180",
"STATION","东明路","KN","4","180",
"STATION","高青路","KO","4","180",
"STATION","华夏西路","KP","4","180",
"STATION","上南路","KR","4","180",
"STATION","灵岩南路","KS","4","180",
"STATION","济阳路（未启用）","KT","4","180",

"SUBWAY","7号线","上海","4","180",
"STATION","花木路","L1","4","180",
"STATION","龙阳路","L2","4","180",
"STATION","芳华路","L3","4","180",
"STATION","锦绣路","L4","4","180",
"STATION","杨高南路","L5","4","180",
"STATION","高科西路","L6","4","180",
"STATION","云台路","L7","4","180",
"STATION","耀华路","L8","4","180",
"STATION","长清路","L9","4","180",
"STATION","后滩","LA","4","180",
"STATION","船厂路","LB","4","180",
"STATION","东安路","LC","4","180",
"STATION","肇嘉浜路","LD","4","180",
"STATION","常熟路","LE","4","180",
"STATION","静安寺","LF","4","180",
"STATION","昌平路","LG","4","180",
"STATION","长寿路","LH","4","180",
"STATION","镇坪路","LI","4","180",
"STATION","岚皋路","LJ","4","180",
"STATION","新村路","LK","4","180",
"STATION","大华三路","LL","4","180",
"STATION","行知路","LM","4","180",
"STATION","大场镇","LN","4","180",
"STATION","场中路","LO","4","180",
"STATION","上大路","LP","4","180",
"STATION","南陈路","LR","4","180",
"STATION","上海大学","LS","4","180",

"SUBWAY","8号线","上海","4","180",
"STATION","航天博物馆","M1","4","180",
"STATION","联航路","M2","4","180",
"STATION","江月路","M3","4","180",
"STATION","浦江镇","M4","4","180",
"STATION","芦恒路","M5","4","180",
"STATION","凌兆新村","M6","4","180",
"STATION","济阳路（未启用）","M7","4","180",
"STATION","杨思","M8","4","180",
"STATION","成山路","M9","4","180",
"STATION","耀华路","MA","4","180",
"STATION","周家渡（未启用）","MB","4","180",
"STATION","西藏南路","MC","4","180",
"STATION","陆家浜路","MD","4","180",
"STATION","老西门","ME","4","180",
"STATION","大世界","MF","4","180",
"STATION","人民广场","MG","4","180",
"STATION","曲阜路","MH","4","180",
"STATION","中兴路","MI","4","180",
"STATION","西藏北路","MJ","4","180",
"STATION","虹口足球场","MK","4","180",
"STATION","曲阳路","ML","4","180",
"STATION","四平路","MM","4","180",
"STATION","鞍山新村","MN","4","180",
"STATION","江浦路","MO","4","180",
"STATION","黄兴路","MP","4","180",
"STATION","延吉中路","MR","4","180",
"STATION","黄兴公园","MS","4","180",
"STATION","翔殷路","MT","4","180",
"STATION","嫩江路","MU","4","180",
"STATION","市光路","MV","4","180",

"SUBWAY","9号线","上海","4","180",
"STATION","杨高中路","O1","4","180",
"STATION","世纪大道","O2","4","180",
"STATION","商城路","O3","4","180",
"STATION","小南门","O4","4","180",
"STATION","陆家浜","O5","4","180",
"STATION","马当路","O6","4","180",
"STATION","打浦桥","O7","4","180",
"STATION","嘉善路","O8","4","180",
"STATION","肇嘉浜路","O9","4","180",
"STATION","徐家汇","OA","4","180",
"STATION","宜山路","OB","4","180",
"STATION","桂林路","OC","4","180",
"STATION","漕河泾开发区","OD","4","180",
"STATION","合川路","OE","4","180",
"STATION","星中路","OF","4","180",
"STATION","七宝","OG","4","180",
"STATION","中春路","OH","4","180",
"STATION","九亭","OI","4","180",
"STATION","泗泾","OJ","4","180",
"STATION","佘山","OK","4","180",
"STATION","洞泾","OL","4","180",
"STATION","松江大学城","OM","4","180",
"STATION","松江新城","ON","4","180",

"SUBWAY","11号线","上海","4","180",
"STATION","江苏路","P1","4","180",
"STATION","隆德路","P2","4","180",
"STATION","曹杨路","P3","4","180",
"STATION","枫桥路","P4","4","180",
"STATION","真如","P5","4","180",
"STATION","上海西站","P6","4","180",
"STATION","李子园","P7","4","180",
"STATION","祁连山路","P8","4","180",
"STATION","武威路","P9","4","180",
"STATION","桃浦新村","PA","4","180",
"STATION","南翔","PB","4","180",
"STATION","马陆","PC","4","180",
"STATION","嘉定新城","PD","4","180",
"STATION","白银路","PE","4","180",
"STATION","嘉定西","PF","4","180",
"STATION","嘉定北","PG","4","180",
"STATION","上海赛车场","PH","4","180",
"STATION","昌吉东路(未启用)","PI","4","180",
"STATION","上海汽车城","PJ","4","180",
"STATION","安亭","PK","4","180",

"CITY","北京","B7","4","180",
"SUBWAY","1号线","北京","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","苹果园","1J","4","180",
"STATION","古城路","2K","6","180",
"STATION","八角游乐园","3K","2","180",
"STATION","八宝山","4K","6","180",
"STATION","玉泉路","5K","2","180",
"STATION","五棵松","6K","6","180",
"STATION","万寿路","7K","2","180",
"STATION","公主坟","8K","6","180",
"STATION","军事博物馆","9K","2","180",
"STATION","木樨地","BK","6","180",
"STATION","南礼士路","CK","2","180",
"STATION","复兴门","DK","3","180",
"STATION","西单","EK","3","180",
"STATION","天安门西","GK","2","180",
"STATION","天安门东","HK","6","180",
"STATION","王府井","IK","2","180",
"STATION","东单","JK","3","180",
"STATION","建国门","LK","3","180",
"STATION","永安里","MK","2","180",
"STATION","国贸","NK","3","180",
"STATION","大望路","OK","2","180",
"STATION","四惠","PK","6","180",
"STATION","四惠东","QK","2","180",

"SUBWAY","2号线","北京","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","西直门","DF","7","180",
"STATION","车公庄","DG","8","180",
"STATION","阜成门","DH","8","180",
"STATION","复兴门","DK","3","180",
"STATION","长椿街","DL","7","180",
"STATION","宣武门","EL","3","180",
"STATION","和平门","FL","6","180",
"STATION","前门","GL","2","180",
"STATION","崇文门","JL","3","180",
"STATION","北京站","KL","4","180",
"STATION","建国门","LK","3","180",
"STATION","朝阳门","LI","4","180",
"STATION","建国门","LH","4","180",
"STATION","东四十条","LG","4","180",
"STATION","东直门","LF","4","180",
"STATION","雍和宫","JE","4","180",
"STATION","安定门","IE","2","180",
"STATION","鼓楼大街","FE","6","180",
"STATION","积水潭","EE","2","180",
"STATION","西直门","DF","7","180",

"SUBWAY","八通线","北京","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","四惠","PK","6","180",
"STATION","四惠东","QK","2","180",
"STATION","高碑店","RK","6","180",
"STATION","传媒大学","SK","2","180",
"STATION","双桥","TK","6","180",
"STATION","管庄","UK","2","180",
"STATION","八里桥","VK","6","180",
"STATION","北苑","WL","4","180",
"STATION","果园","XM","4","180",
"STATION","九棵树","YN","4","180",
"STATION","梨园","ZO","4","180",
"STATION","临河里","aP","4","180",
"STATION","土桥","bQ","4","180",

"SUBWAY","4号线","北京","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","公益西桥","ER","4","180",
"STATION","角门西","EQ","4","180",
"STATION","马家堡","EP","4","180",
"STATION","北京南站","EO","4","180",
"STATION","陶然亭","EN","4","180",
"STATION","菜市口","EM","4","180",
"STATION","宣武门","EL","3","180",
"STATION","西单","EK","3","180",
"STATION","灵境胡同","EI","4","180",
"STATION","西四","EH","4","180",
"STATION","平安里","EG","4","180",
"STATION","新街口","EF","4","180",
"STATION","西直门","DF","7","180",
"STATION","动物园","BF","6","180",
"STATION","国家图书馆","AF","3","180",
"STATION","魏公村","AE","4","180",
"STATION","人民大学","AB","4","180",
"STATION","海淀黄庄","AA","3","180",
"STATION","中关村","A9","4","180",
"STATION","北京大学东门","A8","4","180",
"STATION","圆明园","97","4","180",
"STATION","西苑","86","4","180",
"STATION","北宫门","76","2","180",

"SUBWAY","5号线","北京","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","天通苑北","J1","4","180",
"STATION","天通苑","J2","4","180",
"STATION","天通苑南","J3","4","180",
"STATION","立水桥","J4","3","180",
"STATION","立水桥南","J5","4","180",
"STATION","北苑路北","J6","4","180",
"STATION","大屯路东","J7","4","180",
"STATION","惠新西街北口","J8","4","180",
"STATION","惠新西街南口","JA","3","180",
"STATION","和平西桥","JB","4","180",
"STATION","和平里北街","JC","4","180",
"STATION","雍和宫","JE","3","180",
"STATION","北新桥","JF","4","180",
"STATION","张自忠路","JG","4","180",
"STATION","东四","JH","4","180",
"STATION","灯市口","JI","4","180",
"STATION","东单","JK","3","180",
"STATION","崇文门","JL","3","180",
"STATION","磁器口","JN","4","180",
"STATION","天坛东门","JO","4","180",
"STATION","蒲黄榆","JP","4","180",
"STATION","刘家窑","JQ","4","180",
"STATION","宋家庄","JR","4","180",

"SUBWAY","10号线","北京","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","巴沟","6A","2","180",
"STATION","苏州街","8A","6","180",
"STATION","海淀黄庄","AA","3","180",
"STATION","知春里","BA","6","180",
"STATION","知春路","CA","3","180",
"STATION","西土城","EA","6","180",
"STATION","牡丹园","FA","2","180",
"STATION","健德门","GA","6","180",
"STATION","北土城","HA","3","180",
"STATION","安贞门","IA","6","180",
"STATION","惠新西街南口","JA","3","180",
"STATION","芍药居","LA","3","180",
"STATION","太阳宫","MA","4","180",
"STATION","三元桥","NB","4","180",
"STATION","亮马桥","NC","4","180",
"STATION","农业展览馆","ND","4","180",
"STATION","团结湖","NE","4","180",
"STATION","呼家楼","NG","4","180",
"STATION","金台夕照","NI","4","180",
"STATION","国贸","NK","3","180",
"STATION","双井","NL","4","180",
"STATION","劲松","NM","4","180",

"SUBWAY","13号线","北京","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","西直门","DF","7","180",
"STATION","大钟寺","CC","4","180",
"STATION","知春路","CA","3","180",
"STATION","五道口","C8","4","180",
"STATION","上地","C6","4","180",
"STATION","西二旗","C5","4","180",
"STATION","龙泽","D4","2","180",
"STATION","回龙观","E4","6","180",
"STATION","霍营","G4","2","180",
"STATION","立水桥","J4","3","180",
"STATION","北苑","L5","4","180",
"STATION","望京西","L7","4","180",
"STATION","芍药居","LA","3","180",
"STATION","光熙门","LB","4","180",
"STATION","柳芳","LD","4","180",
"STATION","东直门","LF","4","180",

"SUBWAY","奥运线","北京","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","森林公园南门","H7","8","180",
"STATION","奥林匹克公园","H8","8","180",
"STATION","奥体中心","H9","8","880",
"STATION","北土城","HA","3","180",

"SUBWAY","机场快线","北京","4","180",
"TIME_FORWORD","25200","600","4","0",
"TIME_BACKWORD","27000","600","4","0",
"STATION","T2航站楼","T4","8","180",
"STATION","T3航站楼","U4","2","180",
"STATION","三元桥","NB","5","180",
"STATION","东直门","LF","4","180",

"CITY","广州","9G","4","180",
"SUBWAY","1号线","广州","4","180",
"STATION","广州东站","A1","4","180",
"STATION","体育中心","A2","4","180",
"STATION","体育西路","A3","4","180",
"STATION","杨箕","A4","4","180",
"STATION","东山口","A5","4","180",
"STATION","烈士陵园","A6","4","180",
"STATION","农讲所","A7","4","180",
"STATION","公园前","A8","4","180",
"STATION","西门口","A9","4","180",
"STATION","陈家祠","AA","4","180",
"STATION","长寿路","AB","4","180",
"STATION","黄沙","AC","4","180",
"STATION","芳村","AD","4","180",
"STATION","花地湾","AE","4","180",
"STATION","坑口","AF","4","180",

"SUBWAY","2号线","广州","4","180",
"STATION","广州南站","D1","4","180",
"STATION","石壁站","A1","4","180",
"STATION","会江站","A1","4","180",
"STATION","南浦站","A1","4","180",
"STATION","洛溪站","A1","4","180",
"STATION","南洲站","A1","4","180",
"STATION","东晓南站","A1","4","180",
"STATION","江泰路站","A1","4","180",
"STATION","昌岗站","A1","4","180",
"STATION","江南西站","A1","4","180",
"STATION","市二宫站","A1","4","180",
"STATION","海珠广场站","A1","4","180",
"STATION","公园前站","A1","4","180",
"STATION","纪念堂站","A1","4","180",
"STATION","越秀公园站","A1","4","180",
"STATION","广州火车站站","A1","4","180",
"STATION","三元里站","A1","4","180",
"STATION","飞翔公园站","A1","4","180",
"STATION","白云公园站","A1","4","180",
"STATION","白云文化广场站","A1","4","180",
"STATION","萧岗站","A1","4","180",
"STATION","江夏站","A1","4","180",
"STATION","黄边站","A1","4","180",
"STATION","嘉禾望岗","A1","4","180",

"SUBWAY","3号线","广州","4","180",
"STATION","天河客运站","E1","4","180",
"STATION","五山","E1","4","180",
"STATION","华师","E1","4","180",
"STATION","岗顶","E1","4","180",
"STATION","石牌桥","A1","4","180",
"STATION","体育西路","A1","4","180",
"STATION","珠江新城","A1","4","180",
"STATION","赤岗塔","A1","4","180",
"STATION","客村","A1","4","180",
"STATION","大塘","A1","4","180",
"STATION","沥滘","A1","4","180",
"STATION","厦滘","A1","4","180",
"STATION","大石","A1","4","180",
"STATION","汉溪长隆","A1","4","180",
"STATION","市桥","A1","4","180",
"STATION","番禺广场","A1","4","180",

"SUBWAY","4号线","广州","4","180",
"STATION","车陂南","A1","4","180",
"STATION","万胜围","A1","4","180",
"STATION","官洲","A1","4","180",
"STATION","大学城北","A1","4","180",
"STATION","大学城南","A1","4","180",
"STATION","新造","A1","4","180",
"STATION","石碁","A1","4","180",
"STATION","海傍","A1","4","180",
"STATION","低涌","A1","4","180",
"STATION","东涌","A1","4","180",
"STATION","黄阁汽车城","A1","4","180",
"STATION","黄阁","A1","4","180",
"STATION","蕉门","A1","4","180",
"STATION","金洲","A1","4","180",

"SUBWAY","5号线","广州","4","180",
"STATION","滘口","A1","4","180",
"STATION","坦尾","B1","4","180",
"STATION","中山八","C2","4","180",
"STATION","西场","D1","4","180",
"STATION","西村","A1","4","180",
"STATION","广州火车站","A1","4","180",
"STATION","小北","A1","4","180",
"STATION","淘金","A1","4","180",
"STATION","区庄","A1","4","180",
"STATION","动物园","A1","4","180",
"STATION","杨箕","A1","4","180",
"STATION","五羊邨","A1","4","180",
"STATION","珠江新城","A1","4","180",
"STATION","猎德","A1","4","180",
"STATION","潭村","A1","4","180",
"STATION","员村","A1","4","180",
"STATION","科韵路","A1","4","180",
"STATION","车陂南","A1","4","180",
"STATION","东圃","A1","4","180",
"STATION","三溪","A1","4","180",
"STATION","鱼珠","A1","4","180",
"STATION","大沙地","A1","4","180",
"STATION","大沙东","A1","4","180",
"STATION","文冲","A1","4","180",


"CITY","南京","CB","4","180",
"SUBWAY","1号线","南京","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","迈皋桥站","C3","4","120",                 
"STATION","高力家具港","C4","4","180",               
"STATION","红山动物园站","C5","4","180",             
"STATION","南京站站","A6","5","120",                 
"STATION","新模范马路站","87","5","120",             
"STATION","玄武门站","88","4","180",                 
"STATION","鼓楼站","89","4","60",                    
"STATION","珠江路站","8A","4","120",                 
"STATION","新街口站","8B","3","120",                 
"STATION","张府园站","8C","4","120",                 
"STATION","三山街站","8D","4","120",                 
"STATION","中华门站","7E","5","180",                 
"STATION","安德门站","7F","4","180",                 
"STATION","小行","7G","6","120",                     
"STATION","中胜路站","6G","2","120",                 
"STATION","元通站","4G","3","120",                   
"STATION","奥体中心站","3F","8","120",               



"SUBWAY","1号延长线","南京","4","180",
"TIME_FORWORD","25200","320","4","0",
"TIME_BACKWORD","27000","320","4","0",
"STATION","安德门站","7F","4","180",
"STATION","天隆寺站","8G","4","180",
"STATION","软件大道站","9H","4","180",
"STATION","花神庙站","AI","4","180",
"STATION","高铁南京南站","AJ","8","180",
"STATION","双龙大道站","BK","3","180",
"STATION","胜太路站","CL","6","180",
"STATION","百家湖站","DL","2","180",
"STATION","小龙湾站","EL","6","180",
"STATION","竹山路站","FL","2","180",
"STATION","天印大道站","GL","6","180",
"STATION","龙眠大道站","HL","4","180",
"STATION","南医大学院站","HM","4","180",
"STATION","南京交院站","HN","4","180",
"STATION","中国药科大学站","HO","4","180",

"SUBWAY","2号线","南京","4","180",
"TIME_FORWORD","25200","360","4","0",
"TIME_BACKWORD","27000","360","4","0",
"STATION","油坊桥站","3I","4","180",
"STATION","雨润大街站","4H","4","180",
"STATION","元通站","4G","3","180",
"STATION","奥体东站","4E","4","180",
"STATION","兴隆大街站","4D","4","180",
"STATION","集庆门大街站","4C","4","180",
"STATION","云锦路站","4B","2","180",
"STATION","莫愁湖站","5B","6","180",
"STATION","汉中门站","6B","2","180",
"STATION","上海路站","7B","6","180",
"STATION","新街口站","8B","3","180",
"STATION","大行宫站","9B","6","180",
"STATION","西安门站","AB","2","180",
"STATION","明故宫站","BB","6","180",
"STATION","苜蓿园站","CB","2","180",
"STATION","下马坊站","DB","6","180",
"STATION","孝陵卫站","EB","2","180",
"STATION","钟灵街站","FB","5","180",
"STATION","马群站","GA","5","180",
"STATION","金马路站","I9","5","180",
"STATION","仙鹤门站","J8","5","180",
"STATION","学则路站","K8","5","180",
"STATION","仙林中心站","L7","5","180",
"STATION","羊山公园站","N6","4","180",
"STATION","南大仙林校区站","M5","4","180",
"STATION","经天路站","N4","8","180",

"GT","宁合高铁","BB","4","180",
"SUBWAY","沪宁高铁","南京","4","180",
"STATION","合肥西","52","6","180",
"STATION","南京东","72","2","180",
"STATION","南京东","92","2","180",
"STATION","南京东","D2","2","180",

"GT","沪宁高铁","CB","4","180",
"SUBWAY","沪宁高铁","上海","4","180",
"STATION","南京","43","2","180",
"STATION","仙林","53","6","180",
"STATION","宝华山","63","2","180",
"STATION","镇江","72","3","180",
"STATION","丹徒","83","3","180",
"STATION","丹阳","94","3","180",
"STATION","常州","B5","3","180",
"STATION","戚墅堰","E6","3","180",
"STATION","惠山","G7","6","180",
"STATION","无锡","H7","2","180",
"STATION","无锡新区","I7","3","180",
"STATION","苏州新区","K8","7","180",
"STATION","苏州","L8","3","180",
"STATION","苏州园区","M9","4","180",
"STATION","阳澄湖","NA","4","180",
"STATION","昆山南","NB","4","180",
"STATION","花桥","OC","4","180",
"STATION","安亭北","PD","4","180",
"STATION","南翔北","PE","4","180",
"STATION","上海西","PF","4","180",
"STATION","上海","QG","4","180",
"STATION","共康路","QH","4","180",

"CITY","乌鲁木齐","03","4","180",
"SUBWAY","1号线","乌鲁木齐","4","180",
"STATION","乌鲁木齐","00","4","180",

"CITY","兰州","39","4","180",
"SUBWAY","1号线","兰州","4","180",
"STATION","兰州","00","4","180",

"CITY","成都","4C","4","180",
"SUBWAY","1号线","成都","4","180",
"STATION","成都","00","4","180",

"CITY","昆明","3F","4","180",
"SUBWAY","1号线","","4","180",
"STATION","--","00","4","180",

"CITY","贵阳","5E","4","180",
"SUBWAY","1号线","","4","180",
"STATION","--","00","4","180",

"CITY","南宁","6H","4","180",
"SUBWAY","1号线","","4","180",
"STATION","--","00","4","180",

"CITY","西安","7A","4","180",
"SUBWAY","1号线","","4","180",
"STATION","--","00","4","180",

"CITY","海口","7I","4","180",
"SUBWAY","1号线","","4","180",
"STATION","--","00","4","180",

"CITY","呼和浩特","86","4","180",
"SUBWAY","1号线","","4","180",
"STATION","--","00","4","180",

"CITY","郑州","9A","4","180",
"SUBWAY","1号线","","4","180",
"STATION","--","00","4","180",

"CITY","武汉","9C","4","180",
"SUBWAY","1号线","","4","180",
"STATION","--","00","4","180",

"CITY","长沙","9E","4","180",
"SUBWAY","1号线","","4","180",
"STATION","--","00","4","180",

"CITY","石家庄","A8","4","180",
"SUBWAY","1号线","","4","180",
"STATION","--","00","4","180",

"CITY","合肥","BB","4","180",
"SUBWAY","1号线","","4","180",
"STATION","--","00","4","180",

"CITY","天津","C7","4","180",
"SUBWAY","1号线","","4","180",
"STATION","--","00","4","180",

"CITY","济南","C9","4","180",
"SUBWAY","1号线","","4","180",
"STATION","--","00","4","180",

"CITY","长春","F4","4","180",
"SUBWAY","1号线","","4","180",
"STATION","--","00","4","180",

"CITY","沈阳","E5","4","180",
"SUBWAY","1号线","","4","180",
"STATION","--","00","4","180",

"CITY","哈尔滨","G3","4","180",
"SUBWAY","1号线","","4","180",
"STATION","--","00","4","180",

"CITY","香港","AH","4","180",
"SUBWAY","1号线","","4","180",
"STATION","--","00","4","180",
"END","Gameover","","4","0"
};

//网格
static int m_x=0,m_y = 0;            // 画板的偏移量
static int m_ox=0,m_oy = 0;            // 画板的偏移量

static double m_ozoom = 0;  // 画板的放大倍数偏移量
static double m_zoom  = 0.25;           //放大倍数
static Graphics g = null;
static Font m_font =null;
static Font m_font_s =null;
static Font m_font_b =null;
static Ccity m_act_city = null;
static Cstation m_act_station = null;
static class CCell 
{
   String m_position="AAAA";//位置信息;
    int   m_textpos=0;;//位置信息;

         // 1,2,3,4,5        zoom 城市
        // 5,7,8.9.10       zoom 地铁线
        // 11,12,13.14.15   zoom 地铁     

   int m_index=0; //序号
   int m_rote=0;
   int m_color=Color.RED;     
   int m_x1=0;
   int m_x2=0;
   int m_y1=0;
   int m_y2=0;
   double m_magic=1;//本对象的放大系数
   
 protected void debug(Graphics graphics,String str,int x, int  y)
 {
     if (1==2)
      graphics.drawText(str,x,y);
 };   
 
 protected double zoomsize()
 {
     return m_zoom * m_magic;
 }
  protected int get_x()
 {
    if (m_x2==0)
    return (int)( (m_x1*60 + ctod('A')*m_magic)  * m_zoom);
    return (int)(( m_x1*60 + m_x2*m_magic) * m_zoom);
 };   
   protected int get_y()
 {
    if (m_y2==0)
    return (int)((m_y1*60 + ctod('A')*m_magic)  * m_zoom);
    return (int)(( m_y1*60 + m_y2*m_magic) * m_zoom);
 }; 

 protected void setPosition(String pos)
 {
     m_position= pos;
     m_x1 = ctod(m_position.charAt(0));
     m_x2 = ctod(m_position.charAt(1));
     m_y1 = ctod(m_position.charAt(2));
     m_y2 = ctod(m_position.charAt(3));     
 }
 
 protected int ctod(char c)
 {
        if (c < 'A')  return c - '0';        
        if (c >='A')  return c - 'A'+10;
        if (c >='a')  return c - 'a'+10+26;
        return 0;
 }   

 public boolean visiable()
 {
       if (( m_y+ get_y() > - 2*m_zoom )&& (m_y+get_y() < 240+2*m_zoom)
           && (m_x+get_x() < 360+2*m_zoom)&& (m_x+get_x() > -2*m_zoom))
        return true; 
      else
        return false;
 }
    
}

//地铁站
static class Cstation extends CCell
{
    String m_stationname="station";
    int m_runtime = 0;
    int m_ftime =0;
    int m_btime =0;
    int m_downtime =0;
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
        int l_cir = Math.min(3,(int)(3*m_zoom));
        debug(graphics,"S",10,110);
        l_x = get_x();
        l_y = get_y();   
        if (zoomsize() >30) l_cir = 4;
        if (zoomsize() >50) l_cir = 5;
        if (zoomsize() >60) l_cir = 6;
        
       if (zoomsize() > 10)         
        graphics.fillArc(m_x+l_x-l_cir,m_y+l_y-l_cir, 2*l_cir+1,2*l_cir+1,0,360);  
        if (zoomsize() >20)   
        { if (m_textpos==1)
           graphics.drawText(m_stationname,m_x + l_x - m_font.getAdvance(m_stationname) - l_cir  ,
                                                 m_y +l_y - 38);
          if (m_textpos==2)
           graphics.drawText(m_stationname,m_x + l_x  - m_font.getAdvance(m_stationname)/2,
                                                 m_y +l_y - 38);       
          if (m_textpos==3)                                      
           graphics.drawText(m_stationname,m_x + l_x + l_cir +2  , m_y +l_y - 30);
          if (m_textpos==4)
           graphics.drawText(m_stationname,m_x + l_x + l_cir +5, m_y +l_y -6);         
          if (m_textpos==5)
           graphics.drawText(m_stationname,m_x + l_x + l_cir +2 , m_y +l_y +10);  
          if (m_textpos==6)
           graphics.drawText(m_stationname,m_x + l_x  - m_font.getAdvance(m_stationname)/2,m_y +l_y+20 );  
           if (m_textpos==7)
           graphics.drawText(m_stationname,m_x + l_x  - m_font.getAdvance(m_stationname) - l_cir  ,
                                                m_y +l_y +20); 
          if (m_textpos==8)
           graphics.drawText(m_stationname,m_x + l_x  - m_font.getAdvance(m_stationname)- l_cir -5 ,
                                                 m_y +l_y -6 );  
        }
    } 
    
    public void drawlist(Graphics graphics )
    {  
        int l_y = 20*m_index;    
        if(( l_y < m_y+240) && ( l_y +m_y >0) )
        graphics.drawText(m_stationname,m_x + 10, m_y + l_y + 10);                 
    } 
    

}

//线路
static class Cline extends CCell
{
    String m_linename = "line";
    Vector m_stations = new Vector();
    int m_begintime_f =0;
    int m_begintime_b =0;
    int m_totaltime =0;
    int m_gaptime =240;
    
    long l_time = 0; 
    public void draw(Graphics graphics,int type)
    {
        int l_p=0;
        debug(graphics,"L",10,90);
        graphics.setColor(m_color);
        Date l_d = new Date();
        int l_cycle = 0;
         Cstation   l_sta = null;
        if (zoomsize()  < 1) return ;
          l_sta = ((Cstation) m_stations.elementAt(0));
       
        if ( (zoomsize()  > 8) && (zoomsize()  <20) )
              graphics.drawText(m_linename,l_sta.get_x()+m_x+5 ,l_sta.get_y()+m_y+5);                                      
        
        for (int i = 0 ; i < m_stations.size(); i++)
        { 
           l_sta = ((Cstation) m_stations.elementAt(i));
               
          if (l_sta .visiable())
          {   
           if ( l_p ==l_sta.get_y())
           {
            l_sta.draw(graphics,type,2);
             l_p = 0;
            }
           else
           {             
             l_sta.draw(graphics,type,1);
             l_p = l_sta.get_y();
           }
           
            if ((i> 0)) //显示线路
            {           
             graphics.drawLine(((Cstation) m_stations.elementAt(i-1)).get_x()+m_x,
            ((Cstation) m_stations.elementAt(i-1)).get_y() +m_y,
              l_sta.get_x()+m_x,
              l_sta.get_y() +m_y);
           }                                      
         }
        }
        
        if (m_begintime_f !=0  && zoomsize()  > 40)
        {
            l_time = l_d.getTime()/1000 % 86400 +8*3600;
            l_cycle = (int)(l_time - m_begintime_f) % m_gaptime;           
            for (int i = 0 ; i < m_stations.size(); i++)
            {                   
             l_sta = ((Cstation) m_stations.elementAt(i));
            if (l_cycle >= l_sta.m_runtime) //时长跨越当前车站
                 { l_sta.m_ftime = l_cycle; l_cycle -= l_sta.m_runtime ; }
            else { l_sta.m_ftime = l_cycle; l_cycle = l_cycle + m_gaptime - l_sta.m_runtime;}
              if (i < m_stations.size()-1)              
              if (l_sta .visiable())
              if (l_sta.m_ftime < l_sta.m_runtime)
              {                
                  int l_x =((Cstation) m_stations.elementAt(i+1)).get_x()+m_x;
                  int l_y = ((Cstation) m_stations.elementAt(i+1)).get_y()+m_y;
                  l_x =l_sta.get_x()+m_x + (l_x- l_sta.get_x()-m_x) *l_sta.m_ftime/ l_sta.m_runtime;
                   l_y =l_sta.get_y()+m_y + (l_y- l_sta.get_y()-m_y) *l_sta.m_ftime/ l_sta.m_runtime;  
                   graphics.setColor(Color.BLUE);
                   String l_tag =String.valueOf(l_sta.m_runtime - l_sta.m_ftime);
                   int l_w = m_font.getAdvance(l_tag);
                   graphics.fillRect( l_x- 3, l_y-3,7,7);                                      
                   //graphics.setColor(m_color);
                   //graphics.drawRect( l_x-4, l_y-4,9,9);
                    if (zoomsize()  > 30)
                    {
                       graphics.setColor(Color.YELLOW);
                       graphics.drawText(l_tag, l_x - l_w/2, l_y+ 8);
                    }
                   graphics.setColor(m_color);
              } 
          }          
          
         }
         if (m_begintime_b !=0 && zoomsize()  > 40)
        {
            l_time = l_d.getTime()/1000 % 86400 +8*3600;
            l_cycle = (int)(l_time - m_begintime_b) % m_gaptime;           
            for (int i =  m_stations.size()-1 ; i >0 ; i--)
            {               
             l_sta = ((Cstation) m_stations.elementAt(i));    
            if (l_cycle >= l_sta.m_runtime) //时长跨越当前车站
                 { l_sta.m_btime = l_cycle; l_cycle -= l_sta.m_runtime ; }
            else { l_sta.m_btime = l_cycle; l_cycle = l_cycle + m_gaptime - l_sta.m_runtime;}
                   
            if (i > 1)              
           if (l_sta .visiable())
           if ( l_sta.m_btime < l_sta.m_runtime)
              {
                  int l_x =((Cstation) m_stations.elementAt(i-1)).get_x()+m_x;
                  int l_y = ((Cstation) m_stations.elementAt(i-1)).get_y()+m_y;
                  l_x =l_sta.get_x()+m_x + (l_x- l_sta.get_x()-m_x) *l_sta.m_btime/ l_sta.m_runtime;
                   l_y =l_sta.get_y()+m_y + (l_y- l_sta.get_y()-m_y) *l_sta.m_btime/ l_sta.m_runtime;  
                   graphics.setColor(Color.GREEN);
                   String l_tag =String.valueOf(l_sta.m_runtime - l_sta.m_btime);
                   int l_w = m_font.getAdvance(l_tag);
                   graphics.fillRect( l_x- 3, l_y-3,7,7);                                         
                   //graphics.setColor(m_color);
                   //graphics.drawRect( l_x-4, l_y-4,9,9);
                   if (zoomsize()  > 30)
                   { graphics.setColor(Color.RED);
                    graphics.drawText(l_tag, l_x - l_w/2, l_y-20);
                   }graphics.setColor(m_color);                  
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
        if ( !m_GT )//显示城市名称
        {                       
            int l_x = get_x();
            int l_y = get_y();
            int l_cir = Math.min(3,3);
            debug(graphics,"C",10,50);   
             if (zoomsize()  < 8) 
             {
                graphics.setColor(Color.YELLOW);
                graphics.fillArc(m_x+l_x, m_y+l_y, l_cir*2+1,l_cir*2+1,0,360);                 
            }
            if (zoomsize()  > 0.1 && zoomsize()  < 8)
            {   
                graphics.setColor(Color.LIGHTCYAN);                                                 
                graphics.drawText(m_cityname,m_x + l_x + 10,m_y + l_y - 15);    
            }
       }

       debug(graphics,"draw city",10,50);
       for (int i = 0 ; i < m_lines.size(); i++)
           ((Cline)(m_lines.elementAt(i))).draw(graphics,type);        
    }  
}

//
static class Cmetro extends CCell
{
  String m_metro = "metro";
  Vector m_citys  = new Vector();
  String m_city ="";

  Ccity l_city=null;
  Cline l_line=null;
  Cstation l_station=null; 
   
  char l_map[]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'} ;

 static final int ITEM_CNT=5; 
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
    int cl=0,u=0;
    String a="",b="",c="",d="",tmp="";
    m_font_s = Font.getDefault().derive(Font.PLAIN,6,Ui.UNITS_pt);
    m_font_b = Font.getDefault().derive(Font.PLAIN,9,Ui.UNITS_pt);
    m_font = m_font_s;
    for (int i = 0 ;i < 10000; i ++)
    {
             if (subways[i*ITEM_CNT]=="END") 
                break;                           
             if (subways[i*ITEM_CNT]=="CITY" )
             {
                  cl=0;u=0;                  
                 l_city = new Ccity();       
                 m_act_city = l_city;                           
                 l_city.m_cityname =subways[i*ITEM_CNT+1];
                 if (m_city == "") 
                      m_city = l_city.m_cityname;
                 tmp = subways[i*ITEM_CNT+2];
                 a = tmp.substring(0,1);
                 b = tmp.substring(1,2);
                 l_city.setPosition(a +"0"+ b+"0");    
                 m_citys.addElement(l_city);
             }
             if (subways[i*ITEM_CNT]=="GT")
             {    
                 cl=0;u=0;                  
                 l_city = new Ccity();                               
                 l_city.m_cityname =subways[i*ITEM_CNT+1];
                 l_city.m_GT = true;                 
                 tmp = subways[i*ITEM_CNT+2];
                 a = tmp.substring(0,1);
                 b = tmp.substring(1,2);                 
                 l_city.setPosition(a +"0"+ b+"0");                   
                 m_citys.addElement(l_city);
             }
            else if (subways[i*ITEM_CNT]=="SUBWAY")  
             {  
                cl++;u++;               
                l_line = new Cline();    
                l_line.m_linename =subways[i*ITEM_CNT+1]; 
                l_line.m_color=colors[cl];              
                
                l_city.m_lines.addElement(l_line);
             }
            else if (subways[i*ITEM_CNT]=="TIME_FORWORD")
            {
                l_line.m_begintime_f =  Integer.parseInt(subways[i*ITEM_CNT+1]);
                l_line.m_gaptime =  Integer.parseInt(subways[i*ITEM_CNT+2]);
            }
            else if (subways[i*ITEM_CNT]=="TIME_BACKWORD")
            {
                l_line.m_begintime_b =  Integer.parseInt(subways[i*ITEM_CNT+1]);
                l_line.m_gaptime =  Integer.parseInt(subways[i*ITEM_CNT+2]);
            }
            else if (subways[i*ITEM_CNT]=="STATION")  
             {                 
                 u++;
                 l_station               = new Cstation(); 
                 l_station.m_index       = u;                                  
                 l_station.m_stationname = subways[i*ITEM_CNT+1];
                 tmp = subways[i*ITEM_CNT+2];
                 c = tmp.substring(0,1);
                 d = tmp.substring(1,2);
                 l_station.setPosition(a+ c + b +d);     
                 if (l_city.m_GT ) 
                    l_station.m_magic=4.5;                
                 l_station.m_color       = colors[cl];
                 l_station.m_textpos =  Integer.parseInt(subways[i*ITEM_CNT+3]);
                 l_station.m_runtime =  Integer.parseInt(subways[i*ITEM_CNT+4]);    
                 l_line.m_totaltime +=  l_station.m_runtime ;
                 l_line.m_stations.addElement(l_station);                 
              }              
     } 
  }
  
  public void draw(Graphics graphics,int type )
  {     

    graphics.setBackgroundColor(Color.BLACK);    
    graphics.clear(); 
    graphics.setColor(Color.LIGHTBLUE);
    String ls_zoom = String.valueOf(m_zoom);         
    m_font = m_font_s;
    graphics.setFont(m_font);  
    graphics.drawText("Z:"+ls_zoom,1,225);
    if (zoomsize()  > 100) 
        m_font = m_font_b;
    graphics.setFont(m_font);
    if (zoomsize()>20);
    {
        m_act_city.draw(graphics,type);
        //if (l_city.visiable()) return;
    }
    for (int i = 0; i <m_citys.size(); i++)
    {
       debug(graphics,"City"+String.valueOf(m_zoom),10,20);
       l_city = (Ccity)(m_citys.elementAt(i));
       if (l_city.m_GT)  
            l_city.draw(graphics,type);       
       else if (l_city.visiable())       
       {
            m_act_city = l_city;
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
 
}
       
   public void rote()
  {       
      
  }
  
   public void cal()
  {       
      
  }
  
  public void changeCity(String cityname)
  {
    m_city=cityname;
    for (int i = 0; i <m_citys.size(); i++)
    {
       l_city = (Ccity)(m_citys.elementAt(i));       
       if (l_city.m_cityname == m_city ) //显示总体
       { 
         m_act_city = l_city;
         m_x = 160  - l_city.get_x();
         m_y = 120  - l_city.get_y();         
        break;
        }
    }
     
  }
}

Ccity l_city=null;
Cline l_line=null;
Cstation l_station=null;  
       
Cmetro m_metro= new Cmetro();
String m_show ="showmap";
RichTextField m_background;
za_ColorSet m_ColorSet;
UiApplication m_app;
public za_SubWay(UiApplication app)
    { 
        m_metro.init(subways);    
        m_app = app;
        m_ColorSet = new za_ColorSet(app);
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
         menu.add(new MenuItem("关于" , 100, 10){
            public void run()
                { 
                    Dialog.alert("地铁时光 V1.0 \n 作者:朱兴宇 \n   2010.07");
                 }});               
         menu.addSeparator();    
         menu.add(new MenuItem("调色板" , 100, 10){
            public void run(){
               m_app.pushScreen(m_ColorSet);
            }}
        );  
        menu.addSeparator();    
        for (int i = 0; i <m_metro.m_citys.size(); i++)
        {
                menu.add(new MenuItem(((Ccity)(m_metro.m_citys.elementAt(i))).m_cityname ,200 +i, 20+i)
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
                                    
            invalidate();
            doPaint();          
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
        if (key == Characters.LATIN_SMALL_LETTER_C) 
            m_metro.cal();      

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
