/*
 * ZAImage.cpp
 *
 *  Created on: 2012-2-14
 *      Author: zhuxy
 */

#include "ZAImage.h"
namespace bbcubezone {
ZAImage::ZAImage() {
	// TODO Auto-generated constructor stub
	m_d = 10.0f+30.0f*(float)rand()/RAND_MAX ;
	m_r = 0;
	m_z = 1;
	m_stop = false;
	m_rotation = true;
	m_darkstyle = false;
	m_img = 0;
	m_alpha = 1.0f;
	this->m_trans = 1.0f;
	this->m_enable = false;
}

ZAImage::~ZAImage() {
	// TODO Auto-generated destructor stub
	if (m_img && &m_img)
	glDeleteTextures(1,&m_img);
}


void ZAImage::reset() {
	m_d = 10.0f+30.0f*(float)rand()/RAND_MAX ;
	m_r = 0;
	m_z = 1;
	m_stop = false;
}


void ZAImage::setrote(int r)
{
	m_r = r;
}

int ZAImage::DrawImg()
{
	return DrawImg( m_x ,  m_y,  m_r );
}

void ZAImage::Ran()
{

// m_d -= 0.003f;
	if (m_rotation)
	m_r += m_d;
//	m_z -= l_z;

	if (m_z < 0)
		m_z = 0;
}

int ZAImage::RunImg()
{
	if (m_stop)
		return DrawImg();

	Ran();
	if (m_z < 0 ) return 0;

	int l_x ,l_y ;

	float l_rate = cos(3.1415f/2*(1-m_z));
	if (l_rate < 0.4) l_rate = 0.4;

	l_x = 512 + (m_x -512) * l_rate;
	l_y = 300 + (m_y -300) * l_rate;

	return DrawImg( l_x ,  l_y,  m_r );
}


int ZAImage::DrawImg(int x , int y, int r )
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
	glRotatef(m_r,0.0f,0.0f,1.0f);

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

static inline int
nextp2(int x)
{
    int val = 1;
    while(val < x) val <<= 1;
    return val;
}

int ZAImage::load_memory(const char* filename, int* width, int* height, float* tex_x, float* tex_y, unsigned int *tex)
{
    GLuint format;
    int image_width = *width;
    int image_height = *height;
    format = GL_RGBA;

    // Allocate the image_data as a big block, to be given to opengl
//    unsigned char *image_data = (unsigned char *) malloc(4 * image_width * image_height);


//     glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
//     glPixelStorei(GL_UNPACK_ALIGNMENT, 4);
//     glReadPixels(0, 0, image_width, image_height,
//    		 GL_RGBA, GL_UNSIGNED_BYTE, image_data);

   // ȫ��ɫ����
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


    glCopyTexImage2D(GL_TEXTURE_2D, 0, format, 0,0,tex_width, tex_height, 0);
    glCopyTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, 0,0,image_width, image_height);

//

//    glTexImage2D(GL_TEXTURE_2D, 0, format, tex_width, tex_height, 0, format, GL_UNSIGNED_BYTE, NULL);
//    glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, image_width, image_height, format, GL_UNSIGNED_BYTE, image_data);

    GLint err = glGetError();

//    free(image_data);

    if (err == 0) {
        //Return physical with and height of texture if pointers are not null
        if(width) {
            *width = image_width;
        }
        if (height) {
            *height = image_height;
        }
        //Return modified texture coordinates if pointers are not null
        if(tex_x) {
            *tex_x = ((float) image_width - 0.5f) / ((float)tex_width);
        }
        if(tex_y) {
            *tex_y = ((float) image_height - 0.5f) / ((float)tex_height);
        }
        return EXIT_SUCCESS;
    } else {
        fprintf(stderr, "GL error %i \n", err);
        return EXIT_FAILURE;
    }
}

