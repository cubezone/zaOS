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
	m_event = false;
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

	this->m_img_boottime.LoadImg("app/native/res/boottime.png",400,600);
	this->m_img_boottime.setposition(200,300);

	//zaFont l_font;
	//l_font.init("/usr/fonts/font_repository/monotype/SlatePro.ttf",13);
	//this->font = l_font.font;

	// pb
//	this->m_bg.LoadImg("app/native/res/bg.png",1024,600);
//	this->m_bg.setposition(1024/2,600/2);
//	m_bg.m_alpha = 0.3f;

	// Z10
	this->m_bg.LoadImg("app/native/res/bg2.png",768,1280);
	this->m_bg.setposition(768/2,1280/2);
	m_bg.m_alpha = 0.3f;

	// Q10
//	this->m_bg.LoadImg("app/native/res/bg.png",720,720);
//	this->m_bg.setposition(720/2,720/2);
//	m_bg.m_alpha = 0.3f;

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
		glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
		glColor4f(1.0f, 1.0f, 1.0f, 1.0f);

		m_dir.dirlist();

		InitEvent();
		for(;;)
		{
			for(;;)
			{
				bps_event_t *event = NULL;
				bps_get_event(&event, 0);
				if (event) {

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

	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
	m_bg.RunImg();

	m_dir.render();

	//m_img_boottime.RunImg();

//	if (m_event)
//	{
//		ScreenShot();
//		this->m_img_boottime.Bmp2Jpg(
//		"/accounts/1000/shared/photos/ChargeInfo.bmp",
//		"/accounts/1000/shared/photos/ChargeInfo.jpeg",
//		768,1280
//		);
//		m_dir.exec();
//		m_event = false;
//	}
	bbutil_swap();

	return 0;
}

void zaGL::ScreenShot()
{
	     FILE*     pDummyFile;
	     FILE*     pWritingFile;
	     GLubyte* pPixelData;
		#define BMP_Header_Length 54

	     GLubyte   BMP_Header[BMP_Header_Length];
	     GLint     i, j;
	     GLint     PixelDataLength;
	     int WindowWidth = 768;
	     int WindowHeight  = 1280;

	     // ����������ݵ�ʵ�ʳ���
	     i =  WindowWidth * 4;    // �õ�ÿһ�е�������ݳ���
	    while( i%4 != 0 )       // ������ݣ�ֱ��i�ǵı���
	         ++i;                // �������и����㷨��
	                            // �������׷��ֱ�ۣ����ٶ�û��̫��Ҫ��
	     PixelDataLength = i * WindowHeight;

	     // �����ڴ�ʹ��ļ�
	     pPixelData = (GLubyte*)malloc(PixelDataLength);
	    if( pPixelData == 0 )
	        exit(0);

	    pDummyFile = fopen("app/native/res/dummy.bmp", "rb");
	    if( pDummyFile == 0 )
	        exit(0);

	     pWritingFile = fopen("/accounts/1000/shared/photos/ChargeInfo.bmp", "wb");
	    if( pWritingFile == 0 )
	        exit(0);

//	    //glReadBuffer(GL_FRONT);
	     // ��ȡ����
	    glColor4f(1.0f, 1.0f, 1.0f, 1.0f);

	     glPixelStorei(GL_UNPACK_ALIGNMENT, 4);
	     glReadPixels(0, 0, WindowWidth, WindowHeight,
	    		 GL_RGBA, GL_UNSIGNED_BYTE, pPixelData);

	     // ��dummy.bmp���ļ�ͷ����Ϊ���ļ����ļ�ͷ
	    fread(BMP_Header, sizeof(BMP_Header), 1, pDummyFile);
	    fwrite(BMP_Header, sizeof(BMP_Header), 1, pWritingFile);
	    fseek(pWritingFile, 0x0012, SEEK_SET);
	     i = WindowWidth;
	     j = WindowHeight;
	    fwrite(&i, sizeof(i), 1, pWritingFile);
	    fwrite(&j, sizeof(j), 1, pWritingFile);

	     // д���������
	    fseek(pWritingFile, 0, SEEK_END);
	    for (int m = 0 ; m < PixelDataLength -4; m += 4)
	    {
	    	int a = pPixelData[m];
	    	pPixelData[m]= pPixelData[m+2];
	    	pPixelData[m+2] = a;
	    }


//	    for (int m = 0 ; m < PixelDataLength -4; m += 4)
//	    {
//	    	int a = pPixelData[m]+pPixelData[m+1]
//	    	       +pPixelData[m+2];
//	    	pPixelData[m]= a/3;
//	    	pPixelData[m+1] = a/3;
//	    	pPixelData[m+2] = a/3;
//	    }


	    fwrite(pPixelData, PixelDataLength, 1, pWritingFile);

	     // �ͷ��ڴ�͹ر��ļ�
	    fclose(pDummyFile);
	    fclose(pWritingFile);
	    free(pPixelData);
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
				m_worker->move(pair[0],pair[1]);
				if(m_worker->m_x < 50 &&
			        m_worker->m_y < 50)
				{
					soundplayer_play_sound("input_keypress");
					m_event = true;

				}
				m_worker->m_task = 2;
			}
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
