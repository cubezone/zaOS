/*
 * zaFont.cpp
 *
 *  Created on: 2012-2-19
 *      Author: zhuxy
 */

#include "zaFont.h"

zaFont::zaFont() {
	// TODO Auto-generated constructor stub

	font = NULL;
	m_charset[0]=0;
	this->m_max_x = 0;
	this->m_max_y = 0;
}

/* Finds the next power of 2 */
static inline int
nextp2(int x)
{
    int val = 1;
    while(val < x) val <<= 1;
    return val;
}

int zaFont::clear()
{
	m_max_y = 0;
	m_max_x = 0;
	std::map<uint,font_t*>::iterator iter;
		for (iter = m_map.begin();iter != m_map.end();iter++)
		{
			glDeleteTextures(1, &(iter->second->font_texture));
			free(iter->second);
		}
		m_map.clear();
	return 0;
}

int zaFont::initFont(char * path)
{
    FT_Library library;
    FT_Face face;

    if(FT_Init_FreeType(&library)) {
        fprintf(stderr, "Error loading Freetype library\n");
        return NULL;
    }

    if (FT_New_Face(library,path,0,&face)) {
        fprintf(stderr, "Error loading font %s\n", path);
        return NULL;
    }

	int iCharMapCnt = face->num_charmaps;
	FT_CharMap* pCharMaps = face->charmaps;
	// FT_ULong lang= FT_Get_CMap_Language_ID(*pCharMaps);
	 int ic;
	 for ( ic = 0; ic < iCharMapCnt; ic ++)
	 {
		 if (ic == 0 )
		 {
			 FT_CharMapRec aCharMap = *(pCharMaps[ic]);
			 FT_Encoding enconding = aCharMap.encoding;
			 int platform_id = aCharMap.platform_id;
			 int encoding_id = aCharMap.encoding_id;
//			 this->m_max_x = face->max_advance_width;
//			 this->m_max_y = face->max_advance_height;
			 fprintf(stderr,
					 "initFont "
					 "platform_id %d, "
					 "encoding_id %d "
					 "width %d height %d\n",
					 platform_id,encoding_id,m_max_x,m_max_y);
		 }
	 }
    FT_Done_Face(face);
    FT_Done_FreeType(library);
}

int zaFont::fontconf(const char * charset)
{
	FcFontSet* fs = NULL;
	FcPattern* pat = NULL;
	FcObjectSet* os = NULL;
	//FcChar8* strpat = (FcChar8*)":lang=ja";
	string ls = ":lang=";
	ls.append(charset);

	FcChar8* strpat = (FcChar8*)ls.c_str();
	fprintf(stderr,"zaFont::fontconf charset %s\n",strpat);

	pat = FcNameParse(strpat);
	os = FcObjectSetBuild(FC_FAMILY, FC_CHARSET, FC_STYLE,FC_FILE, (char *)0);
	fs = FcFontList(0, pat, os);
	if(os)
	  FcObjectSetDestroy(os);
	os = NULL;
	  FcPatternDestroy(pat);
	pat = NULL;
	  if(!fs || fs->nfont <= 0)
	  goto nofont;
	 FcChar8 *family;
	FcChar8 *style;
	FcChar8 *file;
	FcCharSet* cs;
	FcChar32 ch;
	FcUtf8ToUcs4((FcChar8*)"这", &ch, 3);
	int i;
	for(i=0; i<fs->nfont; i++)
	{
		  if(FcPatternGetCharSet(fs->fonts[i], FC_CHARSET, 0, &cs) != FcResultMatch)
		  {
			  fprintf(stderr, "no match\n");
			  FcPatternPrint(fs->fonts[i]);
			  goto nofont;
		  }

		  if(FcPatternGetString(fs->fonts[i], FC_FAMILY, 1, &family) != FcResultMatch)
			 if(FcPatternGetString(fs->fonts[i], FC_FAMILY, 0, &family) != FcResultMatch)
			 goto nofont;

	//	  fprintf(stderr,"zaFont::fontconf [%d] %s \n", i, (char *)family);

		  if(FcPatternGetString(fs->fonts[i], FC_STYLE, 0, &style) != FcResultMatch)
			  goto nofont;
	//	  fprintf(stderr,"zaFont::fontconf [%d] %s \n", i, (char *)style);

		  if(FcPatternGetString(fs->fonts[i], FC_FILE, 0, &file) != FcResultMatch)
					  goto nofont;
	//	  fprintf(stderr, "zaFont::fontconf (%s): \n", (char *)file);
		  strcpy(m_charset,charset);
		  strcpy(this->m_path,(char *)file);

		  if(strstr((char*)file,"arial.ttf"))
			  break;

//		  if(FcCharSetHasChar(cs, ch))
//		  {
//			  puts("Yes");
//		  }else
//		  {
//			  puts("No");
//		  }
	}
	FcFontSetDestroy(fs);
	return 0;

	nofont:
		return 1;
}

