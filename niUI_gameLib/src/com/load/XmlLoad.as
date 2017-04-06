package com.load
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	public class XmlLoad extends EventDispatcher
	{
		public function XmlLoad()
		{
			super(this);
		}
		/*public static function RemoveEventListener(type:String ,fun:Function):void
		{
			getIntace().removeEventListener(type,fun);
		}*/
		public function LoadXml(url:String,arrChildList:Array=null,refsh:Boolean=true):void
		{
			LoadTXml(url,arrChildList,refsh);
		}
		
		private function LoadTXml(url:String,arrChildList:Array=null,refsh:Boolean=true):void
		{
			childListName =arrChildList;
			if(loader==null) loader =new URLLoader();
			loader.dataFormat =URLLoaderDataFormat.BINARY;
			if(refsh){
				var datas:Date = new Date();
				url=url+"?rvid="+datas.fullYear.toString();
				url=url+datas.month.toString();
				url=url+datas.hours.toString();
				url=url+datas.minutes.toString();
				url=url+datas.seconds.toString();
			}
			var urlReq:URLRequest =new URLRequest(url);
			loader.addEventListener(Event.COMPLETE,onXmlComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
			loader.load(urlReq);
		}

		private function onXmlComplete(e:Event):void
		{
			loader.removeEventListener(Event.COMPLETE,onXmlComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
			
			var msg:String="";
			if(e.target is URLLoader)
			{
				var tmp:URLLoader =e.target as URLLoader;
				try{
					dataXml=XML(tmp.data);
					if(dataXml!=null && childListName!=null)
					{
						var lth:int =childListName.length;
						childListArr =new Array(lth);
						for(var i:int=0;i<lth;i++)
						{
							var strName:String=childListName[i].toString();
							childListArr[i] =dataXml.child(strName);
						}
					}
				}
				catch(err:Error)
				{
					msg=err.message;
				}
			}
			loader=null;
			sendMsg(xmlLoadEvent.complete,msg,dataXml,childListArr);
		}
		
		private function sendMsg(strEvent:String,err:String="",xmldata:XML=null,childs:Array=null):void
		{
			var evt:xmlLoadEvent =new xmlLoadEvent(strEvent);
			evt.xmlData=xmldata;
			evt.childs =childs;
			evt.errMsg=err;
			dispatchEvent(evt);
		}

		private function onIOError(e:IOErrorEvent):void
		{
			sendMsg(xmlLoadEvent.err,"onIOError:"+e.text);
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void
		{
			sendMsg(xmlLoadEvent.err,"onSecurityError:"+e.text);
		}
		private var childListName:Array =null; //名字列表
		private var childListArr:Array =null;
		private var dataXml:XML =null;
		private var loader:URLLoader =null;
	}
}