int ZAImage::LoadImgFromMemory(const char * p,int w,int h)
{
	m_isRGBA = false;
	glColor4f(1.0f,1.0f, 1.0f, 1.0f);
	if (m_img && (&m_img))
		glDeleteTextures(1,&m_img);
	if (EXIT_SUCCESS
				!= load_memory(NULL,&w, &h,
						&tex_x, &tex_y,&m_img))
	{
		fprintf(stderr,"ZAImage::LoadImgFromMemory error %s",p);
		return -1;
	}

	m_width = w;
	m_height = h;
	fprintf(stderr,"LoadImgFromMemory ok %p x:%d  y:%d \n" ,this, m_width ,m_height);
	return EXIT_SUCCESS;
}

void ZAImage::drawControl()
{
	int a = m_x, b= m_y;
	getClientXY(a,b);
	DrawImg(a,b,m_r);
	//fprintf(stderr,"ZAImage::drowcontrol %p %d %d %d %d\n",this,a, b,m_width,m_height);
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

int ZAImage::get_PNG_size(const char * filename,int & w,int& h)
{
	    GLuint format;
	    //header for testing if it is a png
	    png_byte header[8];

	    //open file as binary
	    FILE *fp = fopen(filename, "rb");
	    if (!fp) {
	        return EXIT_FAILURE;
	    }

	    //read the header
	    fread(header, 1, 8, fp);

	    //test if png
	    int is_png = !png_sig_cmp(header, 0, 8);
	    if (!is_png) {
	        fclose(fp);
	        return EXIT_FAILURE;
	    }

	    //create png struct
	    png_structp png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
	    if (!png_ptr) {
	        fclose(fp);
	        return EXIT_FAILURE;
	    }

	    //create png info struct
	    png_infop info_ptr = png_create_info_struct(png_ptr);
	    if (!info_ptr) {
	        png_destroy_read_struct(&png_ptr, (png_infopp) NULL, (png_infopp) NULL);
	        fclose(fp);
	        return EXIT_FAILURE;
	    }

	    //create png info struct
	    png_infop end_info = png_create_info_struct(png_ptr);
	    if (!end_info) {
	        png_destroy_read_struct(&png_ptr, &info_ptr, (png_infopp) NULL);
	        fclose(fp);
	        return EXIT_FAILURE;
	    }

	    //setup error handling (required without using custom error handlers above)
	    if (setjmp(png_jmpbuf(png_ptr))) {
	        png_destroy_read_struct(&png_ptr, &info_ptr, &end_info);
	        fclose(fp);
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
	    png_uint_32 image_width, image_height;

	    // get info about png
	    png_get_IHDR(png_ptr, info_ptr, &image_width, &image_height, &bit_depth, &color_type, NULL, NULL, NULL);

	    w = image_width;
	    h = image_height;

	    png_destroy_read_struct(&png_ptr, &info_ptr, &end_info);

	    fclose(fp);

	    return EXIT_FAILURE;
}

void ZAImage::getsize(const char * filename,int & w,int& h)
{
	if(strstr(filename,".png")>0)
		get_PNG_size(filename,w,h);
	else
		get_JPEG_size(filename,w,h);

}

int ZAImage::get_JPEG_size(const char * filename,int & w,int& h)
{
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
	    fprintf(stderr, "can't open %s\n", filename);
	    return 0;
	  }

	  cinfo.err = jpeg_std_error(&jerr.pub);

	  jerr.pub.error_exit = my_error_exit;

	  if (setjmp(jerr.setjmp_buffer)) {
	    jpeg_destroy_decompress(&cinfo);
	    fclose(infile);
	    return 0;
	  }
	  /* Now we can initialize the JPEG decompression object. */
	  jpeg_create_decompress(&cinfo);

	  jpeg_stdio_src(&cinfo, infile);
	  (void) jpeg_read_header(&cinfo, TRUE);
	  (void) jpeg_start_decompress(&cinfo);
	  w = cinfo.output_width;
	  h = cinfo.output_height;

	  jpeg_destroy_decompress(&cinfo);

	  fclose(infile);
	  return 0;
}

int ZAImage::read_JPEG2_file (const char * filename,int w,int h)
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
				m_img = NULL;
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
			m_img = NULL;
	}
    glGenTextures(1, &m_img);
    glBindTexture(GL_TEXTURE_2D, m_img);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);

    glPixelStorei(GL_UNPACK_ALIGNMENT, 1);


    glTexImage2D(GL_TEXTURE_2D, 0, format, tex_width, tex_height, 0, format, GL_UNSIGNED_BYTE, NULL);
    glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, cinfo.output_width, cinfo.output_height, format, GL_UNSIGNED_BYTE, image_data);

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


