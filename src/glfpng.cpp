//========================================================================
// Vsync enabling test
// Copyright (c) Camilla Berglund <elmindreda@elmindreda.org>
//
// This software is provided 'as-is', without any express or implied
// warranty. In no event will the authors be held liable for any damages
// arising from the use of this software.
//
// Permission is granted to anyone to use this software for any purpose,
// including commercial applications, and to alter it and redistribute it
// freely, subject to the following restrictions:
//
// 1. The origin of this software must not be misrepresented; you must not
//    claim that you wrote the original software. If you use this software
//    in a product, an acknowledgment in the product documentation would
//    be appreciated but is not required.
//
// 2. Altered source versions must be plainly marked as such, and must not
//    be misrepresented as being the original software.
//
// 3. This notice may not be removed or altered from any source
//    distribution.
//
//========================================================================
//
// This test renders a high contrast, horizontally moving bar, allowing for
// visual verification of whether the set swap interval is indeed obeyed
//
//========================================================================

#pragma comment (linker, "/nodefaultlib:msvcrt.lib")

#pragma comment(lib,"glfw3.lib") 
#pragma comment(lib,"glfw3dll.lib") 
#pragma comment(lib,"opengl32.lib") 

#include <stdarg.h>

#include <GL/gl.h>
#include <GL/glext.h>
#include <GL/glu.h>
#include <GLFW/glfw3.h>

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <unistd.h>
#include <png.h>
#include <jpeglib.h>

#include <ft2build.h>
#include FT_FREETYPE_H 


static int swap_interval;
static double frame_rate;

typedef struct font_t font_t; 

struct font_t
{
	unsigned int font_texture;
	float pt;
	float advance[128];
	float width[128];
	float height[128];
	float tex_x1[128];
	float tex_x2[128];
	float tex_y1[128];
	float tex_y2[128];
	float offset_x[128];
	float offset_y[128];
	int initialized;
};


struct my_error_mgr {
  struct jpeg_error_mgr pub;	/* "public" fields */

  jmp_buf setjmp_buffer;	/* for return to caller */
};

typedef struct my_error_mgr * my_error_ptr;

METHODDEF (void) my_error_exit (j_common_ptr cinfo) ;
int read_JPEG2_file (const char * filename,int w,int h) ;

font_t* load_font(const char* path, int point_size, int dpi) ;
void render_text(font_t* font, const char* msg, float x, float y);
void destroy_font(font_t* font) ;
void DrawR() ;

static int initialized = 0; 

	GLfloat tex_x=0.9f ,tex_y=0.9f;
	//float m_alpha;
	GLuint m_img=0;
	//float width, height;
	float angle;
	//int m_x,m_y;
	//float m_z;
	float m_d;
	bool m_stop;
	bool m_rotation;
	bool m_darkstyle;
	float m_trans;
	bool m_isRGBA=true;
	
	int m_x =0;
	int m_y=0;
    int m_width = 1;
	int m_height= 1;
	int m_id;
	float m_alpha=1.0f;
	float m_rx ;
	float m_ry ;
	float m_r;
	float m_z=0.5f;
	float m_percent;
	bool m_visiable;
	bool m_enable;
	bool m_pressed;
	bool m_active;
	bool m_dirty;
	bool m_motion;
	bool m_dragable;

	bool m_postparent;

static void update_window_title(GLFWwindow* window)
{
    char title[256];

    sprintf(title, "Tearing detector (interval %i, %0.1f Hz)",
            swap_interval, frame_rate);

    glfwSetWindowTitle(window, title);
}

int load_texture(const char* filename, int* width, int* height,
		float* tex_x, float* tex_y, unsigned int *tex) ;
int DrawImg(int x , int y, int r ) ;

static inline int nextp2(int x)
{
	int val = 1;
	while (val < x)
		val <<= 1;
	return val;
}



static void set_swap_interval(GLFWwindow* window, int interval)
{
    swap_interval = interval;
    glfwSwapInterval(swap_interval);
    update_window_title(window);
}

static void error_callback(int error, const char* description)
{
    fprintf(stderr, "Error: %s\n", description);
}

static void framebuffer_size_callback(GLFWwindow* window, int width, int height)
{
if (height ==0) return;
	/*    
      glViewport( 0, 0, (GLint) width, (GLint) height );
  glMatrixMode( GL_PROJECTION );
   glOrtho(0.0f, width / height, 0.0f, 1.0f, -1.0f, 1.0f);
  glLoadIdentity();
 gluPerspective(60.0,(GLfloat)width/(GLfloat)height, 0.1, 100.0);  
  glMatrixMode( GL_MODELVIEW );
  glLoadIdentity();
    glScalef(1.0f / height, 1.0f / height, 1.0f);
     */
      int w = width;
       int h = height;
      	glViewport(0  ,0  ,w,h); 

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();  
    // 	glOrtho(0.0f, (float)w /(float) h, 0.0f, 1.0f, -100.0f, 100.0f);
  //  glOrtho(-1.f, 1.f, -1.f, 1.f, 1.f, -1.f);
  //  glOrtho(0.0f, 640 / 480, 0.0f, 1.0f, -1.0f, 1.0f);
    
    // glLoadIdentity();
	//glOrtho(0.0f, 640.f / 480.f, 0.0f, 1.0f, 1.0f, 1.0f);	
   gluPerspective(1.0,(GLfloat)w/(GLfloat)h, 0.1, 4000.0);  

    glMatrixMode(GL_MODELVIEW);
    //glLoadIdentity();
     glLoadIdentity();  
    glScalef(1.0f /h*40, 1.0f /h*40, 1.0f);
}

