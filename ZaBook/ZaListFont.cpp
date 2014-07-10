/*
 * ZaListFont.cpp
 *
 *  Created on: 2012-10-2
 *      Author: Administrator
 */

#include "ZaListFont.h"
#include <sys/stat.h>
namespace bbcubezone
{

ZaListFont::ZaListFont()
{
	// TODO Auto-generated constructor stub
	m_style = 0;
}

int ZaListFont::init(const char * lang)
{
	m_v.clear();
	m_path.clear();
	FcFontSet* fs = NULL;
	FcPattern* pat = NULL;
	FcObjectSet* os = NULL;
	//FcChar8* strpat = (FcChar8*)":lang=ja";
	string ls = ":lang=";
	ls.append(lang);

	FcChar8* strpat = (FcChar8*) ls.c_str();
	fprintf(stderr,"ZaListFont::fontconf charset %s\n",strpat);

	pat = FcNameParse(strpat);
	os = FcObjectSetBuild(FC_FAMILY, FC_STYLE, FC_CHARSET, FC_FILE, (char *) 0);
	fs = FcFontList(0, pat, os);
	if (os)
		FcObjectSetDestroy(os);
	os = NULL;
	FcPatternDestroy(pat);
	pat = NULL;
	if (!fs || fs->nfont <= 0)
		goto nofont;
	FcChar8 *family;
	FcChar8 *fstyle;
	FcChar8 *file;
	FcCharSet* cs;
	FcChar32 ch;
	FcUtf8ToUcs4((FcChar8*) "��", &ch, 3);
	int i;
	for (i = 0; i < fs->nfont; i++)
	{
		if (FcPatternGetCharSet(fs->fonts[i], FC_CHARSET, 0, &cs)
				!= FcResultMatch)
		{
			fprintf(stderr, "no match\n");
			FcPatternPrint(fs->fonts[i]);
			goto nofont;
		}

		if(FcPatternGetString(fs->fonts[i], FC_FAMILY, 1, &family) !=FcResultMatch)
			 if(FcPatternGetString(fs->fonts[i], FC_FAMILY, 0, &family) != FcResultMatch)
			 goto nofont;

		//  fprintf(stderr,"ZaListFont::fontconf [%d] %s \n", i, (char *)family);


		  if(FcPatternGetString(fs->fonts[i], FC_FILE, 0, &file) != FcResultMatch)
			  goto nofont;
		  if(FcPatternGetString(fs->fonts[i], FC_STYLE, 0, &fstyle) != FcResultMatch)
			  goto nofont;

		  m_v.push_back(string((char *)family).append("(").append((char*)fstyle).substr(0,37).append(")"));

		//  fprintf(stderr, "ZaListFont::fontconf (%s): \n", (char *)file);
		//strcpy(m_charset,charset);
		//strcpy(this->m_path,(char *)file);
		  m_path.push_back(string((char *)file));
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
	nofont: return 1;

}

ZaListFont::~ZaListFont()
{
	// TODO Auto-generated destructor stub

}

} /* namespace bbcubezone */
