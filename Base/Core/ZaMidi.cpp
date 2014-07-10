// ZaMidi.cpp: implementation of the ZaMidi class.
//
//////////////////////////////////////////////////////////////////////

#include "ZaMidi.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

ZaMidi::ZaMidi()
{
	m_totaltime = 0;
	m_cur = 0;
	m_curtime = 0;
	m_speed = 54;
	m_querttime = 0;
	m_sp = 0;
	m_zoom = 0;

}

void ZaMidi::play_note(int n, int len)
{

}

void ZaMidi::Decode_Midi(char * filename)
{
	for (int mm = 0; mm < m_midi.size(); mm++)
	{
		s_track *l_t = m_midi[mm];
		for (int i = 0; i < l_t->size(); i++)
			delete (*l_t)[i];
		delete l_t;
	}
	m_midi.clear();
	m_megeall.clear();

	Decode_Midi_Event(filename);
	Cal_Event_Len();
	Merge_all();
	Zoom();
	m_cur = 0;
}

void ZaMidi::Decode_Midi_Event(char * filename)
{
	struct stat l_st;

	stat(filename, &l_st);
	int l_size = l_st.st_size;

	if (l_size < 10)
		return;

	char * buf = (char *) malloc(l_size);
	FILE * fh = fopen(filename, "rb");
	int len = fread(buf, 1, l_size, fh);
	fclose(fh);
	if (len != l_size)
		return;

	char *p = buf;
	char hd[14];
	memcpy(hd, p, 14);
	p += 14;
	Decode_midi_Mthd(hd);

	m_midi.clear();

	while (buf + len - p > 0)
	{
		char ltk[5];
		if (buf + len - p > 4)
		{
			memcpy(ltk, p, 4);
			ltk[4] = 0;
			p += 4;
		}
		else
			return;

		string l_tk = ltk;
		if (l_tk != "MTrk")
			return;

		int a;
		if (buf + len - p > 4)
		{
			a = (unsigned char )*p;
			p++;
			a = a * 0x100 +  (unsigned char )*p;
			p++;
			a = a * 0x100 +  (unsigned char )*p;
			p++;
			a = a * 0x100 + (unsigned char ) *p;
			p++;
		}
		else
			return;

		char *tk = (char *) malloc(a);
		memcpy(tk, p, a);
		p += a;
		MIDI_decode_Mtrk(tk, a);
	}

	free(buf);
}

void ZaMidi::Zoom()
{
	float f = (float)0xFF / m_sp * this->m_querttime / 600000;
	for (int i = 0; i < m_megeall.size(); i++)
	{
		ZaMidiEvent * e = m_megeall[i];
		e->time *= f;
		m_totaltime = e->time;
		e->len *= f;
		e->dela_time *= f;

	}
}

void ZaMidi::Merge_all()
{
	m_megeall.clear();
	int lt = 0;
	ZaMidiEvent * t;

	if (m_midi.size() > 2)
	{
		if (m_midi[2]->size() == 0 || m_midi[1]->size() == 0)
		{
				for (int ss = 0; ss < m_midi[1]->size(); ss++)
						m_megeall.push_back(m_midi[1]->at(ss));
			return;
		}

		while (1)
		{
			while (m_midi[1]->at(0)->time <= m_midi[2]->at(0)->time)
			{
				t = *m_midi[1]->begin();
				m_midi[1]->erase(m_midi[1]->begin());
				t->dela_time = t->time - lt;
				lt = t->time;
				m_megeall.push_back(t);
				if (m_midi[1]->size() < 1)
				{
					for (int ss = 0; ss < m_midi[2]->size(); ss++)
						m_megeall.push_back(m_midi[2]->at(ss));
					return;
				}
			}
			while (m_midi[1]->at(0)->time > m_midi[2]->at(0)->time)
			{
				t = *m_midi[2]->begin();
				m_midi[2]->erase(m_midi[2]->begin());
				t->dela_time = t->time - lt;
				lt = t->time;
				m_megeall.push_back(t);
				if (m_midi[2]->size() < 1)
				{
					for (int ss = 0; ss < m_midi[1]->size(); ss++)
						m_megeall.push_back(m_midi[1]->at(ss));
					return;
				}
			}
		}
	}
	else if (m_midi.size() > 1)
			for (int ss = 0; ss < m_midi[1]->size(); ss++)
						m_megeall.push_back(m_midi[1]->at(ss));
	else if (m_midi.size() > 0)
			for (int ss = 0; ss < m_midi[0]->size(); ss++)
						m_megeall.push_back(m_midi[0]->at(ss));
}

