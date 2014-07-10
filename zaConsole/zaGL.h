/*
 * zaGL.h
 *
 *  Created on: 2012-2-10
 *      Author: zhuxy
 */

#include "zaAll.h"


#ifndef ZAGL_H_
#define ZAGL_H_

using namespace std;
namespace bbcubezone {

class zaGL {
public:
	zaGL();
	virtual ~zaGL();
	int m_id;
	int init();
	int start();
	int initBG();
	int DrawImg(int x , int y,int r);
	int LoadImg();
	int render();
	int InitEvent();
	void DrawR();

	GLfloat tex_x ,tex_y;
	ZaMp3 m_snd;
	clock_t m_time;
	int m_ox,m_oy,m_x,m_y;
	int m_len;
	int m_d;
	ZaMp3 m_snd_roll;
	float width, height, angle;
	screen_context_t screen_cxt;
	font_t* font;
	ZAImage m_img_exec;
	ZAImage m_img_view;
	ZAImage m_bg;
	zaDir m_dir;
	bool m_event;
	int m_ll;
	::zaWorker *m_worker ;
	void add_wind(float x,float y);
	void handleScreenEvent(bps_event_t *event) ;
	std::vector<zaObj *> m_v ;
};

} /* namespace bbcubezone */
#endif /* ZAGL_H_ */