void zaFont::initbyCharSet(const char * charset ,int size)
{
	fprintf(stderr,"zaFont::initbyCharSet Old:%s New:%s\n",m_charset,charset);
	if (strcmp(charset,m_charset)!=0)
	{
		fontconf(charset);
		if (size == 0)
			initbyPath(m_path,m_size);
		else
			initbyPath(m_path,size);

	}
}

void zaFont::initbyPath(const char * path ,int size)
{
	m_dpi = bbutil_calculate_dpi(0);
	if (path ==NULL || path[0]==0)
	{
		if (access("/usr/fonts/font_repository/adobe/AdobeHeitiStd-Regular.otf",F_OK)>=0)
		{
			sprintf(m_path,"%s","/usr/fonts/font_repository/adobe/AdobeHeitiStd-Regular.otf");
		}
		else if (access("/usr/fonts/font_repository/monotype/MHeiB.GB18030_200910.ttf",F_OK)>=0)
		{
			sprintf(m_path,"%s","/usr/fonts/font_repository/monotype/MHeiB.GB18030_200910.ttf");
		}

		initFont(m_path);
	}
	else
	{
		sprintf(m_path,"%s",path);
		initFont(m_path);
	}
	m_size = size;

	char en_charmap[128*2];
	for (int i = 0 ; i < 128; i ++)
	{
		en_charmap[i*2] =  (char) (i % 256);
		en_charmap[i*2+1] =(char) (i/ 256);
	}
	load_font(en_charmap,128*2);
}

void zaFont::getcharsize(int charcode, int* x, int *y)
{
	font_t * l_f = m_map[charcode];

	if (!l_f)
			throw CException(__FILE__,__LINE__,"getcharsize err ,charcode %s",charcode);
	if (l_f)
	{
		*x = l_f->advance[0];
		*y = l_f->height[0];
	}
	else
	{
		*x = 10;
		*y = 10;
	}

}

void  zaFont::setcolor(float r,float g,float b,float a)
{
	m_r = r;
	m_g = g;
	m_b = b;
	m_a = a;
}
void zaFont::changesize(int size)
{
	std::map<uint,font_t*>::iterator iter;
	for (iter = m_map.begin();iter != m_map.end();iter++)
	{
		if(&(iter->second->font_texture))
			glDeleteTextures(1, &(iter->second->font_texture));
	    free(iter->second);
	}
	m_map.clear();
	m_max_x = 0;
	m_max_y = 0;
	initbyPath(m_path , size);
}