ZaMidiEvent * ZaMidi::getNext(int time)
{
	if (m_cur < m_megeall.size() && m_megeall[m_cur]->time < time)
	{	
		ZaMidiEvent * e= m_megeall[m_cur];
		m_cur ++;
		return  e;
	}
	else
		return NULL;
}
void ZaMidi::Cal_Event_Len()
{
	s_track st;
	int l_time;

	for (int i = 0; i < m_midi.size(); i++)
	{
		m_trkarray = m_midi[i];
		l_time = 0;
		for (int n = 0; n < m_trkarray->size(); n++)
		{
			ZaMidiEvent * e = m_trkarray->at(n);
			int m = 0;

			int md = e->note % 12;
			if (md == 1 || md == 3 || md == 6 || md == 8 || md == 10)
				e->m_blackkey = true;

			e->chnl = i;

			if ((e->event & 0xF0) == 0x90)
			{
				l_time += e->dela_time;
				e->time = l_time;
				for (m = 0; m < st.size(); m++)
				{
					ZaMidiEvent * t = st[m];
					t->len += e->dela_time;
				}
				st.push_back(e);
			}
			else if ((e->event & 0xF0) == 0x80)
			{
				l_time += e->dela_time;
				e->time = l_time;

				int l_step = st.size();
				for (m = 0; m < l_step; m++)
				{
					ZaMidiEvent * t;
					//bb	t = st.shift() ;
					t = *st.begin();
					st.erase(st.begin());
					t->len += e->dela_time;
					if (t->note != e->note)
					{
						st.push_back(t);
					}
				}
			}
			else
			{
				l_time += e->dela_time;
				e->time = l_time;
				for (m = 0; m < st.size(); m++)
				{
					ZaMidiEvent *t = st[m];
					t->len += e->dela_time;
				}
			}

		}
	}
}

void ZaMidi::Decode_midi_Mthd(char * d)
{
	char * p = d;
	//d.readBytes(t,0,12);
	p += 12;
	//m_sp = d.readUnsignedByte()*256; 
	m_sp = (unsigned char )*p * 256;
	//m_sp += d.readUnsignedByte();
	m_sp += (unsigned char )*(p + 1);
	m_zoom = 1;
	m_speed = 54;
}

