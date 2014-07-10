/*
 * ZAImage.cpp
 *
 *  Created on: 2012-2-14
 *      Author: zhuxy
 */

#include "ZAImage.h"

ZAImage::ZAImage() {
	// TODO Auto-generated constructor stub
	reset();
}

ZAImage::~ZAImage() {
	// TODO Auto-generated destructor stub
}


void ZAImage::reset() {
	m_d = 20;
	m_r = 0;
}

void  ZAImage::setposition(int x, int y)
{
	m_x = x;
	m_y = y;
}

void ZAImage::setrote(int r)
{
	m_r = r;
}

int ZAImage::DrawImg()
{
	return DrawImg( m_x ,  m_y,  m_r );
}

int ZAImage::RunImg()
{
	m_d -= 0.005f;
	m_r += m_d;

	if (m_d < 0 ) return 0;
	return DrawImg( m_x ,  m_y,  m_r );
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


	shadow_vertices[0] = 0.0f;
	shadow_vertices[1] = 0.0f;
	shadow_vertices[2] = 350.0f;
	shadow_vertices[3] = 0.0f;
	shadow_vertices[4] = 0.0f;
	shadow_vertices[5] = 431.0f;
	shadow_vertices[6] = 350.0f;
	shadow_vertices[7] = 431.0f;


	if (m_d > 8)
	{
		shadow_vertices[0] = -width/2;
		shadow_vertices[1] = -height/2;
		shadow_vertices[2] = width/2;
		shadow_vertices[3] = -height/2;
		shadow_vertices[4] = -width/2;
		shadow_vertices[5] = height/2;
		shadow_vertices[6] = width/2;
		shadow_vertices[7] = height/2;
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
	glColor4f(1.0f, 1.0f, 1.0f, m_d/8);
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
	if (EXIT_SUCCESS
				!= bbutil_load_texture(p, NULL, NULL,
						&tex_x, &tex_y, &m_img)) {
		return -1;
	}
	width = w;
	height = h;
	fprintf(stderr,"load png ok x:%d  y:%d " ,tex_x ,tex_y);
	return EXIT_SUCCESS;
}

