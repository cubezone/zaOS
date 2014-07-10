/*
 * zaFont.h
 *
 *  Created on: 2012-2-19
 *      Author: zhuxy
 */

//#include "zaAll.h"

#ifndef ZAFONT_H_
#define ZAFONT_H_
#include <sys/types.h>
#include <ft2build.h>
#include <EGL/egl.h>
#include <screen/screen.h>
#include <sys/platform.h>
#include <GLES/gl.h>
#include <GLES/glext.h>
#include <map>
#include <iconv.h>
#include "zaOS/bbutil.h"
#include "Exception.h"

#include   <limits.h>


#include <ft2build.h>
#include FT_FREETYPE_H

#include "fontconfig/fontconfig.h"

struct font_t {
	unsigned int font_texture;
	float pt;
	float advance[1];
	float width[1];
	float height[1];
	float tex_x1[1];
	float tex_x2[1];
	float tex_y1[1];
	float tex_y2[1];
	float offset_x[1];
	float offset_y[1];
	int initialized;
};

class zaFont {
public:
	zaFont();
//	screen_context_t screen_cxt;

	font_t* font;

	int m_size;

	int m_max_x;
	int m_max_y;

	char m_charset[255];

	char m_path[255];

	int m_dpi;

	float m_r;
	float m_g;
	float m_b;
	float m_a;

	int clear();
	int fontconf(const char * charset);
	void initbyCharSet(const char * charset ,int size);
	void initbyPath(const char * path ,int size);
	int initFont(char * path);
	void render_text(const char * buf,int len, float x, float y,const char * decode );
	int render_text(const char * buf,int len, float x, float y,const char * decode ,int width );
	float render_text_one(font_t * font,int charcode, float x, float y);
	font_t *load_font(int charcode);
	void getcharsize(int charcode, int* x, int *y);
	int load_font(char * instr,int len);
	void changesize(int size);
	void setcolor(float r,float g,float b,float a);
	virtual ~zaFont();

	std::map<uint,font_t*> m_map;
};

#endif /* ZAFONT_H_ */
