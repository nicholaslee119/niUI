package com.load.xmlmanager
{
	
	/*
	* @author nic
	* @build-time 2014-3-4
	* @comments
	*
	*/
	public class XMLItem
	{
		public var name:String;
		public var url:String;
		public var localName:String;
		
		public function XMLItem(_name:String, _url:String, _localName:String)
		{
			name = _name;
			url = _url;
			localName = _localName;
		}
	}
}