int  zaFont::load_font(char * instr,int len)
{

		char * pin  = NULL;
		char * pout = NULL;
		char *p = NULL;

		char* inbuf = pin ; // m_filepos,  file head
		char* outbuf = pout;

		if (len==0)// utf8,
		{
			int ll= strlen(instr);
			size_t inbytesleft= ll+1;
			size_t outbytesleft = inbytesleft*2;

			pin = (char *)malloc(inbytesleft);
			pout = (char *)malloc(outbytesleft);

			inbuf = pin ; // m_filepos,  file head
			outbuf = pout;

			fprintf(stderr,"zaFont::load_font load begin length  %d\n",ll);
			strcpy(pin,instr);

			iconv_t tt;
			tt = iconv_open("UTF-16LE","UTF-8");
			int ret = iconv(tt,&inbuf,&inbytesleft,&outbuf,&outbytesleft);
			if ( ret < 0)
			{
				fprintf(stderr,"zaFont::load_font load error  errno %d\n",errno);
				throw CException(__FILE__,__LINE__,"zaFont::load_font convert error ,filename %s","NULL");
			}
			fprintf(stderr,"zaFont::load_font sucess.%d--%d:\n",ll*2,outbytesleft);
			iconv_close(tt);
			len = ll*2- outbytesleft;
			p= pout;
		}
		else
			p = instr;

			FT_Library library;
		    FT_Face face;
		    int c;
		    int i, j;
		    font_t* font = NULL;

		    if(FT_Init_FreeType(&library)) {
		        fprintf(stderr, "Error loading Freetype library\n");
		        return NULL;
		    }

		    if (FT_New_Face(library, m_path,0,&face)) {
		        fprintf(stderr, "Error loading font %s\n", m_path);
		        return NULL;
		    }

		    if(FT_Set_Char_Size ( face, m_size * 64, m_size * 64, m_dpi, m_dpi)) {
		        fprintf(stderr, "Error initializing character parameters\n");
		        return NULL;
		    }

		    unsigned int charcode = 0;

for (int cci =0 ; cci < len ; cci +=2)
{

charcode = ((unsigned char)*(p+1))*256+(unsigned char)*p ;
if (charcode == 601)
{
	charcode --;
	charcode ++;
}
if (this->m_map.find(charcode)==m_map.end())
{

		    font = (font_t*) malloc(sizeof(font_t));
		    font->initialized = 0;

		    glGenTextures(1, &(font->font_texture));

		    //Let each glyph reside in 32x32 section of the font texture
		    int segment_size_x = 0, segment_size_y = 0;
		    int num_segments_x = 1;//16
		    int num_segments_y = 1;//8

		    FT_GlyphSlot slot;
		    FT_Bitmap bmp;
		    int glyph_width, glyph_height;

		    //First calculate the max width and height of a character in a passed font
		    for(c = 0; c < 1; c++) {
		    	//
		        if(FT_Load_Char(face,0x4E2D+charcode-0x4E2D , FT_LOAD_RENDER)) {
		            fprintf(stderr, "FT_Load_Char failed\n");
		            free(font);
		            return NULL;
		        }

		        slot = face->glyph;
		        bmp = slot->bitmap;

		        //glyph_width = nextp2(bmp.width);
		        //glyph_height = nextp2(bmp.rows);

		        glyph_width = bmp.width;
		        glyph_height = bmp.rows;

		        if (glyph_width > segment_size_x) {
		            segment_size_x = glyph_width;
		        }

		        if (glyph_width > m_max_x)
		        	m_max_x = glyph_width;

		        if (glyph_height > segment_size_y) {
		            segment_size_y = glyph_height;
		        }

		        if (glyph_height > m_max_y)
		 		     m_max_y = glyph_height;
		    }

		    int font_tex_width = nextp2(num_segments_x * segment_size_x);
		    int font_tex_height = nextp2(num_segments_y * segment_size_y);

		    int bitmap_offset_x = 0, bitmap_offset_y = 0;

		    GLubyte* font_texture_data = (GLubyte*) malloc(sizeof(GLubyte) * 2 * font_tex_width * font_tex_height);
		    memset((void*)font_texture_data, 0, sizeof(GLubyte) * 2 * font_tex_width * font_tex_height);

		    if (!font_texture_data) {
		        fprintf(stderr, "Failed to allocate memory for font texture\n");
		        free(font);
		        return NULL;
		    }

		    // Fill font texture bitmap with individual bmp data and record appropriate size, texture coordinates and offsets for every glyph
		    for(c = 0; c < 1; c++)
		    {
		    	   if(FT_Load_Char(face,0x4E2D+charcode-0x4E2D , FT_LOAD_RENDER)) {
		            fprintf(stderr, "FT_Load_Char failed\n");
		            free(font);
		            return NULL;
		        }

		        slot = face->glyph;
		        bmp = slot->bitmap;

		        glyph_width = nextp2(bmp.width);
		        glyph_height = nextp2(bmp.rows);

		        div_t temp = div(c, num_segments_x);

		        bitmap_offset_x = segment_size_x * temp.rem;
		        bitmap_offset_y = segment_size_y * temp.quot;

		        for (j = 0; j < glyph_height; j++) {
		            for (i = 0; i < glyph_width; i++) {
		                font_texture_data[2 * ((bitmap_offset_x + i) + (j + bitmap_offset_y) * font_tex_width) + 0] =
		                font_texture_data[2 * ((bitmap_offset_x + i) + (j + bitmap_offset_y) * font_tex_width) + 1] =
		                    (i >= bmp.width || j >= bmp.rows)? 0 : bmp.buffer[i + bmp.width * j];
		            }
		        }

		        font->advance[c] = (float)(slot->advance.x >> 6);
		        font->tex_x1[c] = (float)bitmap_offset_x / (float) font_tex_width;
		        font->tex_x2[c] = (float)(bitmap_offset_x + bmp.width) / (float)font_tex_width;
		        font->tex_y1[c] = (float)bitmap_offset_y / (float) font_tex_height;
		        font->tex_y2[c] = (float)(bitmap_offset_y + bmp.rows) / (float)font_tex_height;
		        font->width[c] = bmp.width;
		        font->height[c] = bmp.rows;
		        font->offset_x[c] = (float)slot->bitmap_left;
		        font->offset_y[c] =  (float)((slot->metrics.horiBearingY-face->glyph->metrics.height) >> 6);
		    }


		    glBindTexture(GL_TEXTURE_2D, font->font_texture);
		    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
		    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);

		    glTexImage2D(GL_TEXTURE_2D, 0, GL_LUMINANCE_ALPHA, font_tex_width, font_tex_height, 0, GL_LUMINANCE_ALPHA , GL_UNSIGNED_BYTE, font_texture_data);

		  //  fprintf(stderr, "charcode %d %d\n",charcode, cci);
		    fflush(stderr);
		    free(font_texture_data);
		    font->initialized = 1;
m_map[charcode] = font;
}
p += 2;
}
			int err = glGetError();
		    FT_Done_Face(face);
		    FT_Done_FreeType(library);


		    free(pin);
		    free(pout);

		    if (err != 0) {
		        fprintf(stderr, "GL Error 0x%x", err);
		        free(font);
		        throw CException(__FILE__,__LINE__,"GL render ,errcode %d",errno);
		        return NULL;
		    }
		    return 0;
}

