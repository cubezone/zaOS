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


static int swap_interval;
static double frame_rate;

static void update_window_title(GLFWwindow* window)
{
    char title[256];

    sprintf(title, "Tearing detector (interval %i, %0.1f Hz)",
            swap_interval, frame_rate);

    glfwSetWindowTitle(window, title);
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

    
      glViewport( 0, 0, (GLint) width, (GLint) height );
  glMatrixMode( GL_PROJECTION );
  glLoadIdentity();
 gluPerspective(40.0,(GLfloat)width/(GLfloat)height, 0.1, 100.0);  
  glMatrixMode( GL_MODELVIEW );
  glLoadIdentity();

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

    glfwSetErrorCallback(error_callback);

    if (!glfwInit())
        exit(EXIT_FAILURE);

    window = glfwCreateWindow(640, 480, "", NULL, NULL);
    if (!window)
    {
        glfwTerminate();
        exit(EXIT_FAILURE);
    }

    glfwMakeContextCurrent(window);
    set_swap_interval(window, 0);

    last_time = glfwGetTime();
    frame_rate = 0.0;

    glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);
    glfwSetKeyCallback(window, key_callback);

    glClearColor(0.1f , 0.1f , 0.1f , 0.5f );     
	glViewport(0  ,0  ,840,480);       

    glMatrixMode(GL_PROJECTION);
    //glLoadIdentity();  
    //glOrtho(-1.f, 1.f, -1.f, 1.f, 1.f, -1.f);
    glLoadIdentity();
	glOrtho(0.0f, 640 / 480, 0.0f, 1.0f, 1.0f, 1.0f);
	
	
   gluPerspective(40.0,(GLfloat)640/(GLfloat)480, 0.1, 100.0);  
    
    glMatrixMode(GL_MODELVIEW);
    //glLoadIdentity();
    glScalef(1.0f / 480, 1.0f / 480, 1.0f);
glLoadIdentity();  
gluLookAt (0.0, 0.0, -10.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);  
    glEnable(GL_BLEND); // 打开混合
//  glDisable(GL_DEPTH_TEST); // 关闭深度测试
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); // 基于源象素alpha通道值的半透明混合函数


   float a = 0.f;
   float t = 0.004f;
    while (!glfwWindowShouldClose(window))
    {
    	 glEnable(GL_DEPTH_TEST);
        glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);

  // glLoadIdentity();
  //
       glLoadIdentity();  
    
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
        glTranslatef(-a -2, -1.f, -0.1f-3.f *s);
      else
        glTranslatef(-a -2, -1.f, -0.1f+ 3.f *s);	
        
   
      // glRotatef(180*cosf((float) glfwGetTime() * 1.f),0.0f,1.0f,0.0f);

    /*           
        position = cosf((float) glfwGetTime() * 4.f) * 0.75f;
        position =  0.f;
        glColor3f (1.0, 1.0, 0.0); 
        glRectf(position - 2.25f, -2.f, position + 2.25f, 2.f);
            
        glColor4f (1.0, 0.0, 1.0,0.5); 
        glTranslatef(0.0f, 0.0f,1.0f);
        glRectf(position - 1.5f, -0.5f, position - 0.4f, 0.5f);
 */   
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
  
  		for (int n = 0 ;  n < 3 ; n ++ )
        for (int m = 0 ;  m < 8 ;m ++ )             
  		{
  			    glPushMatrix(); 
  			   glColor4f(0, 0.5+0.05*m, 0.5+0.05*m,1.0);        			 
  			   glTranslatef(1.0f*m, 1.f*n,0.f);     			   
  			  glRectf(-0.3,-0.2,0.3,0.2);  
  			  glTranslatef(0, 0,0.0001f);     			   
  			  glColor4f(1, 0.5+0.05*m, 0.5+0.05*m,1.0);        			 
  			   glRectf(-0.3,-0.1,0.3,0.1);  
  			  glPopMatrix();
  		}
  		
             
     
        //  glPopMatrix();
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

    glfwTerminate();
    exit(EXIT_SUCCESS);
    return 0;
}