/*
 * zaFileNanage.cpp
 *
 *  Created on: 2012-2-10
 *      Author: zhuxy
 */

#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <math.h>
#include "zaApp.h"
//#include <QByteArray>
#include <bb/system/Clipboard>
#include <bb/system/InvokeAction>
#include <bb/system/InvokeRequest>
#include <bb/system/InvokeManager>
#include <bb/device/VibrationController>
#include <bb/device/Led>
#include <bb/device/CellularNetworkInfo>
#include <bb/device/CellularRadioInfo>
#include <bb/platform/Notification>

int screentest();
using namespace bb::system;
using namespace bb::device;
using namespace bb::platform;
int main()
{
	try
	{
//		VibrationController v;
//		v.start(100,1000);
//
//		Clipboard clipboard;
//		clipboard.clear();
//		clipboard.insert("text/html", "<b>clipboard Hello world</b>");
//		clipboard.insert("text/plain", "clipboard Hello world");


		Led led;
		led.setColor(LedColor::Blue);
		led.flash(10);

//		CellularRadioInfo cr;
//		if (cr.isPoweredOn())
//		{
//			fprintf(stderr,"power on");
//			CellularNetworkInfo cni;
//			cni.name();
//			QByteArray ba;
//			ba = cni.name().toLatin1();
//			fprintf(stderr,"\nname %s",ba.data());
//			ba = cni.mobileNetworkCode().toLatin1();
//			fprintf(stderr,"\nmobileNetworkCode %s",ba.data());
//		}
//		else
//			fprintf(stderr,"no power");

		bbcubezone::zaApp m_app;
		m_app.init();

//		Notification ntf;
//		ntf.clearEffectsForAll();
//		ntf.setTitle("title");
//		ntf.setBody("Body");
//		ntf.notify();

		m_app.run();
	}
	catch (CException &e)
	{
		fprintf(stderr,"%s",e.GetString());
	}
	return 0;
}

int screentest()
{
	int barwidth = 32;
	int i, j, pos = 0;

	screen_context_t screen_ctx;
	screen_create_context(&screen_ctx, SCREEN_APPLICATION_CONTEXT);

	screen_window_t screen_win;
	screen_create_window(&screen_win, screen_ctx);

	int usage = SCREEN_USAGE_NATIVE;
	screen_set_window_property_iv(screen_win, SCREEN_PROPERTY_USAGE, &usage);

	int rect[4] = { 0, 0 };
	screen_create_window_buffers(screen_win, 2);
	screen_get_window_property_iv(screen_win, SCREEN_PROPERTY_BUFFER_SIZE, rect+2);

	screen_pixmap_t screen_pix;
	screen_create_pixmap(&screen_pix, screen_ctx);

	int format = SCREEN_FORMAT_RGBA8888;
	screen_set_pixmap_property_iv(screen_pix, SCREEN_PROPERTY_FORMAT, &format);

	usage = SCREEN_USAGE_WRITE | SCREEN_USAGE_NATIVE;
	screen_set_pixmap_property_iv(screen_pix, SCREEN_PROPERTY_USAGE, &usage);

	int size[2] = { 100, 100 };
	screen_set_pixmap_property_iv(screen_pix, SCREEN_PROPERTY_BUFFER_SIZE, size);

	screen_buffer_t screen_pbuf;
	screen_create_pixmap_buffer(screen_pix);
	screen_get_pixmap_property_pv(screen_pix, SCREEN_PROPERTY_RENDER_BUFFERS, (void **)&screen_pbuf);

	unsigned char *ptr = NULL;
	screen_get_buffer_property_pv(screen_pbuf, SCREEN_PROPERTY_POINTER, (void **)&ptr);

	int stride = 0;
	screen_get_buffer_property_iv(screen_pbuf, SCREEN_PROPERTY_STRIDE, &stride);

	for (i = 0; i < size[1]; i++, ptr += stride) {
			for (j = 0; j < size[0]; j++) {
				ptr[j*4] = 0xa0;
				ptr[j*4+1] = 0xa0;
				ptr[j*4+2] = 0xa0;
				ptr[j*4+3] = ((j >= i && j <= size[1]-i) || (j <= i && j >= size[1]-i)) ? 0xff : 0;
			}
	}

	while (1) {
		screen_buffer_t screen_buf[2];
		screen_get_window_property_pv(screen_win, SCREEN_PROPERTY_RENDER_BUFFERS, (void **)screen_buf);

		int bg[] = { SCREEN_BLIT_COLOR, 0xffffff00, SCREEN_BLIT_END };
		screen_fill(screen_ctx, screen_buf[0], bg);
		for (int a = 0 ;a <200 ; a++)
			{
				int bar[] = {
					SCREEN_BLIT_COLOR, 0xff000000+a*20,
					SCREEN_BLIT_DESTINATION_X, 5 * a,
					SCREEN_BLIT_DESTINATION_Y, pos + a,
					SCREEN_BLIT_DESTINATION_HEIGHT, barwidth +50,
					SCREEN_BLIT_DESTINATION_WIDTH, 20,
					SCREEN_BLIT_END };

				screen_fill(screen_ctx, screen_buf[0], bar);
			}

		int hg[] = {
			SCREEN_BLIT_SOURCE_WIDTH, 100,
			SCREEN_BLIT_SOURCE_HEIGHT, 100,
			SCREEN_BLIT_DESTINATION_X, 10,
			SCREEN_BLIT_DESTINATION_Y, 10,
			SCREEN_BLIT_DESTINATION_WIDTH, 100,
			SCREEN_BLIT_DESTINATION_HEIGHT, 100,
			SCREEN_BLIT_TRANSPARENCY, SCREEN_TRANSPARENCY_SOURCE_OVER,
			SCREEN_BLIT_END
		};

		//screen_blit(screen_ctx, screen_buf[0], screen_pbuf, hg);

		screen_post_window(screen_win, screen_buf[0], 1, rect, 0);

		pos += 5;
		if ( pos > (rect[3] - barwidth + 1600)) {
			pos = -500;
		}
	}

	return EXIT_SUCCESS;
}
