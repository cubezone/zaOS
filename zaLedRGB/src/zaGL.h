/*
 * zaGL.h
 *
 *  Created on: 2012-2-10
 *      Author: zhuxy
 */
#include <bps/screen.h>
#include <bps/bps.h>
#include <bps/event.h>
#include <bps/led.h>
#include <bps/soundplayer.h>
#include <bps/navigator.h>
#include <screen/screen.h>
#include <EGL/egl.h>
#include <GLES/gl.h>
#include <stdlib.h>
#include <math.h>
#include <Vector>
#include "bbutil.h"

#include "ZAImage.h"


#ifndef ZAGL_H_
#define ZAGL_H_


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
	GLuint m_img;
	float width, height, angle;
	screen_context_t screen_cxt;
	ZAImage m_img1;
	ZAImage m_img2;
	ZAImage m_img3;
	ZAImage m_img4;
	ZAImage m_bg;
	int m_color;
	void add_wind(float w,float h);
	void handleScreenEvent(bps_event_t *event) ;
	std::vector<ZAImage> m_v ;
};

} /* namespace bbcubezone */
#endif /* ZAGL_H_ */