static void key_callback(GLFWwindow* window, int key, int scancode, int action, int mods)
{
    if (key == GLFW_KEY_SPACE && action == GLFW_PRESS)
        set_swap_interval(window, 1 - swap_interval);
}

int main()
{
    float position;
    unsigned long frame_count = 0;
    double last_time, current_time;
    GLFWwindow* window;


	font_t* font;
	
    glfwSetErrorCallback(error_callback);
    int va,vb,vc;
   glfwGetVersion (&va,&vb,&vc); 
    	fprintf(stderr,"version  a:%d b:%d c:%d\n",va,vb,vc);

    if (!glfwInit())
        exit(EXIT_FAILURE);
    int w  = 1000;
    int  h = 500;  
     int monc;
     GLFWmonitor ** mon=glfwGetMonitors(&monc) ; 
     //monc =2;
    //glfwWindowHint( GLFW_AUTO_ICONIFY  ,  GL_FALSE);
    const  GLFWvidmode * vid = glfwGetVideoMode(mon[monc-1]); 
     w =vid->width;
     h = vid->height ;
    //window = glfwCreateWindow(w,h, "",mon[monc-1] , NULL);     
    window = glfwCreateWindow(w,h, "",NULL , NULL);     
           
    if (!window)
    {
        glfwTerminate();
        exit(EXIT_FAILURE);
    }
	int wa,wb;
	glfwGetWindowPos  (window,&wa,&wb);
	fprintf(stderr,"windwos  x:%d y:%d w:%d h:%d\n",wa,wb,w,h);

    glfwMakeContextCurrent(window);
    set_swap_interval(window, 0);

    last_time = glfwGetTime();
    frame_rate = 0.0;

    glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);
    glfwSetKeyCallback(window, key_callback);

 //   glClearColor(0.1f , 0.1f , 0.1f , 0.5f );     
	 
	glViewport(0  ,0  ,w,h); 

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();  
    // 	glOrtho(0.0f, (float)w /(float) h, 0.0f, 1.0f, -100.0f, 100.0f);
  //  glOrtho(-1.f, 1.f, -1.f, 1.f, 1.f, -1.f);
  //  glOrtho(0.0f, 640 / 480, 0.0f, 1.0f, -1.0f, 1.0f);
    
    // glLoadIdentity();
	//glOrtho(0.0f, 640.f / 480.f, 0.0f, 1.0f, 1.0f, 1.0f);	
   gluPerspective(1.0,(GLfloat)w/(GLfloat)h, 0.1, 4000.0);  

    glMatrixMode(GL_MODELVIEW);
    //glLoadIdentity();
     glLoadIdentity();  
    glScalef(1.0f /h*30, 1.0f /h*30, 1.0f);
     
         
    glEnable(GL_BLEND); // 打开混合
//  glDisable(GL_DEPTH_TEST); // 关闭深度测试
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); // 基于源象素alpha通道值的半透明混合函数
   
    GLint err = glGetError();
	fprintf(stderr, "GL EEE %i %d\n", err);   
		initialized = 1; 
		
	font = load_font("CALIBRI.TTF",50,82) ;
	
   if ( 1==2 )
    {		
  		 if (load_texture("cc.png", &m_width, &m_height,
						&tex_x, &tex_y, &m_img)!=EXIT_SUCCESS )
					{
						fprintf(stderr,"load pngtest.png error\n");
						return 0;
					} 
						m_width = 5;
                  m_height =4; 
	}	
	else 		
	{
				m_width = 600;
               m_height = 1024; 
	         read_JPEG2_file("cc.jpeg", m_width, m_height);
	}
	
		
   float a = 0.f;
   float t = 0.004f;
    while (!glfwWindowShouldClose(window))
    {
    	 glEnable(GL_DEPTH_TEST);
        glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);

    //  glLoadIdentity();  
      glPushMatrix(); 
    //  gluLookAt (0.0, 0.0, -5-3.0*cosf((float) glfwGetTime() * 4.f), 0.0, 0.0, 0.0, 3.14f*cosf((float) glfwGetTime()),0.1f, 0.0);  

        a = a +t;        
        
        if ( a > 5 || a < 0)  t = -t;
        	
       float s =  - sinf(3.1416/1 * a);
       
       if (s == 0.f )  	usleep(1000000);
       	
       if ( s > 0  && s< 0.2 )  
       	{ s = 0.2f;       
       	}
       	if ( s< 0  && s >-0.2 )  
        { s = -0.2f;      
       	}
        
       if ( s > 0)
        glTranslatef(-a -2, -1.f, -1850.1f-3.f *s);
      else
        glTranslatef(-a -2, -1.f, -1850.1f+ 3.f *s);	
 

      // glRotatef(180*cosf((float) glfwGetTime() * 1.f),0.0f,1.0f,0.0f);

		DrawR ();  
	
        position = cosf((float) glfwGetTime() * 4.f) * 0.75f;
        position =  0.f; 
        glEnable(GL_BLEND); 
  		glBlendFunc(GL_DST_ALPHA, GL_ZERO);  
        glColor3f (1.0, 1.0, 0.0); 
        glRectf(position - 202.f, -202.f, position + 202.f, 202.f);
            
        glColor4f (1.0, 0.0, 1.0,0.5); 
        glTranslatef(0.0f, 0.0f,10.0f);
        glRectf(position - 150.f, -50.f, position -40.f, 50.f);
        glDisable(GL_BLEND); 
  /*
  		for (int i = 0 ;  i < 10 ;i ++ )
  		{
            glColor4f(0, 0.5+0.05*i, 0.5+0.05*i,1.0);      
           glPushMatrix(); 
           glTranslatef(-0.5f, 0.f,-0.3f*i*i);                     
          // glRotatef(10 *i ,0.0f,1.0f,0.0f);           
           position = 1;          
           glRectf(position - 0.25f- 0.2*i, -0.3f- 0.21*i, position + 0.25f+ 0.2*i, 0.3f+ 0.2*i);
           glPopMatrix();
        }  
           
          for (int i = 0 ;  i < 10 ;i ++ )
  		{
            glColor4f(0, 0.5+0.05*i, 0.5+0.05*i,1.0);      
           glPushMatrix(); 
           glTranslatef(-0.5f, 0.f,0.3f*i*i);                     
          // glRotatef(10 *i ,0.0f,1.0f,0.0f);           
           position = 1;          
           glRectf(position - 0.25f- 0.2*i, -0.3f- 0.21*i, position + 0.25f+ 0.2*i, 0.3f+ 0.2*i);
           glPopMatrix();
        }  
        */
  		   usleep(5000);
    
