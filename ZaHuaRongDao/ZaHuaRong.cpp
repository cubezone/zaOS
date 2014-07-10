/*
 * ZaHuaRong.cpp
 *
 *  Created on: 2012-9-24
 *      Author: Administrator
 */

#include "ZaHuaRong.h"

namespace bbcubezone
{

ZaHuaRong::ZaHuaRong()
{
	m_z = 1.0f;
}

void ZaHuaRong::init()
{
	int lwidth = 120;
	ZAImage * l_img;
	m_sx = (m_width - 480) / 2;
	m_sy = (m_height - 600) /2 +600 ;

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/zf.jpg", lwidth, lwidth * 5);
	l_img->setXY(m_sx - 0.5 * lwidth, m_sy - 2.5*lwidth);
	l_img->m_visiable = false;
	m_v.push_back(l_img);

	m_zf = new ZAImage();
	m_zf->LoadImg("app/native/res/zf.jpg", lwidth, lwidth * 2);
	m_zf->setXY(m_sx + 0.5 * lwidth, m_sy - lwidth);
	m_v.push_back(m_zf);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/zf.jpg", lwidth*4, lwidth*2);
	l_img->setXY(m_sx + 2* lwidth, m_sy + lwidth);
	l_img->m_visiable = false;
	m_v.push_back(l_img);

	m_cc = new ZAImage();
	m_cc->LoadImg("app/native/res/cc.jpg", lwidth * 2, lwidth * 2);
	m_cc->setXY(m_sx + lwidth + lwidth, m_sy - lwidth);
	m_v.push_back(m_cc);

	m_mc = new ZAImage();
	m_mc->LoadImg("app/native/res/mc.jpg", lwidth, lwidth * 2);
	m_mc->setXY(m_sx + 3.5 * lwidth, m_sy - lwidth);
	m_v.push_back(m_mc);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/zf.jpg", lwidth, lwidth * 5);
	l_img->setXY(m_sx + 4.5 * lwidth, m_sy - 2.5*lwidth);
	l_img->m_visiable = false;
	m_v.push_back(l_img);

	m_zy = new ZAImage();
	m_zy->LoadImg("app/native/res/zy.jpg", lwidth, lwidth * 2);
	m_zy->setXY(m_sx + lwidth / 2, m_sy - lwidth * 2 - lwidth);
	m_v.push_back(m_zy);

	m_gy = new ZAImage();
	m_gy->LoadImg("app/native/res/gy.jpg", 2 * lwidth, lwidth);
	m_gy->setXY(m_sx + lwidth + lwidth, m_sy - 2.5 * lwidth);
	m_v.push_back(m_gy);

	m_hz = new ZAImage();
	m_hz->LoadImg("app/native/res/hz.jpg", lwidth, lwidth * 2);
	m_hz->setXY(m_sx + 3.5 * lwidth, m_sy - lwidth * 2 - lwidth);
	m_v.push_back(m_hz);

	m_zu1 = new ZAImage();
	m_zu1->LoadImg("app/native/res/zu.jpg", lwidth, lwidth);
	m_zu1->setXY(m_sx + lwidth / 2, m_sy - 4.5 * lwidth);
	m_v.push_back(m_zu1);

	m_zu2 = new ZAImage();
	m_zu2->LoadImg("app/native/res/zu.jpg", lwidth, lwidth);
	m_zu2->setXY(m_sx + 1.5 * lwidth, m_sy - 3.5 * lwidth);
	m_v.push_back(m_zu2);

	m_zu3 = new ZAImage();
	m_zu3->LoadImg("app/native/res/zu.jpg", lwidth, lwidth);
	m_zu3->setXY(m_sx + 2.5 * lwidth, m_sy - 3.5 * lwidth);
	m_v.push_back(m_zu3);

	m_zu4 = new ZAImage();
	m_zu4->LoadImg("app/native/res/zu.jpg", lwidth, lwidth);
	m_zu4->setXY(m_sx + 3.5 * lwidth, m_sy - 4.5 * lwidth);
	m_v.push_back(m_zu4);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/zf.jpg", lwidth, lwidth );
	l_img->setXY(m_sx + 0.5 * lwidth, m_sy - 5.5 * lwidth);
	l_img->m_visiable = false;
	m_v.push_back(l_img);

	l_img = new ZAImage();
	l_img->LoadImg("app/native/res/zf.jpg", lwidth, lwidth);
	l_img->setXY(m_sx + 3.5 * lwidth, m_sy - 5.5 * lwidth);
	l_img->m_visiable = false;
	m_v.push_back(l_img);

}


void ZaHuaRong::reset()
{
	int lwidth = 120;
	m_sx = (m_width - 480) / 2;
	m_sy = (m_height - 600) /2 +600 ;

//	m_zf->setXY(m_sx + 0.5 * lwidth, m_sy - lwidth);
//	m_cc->setXY(m_sx + lwidth + lwidth, m_sy - lwidth);
//	m_mc->setXY(m_sx + 3.5 * lwidth, m_sy - lwidth);
//	m_zy->setXY(m_sx + 0.5 * lwidth, m_sy - lwidth * 2 - lwidth);
//	m_gy->setXY(m_sx + lwidth + lwidth, m_sy - 2.5 * lwidth);
//	m_hz->setXY(m_sx + 3.5 * lwidth, m_sy - lwidth * 2 - lwidth);
//	m_zu1->setXY(m_sx + 0.5 * lwidth, m_sy - 4.5 *lwidth);
//	m_zu2->setXY(m_sx + 1.5 * lwidth, m_sy - 3.5 * lwidth);
//	m_zu3->setXY(m_sx + 2.5 * lwidth, m_sy - 3.5 * lwidth);
//	m_zu4->setXY(m_sx + 3.5 * lwidth, m_sy - 4.5 * lwidth);

	ZaTweener::getInstance()->push(m_zf, ZaTweener::X, m_zf->m_x ,m_sx + 0.5 * lwidth , 0, 10);
	ZaTweener::getInstance()->push(m_zf, ZaTweener::Y, m_zf->m_y ,m_sy - lwidth , 0, 10);

	ZaTweener::getInstance()->push(m_cc, ZaTweener::X, m_cc->m_x ,m_sx + lwidth + lwidth , 10, 10);
	ZaTweener::getInstance()->push(m_cc, ZaTweener::Y, m_cc->m_y ,m_sy - lwidth , 10, 10);

	ZaTweener::getInstance()->push(m_mc, ZaTweener::X, m_mc->m_x ,m_sx + 3.5 * lwidth , 20, 10);
	ZaTweener::getInstance()->push(m_mc, ZaTweener::Y, m_mc->m_y ,m_sy - lwidth ,20, 10);

	ZaTweener::getInstance()->push(m_zy, ZaTweener::X, m_zy->m_x ,m_sx + 0.5 * lwidth , 30, 10);
	ZaTweener::getInstance()->push(m_zy, ZaTweener::Y, m_zy->m_y ,m_sy - lwidth * 2 - lwidth , 30, 10);

	ZaTweener::getInstance()->push(m_gy, ZaTweener::X, m_gy->m_x ,m_sx + lwidth + lwidth , 40, 10);
	ZaTweener::getInstance()->push(m_gy, ZaTweener::Y, m_gy->m_y , m_sy - 2.5 * lwidth ,40, 10);

	ZaTweener::getInstance()->push(m_hz, ZaTweener::X, m_hz->m_x ,m_sx + 3.5 * lwidth , 50, 10);
	ZaTweener::getInstance()->push(m_hz, ZaTweener::Y, m_hz->m_y , m_sy - lwidth * 2 - lwidth , 50, 10);

	ZaTweener::getInstance()->push(m_zu1, ZaTweener::X, m_zu1->m_x ,m_sx + 0.5 * lwidth , 60, 10);
	ZaTweener::getInstance()->push(m_zu1, ZaTweener::Y, m_zu1->m_y ,m_sy - 4.5 *lwidth , 60, 10);

	ZaTweener::getInstance()->push(m_zu2, ZaTweener::X, m_zu2->m_x ,m_sx + 1.5 * lwidth , 70, 10);
	ZaTweener::getInstance()->push(m_zu2, ZaTweener::Y, m_zu2->m_y ,m_sy - 3.5 * lwidth , 70, 10);

	ZaTweener::getInstance()->push(m_zu3, ZaTweener::X, m_zu3->m_x ,m_sx + 2.5 * lwidth , 80, 10);
	ZaTweener::getInstance()->push(m_zu3, ZaTweener::Y, m_zu3->m_y ,m_sy - 3.5 * lwidth , 80, 10);

	ZaTweener::getInstance()->push(m_zu4, ZaTweener::X, m_zu4->m_x ,m_sx + 3.5 * lwidth , 90, 10);
	ZaTweener::getInstance()->push(m_zu4, ZaTweener::Y, m_zu4->m_y ,m_sy - 4.5 * lwidth , 90, 10);

}


void ZaHuaRong::drawControl()
{
	int a = m_x, b = m_y;
	getClientXY(a, b);
	for (uint i = 0; i < m_v.size(); i++)
	{
		ZAImage * l_img = m_v[i];
		if (l_img->m_visiable)
			l_img->DrawImg(a + l_img->m_x, b + l_img->m_y, l_img->m_r);
	}
}

int roundx(int x, int rnd, int dict)
{
	int r = x % rnd;
	x = x - r;
	if (dict > 0 && r > rnd/2)
		x = x + rnd;
	if (dict < 0 && r < rnd/2)
		x = x - rnd;
	return x;
}

void ZaHuaRong::processEvent(ZaEvent * env)
{
	static ZAImage * f_img = NULL;
	static int o_x, o_y;
	int dictx;
	int dicty;
	env->m_event = env->m_type;
	if (env->m_type == ZaEvent::EVENT_DOWN)
	{
		o_x = env->m_x;
		o_y = env->m_y;
		f_img = NULL;
		for (uint i = 0; i < m_v.size(); i++)
		{
			ZAImage * l_img = m_v[i];
			if (!l_img->m_visiable)
				continue;
			if (l_img->inPoint(env->m_x + l_img->m_width / 2,
					env->m_y + l_img->m_height / 2))
			{
				f_img = l_img;
			}
		}
		env->m_event = ZaEvent::EVENT_DOWN;
	}
	if (env->m_type == ZaEvent::EVENT_MOVE)
	{
		if (f_img)
		{
			f_img->m_x += env->m_x - o_x;
			dictx = 0;
			dicty = 0;
			int llx = f_img->m_x;
			int lly = f_img->m_y;

			for (uint i = 0; i < m_v.size(); i++)
			{
				ZAImage * l_img = m_v[i];
				if (f_img != l_img && f_img->isCross(l_img))
				{
					f_img->m_x -= env->m_x - o_x;
					break;
				}
			}
			f_img->m_y += env->m_y - o_y;
			for (uint i = 0; i < m_v.size(); i++)
			{
				ZAImage * l_img = m_v[i];
				if (f_img != l_img && f_img->isCross(l_img))
				{
					f_img->m_y -= env->m_y - o_y;
					break;
				}
			}
			//防止逃兵
			if (f_img != m_cc && (f_img->m_y - f_img->m_height/2) < m_sy - 120*5)
			{
				f_img->m_y = m_sy -600 + f_img->m_height/2;
			}

			if (f_img->m_y > lly)
				dicty = 1;
			if (f_img->m_y < lly)
				dicty = -1;
			if (f_img->m_x > llx)
				dictx = 1;
			if (f_img->m_x < llx)
				dictx = -1;
		}
		env->m_event = ZaEvent::EVENT_MOVE;
		o_x = env->m_x;
		o_y = env->m_y;
	}
	if (env->m_type == ZaEvent::EVENT_UP)
	{
		if (f_img)
		{
			if (dicty != 0)
				ZaTweener::getInstance()->push(f_img, ZaTweener::Y, f_img->m_y,
						 m_sy - roundx(m_sy - f_img->m_y, 60, dicty) , 0, 5);
			if (dictx != 0)
				ZaTweener::getInstance()->push(f_img, ZaTweener::X, f_img->m_x,
						roundx(f_img->m_x - m_sx, 60, dictx) + m_sx, 0, 5);
		}
		f_img = NULL;
	}

}

ZaHuaRong::~ZaHuaRong()
{
// TODO Auto-generated destructor stub
	for (uint i; i < m_v.size(); i++)
	{
		delete m_v[i];
	}
	m_v.clear();
}

} /* namespace bbcubezone */