font_t * zaFont::load_font(int charcode)
{
	    FT_Library library;
	    FT_Face face;
	    int c;
	    int i, j;
	    font_t* font;

	    if(FT_Init_FreeType(&library)) {
	        fprintf(stderr, "Error loading Freetype library\n");
	        return NULL;
	    }

	    if (FT_New_Face(library, m_path,0,&face)) {
	        fprintf(stderr, "Error loading font %s\n", m_path);
	        return NULL;
	    }

	    if(FT_Set_Char_Size ( face, m_size * 64, m_size * 64, m_dpi, m_dpi)) {
	        fprintf(stderr, "Error initializing character parameters\n");
	        return NULL;
	    }

	    font = (font_t*) malloc(sizeof(font_t));
	    font->initialized = 0;

	    glGenTextures(1, &(font->font_texture));

	    //Let each glyph reside in 32x32 section of the font texture
	    int segment_size_x = 0, segment_size_y = 0;
	    int num_segments_x = 1;//16
	    int num_segments_y = 1;//8

	    FT_GlyphSlot slot;
	    FT_Bitmap bmp;
	    int glyph_width, glyph_height;

	    //First calculate the max width and height of a character in a passed font
	    for(c = 0; c < 1; c++) {
	    	//
	        if(FT_Load_Char(face,0x4E2D+charcode-0x4E2D , FT_LOAD_RENDER)) {
	            fprintf(stderr, "FT_Load_Char failed\n");
	            free(font);
	            return NULL;
	        }

	        slot = face->glyph;
	        bmp = slot->bitmap;

	        //glyph_width = nextp2(bmp.width);
	        //glyph_height = nextp2(bmp.rows);

	        glyph_width = bmp.width;
	        glyph_height = bmp.rows;

	        if (glyph_width > segment_size_x) {
	            segment_size_x = glyph_width;
	        }

	        if (glyph_height > segment_size_y) {
	            segment_size_y = glyph_height;
	        }
	    }

	    int font_tex_width = nextp2(num_segments_x * segment_size_x);
	    int font_tex_height = nextp2(num_segments_y * segment_size_y);

	    int bitmap_offset_x = 0, bitmap_offset_y = 0;

	    GLubyte* font_texture_data = (GLubyte*) malloc(sizeof(GLubyte) * 2 * font_tex_width * font_tex_height);
	    memset((void*)font_texture_data, 0, sizeof(GLubyte) * 2 * font_tex_width * font_tex_height);

	    if (!font_texture_data) {
	        fprintf(stderr, "Failed to allocate memory for font texture\n");
	        free(font);
	        return NULL;
	    }

	    // Fill font texture bitmap with individual bmp data and record appropriate size, texture coordinates and offsets for every glyph
	    for(c = 0; c < 1; c++)
	    {
	    	   if(FT_Load_Char(face,0x4E2D+charcode-0x4E2D , FT_LOAD_RENDER)) {
	            fprintf(stderr, "FT_Load_Char failed\n");
	            free(font);
	            return NULL;
	        }

	        slot = face->glyph;
	        bmp = slot->bitmap;

	        glyph_width = nextp2(bmp.width);
	        glyph_height = nextp2(bmp.rows);

	        div_t temp = div(c, num_segments_x);

	        bitmap_offset_x = segment_size_x * temp.rem;
	        bitmap_offset_y = segment_size_y * temp.quot;

	        for (j = 0; j < glyph_height; j++) {
	            for (i = 0; i < glyph_width; i++) {
	                font_texture_data[2 * ((bitmap_offset_x + i) + (j + bitmap_offset_y) * font_tex_width) + 0] =
	                font_texture_data[2 * ((bitmap_offset_x + i) + (j + bitmap_offset_y) * font_tex_width) + 1] =
	                    (i >= bmp.width || j >= bmp.rows)? 0 : bmp.buffer[i + bmp.width * j];
	            }
	        }

	        font->advance[c] = (float)(slot->advance.x >> 6);
	        font->tex_x1[c] = (float)bitmap_offset_x / (float) font_tex_width;
	        font->tex_x2[c] = (float)(bitmap_offset_x + bmp.width) / (float)font_tex_width;
	        font->tex_y1[c] = (float)bitmap_offset_y / (float) font_tex_height;
	        font->tex_y2[c] = (float)(bitmap_offset_y + bmp.rows) / (float)font_tex_height;
	        font->width[c] = bmp.width;
	        font->height[c] = bmp.rows;
	        font->offset_x[c] = (float)slot->bitmap_left;
	        font->offset_y[c] =  (float)((slot->metrics.horiBearingY-face->glyph->metrics.height) >> 6);
	    }


	    glBindTexture(GL_TEXTURE_2D, font->font_texture);
	    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
	    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);

	    glTexImage2D(GL_TEXTURE_2D, 0, GL_LUMINANCE_ALPHA, font_tex_width, font_tex_height, 0, GL_LUMINANCE_ALPHA , GL_UNSIGNED_BYTE, font_texture_data);

	    int err = glGetError();

	    free(font_texture_data);

	    FT_Done_Face(face);
	    FT_Done_FreeType(library);

	    if (err != 0) {
	        fprintf(stderr, "GL Error 0x%x", err);
	        free(font);

	        return NULL;
	    }

	    font->initialized = 1;
	    return font;
}

