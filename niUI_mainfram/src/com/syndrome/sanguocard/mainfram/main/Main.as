package com.syndrome.sanguocard.mainfram.main
{
	
	import com.electrotank.electroserver5.util.ES5TraceAdapter;
	import com.electrotank.logging.adapter.Log;
	import com.load.resmanager.ResManager;
	import com.load.xmlmanager.XMLManager;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.client.parameters.PublicParameters;
	import com.syndrome.sanguocard.mainfram.loader.SceneLoader;
	import com.syndrome.sanguocard.mainfram.loader.SceneXmlModel;
	import com.syndrome.sanguocard.mainfram.managers.ESRoomManager;
	import com.syndrome.sanguocard.mainfram.ui.AlertPanel;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.utils.ByteArray;
	
	import org.osmf.net.StreamingURLResource;
	
	public class Main
	{
		public var mainfram:gameFram = null;
		private var mainLoginHandler:MainLoginHandler;
		private var mainLoadHandler:MainLoadHandler;
		private var mainConnectHandler:MainConnectHandler;
		private var mainGenericErrorHander:MainGenericErrorHander;
		public var sceneXmlModel:SceneXmlModel;
		public var esRoomManager:ESRoomManager;
		
		public function Main(_gameFram:gameFram)
		{
			mainfram =_gameFram;
			Log.setLogAdapter(new ES5TraceAdapter());
			esRoomManager = new ESRoomManager(this);
			mainLoadHandler = new MainLoadHandler(this);
			mainConnectHandler = new MainConnectHandler(this);
			mainGenericErrorHander = new MainGenericErrorHander();
			if(PublicParameters.isDebug())
			{
				ResManager.getInstance().getRes(XMLManager.getUrlByName(Constant.RES_MAINFRAM), onCompleted);
				function onCompleted(res:Object):void
				{
					var UI_Login:* = res.UI_Login;
					UI_Login.btn_login.addEventListener(MouseEvent.CLICK, onLoginClick);
					mainfram.sonProjectPanel.addChild(UI_Login);
					
					function onLoginClick(evt:MouseEvent):void
					{
						UI_Login.visible = false;
						UI_Login.btn_login.removeEventListener(MouseEvent.CLICK,onLoginClick);
						login(UI_Login.input_account.text, UI_Login.input_password.text);
					}
				}
			}
		}
		
		internal function onLoadConfigXml():void
		{
			sceneXmlModel = new SceneXmlModel();
			esRoomManager.mainOnXmlComplete(); 
		}
		
		public function returnToReady():void
		{
			esRoomManager.MainReturnToReady();
			ExternalInterface.call("onExitFullScreen");
		}
		
		public function onHideSiderBar():void
		{
			esRoomManager.mainOnHideSiderBar();
		}
		
		public function onInit():void
		{
		}
		
		public function login(userName:String,pwd:String="000000"):void
		{
			if(mainLoginHandler == null)mainLoginHandler = new MainLoginHandler(this);
			mainLoginHandler.login(userName, pwd);
		}
		
		public function onSceneBattleProgress(pros:Number):void
		{
			mainLoadHandler.onSceneBattleProgress(pros);
		}
		
		public function onResBattleProgress(pros:Number):void
		{
			mainLoadHandler.onResBattleProgress(pros);
		}
		
		public function onResLoadComplete():void
		{
			mainLoadHandler.onResLoadComplete();
		}
		
		public function onGetOpPros(pros:Number):void
		{
			mainLoadHandler.onGetOpPros(pros);
		}
		
		public function hideUILoading():void
		{
			mainLoadHandler.hideUILoading();
		}
		
		public function showUILoading():void
		{
			mainLoadHandler.showUILoading();
		}
		
		public function getUILoadingDisplayStatus():Boolean
		{
			return mainLoadHandler.getUILoadingDisplayStatus();
		}
		
		public function initLoading():void
		{
			mainLoadHandler.initLoading();
		}
		
		public function initOpDone():void
		{
			mainLoadHandler.initOpDone();
		}
		
		public function LoadScene(scene:Array):void
		{
			new SceneLoader(this, scene["path"], scene["name"]);	
		}
		
		public function RequestLeaveGame():void
		{
			esRoomManager.mainRequestLeaveGame();
		}
	}
}