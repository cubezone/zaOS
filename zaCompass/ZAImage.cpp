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

#define JPEG_QUALITY 95 //图片质量

int ZAImage::Bmp2Jpg(const char *bmp_file, const char *jeg_file, const int width, const int height)
{
    FILE *fd;
    int ret;
    unsigned char *data;
    long sizeImage;
    int depth = 3;
//**
    depth = 3;


    JSAMPROW * row_pointer;
    long rgb_index = 0;
    int i=0;
    struct jpeg_compress_struct cinfo;
    struct jpeg_error_mgr jerr;
    FILE *outfile;
    ;
    // Read bmp image data
    sizeImage = width*height*4;
    data = (unsigned char*)malloc(sizeImage);
    fd = fopen(bmp_file, "rb");
    if(!fd)
    {
        printf("ERROR1: Can not open the image.\n");
        free(data);
        return -1;
    }

    fseek(fd, 54, SEEK_SET);
    ret = fread(data, sizeof(unsigned char)*sizeImage, 1, fd);
    if(ret == 0)
    {
        if(ferror(fd))
        {
            printf("\nERROR2: Can not read the pixel data.\n");
            free(data);
            fclose(fd);
            return -1;
        }
    }

    //Convert BMP to JPG
    cinfo.err = jpeg_std_error(&jerr);
    //* Now we can initialize the JPEG compression object.
    jpeg_create_compress(&cinfo);

    if ((outfile = fopen(jeg_file, "wb")) == NULL)
    {
        fprintf(stderr, "can't open %s\n", jeg_file);
        return -1;
    }
    jpeg_stdio_dest(&cinfo, outfile);


    cinfo.image_width = width;             //* image width and height, in pixels
    cinfo.image_height = height;

    cinfo.input_components = 3;    //* # of color components per pixel
    cinfo.in_color_space = JCS_RGB;     //* colorspace of input image
 //  cinfo.in_color_space = JCS_RGBA_8888;     //* colorspace of input image
 //   jpeg_set_defaults(&cinfo);
    jpeg_set_defaults(&cinfo);
    cinfo.jpeg_width = 500;
    cinfo.jpeg_height = 300;
    jpeg_calc_jpeg_dimensions(&cinfo);
     //Now you can set any non-default parameters you wish to.
     //Here we just illustrate the use of quality (quantization table) scaling:

    jpeg_set_quality(&cinfo, JPEG_QUALITY, TRUE ); //* limit to baseline-JPEG values
    jpeg_start_compress(&cinfo, TRUE);

    //一次写入
    int j=0;
    row_pointer = (JSAMPLE **)malloc(height*width*depth);
    char * line[800];

    for(i=0;i<height;i++)
    {
        char * lineData = NULL;
        lineData = ( char *)malloc(width*depth);
        line[i]=lineData;
        for(j=0;j<width;j++)
        {
            lineData[j*depth+2] = data[rgb_index];
            rgb_index ++;
            lineData[j*depth+1] = data[rgb_index];
            rgb_index ++;
            lineData[j*depth+0] = data[rgb_index];
            rgb_index ++;
       //     lineData[j*depth+3] = data[rgb_index];
            rgb_index ++;
        }
        row_pointer[height-i-1] =  (JSAMPLE *)lineData;
    }
    jpeg_write_scanlines(&cinfo, row_pointer, height);
    jpeg_finish_compress(&cinfo);
    jpeg_destroy_compress(&cinfo);
    for (i=0; i<height; i++)
    {
        free(line[i]);
    }
    free(row_pointer);
    free(data);
    fclose(fd);
    fclose(outfile);

    return 0;
}

