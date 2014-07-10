/*
 * za_SubWay.java
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
import java.util.* ;


/**
 * 
 */
public final  class za_SubWay extends MainScreen
{     
static String subways[]={
   
"CITY","�Ϻ�","EC","4","180",
"SUBWAY","1����","�Ϻ�","4","180",
"STATION","ݷׯ","4S","4","180",
"STATION","�⻷·","5R","4","180",
"STATION","����·","5Q","4","180",
"STATION","������԰","6Q","4","180",
"STATION","�Ϻ���վ","6P","4","180",
"STATION","�·","7O","4","180",
"STATION","�Ϻ�������","7M","4","180",
"STATION","��һ�","7L","4","180",
"STATION","��ɽ·","8L","4","180",
"STATION","����·","8K","4","180",
"STATION","������·","9K","4","180",
"STATION","������·","AK","4","180",
"STATION","����㳡","AJ","4","180",
"STATION","��բ·","AH","4","180",
"STATION","����·","9H","4","180",
"STATION","�Ϻ���վ","9G","4","180",
"STATION","��ɽ��·","AF","4","180",
"STATION","�ӳ�·","AE","4","180",
"STATION","�Ϻ���Ϸ��","AD","4","180",
"STATION","��ˮ·","AC","4","180",
"STATION","�����´�","AA","4","180",
"STATION","����·","A9","4","180",
"STATION","ͨ���´�","A8","4","180",
"STATION","����·","A7","4","180",
"STATION","�����´�","A6","4","180",
"STATION","������·","A4","4","180",
"STATION","������·","A3","4","180",
"STATION","����·","A2","4","180",

"SUBWAY","2����","�Ϻ�","4","180",
"STATION","�ֶ����ʻ���","KR","4","180",
"STATION","������·","KR","4","180",
"STATION","Զ�����","JQ","4","180",
"STATION","���·","IQ","4","180",
"STATION","��ɳ","IQ","4","180",
"STATION","���Ķ�·","HP","4","180",
"STATION","������·","HO","4","180",
"STATION","����","GO","4","180",
"STATION","����·","GO","4","180",
"STATION","���·","FO","4","180",
"STATION","�Ž��߿�","EO","4","180",
"STATION","����·","EO","4","180",
"STATION","���͹�԰","DN","4","180",
"STATION","�Ϻ��Ƽ���","DM","4","180",
"STATION","���ʹ��","DK","4","180",
"STATION","����·","CJ","4","180",
"STATION","½����","CJ","4","180",
"STATION","�Ͼ���·","BJ","4","180",
"STATION","����㳡","AJ","4","180",
"STATION","�Ͼ���·","9J","4","180",
"STATION","������","8J","4","180",
"STATION","����·","8I","4","180",
"STATION","��ɽ��԰","7I","4","180",
"STATION","¦ɽ��·","6I","4","180",
"STATION","����·","5H","4","180",
"STATION","������","5G","4","180",
"STATION","����·","4G","4","180",
"STATION","����2�ź�վ¥","3H","4","180",
"STATION","���Ż�վ","3I","4","180",
"STATION","������","2I","4","180",

"SUBWAY","3����","�Ϻ�","4","180",
"STATION","�Ϻ���վ","6P","4","180",
"STATION","ʯ��·","7P","4","180",
"STATION","����·","7O","4","180",
"STATION","��Ϫ·","7M","4","180",
"STATION","��ɽ·","6K","4","180",
"STATION","����·","6J","4","180",
"STATION","�Ӱ���·","6I","4","180",
"STATION","��ɽ��԰","6G","4","180",
"STATION","��ɳ��·","7F","4","180",
"STATION","����·","8F","4","180",
"STATION","��ƺ·","8F","4","180",
"STATION","��̶·","9F","4","180",
"STATION","�Ϻ�վ","AG","4","180",
"STATION","��ɽ·","BG","4","180",
"STATION","������·","BF","4","180",
"STATION","�������","BE","4","180",
"STATION","���·","CE","4","180",
"STATION","�����","CD","4","180",
"STATION","������","CC","4","180",
"STATION","�����·","CB","4","180",
"STATION","������·","CA","4","180",
"STATION","����·","C9","4","180",
"STATION","�Ż��","D8","4","180",
"STATION","����·","D7","4","180",
"STATION","ˮ��·","D6","4","180",
"STATION","����·","D5","4","180",
"STATION","����·","D4","4","180",
"STATION","����·","D3","4","180",
"STATION","���·","D2","4","180",

"SUBWAY","4����","�Ϻ�","4","180",
"STATION","��ɽ·","61","4","180",
"STATION","�Ϻ�������","72","4","180",
"STATION","�Ϻ�������","83","4","180",
"STATION","����·","84","4","180",
"STATION","��ľ��·","85","4","180",
"STATION","³��·","96","4","180",
"STATION","������·","A7","4","180",
"STATION","���ִ���","B8","4","180",
"STATION","����","C9","4","180",
"STATION","����·","CA","4","180",
"STATION","�ֵ�·","CB","4","180",
"STATION","���ʹ��","HC","4","180",
"STATION","�ֶ����","HD","4","180",
"STATION","������·","HE","4","180",
"STATION","����·","HF","4","180",
"STATION","��ƽ·","HG","4","180",
"STATION","����·","HH","4","180",
"STATION","��ɽ·","HI","4","180",
"STATION","�Ϻ���վ","HJ","4","180",
"STATION","��̶·","HK","4","180",
"STATION","��ƺ·","HL","4","180",
"STATION","����·","HM","4","180",
"STATION","��ɳ��·","HN","4","180",
"STATION","��ɽ��԰","HO","4","180",
"STATION","�Ӱ���·","HP","4","180",
"STATION","����·","HR","4","180",

"SUBWAY","5����","�Ϻ�","4","180",
"STATION","ݷׯ","J1","4","180",
"STATION","����·","J2","4","180",
"STATION","����·","J3","4","180",
"STATION","���","J4","4","180",
"STATION","����","J5","4","180",
"STATION","����·","J6","4","180",
"STATION","����·","J7","4","180",
"STATION","��ƽ·","J8","4","180",
"STATION","����·","J9","4","180",
"STATION","�ľ�·","JA","4","180",
"STATION","���п�����","JB","4","180",

"SUBWAY","6����","�Ϻ�","4","180",
"STATION","�۳�·","K1","4","180",
"STATION","����ű�˰����","K2","4","180",
"STATION","����·","K3","4","180",
"STATION","����ű�˰����","K4","4","180",
"STATION","�޺�·","K5","4","180",
"STATION","���޴��","K6","4","180",
"STATION","����·","K7","4","180",
"STATION","�޷�·","K8","4","180",
"STATION","����·","K9","4","180",
"STATION","����·","KA","4","180",
"STATION","����·","KB","4","180",
"STATION","��ɽ·","KC","4","180",
"STATION","��ƽ·","KD","4","180",
"STATION","������·","KE","4","180",
"STATION","����·","KF","4","180",
"STATION","Դ����������","KG","4","180",
"STATION","���ʹ��","KH","4","180",
"STATION","�ֵ�·","KI","4","180",
"STATION","����·","KJ","4","180",
"STATION","�Ϻ���ͯҽѧ����","KK","4","180",
"STATION","�����´�","KL","4","180",
"STATION","�߿���·","KM","4","180",
"STATION","����·","KN","4","180",
"STATION","����·","KO","4","180",
"STATION","������·","KP","4","180",
"STATION","����·","KR","4","180",
"STATION","������·","KS","4","180",
"STATION","����·��δ���ã�","KT","4","180",

"SUBWAY","7����","�Ϻ�","4","180",
"STATION","��ľ·","L1","4","180",
"STATION","����·","L2","4","180",
"STATION","����·","L3","4","180",
"STATION","����·","L4","4","180",
"STATION","�����·","L5","4","180",
"STATION","�߿���·","L6","4","180",
"STATION","��̨·","L7","4","180",
"STATION","ҫ��·","L8","4","180",
"STATION","����·","L9","4","180",
"STATION","��̲","LA","4","180",
"STATION","����·","LB","4","180",
"STATION","����·","LC","4","180",
"STATION","�ؼ��·","LD","4","180",
"STATION","����·","LE","4","180",
"STATION","������","LF","4","180",
"STATION","��ƽ·","LG","4","180",
"STATION","����·","LH","4","180",
"STATION","��ƺ·","LI","4","180",
"STATION","᰸�·","LJ","4","180",
"STATION","�´�·","LK","4","180",
"STATION","����·","LL","4","180",
"STATION","��֪·","LM","4","180",
"STATION","����","LN","4","180",
"STATION","����·","LO","4","180",
"STATION","�ϴ�·","LP","4","180",
"STATION","�ϳ�·","LR","4","180",
"STATION","�Ϻ���ѧ","LS","4","180",

"SUBWAY","8����","�Ϻ�","4","180",
"STATION","���첩���","M1","4","180",
"STATION","����·","M2","4","180",
"STATION","����·","M3","4","180",
"STATION","�ֽ���","M4","4","180",
"STATION","«��·","M5","4","180",
"STATION","�����´�","M6","4","180",
"STATION","����·��δ���ã�","M7","4","180",
"STATION","��˼","M8","4","180",
"STATION","��ɽ·","M9","4","180",
"STATION","ҫ��·","MA","4","180",
"STATION","�ܼҶɣ�δ���ã�","MB","4","180",
"STATION","������·","MC","4","180",
"STATION","½���·","MD","4","180",
"STATION","������","ME","4","180",
"STATION","������","MF","4","180",
"STATION","����㳡","MG","4","180",
"STATION","����·","MH","4","180",
"STATION","����·","MI","4","180",
"STATION","���ر�·","MJ","4","180",
"STATION","�������","MK","4","180",
"STATION","����·","ML","4","180",
"STATION","��ƽ·","MM","4","180",
"STATION","��ɽ�´�","MN","4","180",
"STATION","����·","MO","4","180",
"STATION","����·","MP","4","180",
"STATION","�Ӽ���·","MR","4","180",
"STATION","���˹�԰","MS","4","180",
"STATION","����·","MT","4","180",
"STATION","�۽�·","MU","4","180",
"STATION","�й�·","MV","4","180",

"SUBWAY","9����","�Ϻ�","4","180",
"STATION","�����·","O1","4","180",
"STATION","���ʹ��","O2","4","180",
"STATION","�̳�·","O3","4","180",
"STATION","С����","O4","4","180",
"STATION","½���","O5","4","180",
"STATION","��·","O6","4","180",
"STATION","������","O7","4","180",
"STATION","����·","O8","4","180",
"STATION","�ؼ��·","O9","4","180",
"STATION","��һ�","OA","4","180",
"STATION","��ɽ·","OB","4","180",
"STATION","����·","OC","4","180",
"STATION","�����������","OD","4","180",
"STATION","�ϴ�·","OE","4","180",
"STATION","����·","OF","4","180",
"STATION","�߱�","OG","4","180",
"STATION","�д�·","OH","4","180",
"STATION","��ͤ","OI","4","180",
"STATION","����","OJ","4","180",
"STATION","��ɽ","OK","4","180",
"STATION","����","OL","4","180",
"STATION","�ɽ���ѧ��","OM","4","180",
"STATION","�ɽ��³�","ON","4","180",

"SUBWAY","11����","�Ϻ�","4","180",
"STATION","����·","P1","4","180",
"STATION","¡��·","P2","4","180",
"STATION","����·","P3","4","180",
"STATION","����·","P4","4","180",
"STATION","����","P5","4","180",
"STATION","�Ϻ���վ","P6","4","180",
"STATION","����԰","P7","4","180",
"STATION","����ɽ·","P8","4","180",
"STATION","����·","P9","4","180",
"STATION","�����´�","PA","4","180",
"STATION","����","PB","4","180",
"STATION","��½","PC","4","180",
"STATION","�ζ��³�","PD","4","180",
"STATION","����·","PE","4","180",
"STATION","�ζ���","PF","4","180",
"STATION","�ζ���","PG","4","180",
"STATION","�Ϻ�������","PH","4","180",
"STATION","������·(δ����)","PI","4","180",
"STATION","�Ϻ�������","PJ","4","180",
"STATION","��ͤ","PK","4","180",

"CITY","����","B7","4","180",
"SUBWAY","1����","����","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","ƻ��԰","1J","4","180",
"STATION","�ų�·","2K","6","180",
"STATION","�˽�����԰","3K","2","180",
"STATION","�˱�ɽ","4K","6","180",
"STATION","��Ȫ·","5K","2","180",
"STATION","�����","6K","6","180",
"STATION","����·","7K","2","180",
"STATION","������","8K","6","180",
"STATION","���²����","9K","2","180",
"STATION","ľ�ص�","BK","6","180",
"STATION","����ʿ·","CK","2","180",
"STATION","������","DK","3","180",
"STATION","����","EK","3","180",
"STATION","�찲����","GK","2","180",
"STATION","�찲�Ŷ�","HK","6","180",
"STATION","������","IK","2","180",
"STATION","����","JK","3","180",
"STATION","������","LK","3","180",
"STATION","������","MK","2","180",
"STATION","��ó","NK","3","180",
"STATION","����·","OK","2","180",
"STATION","�Ļ�","PK","6","180",
"STATION","�Ļݶ�","QK","2","180",

"SUBWAY","2����","����","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","��ֱ��","DF","7","180",
"STATION","����ׯ","DG","8","180",
"STATION","������","DH","8","180",
"STATION","������","DK","3","180",
"STATION","������","DL","7","180",
"STATION","������","EL","3","180",
"STATION","��ƽ��","FL","6","180",
"STATION","ǰ��","GL","2","180",
"STATION","������","JL","3","180",
"STATION","����վ","KL","4","180",
"STATION","������","LK","3","180",
"STATION","������","LI","4","180",
"STATION","������","LH","4","180",
"STATION","����ʮ��","LG","4","180",
"STATION","��ֱ��","LF","4","180",
"STATION","Ӻ�͹�","JE","4","180",
"STATION","������","IE","2","180",
"STATION","��¥���","FE","6","180",
"STATION","��ˮ̶","EE","2","180",
"STATION","��ֱ��","DF","7","180",

"SUBWAY","��ͨ��","����","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","�Ļ�","PK","6","180",
"STATION","�Ļݶ�","QK","2","180",
"STATION","�߱���","RK","6","180",
"STATION","��ý��ѧ","SK","2","180",
"STATION","˫��","TK","6","180",
"STATION","��ׯ","UK","2","180",
"STATION","������","VK","6","180",
"STATION","��Է","WL","4","180",
"STATION","��԰","XM","4","180",
"STATION","�ſ���","YN","4","180",
"STATION","��԰","ZO","4","180",
"STATION","�ٺ���","aP","4","180",
"STATION","����","bQ","4","180",

"SUBWAY","4����","����","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","��������","ER","4","180",
"STATION","������","EQ","4","180",
"STATION","��ұ�","EP","4","180",
"STATION","������վ","EO","4","180",
"STATION","��Ȼͤ","EN","4","180",
"STATION","���п�","EM","4","180",
"STATION","������","EL","3","180",
"STATION","����","EK","3","180",
"STATION","�龳��ͬ","EI","4","180",
"STATION","����","EH","4","180",
"STATION","ƽ����","EG","4","180",
"STATION","�½ֿ�","EF","4","180",
"STATION","��ֱ��","DF","7","180",
"STATION","����԰","BF","6","180",
"STATION","����ͼ���","AF","3","180",
"STATION","κ����","AE","4","180",
"STATION","�����ѧ","AB","4","180",
"STATION","�����ׯ","AA","3","180",
"STATION","�йش�","A9","4","180",
"STATION","������ѧ����","A8","4","180",
"STATION","Բ��԰","97","4","180",
"STATION","��Է","86","4","180",
"STATION","������","76","2","180",

"SUBWAY","5����","����","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","��ͨԷ��","J1","4","180",
"STATION","��ͨԷ","J2","4","180",
"STATION","��ͨԷ��","J3","4","180",
"STATION","��ˮ��","J4","3","180",
"STATION","��ˮ����","J5","4","180",
"STATION","��Է·��","J6","4","180",
"STATION","����·��","J7","4","180",
"STATION","�������ֱ���","J8","4","180",
"STATION","���������Ͽ�","JA","3","180",
"STATION","��ƽ����","JB","4","180",
"STATION","��ƽ�ﱱ��","JC","4","180",
"STATION","Ӻ�͹�","JE","3","180",
"STATION","������","JF","4","180",
"STATION","������·","JG","4","180",
"STATION","����","JH","4","180",
"STATION","���п�","JI","4","180",
"STATION","����","JK","3","180",
"STATION","������","JL","3","180",
"STATION","������","JN","4","180",
"STATION","��̳����","JO","4","180",
"STATION","�ѻ���","JP","4","180",
"STATION","����Ҥ","JQ","4","180",
"STATION","�μ�ׯ","JR","4","180",

"SUBWAY","10����","����","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","�͹�","6A","2","180",
"STATION","���ݽ�","8A","6","180",
"STATION","�����ׯ","AA","3","180",
"STATION","֪����","BA","6","180",
"STATION","֪��·","CA","3","180",
"STATION","������","EA","6","180",
"STATION","ĵ��԰","FA","2","180",
"STATION","������","GA","6","180",
"STATION","������","HA","3","180",
"STATION","������","IA","6","180",
"STATION","���������Ͽ�","JA","3","180",
"STATION","��ҩ��","LA","3","180",
"STATION","̫����","MA","4","180",
"STATION","��Ԫ��","NB","4","180",
"STATION","������","NC","4","180",
"STATION","ũҵչ����","ND","4","180",
"STATION","�Ž��","NE","4","180",
"STATION","����¥","NG","4","180",
"STATION","��̨Ϧ��","NI","4","180",
"STATION","��ó","NK","3","180",
"STATION","˫��","NL","4","180",
"STATION","����","NM","4","180",

"SUBWAY","13����","����","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","��ֱ��","DF","7","180",
"STATION","������","CC","4","180",
"STATION","֪��·","CA","3","180",
"STATION","�����","C8","4","180",
"STATION","�ϵ�","C6","4","180",
"STATION","������","C5","4","180",
"STATION","����","D4","2","180",
"STATION","������","E4","6","180",
"STATION","��Ӫ","G4","2","180",
"STATION","��ˮ��","J4","3","180",
"STATION","��Է","L5","4","180",
"STATION","������","L7","4","180",
"STATION","��ҩ��","LA","3","180",
"STATION","������","LB","4","180",
"STATION","����","LD","4","180",
"STATION","��ֱ��","LF","4","180",

"SUBWAY","������","����","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","ɭ�ֹ�԰����","H7","8","180",
"STATION","����ƥ�˹�԰","H8","8","180",
"STATION","��������","H9","8","880",
"STATION","������","HA","3","180",

"SUBWAY","��������","����","4","180",
"TIME_FORWORD","25200","600","4","0",
"TIME_BACKWORD","27000","600","4","0",
"STATION","T2��վ¥","T4","8","180",
"STATION","T3��վ¥","U4","2","180",
"STATION","��Ԫ��","NB","5","180",
"STATION","��ֱ��","LF","4","180",

"CITY","����","9G","4","180",
"SUBWAY","1����","����","4","180",
"STATION","���ݶ�վ","A1","4","180",
"STATION","��������","A2","4","180",
"STATION","������·","A3","4","180",
"STATION","���","A4","4","180",
"STATION","��ɽ��","A5","4","180",
"STATION","��ʿ��԰","A6","4","180",
"STATION","ũ����","A7","4","180",
"STATION","��԰ǰ","A8","4","180",
"STATION","���ſ�","A9","4","180",
"STATION","�¼���","AA","4","180",
"STATION","����·","AB","4","180",
"STATION","��ɳ","AC","4","180",
"STATION","����","AD","4","180",
"STATION","������","AE","4","180",
"STATION","�ӿ�","AF","4","180",

"SUBWAY","2����","����","4","180",
"STATION","������վ","D1","4","180",
"STATION","ʯ��վ","A1","4","180",
"STATION","�Ὥվ","A1","4","180",
"STATION","����վ","A1","4","180",
"STATION","��Ϫվ","A1","4","180",
"STATION","����վ","A1","4","180",
"STATION","������վ","A1","4","180",
"STATION","��̩·վ","A1","4","180",
"STATION","����վ","A1","4","180",
"STATION","������վ","A1","4","180",
"STATION","�ж���վ","A1","4","180",
"STATION","����㳡վ","A1","4","180",
"STATION","��԰ǰվ","A1","4","180",
"STATION","������վ","A1","4","180",
"STATION","Խ�㹫԰վ","A1","4","180",
"STATION","���ݻ�վվ","A1","4","180",
"STATION","��Ԫ��վ","A1","4","180",
"STATION","���蹫԰վ","A1","4","180",
"STATION","���ƹ�԰վ","A1","4","180",
"STATION","�����Ļ��㳡վ","A1","4","180",
"STATION","����վ","A1","4","180",
"STATION","����վ","A1","4","180",
"STATION","�Ʊ�վ","A1","4","180",
"STATION","�κ�����","A1","4","180",

"SUBWAY","3����","����","4","180",
"STATION","��ӿ���վ","E1","4","180",
"STATION","��ɽ","E1","4","180",
"STATION","��ʦ","E1","4","180",
"STATION","�ڶ�","E1","4","180",
"STATION","ʯ����","A1","4","180",
"STATION","������·","A1","4","180",
"STATION","�齭�³�","A1","4","180",
"STATION","�����","A1","4","180",
"STATION","�ʹ�","A1","4","180",
"STATION","����","A1","4","180",
"STATION","����","A1","4","180",
"STATION","�Ü�","A1","4","180",
"STATION","��ʯ","A1","4","180",
"STATION","��Ϫ��¡","A1","4","180",
"STATION","����","A1","4","180",
"STATION","��خ�㳡","A1","4","180",

"SUBWAY","4����","����","4","180",
"STATION","������","A1","4","180",
"STATION","��ʤΧ","A1","4","180",
"STATION","����","A1","4","180",
"STATION","��ѧ�Ǳ�","A1","4","180",
"STATION","��ѧ����","A1","4","180",
"STATION","����","A1","4","180",
"STATION","ʯ��","A1","4","180",
"STATION","����","A1","4","180",
"STATION","��ӿ","A1","4","180",
"STATION","��ӿ","A1","4","180",
"STATION","�Ƹ�������","A1","4","180",
"STATION","�Ƹ�","A1","4","180",
"STATION","����","A1","4","180",
"STATION","����","A1","4","180",

"SUBWAY","5����","����","4","180",
"STATION","���","A1","4","180",
"STATION","̹β","B1","4","180",
"STATION","��ɽ��","C2","4","180",
"STATION","����","D1","4","180",
"STATION","����","A1","4","180",
"STATION","���ݻ�վ","A1","4","180",
"STATION","С��","A1","4","180",
"STATION","�Խ�","A1","4","180",
"STATION","��ׯ","A1","4","180",
"STATION","����԰","A1","4","180",
"STATION","���","A1","4","180",
"STATION","����ߗ","A1","4","180",
"STATION","�齭�³�","A1","4","180",
"STATION","�Ե�","A1","4","180",
"STATION","̶��","A1","4","180",
"STATION","Ա��","A1","4","180",
"STATION","����·","A1","4","180",
"STATION","������","A1","4","180",
"STATION","����","A1","4","180",
"STATION","��Ϫ","A1","4","180",
"STATION","����","A1","4","180",
"STATION","��ɳ��","A1","4","180",
"STATION","��ɳ��","A1","4","180",
"STATION","�ĳ�","A1","4","180",


"CITY","�Ͼ�","CB","4","180",
"SUBWAY","1����","�Ͼ�","4","180",
"TIME_FORWORD","25200","240","4","0",
"TIME_BACKWORD","27000","240","4","0",
"STATION","������վ","C3","4","120",                 
"STATION","�����Ҿ߸�","C4","4","180",               
"STATION","��ɽ����԰վ","C5","4","180",             
"STATION","�Ͼ�վվ","A6","5","120",                 
"STATION","��ģ����·վ","87","5","120",             
"STATION","������վ","88","4","180",                 
"STATION","��¥վ","89","4","60",                    
"STATION","�齭·վ","8A","4","120",                 
"STATION","�½ֿ�վ","8B","3","120",                 
"STATION","�Ÿ�԰վ","8C","4","120",                 
"STATION","��ɽ��վ","8D","4","120",                 
"STATION","�л���վ","7E","5","180",                 
"STATION","������վ","7F","4","180",                 
"STATION","С��","7G","6","120",                     
"STATION","��ʤ·վ","6G","2","120",                 
"STATION","Ԫͨվ","4G","3","120",                   
"STATION","��������վ","3F","8","120",               



"SUBWAY","1���ӳ���","�Ͼ�","4","180",
"TIME_FORWORD","25200","320","4","0",
"TIME_BACKWORD","27000","320","4","0",
"STATION","������վ","7F","4","180",
"STATION","��¡��վ","8G","4","180",
"STATION","������վ","9H","4","180",
"STATION","������վ","AI","4","180",
"STATION","�����Ͼ���վ","AJ","8","180",
"STATION","˫�����վ","BK","3","180",
"STATION","ʤ̫·վ","CL","6","180",
"STATION","�ټҺ�վ","DL","2","180",
"STATION","С����վ","EL","6","180",
"STATION","��ɽ·վ","FL","2","180",
"STATION","��ӡ���վ","GL","6","180",
"STATION","���ߴ��վ","HL","4","180",
"STATION","��ҽ��ѧԺվ","HM","4","180",
"STATION","�Ͼ���Ժվ","HN","4","180",
"STATION","�й�ҩ�ƴ�ѧվ","HO","4","180",

"SUBWAY","2����","�Ͼ�","4","180",
"TIME_FORWORD","25200","360","4","0",
"TIME_BACKWORD","27000","360","4","0",
"STATION","�ͷ���վ","3I","4","180",
"STATION","������վ","4H","4","180",
"STATION","Ԫͨվ","4G","3","180",
"STATION","���嶫վ","4E","4","180",
"STATION","��¡���վ","4D","4","180",
"STATION","�����Ŵ��վ","4C","4","180",
"STATION","�ƽ�·վ","4B","2","180",
"STATION","Ī���վ","5B","6","180",
"STATION","������վ","6B","2","180",
"STATION","�Ϻ�·վ","7B","6","180",
"STATION","�½ֿ�վ","8B","3","180",
"STATION","���й�վ","9B","6","180",
"STATION","������վ","AB","2","180",
"STATION","���ʹ�վ","BB","6","180",
"STATION","��ޣ԰վ","CB","2","180",
"STATION","����վ","DB","6","180",
"STATION","Т����վ","EB","2","180",
"STATION","�����վ","FB","5","180",
"STATION","��Ⱥվ","GA","5","180",
"STATION","����·վ","I9","5","180",
"STATION","�ɺ���վ","J8","5","180",
"STATION","ѧ��·վ","K8","5","180",
"STATION","��������վ","L7","5","180",
"STATION","��ɽ��԰վ","N6","4","180",
"STATION","�ϴ�����У��վ","M5","4","180",
"STATION","����·վ","N4","8","180",

"GT","���ϸ���","BB","4","180",
"SUBWAY","��������","�Ͼ�","4","180",
"STATION","�Ϸ���","52","6","180",
"STATION","�Ͼ���","72","2","180",
"STATION","�Ͼ���","92","2","180",
"STATION","�Ͼ���","D2","2","180",

"GT","��������","CB","4","180",
"SUBWAY","��������","�Ϻ�","4","180",
"STATION","�Ͼ�","43","2","180",
"STATION","����","53","6","180",
"STATION","����ɽ","63","2","180",
"STATION","��","72","3","180",
"STATION","��ͽ","83","3","180",
"STATION","����","94","3","180",
"STATION","����","B5","3","180",
"STATION","������","E6","3","180",
"STATION","��ɽ","G7","6","180",
"STATION","����","H7","2","180",
"STATION","��������","I7","3","180",
"STATION","��������","K8","7","180",
"STATION","����","L8","3","180",
"STATION","����԰��","M9","4","180",
"STATION","���κ�","NA","4","180",
"STATION","��ɽ��","NB","4","180",
"STATION","����","OC","4","180",
"STATION","��ͤ��","PD","4","180",
"STATION","���豱","PE","4","180",
"STATION","�Ϻ���","PF","4","180",
"STATION","�Ϻ�","QG","4","180",
"STATION","����·","QH","4","180",

"CITY","��³ľ��","03","4","180",
"SUBWAY","1����","��³ľ��","4","180",
"STATION","��³ľ��","00","4","180",

"CITY","����","39","4","180",
"SUBWAY","1����","����","4","180",
"STATION","����","00","4","180",

"CITY","�ɶ�","4C","4","180",
"SUBWAY","1����","�ɶ�","4","180",
"STATION","�ɶ�","00","4","180",

"CITY","����","3F","4","180",
"SUBWAY","1����","","4","180",
"STATION","--","00","4","180",

"CITY","����","5E","4","180",
"SUBWAY","1����","","4","180",
"STATION","--","00","4","180",

"CITY","����","6H","4","180",
"SUBWAY","1����","","4","180",
"STATION","--","00","4","180",

"CITY","����","7A","4","180",
"SUBWAY","1����","","4","180",
"STATION","--","00","4","180",

"CITY","����","7I","4","180",
"SUBWAY","1����","","4","180",
"STATION","--","00","4","180",

"CITY","���ͺ���","86","4","180",
"SUBWAY","1����","","4","180",
"STATION","--","00","4","180",

"CITY","֣��","9A","4","180",
"SUBWAY","1����","","4","180",
"STATION","--","00","4","180",

"CITY","�人","9C","4","180",
"SUBWAY","1����","","4","180",
"STATION","--","00","4","180",

"CITY","��ɳ","9E","4","180",
"SUBWAY","1����","","4","180",
"STATION","--","00","4","180",

"CITY","ʯ��ׯ","A8","4","180",
"SUBWAY","1����","","4","180",
"STATION","--","00","4","180",

"CITY","�Ϸ�","BB","4","180",
"SUBWAY","1����","","4","180",
"STATION","--","00","4","180",

"CITY","���","C7","4","180",
"SUBWAY","1����","","4","180",
"STATION","--","00","4","180",

"CITY","����","C9","4","180",
"SUBWAY","1����","","4","180",
"STATION","--","00","4","180",

"CITY","����","F4","4","180",
"SUBWAY","1����","","4","180",
"STATION","--","00","4","180",

"CITY","����","E5","4","180",
"SUBWAY","1����","","4","180",
"STATION","--","00","4","180",

"CITY","������","G3","4","180",
"SUBWAY","1����","","4","180",
"STATION","--","00","4","180",

"CITY","���","AH","4","180",
"SUBWAY","1����","","4","180",
"STATION","--","00","4","180",
"END","Gameover","","4","0"
};

//����
static int m_x=0,m_y = 0;            // �����ƫ����
static int m_ox=0,m_oy = 0;            // �����ƫ����

static double m_ozoom = 0;  // ����ķŴ���ƫ����
static double m_zoom  = 0.25;           //�Ŵ���
static Graphics g = null;
static Font m_font =null;
static Font m_font_s =null;
static Font m_font_b =null;
static Ccity m_act_city = null;
static Cstation m_act_station = null;
static class CCell 
{
   String m_position="AAAA";//λ����Ϣ;
    int   m_textpos=0;;//λ����Ϣ;