void ZAImage::write_JPEG_file (char * filename, int quality,int image_width,int image_height,JSAMPLE * image_buffer)
{
  //quality 80

  /* This struct contains the JPEG compression parameters and pointers to
   * working space (which is allocated as needed by the JPEG library).
   * It is possible to have several such structures, representing multiple
   * compression/decompression processes, in existence at once.  We refer
   * to any one struct (and its associated working data) as a "JPEG object".
   */
  struct jpeg_compress_struct cinfo;
  /* This struct represents a JPEG error handler.  It is declared separately
   * because applications often want to supply a specialized error handler
   * (see the second half of this file for an example).  But here we just
   * take the easy way out and use the standard error handler, which will
   * print a message on stderr and call exit() if compression fails.
   * Note that this struct must live as long as the main JPEG parameter
   * struct, to avoid dangling-pointer problems.
   */
  struct jpeg_error_mgr jerr;
  /* More stuff */
  FILE * outfile;		/* target file */
  JSAMPROW row_pointer[1];	/* pointer to JSAMPLE row[s] */
  int row_stride;		/* physical row width in image buffer */

  /* Step 1: allocate and initialize JPEG compression object */

  /* We have to set up the error handler first, in case the initialization
   * step fails.  (Unlikely, but it could happen if you are out of memory.)
   * This routine fills in the contents of struct jerr, and returns jerr's
   * address which we place into the link field in cinfo.
   */
  cinfo.err = jpeg_std_error(&jerr);
  /* Now we can initialize the JPEG compression object. */
  jpeg_create_compress(&cinfo);

  /* Step 2: specify data destination (eg, a file) */
  /* Note: steps 2 and 3 can be done in either order. */

  /* Here we use the library-supplied code to send compressed data to a
   * stdio stream.  You can also write your own code to do something else.
   * VERY IMPORTANT: use "b" option to fopen() if you are on a machine that
   * requires it in order to write binary files.
   */
  if ((outfile = fopen(filename, "wb")) == NULL) {
    fprintf(stderr, "can't open %s\n", filename);
    exit(1);
  }
  jpeg_stdio_dest(&cinfo, outfile);

  /* Step 3: set parameters for compression */

  /* First we supply a description of the input image.
   * Four fields of the cinfo struct must be filled in:
   */
  cinfo.image_width = image_width; 	/* image width and height, in pixels */
  cinfo.image_height = image_height;
  cinfo.input_components = 3;		/* # of color components per pixel */
  cinfo.in_color_space = JCS_RGB; 	/* colorspace of input image */
  /* Now use the library's routine to set default compression parameters.
   * (You must set at least cinfo.in_color_space before calling this,
   * since the defaults depend on the source color space.)
   */
  jpeg_set_defaults(&cinfo);
  /* Now you can set any non-default parameters you wish to.
   * Here we just illustrate the use of quality (quantization table) scaling:
   */
  jpeg_set_quality(&cinfo, quality, TRUE /* limit to baseline-JPEG values */);

  /* Step 4: Start compressor */

  /* TRUE ensures that we will write a complete interchange-JPEG file.
   * Pass TRUE unless you are very sure of what you're doing.
   */
  jpeg_start_compress(&cinfo, TRUE);

  /* Step 5: while (scan lines remain to be written) */
  /*           jpeg_write_scanlines(...); */

  /* Here we use the library's state variable cinfo.next_scanline as the
   * loop counter, so that we don't have to keep track ourselves.
   * To keep things simple, we pass one scanline per call; you can pass
   * more if you wish, though.
   */
  row_stride = image_width * 3;	/* JSAMPLEs per row in image_buffer */

  while (cinfo.next_scanline < cinfo.image_height) {
    /* jpeg_write_scanlines expects an array of pointers to scanlines.
     * Here the array is only one element long, but you could pass
     * more than one scanline at a time if that's more convenient.
     */
    row_pointer[0] = & image_buffer[cinfo.next_scanline * row_stride];
    (void) jpeg_write_scanlines(&cinfo, row_pointer, 1);
  }

  /* Step 6: Finish compression */

  jpeg_finish_compress(&cinfo);
  /* After finish_compress, we can close the output file. */
  fclose(outfile);

  /* Step 7: release JPEG compression object */

  /* This is an important step since it will release a good deal of memory. */
  jpeg_destroy_compress(&cinfo);

  /* And we're done! */
}

