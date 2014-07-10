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
	m_worker = NULL;

}

zaGL::~zaGL() {
	// TODO Auto-generated destructor stub
}

int zaGL::init()
{
	screen_create_context(&screen_cxt, 0);
	bps_initialize();
	if (BPS_SUCCESS != navigator_request_events(0)) {
		fprintf(stderr, "navigator_request_events failed\n");

		screen_destroy_context(screen_cxt);
		return 0;
	}

	if (EXIT_SUCCESS != bbutil_init_egl(screen_cxt, GL_ES_1)) {
		fprintf(stderr, "bbutil_init_egl failed\n");
		bbutil_terminate();
		screen_destroy_context(screen_cxt);
		return 0;
	}

	zaFont l_font;
	this->font = l_font.font;
	this->m_img_exec.LoadImg("app/native/res/exec.png",48,48);
	this->m_img_exec.setposition(600,680);

	this->m_img_view.LoadImg("app/native/res/view.png",48,48);
	this->m_img_view.setposition(600,280);

	m_bg.LoadImg("app/native/res/bg3.png",768,1024);
	m_bg.setposition(512,300);

	return 0;
}

int zaGL::initBG()
{
		EGLint surface_width, surface_height;
		//Initialize app data
		int max_size = 60.0;

		//Query width and height of the window surface created by utility code
		eglQuerySurface(egl_disp, egl_surf, EGL_WIDTH, &surface_width);
		eglQuerySurface(egl_disp, egl_surf, EGL_HEIGHT, &surface_height);

		EGLint err = eglGetError();
		if (err != 0x3000) {
			fprintf(stderr, "Unable to query EGL surface dimensions\n");
			return EXIT_FAILURE;
		}

		bbutil_rotate_screen_surface(270);
		eglQuerySurface(egl_disp, egl_surf, EGL_WIDTH, &surface_width);
		eglQuerySurface(egl_disp, egl_surf, EGL_HEIGHT, &surface_height);

		width = (float) surface_width;
		height = (float) surface_height;

		//Initialize GL for 2D rendering
		glViewport(0, 0, (int) width, (int) height);

		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();

		glOrthof(0.0f, width / height, 0.0f, 1.0f, -1.0f, 1.0f);

		glMatrixMode(GL_MODELVIEW);
		glLoadIdentity();
		//Set world coordinates to coincide with screen pixels
		glScalef(1.0f / height, 1.0f / height, 1.0f);


		return EXIT_SUCCESS;
}



int zaGL::InitEvent()
{
	//Signal BPS library that navigator and screen events will be requested
	if (BPS_SUCCESS != screen_request_events(screen_cxt)) {
		fprintf(stderr, "screen_request_events failed\n");
		bbutil_terminate();
		screen_destroy_context(screen_cxt);
		return 0;
	}
	return EXIT_SUCCESS;
}


int zaGL::start()
{
		glClear(GL_COLOR_BUFFER_BIT);
		glClearColor(0.8f, 0.8f, 0.8f, 1.0f);


		m_dir.font = this->font;
		m_dir.dirlist();

	//	zaPicList *l_pic = new zaPicList();
	//	m_v.push_back(&m_dir);
		fprintf(stderr,"%s","ov2");
	InitEvent();
	for(;;) {
		for(;;) {
			bps_event_t *event = NULL;
			bps_get_event(&event, 0);
			if (event) {
				m_event = true;
				int domain = bps_event_get_domain(event);

				if (domain ==  screen_get_domain()) {
					handleScreenEvent(event);
				}
			}
			else
				break;
		}
		render();
	}
	return 0;
}

int zaGL::render()
{
	glClear(GL_COLOR_BUFFER_BIT);
	glClearColor(0.0f, 0.0f, 0.0f, 1.0f);

	//if (m_dir.render()==1)
	m_bg.RunImg();
	m_dir.render();
	if (m_dir.m_file)
	{
		m_img_exec.RunImg();
		m_img_view.RunImg();
	}

	bbutil_swap();
	return 0;
}


void zaGL::handleScreenEvent(bps_event_t *event)
{
		int screen_val, buttons;
		int pair[2];

		static bool mouse_pressed = false;

		screen_event_t screen_event = screen_event_get_event(event);

		//Query type of screen event and its location on the screen
		screen_get_event_property_iv(screen_event, SCREEN_PROPERTY_TYPE,
				&screen_val);
		screen_get_event_property_iv(screen_event, SCREEN_PROPERTY_SOURCE_POSITION,
				pair);

		//There is a difference between touch screen events and mouse events
		if (screen_val == SCREEN_EVENT_MTOUCH_TOUCH) {
			if (m_worker!= NULL){
				delete m_worker;
				m_worker = NULL;
			}
			m_worker = new ::zaWorker();
			m_worker->m_task = 0;
			m_worker->init(pair[0],pair[1]);
		}

		if (screen_val == SCREEN_EVENT_MTOUCH_MOVE) {

			if (m_worker)
			{
				m_worker->m_task = 1;
				m_worker->move(pair[0],pair[1]);
				m_dir.porcess(m_worker);
			}
		}

		if (screen_val == SCREEN_EVENT_MTOUCH_RELEASE) {
			//This is touch screen event.
			if (m_worker)
			{
				m_worker->m_task = 2;
				m_worker->move(pair[0],pair[1]);
				if (m_img_view.PtinIt(m_worker->m_x,m_worker->m_y))
						m_dir.ppopen();
				else if  (m_img_exec.PtinIt(m_worker->m_x,m_worker->m_y))
						m_dir.exec();
				else
					m_dir.porcess(m_worker);
			}
//			m_time -= clock();
//			if ( abs(m_len) < 20)
//			{
//				if (m_time < 700)
//				add_wind(pair[0],pair[1]);
//			}
//			else
//			{
//				if (m_time ==0)
//				{
//					if (m_len > 0)
//						m_d = 60;
//					else
//						m_d = -60;
//				}
//				else
//				{
//					m_d = m_len*10000/m_time;
//				}
//			}

		} else if (screen_val == SCREEN_EVENT_POINTER) {
			//This is a mouse move event, it is applicable to a device with a usb mouse or simulator
			screen_get_event_property_iv(screen_event, SCREEN_PROPERTY_BUTTONS,
					&buttons);

			if (buttons == SCREEN_LEFT_MOUSE_BUTTON) {
				//Left mouse button is pressed
				mouse_pressed = true;
			} else {
				if (mouse_pressed) {
					//Left mouse button was released, add a cube

					mouse_pressed = false;
				}
			}
		}
//		fprintf(stderr,"touch %d  -- %d %d -- %d %f \n",
//				screen_val,
//				pair[0],pair[1],
//				m_img_view.m_x,m_img_view.width );
}


void zaGL::add_wind(float x,float y)
{

}


void zaGL::DrawR()
{
	GLfloat PII=3.141592f;

	glEnableClientState(GL_VERTEX_ARRAY);
	glColor4f(1.0f, 0.6f, 0.3f, 1.0f);
	glLineWidth(2.0f);
	GLfloat v[200];
	int c=0;
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
