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
"GT","��������","00",
"SUBWAY","��������","�Ϻ�",
"STATION","�Ͼ�","D8",
"STATION","����","E2",
"STATION","����ɽ","E3",
"STATION","��","E4",
"STATION","��ͽ","E5",
"STATION","����","E6",
"STATION","����","E7",
"STATION","������","E8",
"STATION","��ɽ","E9",
"STATION","����","EA",
"STATION","��������","EB",
"STATION","��������","EC",
"STATION","����","ED",
"STATION","����԰��","EE",
"STATION","���κ�","EF",
"STATION","��ɽ��","EG",
"STATION","����","EH",
"STATION","��ͤ��","EI",
"STATION","���豱","EJ",
"STATION","�Ϻ���","EK",
"STATION","�Ϻ�","GF",
"STATION","����·","EM",

"CITY","�Ϻ�","GF",
"SUBWAY","1����","�Ϻ�",
"STATION","ݷׯ","C1",
"STATION","�⻷·","C2",
"STATION","����·","C3",
"STATION","������԰","C4",
"STATION","�Ϻ���վ","C5",
"STATION","�·","C6",
"STATION","�Ϻ�������","C7",
"STATION","��һ�","C8",
"STATION","��ɽ·","C9",
"STATION","����·","CA",
"STATION","������·","CB",
"STATION","������·","CC",
"STATION","����㳡","CD",
"STATION","��բ·","CE",
"STATION","����·","CF",
"STATION","�Ϻ���վ","CG",
"STATION","��ɽ��·","CH",
"STATION","�ӳ�·","CI",
"STATION","�Ϻ���Ϸ��","CJ",
"STATION","��ˮ·","CK",
"STATION","�����´�","CL",
"STATION","����·","CM",
"STATION","ͨ���´�","CN",
"STATION","����·","CO",
"STATION","�����´�","CP",
"STATION","������·","CR",
"STATION","������·","CS",
"STATION","�� �� ·","CT",

"SUBWAY","2����","�Ϻ�",
"STATION","�ֶ����ʻ���","E1",
"STATION","������·","E2",
"STATION","Զ�����","E3",
"STATION","���·","E4",
"STATION","��ɳ","E5",
"STATION","���Ķ�·","E6",
"STATION","������·","E7",
"STATION","����","E8",
"STATION","����·","E9",
"STATION","վ��","EA",
"STATION","","EB",
"STATION","����·","EC",
"STATION","���·","ED",
"STATION","�Ž��߿�","EE",
"STATION","����·","EF",
"STATION","���͹�԰","EG",
"STATION","�Ϻ��Ƽ���","EH",
"STATION","���ʹ��","EI",
"STATION","����·","EJ",
"STATION","½����","EK",
"STATION","�Ͼ���·","EL",
"STATION","����㳡","EM",
"STATION","�Ͼ���·","EN",
"STATION","������","EO",
"STATION","����·","EP",
"STATION","��ɽ��԰","ER",
"STATION","¦ɽ��·","ES",
"STATION","����·","ET",
"STATION","������","EU",
"STATION","����·","EV",
"STATION","����2�ź�վ¥?","EW",
"STATION","���Ż�վ","EX",
"STATION","������","EY",

"SUBWAY","3����","�Ϻ�",
"STATION","�Ϻ���վ","F1",
"STATION","ʯ��·","F2",
"STATION","����·","F3",
"STATION","��Ϫ·","F4",
"STATION","��ɽ·","F5",
"STATION","����·","F6",
"STATION","�Ӱ���·","F7",
"STATION","��ɽ��԰","F8",
"STATION","��ɳ��·","F9",
"STATION","����·","FA",
"STATION","��ƺ·","FB",
"STATION","��̶·","FC",
"STATION","�Ϻ�վ","FD",
"STATION","��ɽ·","FE",
"STATION","������·","FF",
"STATION","�������","FG",
"STATION","���·","FH",
"STATION","�����","FI",
"STATION","������","FJ",
"STATION","�����·","FK",
"STATION","������·","FL",
"STATION","����·","FM",
"STATION","�Ż��","FN",
"STATION","����·","FO",
"STATION","ˮ��·","FP",
"STATION","����·","FR",
"STATION","����·","FS",
"STATION","����·","FT",
"STATION","���·","FU",

"SUBWAY","4����","�Ϻ�",
"STATION","��ɽ·","H1",
"STATION","�Ϻ�������","H2",
"STATION","�Ϻ�������","H3",
"STATION","����·","H4",
"STATION","��ľ��·","H5",
"STATION","³��·","H6",
"STATION","������·","H7",
"STATION","���ִ���","H8",
"STATION","����","H9",
"STATION","����·","HA",
"STATION","�ֵ�·","HB",
"STATION","���ʹ��","HC",
"STATION","�ֶ����","HD",
"STATION","������·","HE",
"STATION","����·","HF",
"STATION","��ƽ·","HG",
"STATION","����·","HH",
"STATION","��ɽ·","HI",
"STATION","�Ϻ���վ","HJ",
"STATION","��̶·","HK",
"STATION","��ƺ·","HL",
"STATION","����·","HM",
"STATION","��ɳ��·","HN",
"STATION","��ɽ��԰","HO",
"STATION","�Ӱ���·","HP",
"STATION","����·","HR",