float zaFont::render_text_one(font_t * font,int charcode, float x, float y)
{
		if (charcode < 0x20 )
		    	return 0;
		if (charcode == 601 )
		{
			charcode++;
			charcode--;
		}
		int i, c;
	    GLfloat *vertices;
	    GLfloat *texture_coords;
	    GLshort* indices;

	    if (!font)
	    {
	    	throw CException(__FILE__,__LINE__,"font is NULL  ,charcode %d",charcode);
	    }
	    float pen_x = 0.0f;

	    int texture_enabled;
	    glGetIntegerv(GL_TEXTURE_2D, &texture_enabled);
	    if (!texture_enabled) {
	        glEnable(GL_TEXTURE_2D);
	    }

	    int blend_enabled;
	    glGetIntegerv(GL_BLEND, &blend_enabled);
	    if (!blend_enabled) {
	        glEnable(GL_BLEND);
	    }

	    int gl_blend_src, gl_blend_dst;
	    glGetIntegerv(GL_BLEND_SRC, &gl_blend_src);
	    glGetIntegerv(GL_BLEND_DST, &gl_blend_dst);

	    //glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	    glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);

	    int vertex_array_enabled;
	    glGetIntegerv(GL_VERTEX_ARRAY, &vertex_array_enabled);
	    if (!vertex_array_enabled) {
	        glEnableClientState(GL_VERTEX_ARRAY);
	    }

	    int texture_array_enabled;
	    glGetIntegerv(GL_TEXTURE_COORD_ARRAY, &texture_array_enabled);
	    if (!texture_array_enabled) {
	        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	    }

	    vertices = (GLfloat*) malloc(sizeof(GLfloat) * 8 * strlen("A"));
	    texture_coords = (GLfloat*) malloc(sizeof(GLfloat) * 8 * strlen("A"));

	    indices = (GLshort*) malloc(sizeof(GLfloat) * 6 * strlen("A"));

	    for(i = 0; i < 1; ++i) {
	        c = 0;

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
	    }

	    glColor4f(m_r,m_g,m_b,m_a);
	    glVertexPointer(2, GL_FLOAT, 0, vertices);
	    glTexCoordPointer(2, GL_FLOAT, 0, texture_coords);
	    glBindTexture(GL_TEXTURE_2D, font->font_texture);

	    glDrawElements(GL_TRIANGLES, 6 * strlen("A"), GL_UNSIGNED_SHORT, indices);

	    if (!texture_array_enabled) {
	        glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	    }

	    if (!vertex_array_enabled) {
	        glDisableClientState(GL_VERTEX_ARRAY);
	    }

	    if (!texture_enabled) {
	        glDisable(GL_TEXTURE_2D);
	    }

	    glBlendFunc(gl_blend_src, gl_blend_dst);

	    if (!blend_enabled) {
	        glDisable(GL_BLEND);
	    }

	    free(vertices);
	    free(texture_coords);
	    free(indices);
	    return pen_x;
}