/*
  		for (int n = 0 ;  n < 3 ; n ++ )
        for (int m = 0 ;  m < 8 ;m ++ )             
  		{
  			    glPushMatrix(); 
  			   glColor4f(0, 0.5+0.05*m, 0.5+0.05*m,1.0);        			 
  			   glTranslatef(1.0f*m, 1.f*n,0.f);     			   
  			  glRectf(-0.3,-0.2,0.3,0.2);  
  			  glTranslatef(0, 0,0.1f);     			   
  			  glColor4f(1, 0.5+0.05*m, 0.5+0.05*m,1.0);        			 
  			   glRectf(-0.3,-0.1,0.3,0.1);  
  			  glPopMatrix();
  		}
  */	
  				m_r = m_r +1.0f;
  	
  				
  	
  		      DrawImg(-250,0,0.1f);               	
  		    
  		    		glColor4f(1.0f, 0.6f, 1.3f, 1.0f);
  		       render_text (font,"a d EGSD EF :-",-10,10); 
  		   
  		      	     
          glPopMatrix();
        glDisable(GL_DEPTH_TEST);
        glfwSwapBuffers(window);
        glfwPollEvents();
        
        frame_count++;

        current_time = glfwGetTime();
        if (current_time - last_time > 1.0)
        {
            frame_rate = frame_count / (current_time - last_time);
            frame_count = 0;
            last_time = current_time;
            update_window_title(window);
        }
    }
destroy_font (font);
    glfwTerminate();
    exit(EXIT_SUCCESS);
    return 0;
}


int DrawImg(int x , int y, int r )
{
	if(m_img==0)
	{
		fprintf(stderr,"ZAImage::DrawImg EMPTY RETURN\n");
		return 0;
	}

	glEnable(GL_TEXTURE_2D);

		glEnableClientState(GL_VERTEX_ARRAY);
		glEnableClientState(GL_TEXTURE_COORD_ARRAY);
		glEnable(GL_BLEND);
		if(m_isRGBA)
			glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
		//	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		else
			glBlendFunc(GL_ONE, GL_ZERO);

	GLfloat shadow_vertices[8],shadow_tex_coord[8];

	shadow_tex_coord[0] = 0.0f;
	shadow_tex_coord[1] = 0.0f;
	shadow_tex_coord[2] = tex_x;
	shadow_tex_coord[3] = 0.0f;
	shadow_tex_coord[4] = 0.0f;
	shadow_tex_coord[5] = tex_y;
	shadow_tex_coord[6] = tex_x;
	shadow_tex_coord[7] = tex_y;

	float l_z = sqrt(m_z);
	
	shadow_vertices[0] = -m_width/2*l_z+ m_rx;
	shadow_vertices[1] = -m_height/2*l_z+ m_ry;
	shadow_vertices[2] = m_width/2*l_z+ m_rx;
	shadow_vertices[3] = -m_height/2*l_z+ m_ry;
	shadow_vertices[4] = -m_width/2*l_z+ m_rx;
	shadow_vertices[5] = m_height/2*l_z+ m_ry;
	shadow_vertices[6] = m_width/2*l_z+ m_rx;
	shadow_vertices[7] = m_height/2*l_z+ m_ry;

//	GLfloat shadow_vertices[80],shadow_tex_coord[80];
//	float l_z = sqrt(m_z);
//
//	for (int i = 0 ; i < 20 ;i ++)
//	{
//			shadow_tex_coord[i*4+0] = 0.0f;
//			shadow_tex_coord[i*4+1] = i * tex_y/19.0f;
//			shadow_tex_coord[i*4+2] = tex_x;
//			shadow_tex_coord[i*4+3] = i * tex_y/19.0f;
//
//
//			shadow_vertices[i*4+0] = 0.0f - width/m_trans/m_trans/2;
//			shadow_vertices[i*4+1] = i * height*m_trans/19.0f - height*m_trans/2;
//			shadow_vertices[i*4+2] = width/m_trans/m_trans - width/m_trans/m_trans/2;
//			shadow_vertices[i*4+3] = i * height/19.0f - height/2 ;
//	}

	glPushMatrix();

	glVertexPointer(2, GL_FLOAT, 0, shadow_vertices);
	glTexCoordPointer(2, GL_FLOAT, 0, shadow_tex_coord);
	glTranslatef(x,y, 0.0f);
	//glRotatef(m_r,0.0f,0.0f,1.0f);
	glRotatef(m_r,0.0f,1.0f,0.0f);

//	glNormal3f (3.0f,23.0f,0.0f);

	glBindTexture(GL_TEXTURE_2D, m_img);

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);


	if (m_darkstyle)
		glColor4f(0.55f, 0.55f, 0.55f, m_alpha);
	else
		glColor4f(1.0f, 1.0f, 1.0f,m_alpha);
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	glPopMatrix();

	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);

	glDisable(GL_BLEND);
	glDisable(GL_TEXTURE_2D);

	return 0;
}



