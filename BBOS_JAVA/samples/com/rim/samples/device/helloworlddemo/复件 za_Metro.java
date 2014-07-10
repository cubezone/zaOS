
/*
 * za_Metro.java
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
public final  class za_Metro extends MainScreen
{     
static String subways[]={

"CITY","北京","401,121","400,280","0.0010",
"SUBWAY","1号线","北京","4","0",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","苹果园","23,350","4","180",
"STATION","古城路","43,364","6","180",
"STATION","八角游乐园","69,364","2","180",
"STATION","八宝山","93,364","6","180",
"STATION","玉泉路","118,364","2","180",
"STATION","五棵松","143,364","6","180",
"STATION","万寿路","165,364","2","180",
"STATION","公主坟","189,364","6","180",
"STATION","军事博物馆","217,364","2","180",
"STATION","木樨地","246,364","6","180",
"STATION","南礼士路","271,364","2","180",
"STATION","复兴门","297,364","3","180",
"STATION","西单","342,364","3","180",
"STATION","天安门西","372,364","2","180",
"STATION","天安门东","396,364","6","180",
"STATION","王府井","423,364","2","180",
"STATION","东单","453,364","3","180",
"STATION","建国门","500,364","3","180",
"STATION","永安里","530,364","6","180",
"STATION","国贸","554,364","5","180",
"STATION","大望路","585,364","6","180",
"STATION","四惠","612,364","9","180",
"STATION","四惠东","633,364","9","180",

"SUBWAY","2号线","北京","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","西直门","297,277","7","180",
"STATION","车公庄","297,304","8","180",
"STATION","阜成门","297,325","8","180",
"STATION","复兴门","297,364","3","180",
"STATION","长椿街","308,388","7","180",
"STATION","宣武门","342,393","3","180",
"STATION","和平门","378,393","6","180",
"STATION","前门","403,393","2","180",
"STATION","崇文门","453,393","3","180",
"STATION","北京站","487,387","4","180",
"STATION","建国门","500,364","9","180",
"STATION","朝阳门","500,327","4","180",
"STATION","东四十条","500,303","4","180",
"STATION","东直门","500,278","4","180",
"STATION","雍和宫","453,257","4","180",
"STATION","安定门","429,256","2","180",
"STATION","鼓楼大街","394,256","6","180",
"STATION","积水潭","327,256","2","180",
"STATION","西直门","297,277","7","180",

"SUBWAY","4号线","北京","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","公益西桥","342,499","4","180",
"STATION","角门西","342,484","4","180",
"STATION","马家堡","342,462","4","180",
"STATION","北京南站","342,446","4","180",
"STATION","陶然亭","342,432","4","180",
"STATION","菜市口","342,413","4","180",
"STATION","宣武门","342,393","3","180",
"STATION","西单","342,364","3","180",
"STATION","灵境胡同","342,343","4","180",
"STATION","西四","342,326","4","180",
"STATION","平安里","342,302","4","180",
"STATION","新街口","342,280","4","180",
"STATION","西直门","297,277","7","180",
"STATION","动物园","255,277","6","180",
"STATION","国家图书馆","219,277","3","180",
"STATION","魏公村","213,249","4","180",
"STATION","人民大学","213,220","4","180",
"STATION","海淀黄庄","213,190","3","180",
"STATION","中关村","213,164","4","180",
"STATION","北京大学东门","213,145","4","180",
"STATION","圆明园","213,125","4","180",
"STATION","西苑","190,118","4","180",
"STATION","北宫门","164,118","2","180",
"STATION","太平桥北","142,118","1","180",

"SUBWAY","5号线","北京","4","0.008",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","天通苑北","453,6","4","180",
"STATION","天通苑","453,25","4","180",
"STATION","天通苑南","453,45","4","180",
"STATION","立水桥","453,61","3","180",
"STATION","立水桥南","453,88","4","180",
"STATION","北苑路北","453,115","4","180",
"STATION","大屯路东","453,141","4","180",
"STATION","惠新西街北口","453,168","4","180",
"STATION","惠新西街南口","453,190","5","180",
"STATION","和平西桥","453,221","4","180",
"STATION","和平里北街","453,239","4","180",
"STATION","雍和宫","453,257","9","180",
"STATION","北新桥","453,282","4","180",
"STATION","张自忠路","453,303","4","180",
"STATION","东四","453,326","4","180",
"STATION","灯市口","453,345","4","180",
"STATION","东单","453,364","3","180",
"STATION","崇文门","453,393","3","180",
"STATION","磁器口","453,413","4","180",
"STATION","天坛东门","453,429","4","180",
"STATION","蒲黄榆","453,446","4","180",
"STATION","刘家窑","453,459","4","180",
"STATION","宋家庄","453,485","4","180",

"SUBWAY","八通线","北京","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","四惠","612,368","6","180",
"STATION","四惠东","633,368","2","180",
"STATION","高碑店","657,368","6","180",
"STATION","传媒大学","677,368","2","180",
"STATION","双桥","701,368","6","180",
"STATION","管庄","720,368","2","180",
"STATION","八里桥","742,368","6","180",
"STATION","北苑","755,380","4","180",
"STATION","果园","768,395","4","180",
"STATION","九棵树","782,407","4","180",
"STATION","梨园","794,421","4","180",
"STATION","临河里","809,432","4","180",
"STATION","土桥","823,444","4","180",

"SUBWAY","10号线","北京","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","巴沟","143,190","2","180",
"STATION","苏州街","177,190","6","180",
"STATION","海淀黄庄","213,190","3","180",
"STATION","知春里","245,190","6","180",
"STATION","知春路","273,190","3","180",
"STATION","西土城","315,190","6","180",
"STATION","牡丹园","343,190","2","180",
"STATION","健德门","370,190","6","180",
"STATION","北土城","397,190","3","180",
"STATION","安贞门","424,190","6","180",
"STATION","惠新西街南口","453,190","5","180",
"STATION","芍药居","510,190","3","180",
"STATION","太阳宫","536,194","4","180",
"STATION","三元桥","554,208","9","180",
"STATION","亮马桥","554,240","4","180",
"STATION","农业展览馆","554,275","4","180",
"STATION","团结湖","554,300","4","180",
"STATION","呼家楼","554,328","4","180",
"STATION","金台夕照","554,346","4","180",
"STATION","国贸","554,364","9","180",
"STATION","双井","554,392","4","180",
"STATION","劲松","554,418","4","180",

"SUBWAY","13号线","北京","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","西直门","297,277","7","180",
"STATION","大钟寺","281,231","4","180",
"STATION","知春路","273,190","3","180",
"STATION","五道口","270,161","4","180",
"STATION","上地","262,106","4","180",
"STATION","西二旗","261,87","4","180",
"STATION","龙泽","307,49","2","180",
"STATION","回龙观","344,45","6","180",
"STATION","霍营","380,49","2","180",
"STATION","立水桥","453,61","3","180",
"STATION","北苑","492,74","4","180",
"STATION","望京西","521,144","4","180",
"STATION","芍药居","510,190","3","180",
"STATION","光熙门","510,225","4","180",
"STATION","柳芳","509,248","4","180",
"STATION","东直门","500,278","4","180",

"SUBWAY","奥运线","北京","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","森林公园南门","397,129","8","180",
"STATION","奥林匹克公园","397,147","8","180",
"STATION","奥体中心","397,167","8","880",
"STATION","北土城","397,190","3","180",

"SUBWAY","机场快线","北京","4","180",
"TIME_FORWORD","25200","600","4","0",
"TIME_BACKWORD","27000","600","4","0",
"STATION","T2航站楼","705,97","8","180",
"STATION","T3航站楼","735,95","2","180",
"STATION","三元桥","554,208","5","180",
"STATION","东直门","500,278","4","180",

"CITY","上海","459,242","412,312","0.002",
"SUBWAY","1号线","上海","4","180",
"TIME_FORWORD","25200","320","4","0",
"TIME_BACKWORD","27000","320","4","0",
"STATION","莘庄","209,455","5","180",
"STATION","外环路","228,444","5","180",
"STATION","莲花路","245,432","5","180",
"STATION","锦江乐园","260,419","4","180",
"STATION","上海南站","281,404","1","180",
"STATION","漕宝路","299,387","1","180",
"STATION","上海体育馆","312,363","3","180",
"STATION","徐家汇","330,350","5","180",
"STATION","衡山路","342,342","1","180",
"STATION","常熟路","362,326","8","180",
"STATION","陕西南路","385,326","6","180",
"STATION","黄陂南路","410,326","5","180",
"STATION","人民广场","434,313","3","180",
"STATION","新闸路","416,296","8","180",
"STATION","汉中路","405,285","4","180",
"STATION","上海火车站","412,268","3","180",
"STATION","中山北路","427,255","4","180",
"STATION","延长路","436,243","4","180",
"STATION","上海马戏城","436,226","4","180",
"STATION","汶水路","436,207","4","180",
"STATION","彭浦新村","436,190","4","180",
"STATION","共康路","436,173","4","180",
"STATION","通河新村","436,154","4","180",
"STATION","呼兰路","436,135","4","180",
"STATION","共富新村","436,116","4","180",
"STATION","宝安公路","436,100","4","180",
"STATION","友谊西路","436,81","4","180",
"STATION","富锦路","436,63","4","180",

"SUBWAY","2号线","上海","4","0.0008",
"TIME_FORWORD","25200","320","4","0",
"TIME_BACKWORD","27000","320","4","0",
"STATION","浦东国际机场","801,443","4","180",
"STATION","海天三路","786,433","3","180",
"STATION","远东大道","760,426","2","180",
"STATION","凌空路","737,426","6","180",
"STATION","川沙","709,426","8","180",
"STATION","华夏东路","709,406","4","180",
"STATION","创新中路","694,393","3","180",
"STATION","唐镇","667,393","2","180",
"STATION","广兰路","642,393","6","180",
"STATION","金科路","616,393","2","180",
"STATION","张江高科","590,393","6","180",
"STATION","龙阳路","563,393","5","180",
"STATION","世纪公园","554,378","4","180",
"STATION","上海科技馆","554,363","4","180",
"STATION","世纪大道","524,335","3","180",
"STATION","东昌路","507,323","4","180",
"STATION","陆家嘴","489,313","4","180",
"STATION","南京东路","455,313","6","180",
"STATION","人民广场","434,313","9","180",
"STATION","南京西路","394,313","2","180",
"STATION","静安寺","362,313","3","180",
"STATION","江苏路","335,303","3","180",
"STATION","中山公园","292,297","3","180",
"STATION","娄山关路","266,297","6","180",
"STATION","威宁路","248,289","4","180",
"STATION","北新泾","232,276","4","180",
"STATION","淞虹路","210,271","2","180",
"STATION","虹桥2号航站楼","176,304","4","180",
"STATION","虹桥火车站","158,304","2","180",
"STATION","徐泾东","135,304","8","180",

"SUBWAY","3号线","上海","4","0.0008",
"TIME_FORWORD","25200","320","4","0",
"TIME_BACKWORD","27000","320","4","0",
"STATION","上海南站","284,404","9","180",
"STATION","石龙路","307,403","4","180",
"STATION","龙漕路","319,395","4","180",
"STATION","漕溪路","310,381","4","180",
"STATION","宜山路","295,358","1","180",
"STATION","虹桥路","290,332","1","180",
"STATION","延安西路","291,314","4","180",
"STATION","中山公园","292,297","9","180",
"STATION","金沙江路","304,270","1","180",
"STATION","曹杨路","336,261","1","180",
"STATION","镇坪路","362,261","1","180",
"STATION","中潭路","390,261","2","180",
"STATION","上海火车站","412,268","9","180",
"STATION","宝山路","445,277","4","180",
"STATION","东宝兴路","463,266","4","180",
"STATION","虹口足球场","481,255","9","180",
"STATION","赤峰路","501,239","4","180",
"STATION","大柏树","508,225","4","180",
"STATION","江湾镇","508,211","4","180",
"STATION","殷高西路","508,194","4","180",
"STATION","长江南路","508,179","4","180",
"STATION","淞发路","521,167","4","180",
"STATION","张华浜","538,156","4","180",
"STATION","淞滨路","541,139","4","180",
"STATION","水产路","541,124","4","180",
"STATION","宝杨路","541,106","4","180",
"STATION","友谊路","541,90","4","180",
"STATION","铁力路","541,75","4","180",
"STATION","江杨北路","519,65","4","180",

"SUBWAY","4号线","上海","4","0.0008",
"TIME_FORWORD","25200","320","4","0",
"TIME_BACKWORD","27000","320","4","0",
"STATION","宜山路","295,358","9","180",
"STATION","上海体育馆","312,363","9","180",
"STATION","上海体育场","335,370","6","180",
"STATION","东安路","362,370","1","180",
"STATION","大木桥路","382,370","6","180",
"STATION","鲁班路","406,370","6","180",
"STATION","西藏南路","435,370","3","180",
"STATION","南浦大桥","456,370","6","180",
"STATION","塘桥","488,370","2","180",
"STATION","蓝村路","515,370","5","180",
"STATION","浦电路","533,363","4","180",
"STATION","世纪大道","524,335","9","180",
"STATION","浦东大道","524,317","4","180",
"STATION","杨树浦路","524,298","4","180",
"STATION","大连路","513,288","4","180",
"STATION","临平路","503,281","4","180",
"STATION","海伦路","481,277","4","180",
"STATION","宝山路","445,277","9","180",
"STATION","上海火车站","412,268","9","180",
"STATION","中潭路","390,261","9","180",
"STATION","镇坪路","362,261","9","180",
"STATION","曹杨路","336,261","9","180",
"STATION","金沙江路","304,270","4","180",
"STATION","中山公园","292,297","9","180",
"STATION","延安西路","291,314","4","180",
"STATION","虹桥路","293,333","9","180",
"STATION","宜山路","295,358","9","180",

"SUBWAY","5号线","上海","4","0.0008",
"TIME_FORWORD","25200","320","4","0",
"TIME_BACKWORD","27000","320","4","0",
"STATION","莘庄","209,455","9","180",
"STATION","春申路","198,474","4","180",
"STATION","银都路","198,493","4","180",
"STATION","颛桥","198,514","4","180",
"STATION","北桥","198,538","4","180",
"STATION","剑川路","198,557","4","180",
"STATION","东川路","198,575","4","180",
"STATION","金平路","176,581","2","180",
"STATION","华宁路","159,582","6","180",
"STATION","文井路","141,582","2","180",
"STATION","闵行开发区","123,580","6","180",

"SUBWAY","6号线","上海","4","0.008",
"TIME_FORWORD","25200","320","4","0",
"TIME_BACKWORD","27000","320","4","0",
"STATION","港城路","662,178","4","180",
"STATION","外高桥保税区北","673,195","4","180",
"STATION","航津路","673,211","4","180",
"STATION","外高桥保税区南","673,226","4","180",
"STATION","洲海路","663,240","4","180",
"STATION","五洲大道","663,256","4","180",
"STATION","东靖路","663,272","4","180",
"STATION","巨峰路","663,291","4","180",
"STATION","五莲路","663,312","4","180",
"STATION","博兴路","659,321","4","180",
"STATION","金桥路","645,335","4","180",
"STATION","云山路","626,335","6","180",
"STATION","德平路","607,335","2","180",
"STATION","北洋泾路","585,335","6","180",
"STATION","民生路","564,335","2","180",
"STATION","源深体育中心","545,335","6","180",
"STATION","世纪大道","524,335","9","180",
"STATION","浦电路","518,353","1","180",
"STATION","蓝村路","515,370","5","180",
"STATION","上海儿童医学中心","497,383","4","180",
"STATION","临沂新村","479,396","1","180",
"STATION","高科西路","461,410","5","180",
"STATION","东明路","461,427","4","180",
"STATION","高青路","461,444","4","180",
"STATION","华夏西路","461,460","4","180",
"STATION","上南路","434,460","2","180",
"STATION","灵岩南路","406,460","6","180",
"STATION","济阳路（未启用）","385,450","8","180",

"SUBWAY","7号线","上海","4","0.0008",
"TIME_FORWORD","25200","320","4","0",
"TIME_BACKWORD","27000","320","4","0",
"STATION","花木路","575,382","4","180",
"STATION","龙阳路","563,393","9","180",
"STATION","芳华路","543,401","5","180",
"STATION","锦绣路","520,410","6","180",
"STATION","杨高南路","492,410","2","180",
"STATION","高科西路","461,410","5","180",
"STATION","云台路","443,410","2","180",
"STATION","耀华路","425,410","1","180",
"STATION","长清路","403,410","6","180",
"STATION","后滩","386,399","7","180",
"STATION","船厂路","367,386","4","180",
"STATION","东安路","362,370","3","180",
"STATION","肇嘉浜","362,350","3","180",
"STATION","常熟路","362,326","9","180",
"STATION","静安寺","362,313","9","180",
"STATION","昌平路","362,294","4","180",
"STATION","长寿路","362,280","4","180",
"STATION","镇坪路","362,262","9","180",
"STATION","岚皋路","369,245","4","180",
"STATION","新村路","384,235","4","180",
"STATION","大华三路","386,226","4","180",
"STATION","行知路","386,214","4","180",
"STATION","大场镇","386,200","4","180",
"STATION","场中路","386,185","4","180",
"STATION","上大路","386,172","4","180",
"STATION","南陈路","386,158","4","180",
"STATION","上海大学","366,155","2","180",

"SUBWAY","8号线","上海","4","0.008",
"TIME_FORWORD","25200","320","4","0",
"TIME_BACKWORD","27000","320","4","0",
"STATION","航天博物馆","385,587","4","180",
"STATION","联航路","385,563","4","180",
"STATION","江月路","385,539","4","180",
"STATION","浦江镇","385,516","4","180",
"STATION","芦恒路","385,490","4","180",
"STATION","凌兆新村","375,470","4","180",
"STATION","济阳路（未启用）","385,450","9","180",
"STATION","杨思","402,436","1","180",
"STATION","成山路","425,427","4","180",
"STATION","耀华路","425,410","4","180",
"STATION","周家渡（未启用）","433,392","8","180",
"STATION","西藏南路","434,370","9","180",
"STATION","陆家浜","436,356","9","180",
"STATION","老西门","434,341","4","180",
"STATION","大世界","434,324","4","180",
"STATION","人民广场","434,313","9","180",
"STATION","曲阜路","434,292","4","180",
"STATION","中兴路","445,265","4","180",
"STATION","西藏北路","458,254","3","180",
"STATION","虹口足球场","479,255","5","180",
"STATION","曲阳路","496,255","2","180",
"STATION","四平路","511,255","4","180",
"STATION","鞍山新村","536,271","6","180",
"STATION","江浦路","560,271","2","180",
"STATION","黄兴路","584,271","4","180",
"STATION","延吉中路","590,261","4","180",
"STATION","黄兴公园","590,244","4","180",
"STATION","翔殷路","590,229","4","180",
"STATION","嫩江路","590,211","4","180",
"STATION","市光路","590,192","4","180",

"SUBWAY","9号线","上海","4","0.0008",
"TIME_FORWORD","25200","320","4","0",
"TIME_BACKWORD","27000","320","4","0",
"STATION","杨高中路","560,352","3","180",
"STATION","世纪大道","524,335","9","180",
"STATION","商城路","501,335","1","180",
"STATION","小南门","471,356","4","180",
"STATION","陆家浜","436,356","3","180",
"STATION","马当路","418,350","2","180",
"STATION","打浦桥","400,350","6","180",
"STATION","嘉善路","379,350","6","180",
"STATION","肇嘉浜路","362,350","3","180",
"STATION","徐家汇","330,350","9","180",
"STATION","宜山路","295,358","9","180",
"STATION","桂林路","264,365","6","180",
"STATION","漕河泾开发区","238,366","2","180",
"STATION","合川路","213,366","6","180",
"STATION","星中路","188,366","2","180",
"STATION","七宝","162,366","6","180",
"STATION","中春路","138,366","2","180",
"STATION","九亭","112,366","6","180",
"STATION","泗泾","88,366","2","180",
"STATION","佘山","66,381","4","180",
"STATION","洞泾","66,412","4","180",
"STATION","松江大学城","66,441","4","180",
"STATION","松江新城","66,470","4","180",

"SUBWAY","11号线","上海","4","0.0008",
"TIME_FORWORD","25200","320","4","0",
"TIME_BACKWORD","27000","320","4","0",
"STATION","江苏路","336,304","9","180",
"STATION","隆德路","336,284","4","180",
"STATION","曹杨路","336,261","9","180",
"STATION","枫桥路","336,247","4","180",
"STATION","真如","331,235","4","180",
"STATION","上海西站","319,228","8","180",
"STATION","李子园","305,214","4","180",
"STATION","祁连山路","278,207","2","180",
"STATION","武威路","252,206","6","180",
"STATION","桃浦新村","232,192","3","180",
"STATION","南翔","213,177","3","180",
"STATION","马陆","193,165","3","180",
"STATION","嘉定新城","166,157","4","180",
"STATION","白银路","163,136","4","180",
"STATION","嘉定西","165,120","4","180",
"STATION","嘉定北","174,105","4","180",
"STATION","上海赛车场","147,154","1","180",
"STATION","昌吉东路(未启用)","132,161","1","180",
"STATION","上海汽车城","118,173","4","180",
"STATION","安亭","94,179","2","180",

"CITY","广州","366,346","360,330","0.0008",
"SUBWAY","1号线","广州","4","180",
"STATION","广州东站","427,103","4","180",
"STATION","体育中心","488,138","4","180",
"STATION","体育西路","430,190","5","180",
"STATION","杨箕","396,190","6","180",
"STATION","东山口","354,190","2","180",
"STATION","烈士陵园","307,190","6","180",
"STATION","农讲所","263,190","2","180",
"STATION","公园前","218,190","2","180",
"STATION","西门口","182,190","6","180",
"STATION","陈家祠","136,190","2","180",
"STATION","长寿路","71,213","4","180",
"STATION","黄沙","71,252","4","180",
"STATION","芳村","71,290","4","180",
"STATION","花地湾","71,329","4","180",
"STATION","坑口","71,360","4","180",

"SUBWAY","2号线","广州","4","180",
"STATION","万胜围","662,310","3","180",
"STATION","琶洲","611,310","2","180",
"STATION","新港东","576,310","6","180",
"STATION","磨碟沙","534,310","2","180",
"STATION","赤岗","492,310","6","180",
"STATION","客村","429,310","3","180",
"STATION","鹭江","359,310","2","180",
"STATION","中大","312,310","6","180",
"STATION","晓港","263,310","3","180",
"STATION","江南西","219,289","4","180",
"STATION","市二宫","219,261","4","180",
"STATION","海珠广场","219,190","4","180",
"STATION","公园前","219,226","4","180",
"STATION","纪念堂","219,140","4","180",
"STATION","越秀公园","219,110","4","180",
"STATION","广州火车站","219,67","4","180",
"STATION","三元里","219,33","4","180",

"SUBWAY","3号线","广州","4","180",
"STATION","天河客运站","636,96","4","180",
"STATION","五山","612,119","4","180",
"STATION","华师","581,138","4","180",
"STATION","岗顶","549,167","4","180",
"STATION","石牌桥","515,190","4","180",
"STATION","体育西路","429,190","4","180",
"STATION","珠江新城","429,230","4","180",
"STATION","赤岗塔","429,272","4","180",
"STATION","客村","429,310","4","180",
"STATION","大塘","429,373","4","180",
"STATION","沥滘","429,405","4","180",
"STATION","厦滘","429,438","4","180",
"STATION","大石","429,468","4","180",
"STATION","汉溪长隆","429,500","4","180",
"STATION","市桥","464,526","4","180",
"STATION","番禺广场","516,527","4","180",

"SUBWAY","4号线","广州","4","180",
"STATION","万胜围","662,310","3","180",
"STATION","官洲","662,345","4","180",
"STATION","大学城北","662,368","4","180",
"STATION","大学城南","662,397","4","180",
"STATION","新造","662,422","4","180",
"STATION","石碁","662,489","4","180",
"STATION","海傍","662,522","4","180",
"STATION","低涌","662,551","4","180",
"STATION","东涌","662,579","4","180",
"STATION","黄阁汽车城","749,617","4","180",
"STATION","黄阁","798,617","4","180",

"CITY","杭州","443,254","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","--","0,0","4","180",

"CITY","南京","428,231","400,300","0.0010",
"SUBWAY","1号线","南京","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","迈皋桥站","457,154","4","120",
"STATION","高力家具港","451,165","4","180",
"STATION","红山动物园站","441,175","4","180",
"STATION","南京站站","428,193","5","120",
"STATION","新模范马路站","402,214","5","120",
"STATION","玄武门站","402,236","4","180",
"STATION","鼓楼站","402,263","4","60",
"STATION","珠江路站","402,285","4","120",
"STATION","新街口站","402,310","3","120",
"STATION","张府园站","402,334","4","120",
"STATION","三山街站","398,354","4","120",
"STATION","中华门站","383,394","4","180",
"STATION","安德门站","357,433","4","180",
"STATION","小行","321,452","6","120",
"STATION","中胜路站","295,439","3","120",
"STATION","元通站","273,419","3","120",
"STATION","奥体中心站","264,387","8","120",

"SUBWAY","1号延长线","南京","4","180",
"TIME_FORWORD","25200","320","4","0",
"TIME_BACKWORD","27000","320","4","0",
"STATION","安德门站","357,433","4","180",
"STATION","天隆寺站","360,462","7","180",
"STATION","软件大道站","382,465","2","180",
"STATION","花神庙站","407,463","3","180",
"STATION","高铁南京南站","431,481","8","180",
"STATION","双龙大道站","471,499","3","180",
"STATION","胜太路站","480,531","8","180",
"STATION","百家湖站","480,549","8","180",
"STATION","小龙湾站","480,579","8","180",
"STATION","竹山路站","530,579","2","180",
"STATION","天印大道站","569,564","6","180",
"STATION","龙眠大道站","597,559","2","180",
"STATION","南医大学院站","621,570","4","180",
"STATION","南京交院站","653,619","4","180",
"STATION","中国药科大学站","669,660","4","180",

"SUBWAY","2号线","南京","4","180",
"TIME_FORWORD","25200","360","4","0",
"TIME_BACKWORD","27000","360","4","0",
"STATION","油坊桥站","265,504","4","180",
"STATION","雨润大街站","273,450","4","180",
"STATION","元通站","273,419","3","180",
"STATION","奥体东站","290,397","4","180",
"STATION","兴隆大街站","302,373","4","180",
"STATION","集庆门大街站","310,339","4","180",
"STATION","云锦路站","328,327","8","180",
"STATION","莫愁湖站","351,317","8","180",
"STATION","汉中门站","368,302","8","180",
"STATION","上海路站","387,305","6","180",
"STATION","新街口站","402,310","3","180",
"STATION","大行宫站","426,310","6","180",
"STATION","西安门站","447,310","2","180",
"STATION","明故宫站","475,310","6","180",
"STATION","苜蓿园站","510,310","2","180",
"STATION","下马坊站","537,315","6","180",
"STATION","孝陵卫站","558,321","2","180",
"STATION","钟灵街站","579,311","5","180",
"STATION","马群站","635,287","5","180",
"STATION","金马路站","659,245","5","180",
"STATION","仙鹤门站","653,200","5","180",
"STATION","学则路站","679,184","5","180",
"STATION","仙林中心站","709,167","5","180",
"STATION","羊山公园站","733,149","1","180",
"STATION","南大仙林校区站","769,139","4","180",
"STATION","经天路站","800,122","8","180",                                                   


"CITY","香港","374,355","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","--","0,0","4","180",

"GT","沪宁高铁","428,231","0,0","0.031",
"SUBWAY","沪宁高铁","上海","4","180",
"STATION","南京","27,4","2","180",
"STATION","仙林","66,-4","6","180",
"STATION","宝华山","119,-43","2","180",
"STATION","镇江","254,-59","3","180",
"STATION","丹徒","277,-35","3","180",
"STATION","丹阳","314,27","3","180",
"STATION","常州","452,103","3","180",
"STATION","戚墅堰","491,148","3","180",
"STATION","惠山","558,164","6","180",
"STATION","无锡","586,206","2","180",
"STATION","无锡新区","615,228","3","180",
"STATION","苏州新区","660,305","7","180",
"STATION","苏州","693,306","3","180",
"STATION","苏州园区","726,301","6","180",
"STATION","阳澄湖","768,303","2","180",
"STATION","昆山南","814,306","6","180",
"STATION","花桥","847,316","2","180",
"STATION","安亭北","892,322","6","180",
"STATION","南翔北","925,322","2","180",
"STATION","上海西","952,339","6","180",
"STATION","上海","979,347","4","180",
"STATION","共康路","985,375","4","180",

"GT","武广高铁","378,250","0,0","0.25",
"SUBWAY","武广高铁","上海","4","180",
"STATION","武汉","0,9","2","180",
"STATION","咸宁北","-18,21","6","180",
"STATION","赤壁北","-28,50","2","180",
"STATION","岳阳东","-43,80","3","180",
"STATION","汨罗东","-53,110","3","180",
"STATION","长沙南","-60,139","3","180",
"STATION","株洲西","-58,154","3","180",
"STATION","衡山西","-63,180","3","180",
"STATION","衡阳东","-68,202","3","180",
"STATION","耒阳西","-72,230","3","180",
"STATION","郴州西","-75,250","3","180",
"STATION","韶关","-78,274","3","180",
"STATION","清远","-68,320","3","180",
"STATION","广州","-54,380","3","180", 

"GT","京津高铁","401,121","0,0","0.08",
"SUBWAY","京津高铁","上海","4","180",
"STATION","北京南站","0,9","2","180",
"STATION","亦庄站","40,50","6","180",
"STATION","武清站","80,80","3","180",
"STATION","天津站","112,145","3","180",

"CITY","乌鲁木齐","74,61","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","乌鲁木齐","0,0","4","180",

"CITY","拉萨","112,264","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","拉萨","0,0","4","180",

"CITY","兰州","259,176","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","兰州","0,0","4","180",

"CITY","西宁","234,168","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","西宁","0,0","4","180",

"CITY","成都","261,249","0,0","4",
"SUBWAY","1号线","成都","4","180",
"STATION","成都","0,0","4","180",

"CITY","昆明","245,322","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","--","0,0","4","180",

"CITY","贵阳","289,302","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","--","0,0","4","180",

"CITY","南宁","310,349","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","--","0,0","4","180",

"CITY","西安","316,201","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","--","0,0","4","180",

"CITY","海口","332,383","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","--","0,0","4","180",

"CITY","呼和浩特","348,106","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","--","0,0","4","180",

"CITY","郑州","370,195","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","--","0,0","4","180",

"CITY","武汉","378,250","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","--","0,0","4","180",

"CITY","长沙","361,281","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","--","0,0","4","180",

"CITY","石家庄","380,148","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","--","0,0","4","180",

"CITY","合肥","411,234","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","--","0,0","4","180",

"CITY","天津","410,133","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","--","0,0","4","180",

"CITY","济南","408,167","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","--","0,0","4","180",

"CITY","长春","503,60","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","--","0,0","4","180",

"CITY","沈阳","481,92","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","--","0,0","4","180",

"CITY","哈尔滨","517,30","0,0","4",
"SUBWAY","1号线","","4","180",
"STATION","--","0,0","4","180",

"END","Gameover","","4","0"
};

//网格
static int m_x=-10,m_y = 25;            // 画板的偏移量
static boolean g_GT = false;
static double m_zoom  = 0.5;           //放大倍数
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
   int m_showlevel = 0;
   int m_hidelevel = 1;

   int m_index=0; //序号
   int m_rote=0;
   int m_color=Color.RED;     
   double m_x1=0;
   double m_y1=0;
   double m_magic=1;//本对象的放大系数
   
 protected void debug(Graphics graphics,String str,int x, int  y)
 {
     if (1==2)
      graphics.drawText(str,x,y);
 };   
 /*
  boolean showlink()
 {
    if (m_showlevel < m_zoom &&  m_zoom < m_hidelevel)
    return true;
    return false;
 }
 
 boolean showdot()
 {
    if (m_showlevel + 2 < m_zoom &&  m_zoom < m_hidelevel)
    return true;
    return false;
 }
 
 boolean showtext()
 {
    if (m_showlevel + 4 < m_zoom &&  m_zoom < m_hidelevel)
    return true;
    return false;
 }
 */
 
 protected double zoomsize()
 {
     return m_zoom * m_magic;
 }
  protected int get_x()
 {
    return (int)(m_x1  * m_zoom);
 };   
   protected int get_y()
 {  
    return (int)(m_y1  * m_zoom);
 }; 
 

 public boolean visiable()
 {
       if (( m_y+ get_y() > -100 )&& (m_y+get_y() < 240 + 100  )
           &&   m_x+get_x() >  -100  && m_x+get_x() < 360 + 100  )
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
        int l_cir = 1;
        double l_zoom = 1;
        l_zoom = zoomsize();
        debug(graphics,"S",10,110);
        l_x = get_x();
        l_y = get_y();   
        
        if (!g_GT) 
        {
            if (l_zoom >1800) l_cir = 4;               
            else if (l_zoom >1200) l_cir = 3;            
            else if (l_zoom >700) l_cir = 2;            
        }
        else
        { 
           if (l_zoom>60) l_cir = 4;  
           else if (l_zoom>50) l_cir = 3;
           else if (l_zoom>30) l_cir = 2;            
        }
                
       if (g_GT && l_zoom > 2)         
       // graphics.fillArc(m_x+l_x-l_cir,m_y+l_y-l_cir, 2*l_cir+1,2*l_cir+1,0,360);  
          graphics.fillRect(m_x+l_x-l_cir,m_y+l_y-l_cir, 2*l_cir+1,2*l_cir+1);  
       else
       {
           if (l_zoom > 60)
           // graphics.fillArc(m_x+l_x-l_cir,m_y+l_y-l_cir, 2*l_cir+1,2*l_cir+1,0,360);  
            graphics.fillRect(m_x+l_x-l_cir,m_y+l_y-l_cir, 2*l_cir+1,2*l_cir+1);  
       }
       
        if ( (!g_GT && l_zoom>1900 ) || ( g_GT && l_zoom >4) )
        { if (m_textpos==1)
           graphics.drawText(m_stationname,m_x + l_x - m_font.getAdvance(m_stationname) - l_cir  ,
                                                 m_y +l_y - 38);
          else if (m_textpos==2)
           graphics.drawText(m_stationname,m_x + l_x  - m_font.getAdvance(m_stationname)/2,
                                                 m_y +l_y - 38);       
          else if (m_textpos==3)                                      
           graphics.drawText(m_stationname,m_x + l_x + l_cir +2  , m_y +l_y - 30);
          else if (m_textpos==4)
           graphics.drawText(m_stationname,m_x + l_x + l_cir +5, m_y +l_y -6);         
          else if (m_textpos==5)
           graphics.drawText(m_stationname,m_x + l_x + l_cir +2 , m_y +l_y +10);  
          else if (m_textpos==6)
           graphics.drawText(m_stationname,m_x + l_x  - m_font.getAdvance(m_stationname)/2,m_y +l_y+20 );  
          else  if (m_textpos==7)
           graphics.drawText(m_stationname,m_x + l_x  - m_font.getAdvance(m_stationname) - l_cir  ,
                                                m_y +l_y +20); 
          else if (m_textpos==8)
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
       
        if ( g_GT )
        {
           if(zoomsize()  > 10)
              graphics.drawText(m_linename,l_sta.get_x()+m_x+5 ,l_sta.get_y()+m_y+5);                                      
       }
       else
       {
           if(zoomsize()  > 60)
              graphics.drawText(m_linename,l_sta.get_x()+m_x+5 ,l_sta.get_y()+m_y+5);    
        }
    
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
              l_sta.get_x()+m_x,l_sta.get_y() +m_y);
           }                                      
         }
        }
        
        if (m_begintime_f !=0  && zoomsize()  > 2000)
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
                   graphics.fillArc( l_x- 3, l_y-3,7,7,0,360);                                                                             
                   //graphics.setColor(m_color);
                   //graphics.drawRect( l_x-4, l_y-4,9,9);
                    if (zoomsize()  > 130)
                    {
                       graphics.setColor(Color.YELLOW);
                       graphics.drawText(l_tag, l_x - l_w/2, l_y+ 8);
                    }
                   graphics.setColor(m_color);
              } 
          }          
          
         }
         if (m_begintime_b !=0 && zoomsize()  >2000)
        {
            l_time = l_d.getTime()/1000 % 86400 +8*3600;
            l_cycle = (int)(l_time - m_begintime_b) % m_gaptime;           
            for (int i =  m_stations.size()-1 ; i >0 ; i--)
            {               
             l_sta = ((Cstation) m_stations.elementAt(i));    
            if (l_cycle >= l_sta.m_runtime) //时长跨越当前车站
                 { l_sta.m_btime = l_cycle; l_cycle -= l_sta.m_runtime ; }
            else { l_sta.m_btime = l_cycle; l_cycle = l_cycle + m_gaptime - l_sta.m_runtime;}
                          
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
                   graphics.fillArc( l_x- 3, l_y-3,7,7,0,360);                                         
                   //graphics.setColor(m_color);
                   //graphics.drawRect( l_x-4, l_y-4,9,9);
                   if (zoomsize()  > 130)
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
             if (zoomsize()  < 100) 
             {
                graphics.setColor(Color.YELLOW);
                graphics.fillArc(m_x+l_x, m_y+l_y, l_cir*2+1,l_cir*2+1,0,360);                 
            }
            if (zoomsize()  > 0.1 && zoomsize()  < 100)
            {   
                graphics.setColor(Color.LIGHTCYAN);                                                 
                graphics.drawText(m_cityname,m_x + l_x + 10,m_y + l_y - 15);    
            }
       }

       debug(graphics,"draw city",10,50);
       for (int i = 0 ; i < m_lines.size(); i++)
       {    g_GT = m_GT;
           ((Cline)(m_lines.elementAt(i))).draw(graphics,type);        
        }
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
 Color.LIGHTSKYBLUE,
 Color.LIGHTGREEN,
 Color.LIGHTSALMON,
 Color.MAROON,
 Color.LIGHTPINK,
 Color.LIGHTGREY,
 Color.LIGHTBLUE,
 Color.LIGHTCORAL,
 Color.LIGHTSEAGREEN,
 Color.LIGHTSTEELBLUE,
 Color.LIGHTCYAN};