"SUBWAY","5����","�Ϻ�",
"STATION","ݷׯ","J1",
"STATION","����·","J2",
"STATION","����·","J3",
"STATION","���","J4",
"STATION","����","J5",
"STATION","����·","J6",
"STATION","����·","J7",
"STATION","��ƽ·","J8",
"STATION","����·","J9",
"STATION","�ľ�·","JA",
"STATION","���п�����","JB",


"SUBWAY","6����","�Ϻ�",
"STATION","�۳�·","K1",
"STATION","����ű�˰����","K2",
"STATION","����·","K3",
"STATION","����ű�˰����","K4",
"STATION","�޺�·","K5",
"STATION","���޴��","K6",
"STATION","����·","K7",
"STATION","�޷�·","K8",
"STATION","����·","K9",
"STATION","����·","KA",
"STATION","����·","KB",
"STATION","��ɽ·","KC",
"STATION","��ƽ·","KD",
"STATION","������·","KE",
"STATION","����·","KF",
"STATION","Դ����������","KG",
"STATION","���ʹ��","KH",
"STATION","�ֵ�·","KI",
"STATION","����·","KJ",
"STATION","�Ϻ���ͯҽѧ����","KK",
"STATION","�����´�","KL",
"STATION","�߿���·","KM",
"STATION","����·","KN",
"STATION","����·","KO",
"STATION","������·","KP",
"STATION","����·","KR",
"STATION","������·","KS",
"STATION","����·��δ���ã�","KT",

"SUBWAY","7����","�Ϻ�",
"STATION","��ľ·","L1",
"STATION","����·","L2",
"STATION","����·","L3",
"STATION","����·","L4",
"STATION","�����·","L5",
"STATION","�߿���·","L6",
"STATION","��̨·","L7",
"STATION","ҫ��·","L8",
"STATION","����·","L9",
"STATION","��̲","LA",
"STATION","����·","LB",
"STATION","����·","LC",
"STATION","�ؼ��·","LD",
"STATION","����·","LE",
"STATION","������","LF",
"STATION","��ƽ·","LG",
"STATION","����·","LH",
"STATION","��ƺ·","LI",
"STATION","᰸�·","LJ",
"STATION","�´�·","LK",
"STATION","����·","LL",
"STATION","��֪·","LM",
"STATION","����","LN",
"STATION","����·","LO",
"STATION","�ϴ�·","LP",
"STATION","�ϳ�·","LR",
"STATION","�Ϻ���ѧ","LS",

"SUBWAY","8����","�Ϻ�",
"STATION","���첩���","M1",
"STATION","����·","M2",
"STATION","����·","M3",
"STATION","�ֽ���","M4",
"STATION","«��·","M5",
"STATION","�����´�","M6",
"STATION","����·��δ���ã�","M7",
"STATION","��˼","M8",
"STATION","��ɽ·","M9",
"STATION","ҫ��·","MA",
"STATION","�ܼҶɣ�δ���ã�","MB",
"STATION","������·","MC",
"STATION","½���·","MD",
"STATION","������","ME",
"STATION","������","MF",
"STATION","����㳡","MG",
"STATION","����·","MH",
"STATION","����·","MI",
"STATION","���ر�·","MJ",
"STATION","�������","MK",
"STATION","����·","ML",
"STATION","��ƽ·","MM",
"STATION","��ɽ�´�","MN",
"STATION","����·","MO",
"STATION","����·","MP",
"STATION","�Ӽ���·","MR",
"STATION","���˹�԰","MS",
"STATION","����·","MT",
"STATION","�۽�·","MU",
"STATION","�й�·","MV",

"SUBWAY","9����","�Ϻ�",
"STATION","�����·","O1",
"STATION","���ʹ��","O2",
"STATION","�̳�·","O3",
"STATION","С����","O4",
"STATION","½���","O5",
"STATION","��·","O6",
"STATION","������","O7",
"STATION","����·","O8",
"STATION","�ؼ��·","O9",
"STATION","��һ�","OA",
"STATION","��ɽ·","OB",
"STATION","����·","OC",
"STATION","�����������","OD",
"STATION","�ϴ�·","OE",
"STATION","����·","OF",
"STATION","�߱�","OG",
"STATION","�д�·","OH",
"STATION","��ͤ","OI",
"STATION","����","OJ",
"STATION","��ɽ","OK",
"STATION","����","OL",
"STATION","�ɽ���ѧ��","OM",
"STATION","�ɽ��³�","ON",