int load_texture(const char* filename, int* width, int* height,
		float* tex_x, float* tex_y, GLuint *tex)
{
	int i;
	GLuint format;
	//header for testing if it is a png
	png_byte header[8];

	if (!tex)
	{
		
		return EXIT_FAILURE;
	}

	//open file as binary
	FILE *fp = fopen(filename, "rb");
	if (!fp)
	{
		return EXIT_FAILURE;
	}

	//read the header
	fread(header, 1, 8, fp);

	//test if png
	int is_png = !png_sig_cmp(header, 0, 8);
	if (!is_png)
	{
		fclose(fp);
		fprintf(stderr, "png png_sig_cmp error %d \n",__LINE__ );
		return EXIT_FAILURE;
	}

	//create png struct
	png_structp png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL,
			NULL, NULL);
	if (!png_ptr)
	{
		fclose(fp);
		return EXIT_FAILURE;
	}

	//create png info struct
	png_infop info_ptr = png_create_info_struct(png_ptr);
	if (!info_ptr)
	{
		png_destroy_read_struct(&png_ptr, (png_infopp) NULL, (png_infopp) NULL);
		fclose(fp);
		return EXIT_FAILURE;
	}

	//create png info struct
	png_infop end_info = png_create_info_struct(png_ptr);
	if (!end_info)
	{
		png_destroy_read_struct(&png_ptr, &info_ptr, (png_infopp) NULL);
		fclose(fp);
		return EXIT_FAILURE;
	}

	//setup error handling (required without using custom error handlers above)
	if (setjmp(png_jmpbuf(png_ptr)))
	{
		png_destroy_read_struct(&png_ptr, &info_ptr, &end_info);
		fclose(fp);
		fprintf(stderr, "png error %d \n",__LINE__ );
		return EXIT_FAILURE;
	}

	//init png reading
	png_init_io(png_ptr, fp);

	//let libpng know you already read the first 8 bytes
	png_set_sig_bytes(png_ptr, 8);

	// read all the info up to the image data
	png_read_info(png_ptr, info_ptr);

	//variables to pass to get info
	int bit_depth, color_type;
	/// zhuxy
	bit_depth = png_get_bit_depth(png_ptr, info_ptr);
	color_type = png_get_color_type(png_ptr, info_ptr);
	/* Convert index color images to RGB images */
	if (color_type == PNG_COLOR_TYPE_PALETTE)
		png_set_palette_to_rgb(png_ptr);
	/* Convert 1-2-4 bits grayscale images to 8 bits grayscale. */
	if (color_type == PNG_COLOR_TYPE_GRAY && bit_depth < 8)
		png_set_gray_to_rgb(png_ptr);

	if (png_get_valid(png_ptr, info_ptr, PNG_INFO_tRNS))
		png_set_tRNS_to_alpha(png_ptr);

	if (bit_depth == 16)
		png_set_strip_16(png_ptr);
	else if (bit_depth < 8)
		png_set_packing(png_ptr);

	png_read_update_info(png_ptr, info_ptr);
	/// zhuxy
	png_uint_32 image_width, image_height;

	// get info about png
	png_get_IHDR(png_ptr, info_ptr, &image_width, &image_height, &bit_depth,
			&color_type, NULL, NULL, NULL);

	switch (color_type)
	{
	case PNG_COLOR_TYPE_RGBA:
		format = GL_RGBA;
		break;
	case PNG_COLOR_TYPE_RGB:
		format = GL_RGB;
		break;
	case PNG_COLOR_TYPE_GRAY:
		format = GL_LUMINANCE;
		break;
	case PNG_COLOR_TYPE_GRAY_ALPHA:
		format = GL_LUMINANCE_ALPHA;
		break;
	default:
		fprintf(stderr, "Unsupported PNG color type (%d) for texture: %s",
				(int) color_type, filename);
		fclose(fp);
		png_destroy_read_struct(&png_ptr, &info_ptr, &end_info);
		fprintf(stderr, "png error %d \n",__LINE__ );
		return 0 ;
	}

	// Update the png info struct.
	//png_read_update_info(png_ptr, info_ptr);

	// Row size in bytes.
	int rowbytes = png_get_rowbytes(png_ptr, info_ptr);

	// Allocate the image_data as a big block, to be given to opengl
	png_byte *image_data = (png_byte*) malloc(
			sizeof(png_byte) * rowbytes * image_height);

	if (!image_data)
	{
		//clean up memory and close stuff
		png_destroy_read_struct(&png_ptr, &info_ptr, &end_info);
		fclose(fp);
		fprintf(stderr, "png error %d \n",__LINE__ );
		return EXIT_FAILURE;
	}

	//row_pointers is for pointing to image_data for reading the png with libpng
	png_bytep *row_pointers = (png_bytep*) malloc(
			sizeof(png_bytep) * image_height);
	if (!row_pointers)
	{
		//clean up memory and close stuff
		png_destroy_read_struct(&png_ptr, &info_ptr, &end_info);
		free(image_data);
		fclose(fp);
		fprintf(stderr, "png error %d \n",__LINE__ );
		return EXIT_FAILURE;
	}

	// set the individual row_pointers to point at the correct offsets of image_data
	for (i = 0; i < image_height; i++)
	{
		row_pointers[image_height - 1 - i] = image_data + i * rowbytes;
	}

	//read the png into image_data through row_pointers
	png_read_image(png_ptr, row_pointers);

	// 全锟斤拷色锟斤拷锟斤拷
	// memset(image_data,0xAA,sizeof(png_byte) * rowbytes * image_height);

	int tex_width, tex_height;

	tex_width = nextp2(image_width);
	tex_height = nextp2(image_height);

	
	glGenTextures(1, tex);	
	
	glBindTexture(GL_TEXTURE_2D, (*tex));
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);

	glPixelStorei(GL_UNPACK_ALIGNMENT, 1);

	glTexImage2D(GL_TEXTURE_2D, 0, format, tex_width, tex_height, 0, format,
			GL_UNSIGNED_BYTE, NULL);
	glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, image_width, image_height, format,
			GL_UNSIGNED_BYTE, image_data);
			


	//clean up memory and close stuff
	png_destroy_read_struct(&png_ptr, &info_ptr, &end_info);
	free(image_data);
	free(row_pointers);
	fclose(fp);

   GLint err = glGetError();

	if (err == 0)
	{
		//Return physical with and height of texture if pointers are not null
		if (width)
		{
			*width = image_width;
		}
		if (height)
		{
			*height = image_height;
		}
		//Return modified texture coordinates if pointers are not null
		if (tex_x)
		{
			*tex_x = ((float) image_width - 0.5f) / ((float) tex_width);
		}
		if (tex_y)
		{
			*tex_y = ((float) image_height - 0.5f) / ((float) tex_height);
		}
		return EXIT_SUCCESS;
	}
	else
	{
		fprintf(stderr, "GL error %i \n", err);
		return EXIT_FAILURE;
	}
} 