// char * formart is UTF-16LE, len is the size of the buf;
int zaFont::render_text(const char * buf,int len, float x, float y,const char * decode ,int width)
{
	iconv_t tt;
	tt = iconv_open("UTF-16LE",decode);

	char *in=NULL;
	char *out=NULL;
	size_t inbytesleft;
	size_t outbytesleft;

	if (len != 0)
	{
		in = (char*)malloc(len);
		out = (char*)malloc(len*2);
		memcpy(in,buf,len);
	}
	else
	{
		len = strlen(buf)+1;
		in = (char*)malloc(len);
		out = (char*)malloc(len*2);
		strcpy(in,buf);
	}
	inbytesleft = len;
	outbytesleft = len*2;

	char* inbuf = in;
	char* outbuf = out;

	int ret = iconv(tt,&inbuf,&inbytesleft,&outbuf,&outbytesleft);
	int err = errno ;
	if (ret<0)
	{
		iconv_close(tt);
		fprintf(stderr,"zaFont::render_text convert err ,errcode %d",errno);
		return 0;
		//throw CException(__FILE__,__LINE__,"font convert err ,errcode %d",errno);
	}
//	if ( ret < 0)
//		fprintf(stderr,"iconv errno %d\n",err);
//	else
//		fprintf(stderr,"convert %d--%d--%s :\n",ret,outbytesleft,out);
	iconv_close(tt);

	char * p = out;

	int uni_len =  len*2-outbytesleft;
//	char * p = buf;

	uint charcode = 0;

	int l_x = x;
	int l_y = 0;
	for (int i =0 ; i < uni_len ; i +=2)
	{
		charcode = ((unsigned char)*(p+1))*256+(unsigned char)*p ;
		if (charcode == 601 )
					{
						charcode++;
						charcode--;
					}
		if (this->m_map.find(charcode)==m_map.end())
		{

//			fprintf(stderr,"render font error ,no charcode %d",charcode);
//			throw CException(__FILE__,__LINE__,"render font error ,no charcode %d",charcode);
			if (charcode == 601 )
			{
				charcode++;
				charcode--;
			}
			font_t * lf=  load_font(charcode);
			if (lf)
				m_map[charcode] = lf;
			else
			{
				free(in);
				free(out);
				throw CException(__FILE__,__LINE__,"load font error ,charcode %d",charcode);
			}
		}

		l_x += render_text_one(m_map[charcode],charcode,l_x, y);
		if ((l_x > x+width-100 && (charcode == 0x20 ||charcode > 0x7F))
				|| charcode== 0x0A )
		{
			l_x = x;
			l_y += 50;
			y -= 50;
		}
		p += 2;
	}
	free(in);
	free(out);
	glColor4f(1.0f,1.0f,1.0f,1.0f);
	return l_y;
}

