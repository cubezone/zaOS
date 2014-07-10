/*
 * zaWorker.cpp
 *
 *  Created on: 2012-2-19
 *      Author: zhuxy
 */

#include "zaWorker.h"

zaWorker::zaWorker() {
	// TODO Auto-generated constructor stub
	m_len = 0;
	m_x = m_ox= 0;
	m_y = m_oy= 0;
}

zaWorker::~zaWorker() {
	// TODO Auto-generated destructor stub
}

void zaWorker::work()
{

}

void zaWorker::init(int x ,int y)
{
	m_x  = x;
	m_y  = y;

	m_ox = m_x;
	m_oy = m_y;
}
void zaWorker::move(int x, int y)
{
	m_ox = m_x;
	m_oy = m_y;

	m_x  = x;
	m_y  = y;

	m_dx = m_x- m_ox;
	m_dy = m_y- m_oy;

	m_len += sqrt(m_dx*m_dx + m_dy*m_dy)  ;
}