void  ZAImage::LoadImg(const char * p,int w,int h)
{
	if (p)
		strcpy(m_filename,p);
	else
		strcpy(m_filename,"NULL");

	if (strstr(p,".png")>0)
		Load_PNG_file(p, w, h);
	else
		read_JPEG2_file(p, w, h);
}


int ZAImage::Load_PNG2_file(const char * p,int w,int h)
{

//	typedef struct{
//	    GLsizei width;
//	    GLsizei height;
//	    GLenum format;
//	    GLint internalFormat;
//	    GLuint id;
//	    GLubyte *texels;
//	}gl_texture_t;
//
//
//	m_isRGBA = true;
//	if (m_img && &m_img)
//			glDeleteTextures(1,&m_img);
//
//
//	    gl_texture_t *texinfo;
//	    png_byte magic[8];
//	    png_structp png_ptr;
//	    png_infop info_ptr;
//	    int bit_depth, color_type;
//	    FILE *fp = NULL;
//	    png_bytep *row_pointers = NULL;
//	    //png_uint_32 w, h;
//	    int i;
//	    /* Open image file */
//	    fp = fopen (p, "rb");
//	    if (!fp)
//	    {
//	        fprintf (stderr, "error: couldn't open \"%s\"!\n", p);
//	        return NULL;
//	    }
//	    /* Read magic number */
//	    fread (magic, 1, sizeof (magic), fp);
//	    /* Check for valid magic number */
//	    if (!png_check_sig (magic, sizeof (magic)))
//	    {
//	        fprintf (stderr, "error: \"%s\" is not a valid PNG image!\n", p);
//	        fclose (fp);
//	        return NULL;
//	    }
//	    /* Create a png read struct */
//	    png_ptr = png_create_read_struct (PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
//	    if (!png_ptr)
//	    {
//	        fclose (fp);
//	        return NULL;
//	    }
//	    /* Create a png info struct */
//	    info_ptr = png_create_info_struct (png_ptr);
//	    if (!info_ptr)
//	    {
//	        fclose (fp);
//	        png_destroy_read_struct (&png_ptr, NULL, NULL);
//	        return NULL;
//	    }
//	    /* Create our OpenGL texture object */
//	    texinfo = (gl_texture_t *) malloc (sizeof (gl_texture_t));
//	    /* Initialize the setjmp for returning properly after a libpng error occured */
//	    if (setjmp (png_jmpbuf (png_ptr)))
//	    {
//	        fclose (fp);
//	        png_destroy_read_struct (&png_ptr, &info_ptr, NULL);
//	        if (row_pointers) free (row_pointers);
//	        if (texinfo) {
//	            if (texinfo->texels)
//	                free (texinfo->texels);
//	            free (texinfo);
//	        }
//	        return NULL;
//	    }
//	    /* Setup libpng for using standard C fread() function with our FILE pointer */
//	    png_init_io (png_ptr, fp);
//	    /* Tell libpng that we have already read the magic number */
//	    png_set_sig_bytes (png_ptr, sizeof (magic));
//	    /* Read png info */
//	    png_read_info (png_ptr, info_ptr);
//	    /* Get some usefull information from header */
//	    bit_depth = png_get_bit_depth (png_ptr, info_ptr);
//	    color_type = png_get_color_type (png_ptr, info_ptr);
//	    /* Convert index color images to RGB images */
//	    if (color_type == PNG_COLOR_TYPE_PALETTE)
//	        png_set_palette_to_rgb (png_ptr);
//	    /* Convert 1-2-4 bits grayscale images to 8 bits grayscale. */
//	    if (color_type == PNG_COLOR_TYPE_GRAY && bit_depth < 8)
//	       // png_set_gray_1_2_4_to_8 (png_ptr);
//	    	png_set_gray_to_rgb(png_ptr);
//	    if (png_get_valid (png_ptr, info_ptr, PNG_INFO_tRNS))
//	        png_set_tRNS_to_alpha (png_ptr);
//	    if (bit_depth == 16) png_set_strip_16 (png_ptr);
//	    else if (bit_depth < 8) png_set_packing (png_ptr);
//	    /* Update info structure to apply transformations */
//	    png_read_update_info (png_ptr, info_ptr);
//	    /* Retrieve updated information */
//	    png_get_IHDR(png_ptr, info_ptr, &w, &h, &bit_depth, &color_type, NULL, NULL, NULL);
//	    texinfo->width = w;
//	    texinfo->height = h;
//	    /* Get image format and components per pixel */
//	    GetPNGtextureInfo (color_type, texinfo);
//	    /* We can now allocate memory for storing pixel data */
//	    texinfo->texels = (GLubyte *)malloc (sizeof (GLubyte) * texinfo->width * texinfo->height * texinfo->internalFormat);
//	    /* Setup a pointer array. Each one points at the begening of a row. */
//	    row_pointers = (png_bytep *)malloc (sizeof (png_bytep) * texinfo->height);
//	    for (i = 0; i < texinfo->height; ++i)
//	    {
//	        row_pointers[i] = (png_bytep)(texinfo->texels + ((texinfo->height - (i + 1)) * texinfo->width * texinfo->internalFormat));
//	    }
//	    /* Read pixel data using row pointers */
//	    png_read_image (png_ptr, row_pointers);
//	    /* Finish decompression and release memory */
//	    png_read_end (png_ptr, NULL);
//	    png_destroy_read_struct (&png_ptr, &info_ptr, NULL);
//	    /* We don't need row pointers anymore */
//	    free (row_pointers);
//	    fclose (fp);
//
//	    /* Generate texture */
//	          glGenTextures (1, &m_img);
//	          glBindTexture (GL_TEXTURE_2D, m_img);
//	          /* Setup some parameters for texture filters and mipmapping */
//	          glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
//	          glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
//	          glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
//	          glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
//	          glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE);
//
//
//	          glPixelStorei (GL_UNPACK_ALIGNMENT, 1);
//	          glTexImage2D (GL_TEXTURE_2D, 0, png_tex->internalFormat, png_tex->width, png_tex->height, 0, png_tex->format, GL_UNSIGNED_BYTE, png_tex->texels);
//
//	          /* OpenGL has its own copy of texture data */
//	          free (png_tex->texels);
//	          free (png_tex);
//	fprintf(stderr,"ZAImage:load png ok %s - x:%f y:%f w:%d h:%d\n" ,
//			p ,tex_x ,tex_y,m_width,m_height);
//	return EXIT_SUCCESS;
	return 0;
}