void ZaMidi::MIDI_decode_Mtrk(char * mtrk, int len)
{
	ZaMidiEvent * l_me;
	char * p = mtrk;
	int l_lastevent = 0xC0;

	m_trkarray = new s_track;
	m_midi.push_back(m_trkarray);

	while (mtrk + len - p > 0)
	{
		l_me = new ZaMidiEvent();
		int b;
		b = (unsigned char)*p;
		p++;
		//read dela time
		while (b >= 0x80)
		{
			l_me->dela_time = (l_me->dela_time + b - 0x80) * 128;
			b = (unsigned char)*p;
			p++;
		}
		l_me->dela_time += b;

		//read event
		l_me->event = (unsigned char)*p;
		p++;

		if (l_me->event < 0x80)
		{
			l_me->event = l_lastevent;
			//d.position --; //????
			p--;
		}
		else
			l_lastevent = l_me->event;

		if (l_me->event == 0xFF)
		{
			b = *p;
			p++;
			l_me->sub_event = b;
			if (b == 0x01) // ????
			{
				b = *p;
				p++;
				if (b > 0)
				{
					char t[255];
					memset(t, 0, 255);
					memcpy(t, p, b);
					p += b;
					//d.readBytes(t,0,b);
					l_me->text = t;
				}
			}
			else if (b == 0x03) //?????
			{
				b = *p;
				p++;
				if (b > 0)
				{
					char t[255];
					memset(t, 0, 255);
					memcpy(t, p, b);
					p += b;
					//d.readBytes(t,0,b);
					l_me->text = t;
				}
			}
			else if (b == 0x04) //?????
			{
				b = *p;
				p++;
				if (b > 0)
				{
					char t[255];
					memset(t, 0, 255);
					memcpy(t, p, b);
					p += b;
					//d.readBytes(t,0,b);
					l_me->subtext = t;
				}
			}
			else if (b == 0x58) //
			{
				b = *p;
				p++;
				if (b > 0)
				{
					char t[255];
					memset(t, 0, 255);
					memcpy(t, p, b);
					p += b;
					//d.readBytes(t,0,b);
					l_me->text = t;
				}
			}
			else if (b == 0x59) //
			{
				b = *p;
				p++;
				if (b > 0)
				{
					char t[255];
					memset(t, 0, 255);
					memcpy(t, p, b);
					p += b;
					//d.readBytes(t,0,b);
					l_me->text = t;
				}
			}
			else if (b == 0x51) // ???
			{
				b = *p;
				p++;
				if (b == 3)
				{
					m_querttime = 0;
					m_querttime = m_querttime + *p;
					p++;
					m_querttime = m_querttime * 256 + *p;
					p++;
					m_querttime = m_querttime * 256 + *p;
					p++;
				}
			}
			else if (b == 0x7F) // 
			{
				b = *p;
				p++;
				if (b > 0)
				{
//							var t:ByteArray = new ByteArray();
//							d.readBytes(t,0,b);			
					p += b;
				}
			}
			else if (b == 0x2F) //?????
			{
				b = *p;
				p++;
			}
			else if (b == 0x21) //
			{
				b = *p;
				p++;
				if (b > 0)
				{
					p += b;
				}
			}
		}
		else if ((l_me->event & 0xF0) == 0xA0)
		{

			b = *p;
			p++;
		}
		else if ((l_me->event & 0xF0) == 0xB0)
		{
			b = *p;
			p++;
			b = *p;
			p++;
		}
		else if ((l_me->event & 0xF0) == 0xC0)
		{
			b = *p;
			p++;
		}
		else if ((l_me->event & 0xF0) == 0xE0)
		{
			b = *p;
			p++;
			b = *p;
			p++;
		}
		else if ((l_me->event & 0xF0) == 0x90)
		{
			l_me->note = *p;
			p++;
			l_me->force = *p;
			p++;
			if (l_me->force == 0) // force =0 ,release key.
			{
				l_me->event &= 0x8F;
			}
		}
		else if ((l_me->event & 0xF0) == 0x80)
		{
			l_me->note = *p;
			p++;
			l_me->force = *p;
			p++;
		}
//		l_me->dump();
	//	fprintf(stderr,"\n%p %d %d  ",p , p - mtrk ,len);
		m_trkarray->push_back(l_me);
	}
}

void ZaMidi::dump()
{
/*	for (int mm = 0; mm < m_midi.size(); mm++)
	{
		s_track *l_t = m_midi[mm];
		for (int i = 0; i < l_t->size(); i++)
			 (*l_t)[i]->dump();
	}
*/
	for (int i = 0; i < m_megeall.size(); i++)
	{
		m_megeall[i]->dump(i);
	}
}

ZaMidi::~ZaMidi()
{
	for (int mm = 0; mm < m_midi.size(); mm++)
	{
		s_track *l_t = m_midi[mm];
		for (int i = 0; i < l_t->size(); i++)
			delete (*l_t)[i];
		delete l_t;
	}
	m_midi.clear();
	m_megeall.clear();
}
