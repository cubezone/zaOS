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
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "jpeglib.h"
#include "png.h"

#include <math.h>
#include "bbutil.h"

#ifndef ZAIMAGE_H_
#define ZAIMAGE_H_
#include <setjmp.h>
#include "ZaObj.h"
#include "png.h"

namespace bbcubezone {

struct my_error_mgr {
  struct jpeg_error_mgr pub;	/* "public" fields */

  jmp_buf setjmp_buffer;	/* for return to caller */
};

typedef struct my_error_mgr * my_error_ptr;

class ZAImage: public bbcubezone::ZaObj {
public:
	ZAImage();
	GLfloat tex_x ,tex_y;
	//float m_alpha;
	GLuint m_img;
	//float width, height;
	float angle;
	//int m_x,m_y;
	//float m_z;
	float m_d;
	bool m_stop;
	bool m_rotation;
	bool m_darkstyle;
	float m_trans;
	bool m_isRGBA;
	char m_filename[255];
	int DrawImg();
	int  DrawFrame();
	static int  DrawRect(int x, int y, int w , int h);
	static int  FillRect(int color,int x, int y, int w , int h,int tp);
	int RunImg();
	void reset();
	void Ran();
	int load_memory(const char* filename, int* width, int* height, float* tex_x, float* tex_y, unsigned int *tex);
	void write_JPEG_file (char * filename, int quality,int image_width,int image_height,JSAMPLE * image_buffer);

	int DrawImg(int x , int y,int r);
	void drawControl();
	void  LoadImg(const char * p,int w,int h);
	int Load_PNG_file(const char * p,int w,int h);
	int Load_PNG2_file(const char * p,int w,int h);
	int read_JPEG2_file (const char * filename,int w,int h);

	int LoadImgFromMemory(const char * p,int w,int h);

	int get_PNG_size(const char * filename,int & w,int& h);
	int get_JPEG_size(const char * filename,int & w,int& h);

	void getsize(const char * filename,int & w,int& h);
	void setrote(int r);
	virtual ~ZAImage();
	int m_type;
};
}
#endif /* ZAIMAGE_H_ */