int read_JPEG2_file (const char * filename,int w,int h)
{

	m_isRGBA = false;
  /* This struct contains the JPEG decompression parameters and pointers to
   * working space (which is allocated as needed by the JPEG library).
   */
  struct jpeg_decompress_struct cinfo;
  /* We use our private extension JPEG error handler.
   * Note that this struct must live as long as the main JPEG parameter
   * struct, to avoid dangling-pointer problems.
   */
  struct my_error_mgr jerr;
  /* More stuff */
  FILE * infile;		/* source file */
  JSAMPARRAY buffer;		/* Output row buffer */
  int row_stride;		/* physical row width in output buffer */

  /* In this example we want to open the input file before doing anything else,
   * so that the setjmp() error recovery below can assume the file is open.
   * VERY IMPORTANT: use "b" option to fopen() if you are on a machine that
   * requires it in order to read binary files.
   */

  if ((infile = fopen(filename, "rb")) == NULL) {
    fprintf(stderr, "ZAImage::read_JPEG2_file can't open %s\n", filename);
    return 0;
  }

  /* Step 1: allocate and initialize JPEG decompression object */

  /* We set up the normal JPEG error routines, then override error_exit. */
  cinfo.err = jpeg_std_error(&jerr.pub);

  jerr.pub.error_exit = my_error_exit;

  /* Establish the setjmp return context for my_error_exit to use. */
  if (setjmp(jerr.setjmp_buffer)) {
    /* If we get here, the JPEG code has signaled an error.
     * We need to clean up the JPEG object, close the input file, and return.
     */
    jpeg_destroy_decompress(&cinfo);
    fclose(infile);
    return 0;
  }
  /* Now we can initialize the JPEG decompression object. */
  jpeg_create_decompress(&cinfo);

  /* Step 2: specify data source (eg, a file) */

  jpeg_stdio_src(&cinfo, infile);

  /* Step 3: read file parameters with jpeg_read_header() */

  (void) jpeg_read_header(&cinfo, TRUE);
  /* We can ignore the return value from jpeg_read_header since
   *   (a) suspension is not possible with the stdio data source, and
   *   (b) we passed TRUE to reject a tables-only JPEG file as an error.
   * See libjpeg.txt for more info.
   */

  /* Step 4: set parameters for decompression */

  /* In this example, we don't need to change any of the defaults set by
   * jpeg_read_header(), so we do nothing here.
   */

  /* Step 5: Start decompressor */

  (void) jpeg_start_decompress(&cinfo);
  /* We can ignore the return value since suspension is not possible
   * with the stdio data source.
   */

  /* We may need to do some setup of our own at this point before reading
   * the data.  After jpeg_start_decompress() we have the correct scaled
   * output image dimensions available, as well as the output colormap
   * if we asked for color quantization.
   * In this example, we need to make an output work buffer of the right size.
   */
  /* JSAMPLEs per row in output buffer */
  tex_x = cinfo.output_width;
  tex_y = cinfo.output_height;
  row_stride = cinfo.output_width * cinfo.output_components;

  unsigned int format ;
  if(cinfo.jpeg_color_space == JCS_GRAYSCALE){
	  format = GL_LUMINANCE ;
  }
  else if(cinfo.jpeg_color_space == 3){
	  format = GL_RGB;
  }
  else
  {
		if (m_img && &m_img)
		{
				glDeleteTextures(1,&m_img);
				m_img = 0;
		}
	  fprintf(stderr, "ZAImage::read_JPEG2_file can't decode %d\n", cinfo.jpeg_color_space);
	  return 0;
  }


  /* Make a one-row-high sample array that will go away when done with image */
  buffer = (*cinfo.mem->alloc_sarray)
		((j_common_ptr) &cinfo, JPOOL_IMAGE, row_stride, 1);

  /* Step 6: while (scan lines remain to be read) */
  /*           jpeg_read_scanlines(...); */

  /* Here we use the library's state variable cinfo.output_scanline as the
   * loop counter, so that we don't have to keep track ourselves.
   */
  int tex_width, tex_height;

   tex_width = nextp2(cinfo.output_width);
   tex_height = nextp2(cinfo.output_height);

   unsigned char * image_data = (unsigned char *)malloc(sizeof(unsigned char)*row_stride*cinfo.output_height);

  while (cinfo.output_scanline < cinfo.output_height) {
    /* jpeg_read_scanlines expects an array of pointers to scanlines.
     * Here the array is only one element long, but you could ask for
     * more than one scanline at a time if that's more convenient.
     */
    (void) jpeg_read_scanlines(&cinfo, buffer, 1);

    memcpy(image_data + sizeof(unsigned char)*(cinfo.output_height- cinfo.output_scanline) * row_stride,
    		buffer[0],
    		row_stride);


    /* Assume put_scanline_someplace wants a pointer and sample count. */
    /// put_scanline_someplace(buffer[0], row_stride);
  }

//    memset(image_data,0xAA,sizeof(unsigned char)*row_stride*cinfo.output_height);
	if (m_img && &m_img)
	{
			glDeleteTextures(1,&m_img);
			m_img = 0;
	}
    glGenTextures(1, &m_img);
    glBindTexture(GL_TEXTURE_2D, m_img);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);

    glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