int ZAImage::Load_PNG_file(const char * p,int w,int h)
{
	m_isRGBA = true;
	if (m_img && &m_img)
			glDeleteTextures(1,&m_img);
	//p = "app/native/fly2.png";
	if (EXIT_SUCCESS
				!= bbutil_load_texture(p, &m_width, &m_height,
						&tex_x, &tex_y, &m_img))
	{
		fprintf(stderr,"load png error %s",p);
		return -1;
	}
	if(w)
	{
		m_width = w;
		m_height = h;
	}
	fprintf(stderr,"ZAImage:load png ok %s - x:%f y:%f w:%d h:%d\n" ,
			p ,tex_x ,tex_y,m_width,m_height);
	return EXIT_SUCCESS;
}

int ZAImage::DrawRect(int x, int y, int w , int h)
{
	glColor4f(1.0f, 0.1f, 0.6f, 1.0f);
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnable(GL_BLEND);
	glLineWidth(1.0f);

	GLfloat v[4];
	GLfloat v_c[8]={0.4f, 0.4f, 0.8f, 1.0f,0.3f, 0.3f, 0.3f, 0.0f};
	for (int i = 0; i < 2 ; i++ )
	{
		glPushMatrix();
		if (i==0)
		{
			v[0]  = x;
			v[1]  = y;
			v[2]  = x +w;
			v[3]  = y;
		}
		if (i==1)
		{
			v[0]  = x;
			v[1]  = y +h;
			v[2]  = x +w;
			v[3]  = y +h;
		}

		glVertexPointer(2, GL_FLOAT, 0,v);
		glColorPointer(4,GL_FLOAT,0,v_c);
//		glTranslatef(m_x, m_y, 0.0f);
		if(i==1)
		glDrawArrays(GL_LINES, 0, 2);
		glPopMatrix();
	}
	glDisable(GL_BLEND);
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_COLOR_ARRAY);

	return 0;
}