         // 1,2,3,4,5        zoom ����
        // 5,7,8.9.10       zoom ������
        // 11,12,13.14.15   zoom ����     

   int m_index=0; //���
   int m_rote=0;
   int m_color=Color.RED;     
   int m_x1=0;
   int m_x2=0;
   int m_y1=0;
   int m_y2=0;
   double m_magic=1;//������ķŴ�ϵ��
   
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

//����վ
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

//��·
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
           
            if ((i> 0)) //��ʾ��·
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
            if (l_cycle >= l_sta.m_runtime) //ʱ����Խ��ǰ��վ
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
            if (l_cycle >= l_sta.m_runtime) //ʱ����Խ��ǰ��վ
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

//����
static class Ccity extends CCell
{
    String m_cityname = "city";

    Vector m_lines = new Vector();
    boolean m_GT = false;
    public void draw(Graphics graphics ,int type)
    {  
        graphics.setColor(m_color);                
        if ( !m_GT )//��ʾ��������
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
       if (l_city.m_cityname == m_city ) //��ʾ����
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
         menu.add(new MenuItem("����" , 100, 10){
            public void run()
                { 
                    Dialog.alert("����ʱ�� V1.0 \n ����:������ \n   2010.07");
                 }});               
         menu.addSeparator();    
         menu.add(new MenuItem("��ɫ��" , 100, 10){
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
