package com.syndrome.sanguocard.mainfram.loader
{
	
	import com.load.XmlLoad;
	import com.load.xmlLoadEvent;
	import com.load.xmlmanager.XMLManager;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.client.parameters.PublicParameters;
	import com.syndrome.sanguocard.mainfram.main.Main;
	
	public class SceneXmlModel
	{
		public var platScene:Array = new Array(2);
		public var lobbyScene:Array = new Array(2);
		public var readyScene:Array = new Array(2);
		public var battleScene:Array = new Array(2);
		
		public function SceneXmlModel()
		{
			init();
		}
		
		private function init():void
		{
			platScene["name"] = Constant.SCENE_PLATFORM;
			platScene["path"] = XMLManager.getUrlByName(Constant.SCENE_PLATFORM);
		
			lobbyScene["name"] = Constant.SCENE_LOBBY;
			lobbyScene["path"] = XMLManager.getUrlByName(Constant.SCENE_LOBBY);
		
			readyScene["name"] = Constant.SCENE_READYROOM;
			readyScene["path"] = XMLManager.getUrlByName(Constant.SCENE_READYROOM);
		
			battleScene["name"] = Constant.SCENE_BATTLE;
			battleScene["path"] = XMLManager.getUrlByName(Constant.SCENE_BATTLE);
		}
		
	}
}