/*
   for (int i = 5 ;i < cinfo.output_width-5 ;i ++)
    for (int l = 5 ;l< cinfo.output_height-5 ;l ++)
    {  image_data[l*cinfo.output_width*3 +i*3]=(image_data[l*cinfo.output_width*3 +i*3+15] +image_data[l*cinfo.output_width*3 +i*3-15])/2;
      image_data[l*cinfo.output_width*3 +i*3+1]=(image_data[l*cinfo.output_width*3 +i*3+1+15] +image_data[l*cinfo.output_width*3 +i*3-15+1])/2; 
       image_data[l*cinfo.output_width*3 +i*3+2]=(image_data[l*cinfo.output_width*3 +i*3+2+15] +image_data[l*cinfo.output_width*3 +i*3-15+2])/2; 
     }  
     */
     //glTexImage2D(GL_TEXTURE_2D, 0, format, 600,1024, 0, format, GL_UNSIGNED_BYTE, image_data);
    
    glTexImage2D(GL_TEXTURE_2D, 0, format, tex_width, tex_height, 0, format, GL_UNSIGNED_BYTE, NULL);
    glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, cinfo.output_width, cinfo.output_height-300, format, GL_UNSIGNED_BYTE, image_data);
    glTexSubImage2D(GL_TEXTURE_2D, 0, 0, cinfo.output_height-200, cinfo.output_width,200 , format, GL_UNSIGNED_BYTE, image_data);
  
    
    GLint err = glGetError();

    free(image_data);

    if (err == 0) {

        //Return modified texture coordinates if pointers are not null

    	if(w != 0)
    	{
    		m_width = w;
    		m_height = h;
    	}
    	else
    	{
    		m_width = cinfo.output_width;
    		m_height = cinfo.output_height;
    	}

          tex_x = ((float) cinfo.output_width - 0.5f) / ((float)tex_width);
          tex_y = ((float) cinfo.output_height - 0.5f) / ((float)tex_height);

      	fprintf(stderr,"ZAImage: jpeg ok %s - x:%f y:%f w:%d h:%d\n" ,
      			filename ,tex_x ,tex_y,m_width,m_height);

        return EXIT_SUCCESS;
    } else {
        fprintf(stderr, "GL error %i \n", err);
        return EXIT_FAILURE;
    }

  /* Step 7: Finish decompression */

  (void) jpeg_finish_decompress(&cinfo);
  /* We can ignore the return value since suspension is not possible
   * with the stdio data source.
   */

  /* Step 8: Release JPEG decompression object */

  /* This is an important step since it will release a good deal of memory. */
  jpeg_destroy_decompress(&cinfo);

  /* After finish_decompress, we can close the input file.
   * Here we postpone it until after no more JPEG errors are possible,
   * so as to simplify the setjmp error logic above.  (Actually, I don't
   * think that jpeg_destroy can do an error exit, but why assume anything...)
   */
  fclose(infile);

  /* At this point you may want to check to see whether any corrupt-data
   * warnings occurred (test whether jerr.pub.num_warnings is nonzero).
   */

  /* And we're done! */
  return 1;
}

METHODDEF (void) my_error_exit (j_common_ptr cinfo)
{
  /* cinfo->err really points to a my_error_mgr struct, so coerce pointer */
  my_error_ptr myerr = (my_error_ptr) cinfo->err;

  /* Always display the message. */
  /* We could postpone this until after returning, if we chose. */
  (*cinfo->err->output_message) (cinfo);

  /* Return control to the setjmp point */
  longjmp(myerr->setjmp_buffer, 1);
}


