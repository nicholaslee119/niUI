package com.syndrome.client.parameters
{
	import com.communication.gamecom.GameCom;
	import com.load.XmlLoad;
	import com.load.xmlLoadEvent;
	
	/*
	* @author nic
	* @build-time 2014-3-4
	* @comments
	*
	*/
	public class ParametersXMLLoader
	{
		private var xmlLoad:XmlLoad;
		private var onCompleted:Function;
		private var DEBUG:Boolean = false;
		private var resMainfram:Array = new Array(2);
		
		public function ParametersXMLLoader(_onCompleted:Function)
		{
			onCompleted = _onCompleted;
			init();
		}
		
		private function init():void
		{
			xmlLoad = new XmlLoad();
			xmlLoad.addEventListener(xmlLoadEvent.complete,onXmlComplete);
			xmlLoad.addEventListener(xmlLoadEvent.err,onXmlerr);
			var arrChild:Array =["ESSettings", "Resource"];
			if(PublicParameters.isDebug())
				xmlLoad.LoadXml("config/publicParameters.xml",arrChild);
			else
				xmlLoad.LoadXml("./Public/Game/config/publicParameters.xml",arrChild);
		}
		
		private function onXmlerr(e:xmlLoadEvent):void
		{
			trace(e.errMsg);
		}
		
		private function onXmlComplete(e:xmlLoadEvent):void
		{
			if((e.childs)==null)return;
			xmlLoad.removeEventListener(xmlLoadEvent.complete,onXmlComplete);
			xmlLoad.removeEventListener(xmlLoadEvent.err,onXmlerr);
			onCompleted(e.xmlData.children());
		}
	}
}