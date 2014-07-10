/*
 * ZAImage.cpp
 *
 *  Created on: 2012-2-14
 *      Author: zhuxy
 */

#include "ZAImage.h"

ZAImage::ZAImage() {
	// TODO Auto-generated constructor stub
	m_d =  20.0f + 5.0f*(float)rand()/RAND_MAX;
	m_r = 0;
	m_stop = false;
	m_rx = 0;
	m_ry = 0;
	m_alpha = 1.0f;
}

ZAImage::~ZAImage() {
	// TODO Auto-generated destructor stub
}

void ZAImage::reset() {

	float r = 20.0f + 5.0f*(float)rand()/RAND_MAX;
	if (m_d < r)
		m_d = r;
	m_alpha = 1.0f;
	m_stop = false;
}

void  ZAImage::setposition(int x, int y)
{
	m_x = x;
	m_y = y;
}

void ZAImage::setrote(int r)
{
	m_rd = r;
}

int ZAImage::DrawImg()
{
	return DrawImg( m_x ,  m_y,  m_r );
}

void ZAImage::stop()
{
	 m_stop = true;
}

void ZAImage::setcenter(int x ,int y)
{
	m_rx = x;
	m_ry = y;
}

bool ZAImage::PtinIt(int x , int y)
{
	return  (m_y - height/2 < (600-y)  && (600-y)< m_y + height/2
		&& m_x  - width/2 < x && x< m_x + width/2);

}

int ZAImage::RunImg()
{
	if (m_d <= 0 )
		stop();

	if (m_stop)
		DrawImg( m_x ,  m_y,  m_r );
	else
	{
		m_d -= 0.01f;
		m_r += m_rd * m_d;
	    DrawImg( m_x ,  m_y,  m_r );
	}
	return 0;
}

int ZAImage::DrawImg(int x , int y, int r )
{

		glEnable(GL_TEXTURE_2D);

		glEnableClientState(GL_VERTEX_ARRAY);
		glEnableClientState(GL_TEXTURE_COORD_ARRAY);

		glEnable(GL_BLEND);
//		glBlendFunc(GL_ONE, GL_ZERO);
		glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

	GLfloat shadow_vertices[8],shadow_tex_coord[8];

	shadow_tex_coord[0] = 0.0f;
	shadow_tex_coord[1] = 0.0f;
	shadow_tex_coord[2] = tex_x;
	shadow_tex_coord[3] = 0.0f;
	shadow_tex_coord[4] = 0.0f;
	shadow_tex_coord[5] = tex_y;
	shadow_tex_coord[6] = tex_x;
	shadow_tex_coord[7] = tex_y;

	if (m_d > -1)
	{
		shadow_vertices[0] = -width/2 + m_rx;
		shadow_vertices[1] = -height/2 + m_ry;
		shadow_vertices[2] = width/2 + m_rx;
		shadow_vertices[3] = -height/2 + m_ry;
		shadow_vertices[4] = -width/2 + m_rx;
		shadow_vertices[5] = height/2 + m_ry;
		shadow_vertices[6] = width/2 + m_rx;
		shadow_vertices[7] = height/2 + m_ry;
	}
	else
	{
		shadow_vertices[0] = -width/2*m_d/8;
		shadow_vertices[1] = -height/2*m_d/8;
		shadow_vertices[2] = width/2*m_d/8;
		shadow_vertices[3] = -height/2*m_d/8;
		shadow_vertices[4] = -width/2*m_d/8;
		shadow_vertices[5] = height/2*m_d/8;
		shadow_vertices[6] = width/2*m_d/8;
		shadow_vertices[7] = height/2*m_d/8;
	}


	glPushMatrix();

	glVertexPointer(2, GL_FLOAT, 0, shadow_vertices);
	glTexCoordPointer(2, GL_FLOAT, 0, shadow_tex_coord);
	glTranslatef(x,y, 0.0f);
	glRotatef(r,0.0f,0.0f,1.0f);

	glBindTexture(GL_TEXTURE_2D, m_img);
	glColor4f(1.0f, 1.0f, 1.0f, m_alpha);
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	glPopMatrix();

	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	glDisable(GL_BLEND);
	glDisable(GL_TEXTURE_2D);

	return 0;
}


int ZAImage::LoadImg(const char * p,int w,int h)
{
	//p = "app/native/fly2.png";
	int p_w,p_h;
	if (EXIT_SUCCESS
				!= bbutil_load_texture(p, &p_w,&p_h,
						&tex_x, &tex_y, &m_img)) {
		return -1;
	}
	if (w !=0)
	{
		width = w;
		height = h;
	}
	else
	{
		width = p_w;
		height = p_h;
	}

	sprintf(m_p,"%s",p);
	fprintf(stderr,"load png ok x:%d  y:%d\n " ,p_w ,p_h);
	return EXIT_SUCCESS;
}