"SUBWAY","11����","�Ϻ�",
"STATION","����·","P1",
"STATION","¡��·","P2",
"STATION","����·","P3",
"STATION","����·","P4",
"STATION","����","P5",
"STATION","�Ϻ���վ","P6",
"STATION","����԰","P7",
"STATION","����ɽ·","P8",
"STATION","����·","P9",
"STATION","�����´�","PA",
"STATION","����","PB",
"STATION","��½","PC",
"STATION","�ζ��³�","PD",
"STATION","����·","PE",
"STATION","�ζ���","PF",
"STATION","�ζ���","PG",
"STATION","�Ϻ�������","PH",
"STATION","������·(δ����)","PI",
"STATION","�Ϻ�������","PJ",
"STATION","��ͤ","PK",
    
"CITY","����","B4",
"SUBWAY","1����","����",
"STATION","ƻ��԰","1J",
"STATION","�ų�·","2K",
"STATION","�˽�����԰","3K",
"STATION","�˱�ɽ","4K",
"STATION","��Ȫ·","5K",
"STATION","�����","6K",
"STATION","����·","7K",
"STATION","������","8K",
"STATION","���²����","9K",
"STATION","ľ�ص�","BK",
"STATION","����ʿ·","CK",
"STATION","������","DK",
"STATION","����","EK",
"STATION","�찲����","GK",
"STATION","�찲�Ŷ�","HK",
"STATION","������","IK",
"STATION","����","KK",
"STATION","������","LK",
"STATION","������","MK",
"STATION","��ó","NK",
"STATION","����·","OK",
"STATION","�Ļ�","PK",
"STATION","�Ļݶ�","QK",

"SUBWAY","2����","����",
"STATION","��ֱ��","DF",
"STATION","����ׯ","DG",
"STATION","������","DH",
"STATION","������","DK",
"STATION","������","DL",
"STATION","������","EL",
"STATION","��ƽ��","FL",
"STATION","ǰ��","GL",
"STATION","������","JL",
"STATION","����վ","KL",
"STATION","������","LK",
"STATION","������","LI",
"STATION","������","LH",
"STATION","����ʮ��","LG",
"STATION","��ֱ��","LF",
"STATION","Ӻ�͹�","JE",
"STATION","������","IE",
"STATION","��¥���","FE",
"STATION","��ˮ̶","EE",
"STATION","��ֱ��","DF",

"SUBWAY","��ͨ��","����",
"STATION","�Ļ�","PK",
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

"CITY","����","KE",
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
"STATION","��ӿ���վ","E1",
"STATION","��ɽ","E1",
"STATION","��ʦ","E1",
"STATION","�ڶ�","E1",
"STATION","ʯ����","A1",
"STATION","������·","A1",
"STATION","�齭�³�","A1",
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

"CITY","�Ͼ�","D8",
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

//����
static int m_x=0,m_y = 0;            // �����ƫ����
static int m_ox=0,m_oy = 0;            // �����ƫ����
static int m_zoom_x = 0,m_zoom_y = 0;  // ����ķŴ���ƫ����
static double m_ozoom = 0;  // ����ķŴ���ƫ����
static double m_zoom  = 1;           //�Ŵ���
static int m_level   = 0 ;           //

static class CCell 
{
   String m_position="AA";//λ����Ϣ;
   String m_cityposition="00";//λ����Ϣ;

         // 1,2,3,4,5        zoom ����
        // 5,7,8.9.10       zoom ������
        // 11,12,13.14.15   zoom ����     

   int m_index=0;          //���
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

//����վ
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

//��·
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

//����
static class Ccity extends CCell
{
    String m_cityname = "city";
    Vector m_lines = new Vector();
    boolean m_GT = false;
    public void draw(Graphics graphics ,int type)
    {  
        graphics.setColor(m_color);        
        if (m_level ==0 && !m_GT )//��ʾ����
        {
            int l_x ,l_y;  
            int l_cir = Math.min(4,(int)(2*m_zoom));
            debug(graphics,"C",10,50);            
            l_x = get_x();
            l_y = get_y();
            graphics.fillArc(m_x+l_x,m_zoom_y +m_y+l_y, l_cir*2+1,l_cir*2+1,0,360);         
            graphics.drawText(m_cityname,m_x + l_x + 10,m_y + l_y + 10);    
       }
       if (m_level == 1 || m_GT)//������ʾ ��ʾ����
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
       
       if (m_level==0) //��ʾ����
            l_city.draw(graphics,type);
            
       if (m_level == 1)//��ʾ����
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
     //���ݵ�ǰ��Ļ3600*240�����ĵ����zoom;           
           
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