public void init(String[] subways)
{  
    int cl=0,u=0;
    String tmp="";
    int l_offx=0,l_offy=0;
    double l_magic=1;
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
                 l_city.m_x1= l_city.m_x1 + Integer.parseInt(tmp.substring(0,tmp.indexOf(','))); 
                 l_city.m_y1=  + Integer.parseInt(tmp.substring(tmp.indexOf(',')+1)); 
                 tmp = subways[i*ITEM_CNT+3];                           
                 l_offx=  Integer.parseInt(tmp.substring(0,tmp.indexOf(','))); 
                 l_offy=  Integer.parseInt(tmp.substring(tmp.indexOf(',')+1)); 
                 l_magic =Double.parseDouble( subways[i*ITEM_CNT+4]);   
                 m_citys.addElement(l_city);
             }
             if (subways[i*ITEM_CNT]=="GT")
             {    
                 cl=10;u=0;                  
                 l_city = new Ccity();                               
                 l_city.m_cityname =subways[i*ITEM_CNT+1];
                 l_city.m_GT = true;               
                 tmp = subways[i*ITEM_CNT+2];                           
                l_city.m_x1= l_city.m_x1 + Integer.parseInt(tmp.substring(0,tmp.indexOf(','))); 
                l_city.m_y1=  + Integer.parseInt(tmp.substring(tmp.indexOf(',')+1)); 
                 l_magic =Double.parseDouble( subways[i*ITEM_CNT+4]);    
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
               // l_station.m_magic = l_magic;                         
                l_station.m_x1= l_city.m_x1 + (Integer.parseInt(tmp.substring(0,tmp.indexOf(','))) - l_offx)*l_magic ; 
                l_station.m_y1= l_city.m_y1 + (Integer.parseInt(tmp.substring(tmp.indexOf(',')+1)) - l_offy)*l_magic ; 
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
    Calendar l_c = Calendar.getInstance();
    
    graphics.drawText("Z:"+ls_zoom,1,1);
    graphics.drawText(String.valueOf(l_c.get(l_c.YEAR))+"/" 
                      + String.valueOf(l_c.get(l_c.MONTH)+1)+"/"
                      + String.valueOf(l_c.get(l_c.DAY_OF_MONTH))+" "
                      + String.valueOf(l_c.get(l_c.HOUR_OF_DAY))+":"
                      + String.valueOf(l_c.get(l_c.MINUTE ))+":"
                      + String.valueOf(l_c.get(l_c.SECOND))
                      ,1,225);

    if (zoomsize()> 200)
    {
        if (zoomsize()  > 3700)
        {    m_font = m_font_b;
             graphics.setFont(m_font);
        }
        m_act_city.draw(graphics,type);
        return;
    }
    for (int i = 0; i <m_citys.size(); i++)
    {
       debug(graphics,"City"+String.valueOf(m_zoom),10,20);
       l_city = (Ccity)(m_citys.elementAt(i));
       if (l_city.m_GT)  
       {
            if (zoomsize()  > 100)
            { 
                m_font = m_font_b;
                graphics.setFont(m_font);              
            }  
            l_city.draw(graphics,type);     
        }
       else if (l_city.visiable())       
       {
           m_act_city = l_city;
           if (zoomsize()  > 3700)
           {    m_font = m_font_b;
                graphics.setFont(m_font);
            }
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
     m_x = (int)((m_x - 159)/m_zoom * m_zoom * a/b)+159;
     m_y = (int)((m_y - 119)/m_zoom * m_zoom * a/b)+119;    
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
         m_x = 159  - l_city.get_x();
         m_y = 119  - l_city.get_y();         
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
public za_Metro(UiApplication app)
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
                    Dialog.alert("   地铁时光 V1.0 \ndaemon@wo.com.cn\n      2010.07");
                 }});               
         menu.addSeparator();             
         
        menu.add(new MenuItem("帮助" , 100, 10){
            public void run()
                { 
                    Dialog.alert("1.轨迹球移动地图\n2.+ - 键放大缩小");
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
           m_metro.zoom(2,1);          
        if (key == Characters.LATIN_SMALL_LETTER_I) // zoom out
           m_metro.zoom(1,2);          
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
        System.exit(0);  
    }   
}
