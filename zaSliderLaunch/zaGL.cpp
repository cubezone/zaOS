/*
 * zaGL.cpp
 *
 *  Created on: 2012-2-10
 *      Author: zhuxy
 */
#include "zaGL.h"

namespace bbcubezone {

zaGL::zaGL() {
	// TODO Auto-generated constructor stub
}

zaGL::~zaGL() {
	// TODO Auto-generated destructor stub
}

int zaGL::init()
{
	initBG();
	InitEvent();
	return 0;
}

int zaGL::initBG()
{
	screen_create_context(&screen_ctx, 0);
	bps_initialize();
	if (BPS_SUCCESS != navigator_request_events(0)) {
		fprintf(stderr, "navigator_request_events failed\n");
		bbutil_terminate();
		screen_destroy_context(screen_ctx);
		return 0;
	}

	if (BPS_SUCCESS != virtualkeyboard_request_events(0)) {
		fprintf(stderr, "navigator_request_events failed\n");
		bbutil_terminate();
		screen_destroy_context(screen_ctx);
		return 0;
	}

	if (EXIT_SUCCESS != bbutil_init_egl(screen_ctx, GL_ES_1))
	{
		fprintf(stderr, "bbutil_init_egl failed\n");
		bbutil_terminate();
		screen_destroy_context(screen_ctx);
		return 0;
	}
	//Initialize app data

	//Query width and height of the window surface created by utility code
	eglQuerySurface(egl_disp, egl_surf, EGL_WIDTH, &surface_width);
	eglQuerySurface(egl_disp, egl_surf, EGL_HEIGHT, &surface_height);

	EGLint err = eglGetError();
		if (err != 0x3000) {
			fprintf(stderr, "Unable to query EGL surface dimensions\n");
			return EXIT_FAILURE;
		}

	fprintf(stderr,"screen %d %d\n",surface_width, surface_height);
	if (surface_height < 768)
	{
		bbutil_rotate_screen_surface(270);
		eglQuerySurface(egl_disp, egl_surf, EGL_WIDTH, &surface_width);
		eglQuerySurface(egl_disp, egl_surf, EGL_HEIGHT, &surface_height);
	}

	width = (float) surface_width;
	height = (float) surface_height;

	//Initialize GL for 2D rendering
	glViewport(0, 0, (int) width, (int) height);

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();

	glOrthof(0.0f, width / height, 0.0f, 1.0f, -1.0f, 1.0f);

	//float size = 0.01f*(float)Math.tan(Math.toRadians(45.0)/2);
//		float size = 0.01;
//		float ratio = width/height;
//		glFrustumf(-size, size, -size / ratio, size / ratio, 0.01f, 100.0f);

	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	//Set world coordinates to coincide with screen pixels
	glScalef(1.0f / height, 1.0f / height, 1.0f);

	return EXIT_SUCCESS;
}


int zaGL::InitEvent()
{
	//Signal BPS library that navigator and screen events will be requested
	if (BPS_SUCCESS != screen_request_events(screen_ctx)) {
		fprintf(stderr, "screen_request_events failed\n");
		bbutil_terminate();
		screen_destroy_context(screen_ctx);
		return 0;
	}
	return EXIT_SUCCESS;
}

void zaGL::DrawR()
{
	GLfloat PII=3.141592f;

	glEnableClientState(GL_VERTEX_ARRAY);
	glColor4f(1.0f, 0.6f, 0.3f, 1.0f);
	glLineWidth(2.0f);
	GLfloat v[200];

	for (GLfloat angle = 0.0f; angle <= 2*PII ; angle += 0.01f )
	{
		glPushMatrix();
		v[1]  = 1.0f*sin(angle);
		v[0]  = 1.0f*cos(angle);

		v[2] = 0.0f;
		v[3]=  0.0f;

		glVertexPointer(2, GL_FLOAT, 0, v);
		glTranslatef(500.0f, 500.0f, 0.0f);
		glScalef(40.0f, 60.0f, 1.0f);
		glRotatef(45.0f,0.0f,0.0f,1.0f);
		glDrawArrays(GL_LINES, 0, 2);

		glPopMatrix();
	}
	glDisableClientState(GL_VERTEX_ARRAY);
}


} /* namespace bbcubezone */
