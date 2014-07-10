/////////////////////////////////////////////////////////////////////////////
//ContactList
#include "stdafx.h"
#include "ContactList.h"
using namespace MSXML2;

extern CComModule _Module;

inline void CHECKHR(HRESULT hr) {
	if FAILED(hr) throw(hr);
}

ContactList::ContactList(char const * const filename) //:
	//m_file(filename, CFile::modeReadWrite | CFile::typeText)
{
	CHECKHR(CoInitialize(NULL));
	CHECKHR(m_data.CreateInstance(CLSID_DOMDocument));

	_variant_t varOut((bool)TRUE);
	char path[_MAX_PATH];
	HINSTANCE h = _Module.GetModuleInstance();
	GetModuleFileName(h, path, sizeof(path) - 1);
	
	char * p = strrchr(path, '\\');
	if ( p != NULL )
	{
		char localpath[] = "..\\";
		strcpy(p + 1, localpath);
		m_homePath = path; //save this path for later use
		strcat(path, filename);
	}
	
	_variant_t varData(path);
	varOut = m_data->load(varData);
	if ( (bool)varOut == FALSE )
	{
		CString msg;
		msg.Format("Failed to load base contact file: %s", filename);
		::MessageBox(NULL, msg, "Desktop API Sample", MB_OK|MB_ICONERROR);
		throw(0);
	}
	m_data->setProperty(_bstr_t("SelectionLanguage"), _variant_t("XPath"));
	
#if defined(_DEBUG)
	_bstr_t text = m_data->text;
#endif
	//at this point the data is in memory
}

bool ContactList::contains(char const * firstname, char const * lastname)
{
	CString queryString;
	queryString.Format(QUERY_STRING, firstname, lastname);

	//use the XPath features to quickly search for matching nodes
	m_node = m_data->selectSingleNode(_bstr_t(queryString));
	return m_node != NULL;	
}

ContactList::Contact * ContactList::get(char const * firstname, char const * lastname)
{
	return toContact(getNode(firstname, lastname));
}

IXMLDOMNodePtr ContactList::getNode(char const * firstname, char const * lastname)
{
	if ( m_node != NULL)
	{
		IXMLDOMNamedNodeMapPtr p = m_node->attributes; //does the current node contain the information required?
		if ( p != NULL )
		{
			IXMLDOMNodePtr fn = p->getNamedItem(_bstr_t("first"));
			IXMLDOMNodePtr ln = p->getNamedItem(_bstr_t("last"));
			if ( fn != NULL && ln != NULL)
			{
				if ( _bstr_t(firstname) == fn->text && _bstr_t(lastname) == ln->text )
				{
					return m_node;
				}			
			}

		}
	}
	
	CString queryString;
	queryString.Format(QUERY_STRING, firstname, lastname);
	
	//search again for a list of nodes
	return m_data->selectSingleNode(_bstr_t(queryString));
}

bool ContactList::put(ContactList::Contact * contact)
{
	//if the node already exists in the tree, then just modify it's data
	IXMLDOMNodePtr node = getNode(contact->m_firstName, contact->m_lastName);

	if ( node != NULL)
	{
		//just modify the email address
		IXMLDOMNodePtr p = node->selectSingleNode(_bstr_t("./email"));
		if ( p != NULL )
		{
			//this element has an email address, replace it
			p->text = _bstr_t(contact->m_email);
			return true;
		}
		else
		{
			IXMLDOMElementPtr email = m_data->createElement(_bstr_t("email"));
			email->text = _bstr_t(contact->m_email);
			return node->appendChild(email) != NULL;
		}
	}
	else 
	{

		//add a new node to the tree
		IXMLDOMElementPtr contactNode = m_data->createElement(_bstr_t("contact"));
		contactNode->setAttribute(_bstr_t("first"), _variant_t((LPCTSTR)(contact->m_firstName)));
		contactNode->setAttribute(_bstr_t("last"), _variant_t((LPCTSTR)(contact->m_lastName)));

		IXMLDOMElementPtr first = m_data->createElement(_bstr_t("first"));
		first->text = _bstr_t((LPCTSTR)(contact->m_firstName));
		contactNode->appendChild(first);

		IXMLDOMElementPtr last = m_data->createElement(_bstr_t("last"));
		last->text = _bstr_t((LPCTSTR)(contact->m_lastName));
		contactNode->appendChild(last);

		IXMLDOMElementPtr email = m_data->createElement(_bstr_t("email"));
		email->text = _bstr_t((LPCTSTR)(contact->m_email));
		contactNode->appendChild(email);	
		
		return m_data->documentElement->appendChild(contactNode) != NULL;
	}
}

bool ContactList::save(char const * const filename)
{
	CString local = filename;
	if ( local.Find(':') <= -1 ) //look for an absolute path
	{
		local = m_homePath;
		local += filename;
	}
	return S_OK == m_data->save(_variant_t((LPCTSTR)local));
}

ContactList::Contact * ContactList::toContact(IXMLDOMNodePtr node)
{
	if ( node == NULL ) return NULL;
	//extract the various fields
	//extract the various bits of the node
	IXMLDOMNodePtr p = node->selectSingleNode(FIRST_QSTRING);
	Contact * c = new Contact();
	if ( p != NULL )
	{
		c->m_firstName = (LPCTSTR)p->text;
	}
	p = node->selectSingleNode(LAST_QSTRING);
	if ( p != NULL )
	{
		c->m_lastName = (LPCTSTR)p->text;
	}
	p = node->selectSingleNode(EMAIL_QSTRING);
	if ( p != NULL )
	{
		c->m_email = (LPCTSTR)p->text;
	}
	return c;
}

BOOL ContactList::Contact::operator==(const Contact & c1)
{
	return m_email == c1.m_email && m_firstName == c1.m_firstName && m_lastName == c1.m_lastName;
}

ContactList::Contact ** ContactList::get(int * count)
{
	ContactList::Contact ** list = NULL;
	if ( count != NULL ) *count = 0;

	IXMLDOMNodeListPtr nodes = m_data->documentElement->childNodes;
	if ( nodes != NULL )
	{
		if ( NULL != count ) *count = (int)nodes->length;
		long size = nodes->length;
		list = new Contact * [size];
		for (long i = 0; i < nodes->length; ++i)
		{
			list[i] = toContact(nodes->item[i]);
		}
	}
	
	return list;
}