font_t* load_font(const char* path, int point_size, int dpi)
{
	FT_Library library;
	FT_Face face;
	int c;
	int i, j;
	font_t* font;

	if (!initialized)
	{
		fprintf(stderr, "EGL has not been initialized\n");
		return NULL ;
	}

	if (!path)
	{
		fprintf(stderr, "Invalid path to font file\n");
		return NULL ;
	}

	if (FT_Init_FreeType(&library))
	{
		fprintf(stderr, "Error loading Freetype library\n");
		return NULL ;
	}
	if (FT_New_Face(library, path, 0, &face))
	{
		fprintf(stderr, "Error loading font %s\n", path);
		return NULL ;
	}

	{
		int iCharMapCnt = face->num_charmaps;
		FT_CharMap* pCharMaps = face->charmaps;
 		//FT_ULong lang= FT_Get_CMap_Language_ID(*pCharMaps);
		int ic;
		for (ic = 0; ic < iCharMapCnt; ic++)
		{
			FT_CharMapRec aCharMap = *(pCharMaps[ic]);
			FT_Encoding enconding = aCharMap.encoding;
			if (ic == 0)
			{
			}
			int platform_id = aCharMap.platform_id;

			int encoding_id = aCharMap.encoding_id;
			fprintf(stderr,
					"bbutil_load_font  %d platform_id %d, encoding_id %d lang %d\n",
					ic, platform_id, encoding_id, 0);
		}
	}

	if (FT_Set_Char_Size(face, point_size * 64, point_size * 64, dpi, dpi))
	{
		fprintf(stderr, "Error initializing character parameters\n");
		return NULL ;
	}

	font = (font_t*) malloc(sizeof(font_t));
	font->initialized = 0;

	glGenTextures(1, &(font->font_texture));

	//Let each glyph reside in 32x32 section of the font texture
	int segment_size_x = 0, segment_size_y = 0;
	int num_segments_x = 16;
	int num_segments_y = 8;

	FT_GlyphSlot slot;
	FT_Bitmap bmp;
	int glyph_width, glyph_height;

	//First calculate the max width and height of a character in a passed font
	for (c = 0; c < 128; c++)
	{
		//
		if (FT_Load_Char(face, 0x4E2D + c - 0x4E2D, FT_LOAD_RENDER))
		{
			fprintf(stderr, "FT_Load_Char failed\n");
			free(font);
			return NULL ;
		}

		slot = face->glyph;
		bmp = slot->bitmap;

		//glyph_width = nextp2(bmp.width);
		//glyph_height = nextp2(bmp.rows);

		glyph_width = bmp.width;
		glyph_height = bmp.rows;

		if (glyph_width > segment_size_x)
		{
			segment_size_x = glyph_width;
		}

		if (glyph_height > segment_size_y)
		{
			segment_size_y = glyph_height;
		}
	}

	int font_tex_width = nextp2(num_segments_x * segment_size_x);
	int font_tex_height = nextp2(num_segments_y * segment_size_y);

	int bitmap_offset_x = 0, bitmap_offset_y = 0;

	GLubyte* font_texture_data = (GLubyte*) malloc(
			sizeof(GLubyte) * 2 * font_tex_width * font_tex_height);
	memset((void*) font_texture_data, 0,
			sizeof(GLubyte) * 2 * font_tex_width * font_tex_height);

	if (!font_texture_data)
	{
		fprintf(stderr, "Failed to allocate memory for font texture\n");
		free(font);
		return NULL ;
	}

	// Fill font texture bitmap with individual bmp data and record appropriate size, texture coordinates and offsets for every glyph
	for (c = 0; c < 128; c++)
	{
		if (FT_Load_Char(face, 0x4E2D + c - 0x4E2D, FT_LOAD_RENDER))
		{
			fprintf(stderr, "FT_Load_Char failed\n");
			free(font);
			return NULL ;
		}

		slot = face->glyph;
		bmp = slot->bitmap;

		glyph_width = nextp2(bmp.width);
		glyph_height = nextp2(bmp.rows);

		div_t temp = div(c, num_segments_x);

		bitmap_offset_x = segment_size_x * temp.rem;
		bitmap_offset_y = segment_size_y * temp.quot;

		for (j = 0; j < glyph_height; j++)
		{
			for (i = 0; i < glyph_width; i++)
			{
				font_texture_data[2
						* ((bitmap_offset_x + i)
								+ (j + bitmap_offset_y) * font_tex_width) + 0] =
						font_texture_data[2
								* ((bitmap_offset_x + i)
										+ (j + bitmap_offset_y) * font_tex_width)
								+ 1] =
								(i >= bmp.width || j >= bmp.rows) ?
										0 : bmp.buffer[i + bmp.width * j];
			}
		}

		font->advance[c] = (float) (slot->advance.x >> 6);
		font->tex_x1[c] = (float) bitmap_offset_x / (float) font_tex_width;
		font->tex_x2[c] = (float) (bitmap_offset_x + bmp.width)
				/ (float) font_tex_width;
		font->tex_y1[c] = (float) bitmap_offset_y / (float) font_tex_height;
		font->tex_y2[c] = (float) (bitmap_offset_y + bmp.rows)
				/ (float) font_tex_height;
		font->width[c] = bmp.width;
		font->height[c] = bmp.rows;
		font->offset_x[c] = (float) slot->bitmap_left;
		font->offset_y[c] = (float) ((slot->metrics.horiBearingY
				- face->glyph->metrics.height) >> 6);  
				
		
	}

	glBindTexture(GL_TEXTURE_2D, font->font_texture);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);

	glTexImage2D(GL_TEXTURE_2D, 0, GL_LUMINANCE_ALPHA, font_tex_width,
			font_tex_height, 0, GL_LUMINANCE_ALPHA, GL_UNSIGNED_BYTE,
			font_texture_data);

	int err = glGetError();

	free(font_texture_data);

	FT_Done_Face(face);
	FT_Done_FreeType(library);

	if (err != 0)
	{
		fprintf(stderr, "GL Error 0x%x", err);
		free(font);
		return NULL ;
	}

	font->initialized = 1;
	return font;
}


