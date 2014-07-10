/*
 * ZAImage.h
 *
 *  Created on: 2012-2-14
 *      Author: zhuxy
 */
#include <bps/screen.h>
#include <bps/bps.h>
#include <bps/event.h>
#include <bps/navigator.h>
#include <screen/screen.h>
#include <EGL/egl.h>
#include <GLES/gl.h>
#include <stdlib.h>
#include <math.h>
#include "bbutil.h"

#ifndef ZAIMAGE_H_
#define ZAIMAGE_H_

class ZAImage {
public:
	ZAImage();
	GLfloat tex_x ,tex_y;
	GLuint m_img;
	float width, height, angle;
	int m_x,m_y, m_r;
	float m_d;
	int DrawImg();
	int RunImg();
	void reset();
	int DrawImg(int x , int y,int r);
	int LoadImg(const char * p,int w,int h);
	void setposition(int x, int y);
	void setrote(int r);
	virtual ~ZAImage();
};

#endif /* ZAIMAGE_H_ */
