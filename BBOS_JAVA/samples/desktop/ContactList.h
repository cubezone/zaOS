#ifndef __CONTACTLIST_H_
#define __CONTACTLIST_H_

using namespace MSXML2;

static char const * const DATAFILE = "ContactList.xml";
static char const * QUERY_STRING = ".//contact[@first=\"%s\" and @last=\"%s\"]"; //search the current context branch
static char const * FIRST_QSTRING = "./first"; //search for the 'first' element in child nodes of current context
static char const * LAST_QSTRING = "./last"; //search for the 'last' element in child nodes of current context
static char const * EMAIL_QSTRING = "./email"; //search for the first element in child nodes of current context

const int FIELDTAG_FIRST_NAME = 1;
const int FIELDTAG_LAST_NAME = 2;
const int FIELDTAG_EMAIL_ADDRESS = 3;

class ContactList
{
public:
	class Contact {
	public:
		Contact() {}
		Contact(char const * const fn, char const * const ln, char const * const email) 
		{
			m_firstName = (LPCTSTR)fn;
			m_lastName = (LPCTSTR)ln;
			m_email = (LPCTSTR)email;
		}
			
	public:
		CString m_firstName;
		CString m_lastName;
		CString m_email;
	public:
		BSTR toXMLNode();
		
		BOOL operator==(const Contact & c1);
	};

public:
	ContactList(char const * const filename);
	
	bool contains(char const * firstname, char const * lastname);
	Contact * get(char const * firstname, char const * lastname);
	Contact** get(int * count); //get the entire list of contacts

	/*
	 * adds or replaces elements. if an element matching the first and last name fields is already present, the email field is updated
	 * using the value contained in the contact instance
	 */
	bool put(Contact * contact);

	/*
	 * save the DOM to the named file
	 */
	bool save(char const * const filename); 
	
private:
	IXMLDOMNodePtr getNode(char const * firstname, char const * lastname);
	Contact * toContact(IXMLDOMNodePtr p);

private:
	IXMLDOMDocument2Ptr m_data;
	IXMLDOMNodePtr m_node; //place holder to allow some optimization
	CString m_homePath;
};

#endif //__CONTACTLIST_H_