void render_text(font_t* font, const char* msg, float x, float y)
{
	int i, c;
	GLfloat *vertices;
	GLfloat *texture_coords;
	GLshort* indices;

	float pen_x = 0.0f;

	if (!font)
	{
		fprintf(stderr, "Font must not be null\n");
		return;
	}

	if (!font->initialized)
	{
		fprintf(stderr, "Font has not been loaded\n");
		return;
	}

	if (!msg)  
	{
		return;
	}

	int texture_enabled;
	glGetIntegerv(GL_TEXTURE_2D, &texture_enabled);
	if (!texture_enabled)
	{
		glEnable(GL_TEXTURE_2D);
	}

	int blend_enabled;
	glGetIntegerv(GL_BLEND, &blend_enabled);
	if (!blend_enabled)
	{
		glEnable(GL_BLEND);
	}

	int gl_blend_src, gl_blend_dst;
	glGetIntegerv(GL_BLEND_SRC, &gl_blend_src);
	glGetIntegerv(GL_BLEND_DST, &gl_blend_dst);

	//glBlendFunc(GL_ZERO, GL_ONE_MINUS_SRC_ALPHA);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	//glBlendFunc(GL_ONE, GL_SRC_ALPHA);

	int vertex_array_enabled;
	glGetIntegerv(GL_VERTEX_ARRAY, &vertex_array_enabled);
	if (!vertex_array_enabled)
	{
		glEnableClientState(GL_VERTEX_ARRAY);
	}

	int texture_array_enabled;
	glGetIntegerv(GL_TEXTURE_COORD_ARRAY, &texture_array_enabled);
	if (!texture_array_enabled)
	{
		glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	}

	vertices = (GLfloat*) malloc(sizeof(GLfloat) * 8 * strlen(msg));
	texture_coords = (GLfloat*) malloc(sizeof(GLfloat) * 8 * strlen(msg));

	indices = (GLshort*) malloc(sizeof(GLfloat) * 6 * strlen(msg));

	for (i = 0; i < strlen(msg); ++i)
	{
		c = msg[i];
		
		vertices[8 * i + 0] = x + pen_x + font->offset_x[c];
		vertices[8 * i + 1] = y + font->offset_y[c];
		vertices[8 * i + 2] = vertices[8 * i + 0] + font->width[c];
		vertices[8 * i + 3] = vertices[8 * i + 1];
		vertices[8 * i + 4] = vertices[8 * i + 0];
		vertices[8 * i + 5] = vertices[8 * i + 1] + font->height[c];
		vertices[8 * i + 6] = vertices[8 * i + 2];
		vertices[8 * i + 7] = vertices[8 * i + 5];

		texture_coords[8 * i + 0] = font->tex_x1[c];
		texture_coords[8 * i + 1] = font->tex_y2[c];
		texture_coords[8 * i + 2] = font->tex_x2[c];
		texture_coords[8 * i + 3] = font->tex_y2[c];
		texture_coords[8 * i + 4] = font->tex_x1[c];
		texture_coords[8 * i + 5] = font->tex_y1[c];
		texture_coords[8 * i + 6] = font->tex_x2[c];
		texture_coords[8 * i + 7] = font->tex_y1[c];

		indices[i * 6 + 0] = 4 * i + 0;
		indices[i * 6 + 1] = 4 * i + 1;
		indices[i * 6 + 2] = 4 * i + 2;
		indices[i * 6 + 3] = 4 * i + 2;
		indices[i * 6 + 4] = 4 * i + 1;
		indices[i * 6 + 5] = 4 * i + 3;

		//Assume we are only working with typewriter fonts
		pen_x += font->advance[c]; 
		
	//	fprintf(stderr, "rendx  c:%c  penx:%f font:%f \n ",c ,pen_x,font->advance[c]); 
	}

	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glTexCoordPointer(2, GL_FLOAT, 0, texture_coords);
	glBindTexture(GL_TEXTURE_2D, font->font_texture);

	glDrawElements(GL_TRIANGLES, 6 * strlen(msg), GL_UNSIGNED_SHORT, indices);

	if (!texture_array_enabled)
	{
		glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	}

	if (!vertex_array_enabled)
	{
		glDisableClientState(GL_VERTEX_ARRAY);
	}

	if (!texture_enabled)
	{
		glDisable(GL_TEXTURE_2D);
	}

	glBlendFunc(gl_blend_src, gl_blend_dst);

	if (!blend_enabled)
	{
		glDisable(GL_BLEND);
	}

	free(vertices);
	free(texture_coords);
	free(indices);
}

void destroy_font(font_t* font)
{
	if (!font)
	{
		return;
	}

	glDeleteTextures(1, &(font->font_texture));

	free(font);
}

void DrawR()
{
	GLfloat PII=3.141592f;

	glEnableClientState(GL_VERTEX_ARRAY);
	glColor4f(1.0f, 0.6f, 0.3f, 1.0f);
	glLineWidth(2.0f);
	GLfloat v[200];
	glEnable(GL_BLEND); 
  //	glBlendFunc(GL_ZERO, GL_ONE_MINUS_SRC_ALPHA);  
  
	for (GLfloat angle = 0.0f; angle <= 2*PII ; angle += 0.005f )
	{
		glPushMatrix();
		v[1]  = 1.0f*sin(angle);
		v[0]  = 1.0f*cos(angle);

		v[2] = 0.0f;
		v[3]=  0.0f;

		glVertexPointer(2, GL_FLOAT, 0, v);
		glTranslatef(-100.0f, 100.0f, -6.0f);
		glScalef(80.0f, 220.0f, 1.0f);
		glRotatef(45.0f,0.0f,0.0f,1.0f);
		glDrawArrays(GL_LINES, 0, 2);

		glPopMatrix();
	}
	glDisable(GL_BLEND); 
	glDisableClientState(GL_VERTEX_ARRAY);
}	