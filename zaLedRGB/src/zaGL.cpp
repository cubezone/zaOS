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
 m_color = 0;
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

	if (EXIT_SUCCESS != bbutil_init_egl(screen_cxt)) {
		fprintf(stderr, "bbutil_init_egl failed\n");
		bbutil_terminate();
		screen_destroy_context(screen_cxt);
		return 0;
	}

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

int zaGL::render()
{
	return 0;
}


int zaGL::InitEvent()
{
	//Signal BPS library that navigator and screen events will be requested
	if (BPS_SUCCESS != screen_request_events(screen_cxt)) {
		fprintf(stderr, "screen_request_events failed\n");
		bbutil_terminate();
		screen_destroy_context(screen_cxt);
		return 0;
	}else if (BPS_SUCCESS != led_request_events(0)) {
		fprintf(stderr, "led_request_events failed\n");
				bbutil_terminate();
				screen_destroy_context(screen_cxt);
				return 0;
	}
	return EXIT_SUCCESS;
}


int zaGL::start()
{
	InitEvent();

	for(;;) {
			bps_event_t *event = NULL;
			bps_get_event(&event, 0);

			if (event) {
				int domain = bps_event_get_domain(event);

				if (domain ==  screen_get_domain()) {
					handleScreenEvent(event);
				}else if  (domain ==  led_get_domain()) {
					bool l_red,l_green,l_blue;
					led_event_get_rgb(event,&l_red,&l_green,&l_blue);

				}
			}
			glClear(GL_COLOR_BUFFER_BIT);

			if (m_color %5 == 0)
				glClearColor(1.0f, 0.0f, 0.0f, 1.0f);
			else if (m_color %5 == 1)
				glClearColor(0.0f, 1.0f, 0.0f, 1.0f);
			else if (m_color %5 == 2)
				glClearColor(0.0f, 0.0f, 1.0f, 1.0f);
			else if (m_color %5 == 3)
				glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
			else if (m_color %5 == 4)
				glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
			glFlush();

			bbutil_swap();
	}
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
		if (screen_val == SCREEN_EVENT_MTOUCH_RELEASE) {
			//This is touch screen event.
			soundplayer_play_sound("input_keypress");
			m_color ++;

		} else if (screen_val == SCREEN_EVENT_POINTER) {
			//This is a mouse move event, it is applicable to a device with a usb mouse or simulator
			screen_get_event_property_iv(screen_event, SCREEN_PROPERTY_BUTTONS,
					&buttons);

			if (buttons == SCREEN_LEFT_MOUSE_BUTTON) {
				//Left mouse button is pressed
				mouse_pressed = true;
			} else {
				if (mouse_pressed) {
				    soundplayer_play_sound("input_keypress");
					//Left mouse button was released, add a cube
					m_color ++;
					mouse_pressed = false;
				}
			}
		}
		led_cancel("led");

		if (m_color %5 == 0)
				led_request_color("led", LED_COLOR_RED,0);
		else if (m_color %5 == 1)
				led_request_color("led",LED_COLOR_GREEN,0);
		else if (m_color %5 == 2)
				led_request_color("led",LED_COLOR_BLUE,0);
		else if (m_color %5 == 3)
				led_cancel("led");
		else if (m_color %5 == 4)
				led_request_color("led",LED_COLOR_WHITE,0);
}

} /* namespace bbcubezone */
