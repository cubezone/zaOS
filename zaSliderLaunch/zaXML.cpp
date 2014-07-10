/*
 * zaXML.cpp
 *
 *  Created on: 2012-8-24
 *      Author: Administrator
 */

#include "zaXML.h"

namespace bbcubezone {

zaXML::zaXML() {
	// TODO Auto-generated constructor stub
	m_num=0;
}

zaXML::~zaXML() {
	// TODO Auto-generated destructor stub
}

int zaXML::loadfromdb()
{

}

void zaXML::dump(){
	fprintf(stderr,"path: %s\n",m_path);
	fprintf(stderr,"img: %s\n",m_coverimg);
	fprintf(stderr,"title: %s\n",m_docname);
	fprintf(stderr,"author: %s\n",m_docauthor);

	for (uint i = 0; i < m_manifest.size();i++)
	{
		fprintf(stderr,"m_manifest [%d] id        %s \n",i,m_manifest[i].id.c_str());
		fprintf(stderr,"m_manifest [%d] href      %s \n",i,m_manifest[i].href.c_str());
		fprintf(stderr,"m_manifest [%d] mediatype %s \n",i,m_manifest[i].mediatype.c_str());
	}

	for (uint i = 0; i < m_spine.size();i++)
	{
		fprintf(stderr,"m_spine [%d] itemref   %s \n",i,m_spine[i].c_str());
	}

	for (uint i = 0; i < m_navmap.size();i++)
	{
		fprintf(stderr,"m_navmap [%d] navlabel  %s \n",i,m_navmap[i].navlabel.c_str());
		fprintf(stderr,"m_navmap [%d] href      %s \n",i,m_navmap[i].href.c_str());
	}

	for (uint i = 0; i < m_pages.size();i++)
	{
		fprintf(stderr,"m_pages [%d] id        %s \n",i,m_pages[i].id.c_str());
		fprintf(stderr,"m_pages [%d] navlabel  %s \n",i,m_pages[i].navlabel.c_str());
		fprintf(stderr,"m_pages [%d] href      %s \n",i,m_pages[i].href.c_str());
	}

}

int zaXML::addaction(int time,int x, int y)
{

/*	m_s[m_n].time=time - m_now;
	m_now = time;
	m_s[m_n].x=x;
	m_s[m_n].y=y;
	m_n ++;
	if (m_n==20)
	{
		char ff[255];
		sprintf(ff,"/accounts/1000/shared/documents/active%03d.xml",m_sn);
		xmlwrite(ff);
		m_sn++;
		m_n =0;
	}
*/
	return 0;
}

int zaXML::loadaction(int sn,int x, int y)
{
	char ff[255];
	sprintf(ff,"/accounts/1000/shared/documents/active%03d.xml",sn);
//	xmlloadaction(ff);

	  xmlDocPtr     pdoc = NULL;
	  xmlNodePtr    proot = NULL, curNode = NULL;
	  //xmlKeepBlanksDefault(0);
	 // pdoc = xmlReadFile (psfilename, "UTF-8", XML_PARSE_NOERROR);
	  pdoc = xmlReadFile (ff, "UTF-8",XML_PARSE_RECOVER);


	  // 获取 xml 文档对象的根节对象
	  proot = xmlDocGetRootElement (pdoc);


	  /* 我使用上面程序创建的 xml 文档，它的根节点是“根节点”，这里比较是否
	     正确。*/
	  if (xmlStrcmp (proot->name, BAD_CAST "root") != 0)
	    {
	      printf ("错误文档" );
	    }

	  curNode = proot->xmlChildrenNode;
/*
	  m_n = 0;

	  char n=0;
	  while (curNode != NULL)
	    {
	      if (xmlStrcmp(curNode->name,BAD_CAST "action")==0)
	        {
	    	  curNode = curNode->children;
	          printf ("子节点%d： %s\n", n++,curNode->name);
	        }
	      else
	      {
	    	  if (xmlStrcmp(curNode->name, BAD_CAST "time")==0)
	    	  {
	    		  m_s[m_n].time =atoi((const char *)xmlNodeGetContent(curNode));
	    		  curNode = curNode->next;
	    	  }
	    	  if (xmlStrcmp(curNode->name, BAD_CAST "x")==0)
	    	  {
	    		  m_s[m_n].x=atoi((const char *)xmlNodeGetContent(curNode));
	    		  curNode = curNode->next;
	    	  }
	    	  if (xmlStrcmp(curNode->name, BAD_CAST "y")==0)
	    	  {
	    		  m_s[m_n].y=atoi((const char *)xmlNodeGetContent(curNode));
	    		  curNode = curNode->next;
	    	  }
	    	  if (xmlStrcmp(curNode->name, BAD_CAST "type")==0)
	    	  {
	    		  m_s[m_n].type=atoi((const char *)xmlNodeGetContent(curNode));
	    		  m_n ++;
	    		  curNode = curNode->parent;
	    	  }

	    	}
	    	  curNode = curNode->next;
	      }
*/
	  /* 关闭和清理 */
	  xmlFreeDoc (pdoc);
	  xmlCleanupParser ();




	return 0;
}

int zaXML::xmlwrite(char *name)
{
	  xmlDocPtr pdoc = NULL;
	  xmlNodePtr proot_node = NULL,pnode = NULL,pnode1 = NULL;

	  // 创建一个新文档并设置 root 节点
	  // 一个 XML 文件只有一个 root 节点
	  pdoc = xmlNewDoc (BAD_CAST "1.0");
	  proot_node = xmlNewNode (NULL, BAD_CAST "root");
	  xmlNewProp (proot_node, BAD_CAST "ver", BAD_CAST "1.0");
	  xmlDocSetRootElement (pdoc, proot_node);

	  for (int n = 0; n < m_n ; n++)
	  {
		  pnode = xmlNewNode (NULL, BAD_CAST "action");
		  // 创建上面 pnode 的子节点
		  char bb[100];
		  sprintf(bb,"%d",m_s[n].time);
		  xmlNewChild (pnode, NULL, BAD_CAST "time", BAD_CAST bb);
		  // 添加子节点到 root 节点
		  xmlAddChild (proot_node, pnode);

		  sprintf(bb,"%d",m_s[n].x);
		  pnode1 = xmlNewNode (NULL, BAD_CAST "x");
		  xmlAddChild (pnode, pnode1);
		  xmlAddChild (pnode1,xmlNewText (BAD_CAST bb));

		  sprintf(bb,"%d",m_s[n].y);
		  pnode1 = xmlNewNode (NULL, BAD_CAST "y");
		  xmlAddChild (pnode, pnode1);
		  xmlAddChild (pnode1,xmlNewText (BAD_CAST bb));
	  }
	  // 还可以这样直接创建一个子节点到 root 节点上
//	  xmlNewTextChild (proot_node, NULL, BAD_CAST "子节点2", BAD_CAST "子节点2的内容");
//	  xmlNewTextChild (proot_node, NULL, BAD_CAST "子节点3", BAD_CAST "子节点3的内容");

	  // 保存 xml 为文件,如果没有给出文件名参数，就输出到标准输出
	  xmlSaveFormatFileEnc (name, pdoc, "UTF-8", 1);

	  // 释放资源
	  xmlFreeDoc (pdoc);
	  xmlCleanupParser ();
	  xmlMemoryDump ();

	  return 0;

}

int zaXML::getOPF()
{
	char f[] = "META-INF/container.xml";

	char psfilename[255];
	sprintf(psfilename,"%s/%s",m_path,f);

	  xmlDocPtr     pdoc = NULL;
	   xmlNodePtr    proot = NULL, curNode = NULL;

	   // 打开 xml 文档
	  //xmlKeepBlanksDefault(0);
	  // pdoc = xmlReadFile (psfilename, "UTF-8", XML_PARSE_NOERROR);
	    xmlParseMemory(NULL,100);
	   pdoc = xmlReadFile (psfilename, "UTF-8",XML_PARSE_RECOVER);

	  if (pdoc == NULL)
	    {
	      printf ("打开文件 %s 出错!\n", psfilename);
	      throw "e";
	    }


	  proot = xmlDocGetRootElement (pdoc);

	  curNode = proot->xmlChildrenNode;
	  xmlChar * l_href;

	  while (curNode != NULL)
	    {
	      if (xmlStrcmp(curNode->name,BAD_CAST "rootfile")==0)
		  {
		  	 if (xmlHasProp (curNode, BAD_CAST "full-path"))
		  	 {
		  		 l_href = xmlGetProp (curNode, BAD_CAST "full-path");
		    	 strcpy(m_opf,(const  char *)l_href);
		    }
		  }

	      if (curNode->children)
	    	  curNode =  curNode->children;
	      else if  (curNode->next)
	    		  curNode = curNode->next;
	      else
	      {
	    	  curNode = curNode->parent;
	    	  while (curNode->parent && curNode->next==NULL)
	    	  {
	    		  curNode= curNode->parent;
	    	  }
	    	  if (curNode) curNode = curNode->next;
	      }
	    }

	  /* 关闭和清理 */
	  xmlFreeDoc (pdoc);
	  xmlCleanupParser ();
	  return 0;
}


int zaXML::getNcx()
{
	char psfilename[255];
	sprintf(psfilename,"%s/%s",m_path,m_opf);
	char *p = m_opf + strlen(m_opf);
//获取opf的路径
	for (int i = strlen(m_opf) ;i > 0; i--)
	{
			p --;
		if (*p == '/')
			break;
	}
	if(p!=m_opf)
		strcat(m_path,"/");
	strncat(m_path,m_opf,p-m_opf);

//		if (memcmp(m_opf,"OPS/",4)==0)
//		if (memcmp(m_opf,"OEBPS/",6)==0)
//		strcat(m_path,"/OEBPS");
//		if (memcmp(m_opf,"41029/",6)==0)
//		strcat(m_path,"/41029");

	xmlDocPtr     pdoc = NULL;
	xmlNodePtr    proot = NULL, curNode = NULL;

	   // 打开 xml 文档
	  //xmlKeepBlanksDefault(0);
	  // pdoc = xmlReadFile (psfilename, "UTF-8", XML_PARSE_NOERROR);

	   pdoc = xmlReadFile (psfilename, "UTF-8",XML_PARSE_RECOVER);

	  if (pdoc == NULL)
	    {
	      printf ("打开文件 %s 出错!\n", psfilename);
	      exit (1);
	    }

	  // 获取 xml 文档对象的根节对象
	  proot = xmlDocGetRootElement (pdoc);

	  curNode = proot->xmlChildrenNode;

	  xmlChar * l_href;
	  xmlChar * l_id;
	  xmlChar * l_mediatype;
	  xmlChar * l_imgp = NULL;
	  while (curNode != NULL)
	  {
		   // <meta name="cover" content="cover-image"/>
		  	if (xmlStrcmp(curNode->name,BAD_CAST "meta")==0)
		  	{
		  		if (xmlHasProp (curNode, BAD_CAST "content") &&
		  		     xmlHasProp (curNode, BAD_CAST "name"))
		  		{
		  			if (xmlStrcmp(xmlGetProp (curNode, BAD_CAST "name"),BAD_CAST "cover")==0)
		  			{
		  				l_imgp = xmlGetProp (curNode, BAD_CAST "content");
		  			}
		  		}
		  	}
		    if (xmlStrcmp(curNode->name,BAD_CAST "item")==0)
	        {
		    	if (xmlHasProp (curNode, BAD_CAST "id") &&
		    			xmlHasProp (curNode, BAD_CAST "media-type")
		    		)
		    	{
		    		 l_id = xmlGetProp (curNode, BAD_CAST "id");
		    		 l_mediatype = xmlGetProp (curNode, BAD_CAST "media-type");
		    		 l_href = xmlGetProp (curNode, BAD_CAST "href");

		    		 if (xmlStrcmp(l_id,BAD_CAST "ncx") ==0
		    		 ||xmlStrcmp(l_id,BAD_CAST "ncxtoc") ==0
		    		 ||xmlStrcmp(l_id,BAD_CAST "toc") ==0)
		    		 {
		    			 if (l_href)
		    			 strcpy(m_ncx,(const  char *)l_href);
		    		 }


		    		 if (xmlStrcmp(l_mediatype,BAD_CAST "image/jpeg") ==0 ||
		    				 xmlStrcmp(l_mediatype,BAD_CAST "image/png") ==0
		    			)
		    		 {
						 if ( m_coverimg[0]==0 &&
								 xmlStrstr(l_id,BAD_CAST "title") != NULL)
						 {
							 if (l_href)
								 sprintf(m_coverimg,"%s/%s",m_path,(const  char *)l_href);
						 }
						 if(l_imgp)
						  {
							 if (xmlStrcmp(l_id ,l_imgp) ==0)
							 {
								 if (l_href)
								 sprintf(m_coverimg,"%s/%s",m_path,(const  char *)l_href);
							 }
						 }
						 else if (xmlStrstr(l_id ,BAD_CAST "cover" ) != NULL )
						 {
							 if (l_href)
							 sprintf(m_coverimg,"%s/%s",m_path,(const  char *)l_href);
						 }
		    		 }

		    		 if (xmlStrcmp(l_mediatype,BAD_CAST "application/xhtml+xml") ==0)
		    		 {
		    			 manifest_str l_mf;
		    			 l_mf.id = (char *)l_id;
		    			 l_mf.href  = (char *)l_href;
		    			 l_mf.mediatype  = (char *)l_mediatype;
		    			 this->m_manifest.push_back(l_mf);
		    		 }
		    	}
	        }

		    if  (xmlStrcmp(curNode->name,BAD_CAST "itemref")==0 &&
		    	xmlHasProp (curNode, BAD_CAST "idref") )
		    {
		    	m_spine.push_back((const char *)xmlGetProp (curNode, BAD_CAST "idref"));
		    }

		    	if (curNode->children)
		   	    	  curNode =  curNode->children;
		   	      else if  (curNode->next)
		   	    		  curNode = curNode->next;
		   	      else
		   	      {
			    	  curNode = curNode->parent;
			    	  while (curNode->parent && curNode->next==NULL)
			    	  {
			    		  curNode= curNode->parent;
			    	  }
			    	  if (curNode) curNode = curNode->next;
		   	      }
	    }

	  if (m_coverimg[0] ==0)
	  {
		  char lp[255];
		  sprintf(lp,"%s/images/cover.jpg",m_path);
		  if (access(lp,F_OK)>=0)
		  {
			  strcpy(m_coverimg,lp);
		  }
		  sprintf(lp,"%s/cover.jpg",m_path);
		  if (access(lp,F_OK)>=0)
		  {
			  strcpy(m_coverimg,lp);
		  }
	  }

	  /* 关闭和清理 */
	  xmlFreeDoc (pdoc);
	  xmlCleanupParser ();
	  return 0;
}

void zaXML::buildpages()
{
	m_pages.clear();
	for (uint i = 0;i < this->m_spine.size();i ++)
	{
		bookspages_str ls_bp;
		ls_bp.id = m_spine[i];
		for (uint n=0; n <  this->m_manifest.size();n++)
		{
			if (ls_bp.id.compare(m_manifest[n].id)==0)
			{
				ls_bp.href =m_manifest[n].href;
				break;
			}
		}
		for (uint n=0; n <  this->m_navmap.size();n++)
		{
			if (ls_bp.href.compare(m_navmap[n].href)==0)
			{
				ls_bp.navlabel =m_navmap[n].navlabel;
				break;
			}
		}
		m_pages.push_back(ls_bp);
	}

}

int zaXML::getlink()
{
	char psfilename[255];
	sprintf(psfilename,"%s/%s",m_path,m_ncx);

	  xmlDocPtr     pdoc = NULL;
	   xmlNodePtr    proot = NULL, curNode = NULL;

	   if (access(psfilename,R_OK)<0)
			throw CException(__FILE__,__LINE__,"zaXML::getlink file not open, %s",psfilename);

	   // 打开 xml 文档
	  //xmlKeepBlanksDefault(0);
	  // pdoc = xmlReadFile (psfilename, "UTF-8", XML_PARSE_NOERROR);

	   pdoc = xmlReadFile (psfilename, "UTF-8",XML_PARSE_RECOVER);

	  if (pdoc == NULL)
	    {
	      printf ("打开文件 %s 出错!\n", psfilename);
	      exit (1);
	    }

	  // 获取 xml 文档对象的根节对象
	  proot = xmlDocGetRootElement (pdoc);

	  curNode = proot->xmlChildrenNode;

//	  <docTitle><text> 步步惊心 </text></docTitle>
//	  <docAuthor><text> 桐华 </text></docAuthor>
//	  <navMap>
//	  <navPoint id="coverpage" playOrder="0">
//	  <navLabel><text>封面</text></navLabel>
//	  <content src="coverpage.html"/>
//	  </navPoint>

	  char n=0;
	  xmlChar * l_href;

	  while (curNode != NULL)
	   {
		  if (xmlStrcmp(curNode->name,BAD_CAST "docTitle")==0)
		  {
			  n = 1;
		  }

		  if (xmlStrcmp(curNode->name,BAD_CAST "docAuthor")==0)
		  {
			  n = 2;
		  }

		  if (xmlStrcmp(curNode->name,BAD_CAST "navLabel")==0)
		  {
			  n = 3;
		  }

		  if (n == 1)
			  if (xmlStrcmp(curNode->name,BAD_CAST "text")==0 &&
					  curNode->type  ==XML_ELEMENT_NODE )
			  {
				 l_href =   xmlNodeGetContent(curNode);
				 strcpy(m_docname,(const  char *)l_href);
			  }
		  if (n == 2)
				  if (xmlStrcmp(curNode->name,BAD_CAST "text")==0 &&
						  curNode->type  ==XML_ELEMENT_NODE )
				  {
					 l_href =   xmlNodeGetContent(curNode);
					 strcpy(m_docauthor,(const  char *)l_href);
				  }
		  if (n == 3)
		  {
			  static struct navMap_str l_vavmap;
			  if (xmlStrcmp(curNode->name,BAD_CAST "text")==0 &&
					  curNode->type  == XML_ELEMENT_NODE )
			  {
				  l_vavmap.navlabel =  (const char *)xmlNodeGetContent(curNode);
		 	 }

			  if (xmlStrcmp(curNode->name,BAD_CAST "content")==0)
			  {

	    		 if (xmlHasProp (curNode, BAD_CAST "src"))
	    		 {
	    			 l_href = xmlGetProp (curNode, BAD_CAST "src");
	    			 char * lab = (char * )malloc( strlen((const  char *)l_href)+1);
	    			 strcpy(lab,(const  char *)l_href);
	    			 char *p = lab;
	    			 while (*p)
	    			 {
	    				 if (*p =='#')
	    					 *p = 0;
	    				 p ++;
	    			 }
	    			 l_vavmap.href =  lab;
	    			 free(lab);

	    			 m_navmap.push_back(l_vavmap);
	    		 }
			  }
		  }

	      if (curNode->children)
	    	  curNode =  curNode->children;
	      else if  (curNode->next)
	    	  curNode = curNode->next;
	      else
	      {
	    	  curNode = curNode->parent;
	    	  while (curNode->parent && curNode->next==NULL)
	    	  {
	    		  curNode= curNode->parent;
	    	  }
	    	  if (curNode) curNode = curNode->next;
	      }
	    }
	  /* 关闭和清理 */
	  xmlFreeDoc (pdoc);
	  xmlCleanupParser ();



	  return 0;
}

int zaXML::xmlexplorer (char *name)
{
 //m_s[m_n].time =atoi((const char *)xmlNodeGetContent(curNode));

  char psfilename[255];
  sprintf(psfilename,"%s",name);

  xmlDocPtr     pdoc = NULL;
   xmlNodePtr    proot = NULL, curNode = NULL;

   // 打开 xml 文档
  //xmlKeepBlanksDefault(0);
  // pdoc = xmlReadFile (psfilename, "UTF-8", XML_PARSE_NOERROR);

   pdoc = xmlReadFile (psfilename, "UTF-8",XML_PARSE_RECOVER);

  if (pdoc == NULL)
    {
      printf ("打开文件 %s 出错!\n", psfilename);
      exit (1);
    }

  // 获取 xml 文档对象的根节对象
  proot = xmlDocGetRootElement (pdoc);

  curNode = proot->xmlChildrenNode;


  xmlChar * l_href;
  while (curNode != NULL)
    {
      if (xmlStrcmp(curNode->name,BAD_CAST "rootfile")==0)
        {
    		 if (xmlHasProp (curNode, BAD_CAST "full-path"))
    		 {
    			 l_href = xmlGetProp (curNode, BAD_CAST "href");

    		 }
        }
      curNode = curNode->next;
    }

  /* 关闭和清理 */
  xmlFreeDoc (pdoc);
  xmlCleanupParser ();
  return 0;
}

} /* namespace bbcubezone */