void zaFont::render_text(const char * buf,int len, float x, float y,const char * decode )
{
	iconv_t tt;
	tt = iconv_open("UTF-16LE",decode);

	char *in=NULL;
	char *out=NULL;
	size_t inbytesleft;
	size_t outbytesleft;

	if (len != 0)
	{
		in = (char*)malloc(len);
		out = (char*)malloc(len*2);
		memcpy(in,buf,len);
	}
	else
	{
		len = strlen(buf)+1;
		in = (char*)malloc(len);
		out = (char*)malloc(len*2);
		strcpy(in,buf);
	}
	inbytesleft = len;
	outbytesleft = len*2;

	char* inbuf = in;
	char* outbuf = out;

	int ret = iconv(tt,&inbuf,&inbytesleft,&outbuf,&outbytesleft);
	int err = errno ;
	if (ret<0)
	{
		iconv_close(tt);
		throw CException(__FILE__,__LINE__,"font convert err ,errcode %d",errno);
	}
//	if ( ret < 0)
//		fprintf(stderr,"iconv errno %d\n",err);
//	else
//		fprintf(stderr,"convert %d--%d--%s :\n",ret,outbytesleft,out);
	iconv_close(tt);

	char * p = out;

	int uni_len =  len*2-outbytesleft;
//	char * p = buf;

	uint charcode = 0;

	for (int i =0 ; i < uni_len ; i +=2)
	{
		charcode = ((unsigned char)*(p+1))*256+(unsigned char)*p ;
		if (charcode == 601 )
							{
								charcode++;
								charcode--;
							}
		if (this->m_map.find(charcode)==m_map.end())
		{
			font_t * lf=  load_font(charcode);
			if (lf)
				m_map[charcode] = lf;
			else
			{
				free(in);
				free(out);
				throw CException(__FILE__,__LINE__,"load font error ,charcode %d",charcode);
			}
		}

		x += render_text_one(m_map[charcode],charcode,x, y);
		p += 2;
	}
	free(in);
	free(out);
	glColor4f(1.0f,1.0f,1.0f,1.0f);
}

int cn2utf(){
	iconv_t tt;
	tt = iconv_open("UTF-16LE","GBK");
	char in[100]= "1234����";
	char out[100];
	char* inbuf = in;
	char* outbuf = out;
	size_t inbytesleft=strlen(inbuf);
	size_t outbytesleft;

	outbytesleft = 100;
	int ret = iconv(tt,&inbuf,&inbytesleft,&outbuf,&outbytesleft);
	int err = errno ;
	if ( ret < 0)
	{
		fprintf(stderr," errno %d\n",err);
		throw CException(__FILE__,__LINE__,"errno %d",err);
	}
	else
		fprintf(stderr,"convert %d--%d--%s :\n",ret,outbytesleft,out);
	iconv_close(tt);
	return 0;
}

zaFont::~zaFont() {
	if (font)
	{
		if (font->initialized)
			glDeleteTextures(1, &(font->font_texture));
		free (font);
	}
	std::map<uint,font_t*>::iterator iter;
	for (iter = m_map.begin();iter != m_map.end();iter++)
	{
	    glDeleteTextures(1, &(iter->second->font_texture));
	    free(iter->second);
	}
	// TODO Auto-generated destructor stub
}

