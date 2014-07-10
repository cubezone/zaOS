// ZaMidi.h: interface for the ZaMidi class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_ZAMIDI_H__D7A788BC_C62B_4D24_97FC_2D027AA66CE8__INCLUDED_)
#define AFX_ZAMIDI_H__D7A788BC_C62B_4D24_97FC_2D027AA66CE8__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include <vector>
#include <string>
#include <sys/stat.h>
#include <sys/types.h>
#define  uint unsigned int 
using namespace std;
class ZaMidiEvent
{ 
public:
	ZaMidiEvent()
	{
	len = 0;
	time = 0;
	dela_time = 0;
	chnl = 0;
	event = 0;
	note = 0;
	};
  	    uint  dela_time;
		uint b;
		uint event;
		uint sub_event;
		uint sub_value;
		uint note;
		uint force;
		uint time;		
		uint len;
		string  text;
		string  subtext;
		uint chnl;		
		bool m_blackkey;
		void dump(int idx)
		{
			fprintf(stderr,"\n%d  time%7d  len%5d chl:%3d  event:%5d  note:%4d",idx,time,len,chnl,event,note);
		}
};

class ZaMidi  
{
public:
	ZaMidi();
	int m_sp;
	int m_querttime;
	int m_totaltime;
	int m_zoom;
	int m_speed;
	int m_cur;
	int m_curtime;
	bool m_stop;
	void Decode_Midi(char * filename);
	void Decode_Midi_Event(char * filename);
	void Decode_midi_Mthd(char * hd);
	void MIDI_decode_Mtrk(char * mtrk,int len);
	ZaMidiEvent * getNext(int time);
	void Cal_Event_Len();	
	void Merge_all();
	void Zoom();
	void play_note(int n,int len);
	void dump();

	typedef std::vector <ZaMidiEvent *> s_track;
	
	s_track m_megeall ;
	s_track * m_trkarray;
	std::vector <s_track *> m_midi;
	
	virtual ~ZaMidi();

};

#endif // !defined(AFX_ZAMIDI_H__D7A788BC_C62B_4D24_97FC_2D027AA66CE8__INCLUDED_)

