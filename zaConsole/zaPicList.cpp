/*
 * zaPicList.cpp
 *
 *  Created on: 2012-2-19
 *      Author: zhuxy
 */

#include "zaPicList.h"

zaPicList::zaPicList() {
	// TODO Auto-generated constructor stub

	ZAImage *l_img = new ZAImage();
	l_img->LoadImg("app/native/icon.png",0,0);
	l_img->setposition(500,300);
	l_img->stop();
	m_v.push_back(*l_img);

}

void zaPicList::addPic() {
	std::vector<ZAImage>::iterator iter;
	for (iter = m_v.begin(); iter != m_v.end(); iter++) {

		if (m_x > iter->m_x - iter->width / 2
				&& m_x < iter->m_x + iter->width / 2)
			soundplayer_play_sound("input_keypress");

	}

	if (m_worker->m_x > 840 && m_worker->m_x < 970 && m_worker->m_y > 280
			&& m_worker->m_y < 360) {
		soundplayer_play_sound("input_keypress");
		for (iter = m_v.begin(); iter != m_v.end(); iter++) {
			iter->m_r += 20;
		}
	}

	if (m_worker->m_x > 60 && m_worker->m_x < 170 && m_worker->m_y > 280
			&& m_worker->m_y < 360) {
		soundplayer_play_sound("input_keypress");
		//m_snd.play("/app/native/res/metelhit.mp3");

		for (iter = m_v.begin(); iter != m_v.end(); iter++) {
			iter->m_x += 20;
		}
	}
}

zaPicList::~zaPicList()
{
//	if (m_v.at(0).m_x +  m_x - m_ox < 312 &&
//		m_v.at(0).m_x +  m_x - m_ox > - m_ll)
//	{
//		m_len += m_x - m_ox;
//		std::vector<ZAImage>::iterator iter;
//		for (iter = m_v.begin();iter != m_v.end();iter++)
//		{
//				iter->m_x += m_x - m_ox;
//			//	iter->m_y -= m_y - m_oy;
//				if (abs(iter->m_x-512)>512)
//					iter->m_alpha = 0.0f;
//				else if (abs(iter->m_x-512)>200)
//					iter->m_alpha = 1.0f- (float)(abs(iter->m_x-512)-200)/312;
//				else
//					iter->m_alpha = 1.0f;
//		}
//	}
//	m_ox = pair[0];
//	m_oy = pair[1];
	// TODO Auto-generated destructor stub
}

