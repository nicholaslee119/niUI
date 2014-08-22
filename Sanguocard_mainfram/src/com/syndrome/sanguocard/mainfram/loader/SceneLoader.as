package com.syndrome.sanguocard.mainfram.loader
{
	import com.load.resmanager.ResManager;
	import com.syndrome.sanguocard.mainfram.main.Main;
	import com.syndrome.sanguocard.mainfram.ui.AlertPanel;
	
	import flash.display.DisplayObject;

	public class SceneLoader
	{
		private var scenePath:String;
		private var sceneName:String;
		private var main:Main
		
		
		public function SceneLoader(_main:Main, _scenePath:String, _sceneName:String )
		{
			main = _main;
			scenePath = _scenePath;
			sceneName = _sceneName;
			beginLoad();
		}
		
		private function beginLoad():void
		{
			if(sceneName==main.sceneXmlModel.lobbyScene["name"])
			{
				AlertPanel.creatInstance().showTempLoading();
			}
			else if(sceneName==main.sceneXmlModel.readyScene["name"])
			{
				AlertPanel.creatInstance().showTempLoading();
			}
			else if(sceneName==main.sceneXmlModel.battleScene["name"])
				main.initLoading();
			ResManager.getInstance().getRes(scenePath, onCplt, onSceneLoadProgress);
		}
		
		private function onSceneLoadProgress(pros:Number):void
		{
			if(sceneName==main.sceneXmlModel.battleScene["name"])
			{
				pros = pros/2;
				main.onSceneBattleProgress(pros);
			}else if(sceneName==main.sceneXmlModel.lobbyScene["name"]){
				if(pros == 1){
					AlertPanel.creatInstance().hideTempLoading();
				}
			}else if(sceneName==main.sceneXmlModel.readyScene["name"]){
				if(pros == 1){
					AlertPanel.creatInstance().hideTempLoading();
				}
			}
		}
		
		private function onCplt(_d:DisplayObject):void
		{
			main.esRoomManager.mainOnSceneLoderCompleted(_d, sceneName);
		}
	}
}