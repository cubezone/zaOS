/*
 * zaGL.h
 *
 *  Created on: 2012-2-10
 *      Author: zhuxy
 */
#include <bps/screen.h>
#include <bps/bps.h>
#include <bps/event.h>
#include <bps/soundplayer.h>
#include <bps/deviceinfo.h>
#include <bps/navigator.h>
#include <bps/virtualkeyboard.h>
#include <sys/keycodes.h>
#include <screen/screen.h>
#include <EGL/egl.h>
#include <GLES/gl.h>
#include <stdlib.h>
#include <math.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <Vector>
#include "bbutil.h"


#include "Exception.h"
#include "ZaMp3.h"
#include "ZAImage.h"
#include "zaFont.h"
#include "unzip.h"
#include "miniz.h"

#include "zaXML.h"
#include "zaMySQL.h"

#ifndef ZAGL_H_
#define ZAGL_H_

using namespace std;

namespace bbcubezone {
class zaGL {
public:
	zaGL();
	virtual ~zaGL();

	int init();
	int initBG();
	int InitEvent();

	void DrawR();
	EGLint surface_width, surface_height;
	screen_context_t m_ctx;
//	GLfloat tex_x ,tex_y;

	float width, height, angle;


};

} /* namespace bbcubezone */
#endif /* ZAGL_H_ */