int ZAImage::FillRect(int color,int x, int y , int w, int h,int tp )
{

	GLfloat v[12] = {
			0.0,0.0,0.0,
			0.0,h,0.0,
			w,h,0.0,
			w,0,0.0} ;

	float r, g , b;
	r = (float)((color & 0xFF0000)>>16)/255;
	g = (float)((color & 0x00FF00)>>8)/255;
	b = (float)((color & 0x0000FF))/255;
	GLfloat v_c[16] = { r,g,b,1.0f,
			 r,g,b,1.0f,
			 r,g,b,1.0f,
			 r,g,b,1.0f};
	//gridline
	if (tp==1)
	{
		v_c[11] = 0.0f;
		v_c[15]= 0.0f;
	}

	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnable(GL_BLEND);

	glVertexPointer(3, GL_FLOAT, 0,v);
	glColorPointer(4,GL_FLOAT,0,v_c);
	glPushMatrix();
	glTranslatef(x, y, 0.0f);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	glPopMatrix();

	glDisable(GL_BLEND);
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_COLOR_ARRAY);
	return 0;
}

int ZAImage::DrawFrame()
{
	GLfloat PII=3.141592f;
	glColor4f(1.0f, 0.6f, 0.3f, 1.0f);
	glEnableClientState(GL_VERTEX_ARRAY);
	glLineWidth(1.0f);
	GLfloat v[4];

	for (GLfloat angle = 0.0f; angle <= 2*PII ; angle += PII/4.0f )
	{
		glPushMatrix();
		if (angle==0)
		{
			v[2]  = 1.0f*cos(angle);
			v[3]  = 1.0f*sin(angle);
		}
		else
		{
			v[2] = v[0];
			v[3] = v[1];
		}
		v[0]  = 1.0f*cos(angle);
		v[1]  = 1.0f*sin(angle);


		glVertexPointer(2, GL_FLOAT, 0, v);
		glTranslatef(m_x, m_y, 0.0f);
		glScalef(m_width/3,m_height/3, 1.0f);
		glRotatef(0.0f,0.0f,0.0f,1.0f);
		glDrawArrays(GL_LINES, 0, 2);
		glPopMatrix();
	}
	glDisableClientState(GL_VERTEX_ARRAY);
	return 0;
}

}
