package com.syndrome.sanguocard.mainfram.esroom.battle
{
	import com.communication.AppEvent;
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.PublicMessageEvent;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;
	import com.load.ResLoad;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfBattle;
	import com.syndrome.sanguocard.mainfram.main.Main;
	import com.syndrome.sanguocard.mainfram.managers.ESRoomManager;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	
	public class BattleEsRoom extends EsRoomBase
	{
		use namespace ThisIsInterface;
		private var battleProtocolHandler:BattleProtocolHandler;
		private var battleUserUpdateHandler:BattleUserUpdateHandler;
		private var battlePublicMessageHandler:BattlePublicMessageHandler;
		public var normalOut:Boolean = false;
		
		public function BattleEsRoom(_esRoomManager:ESRoomManager)
		{
			super(_esRoomManager);
			roomManager.pluginName = "FightRoom";
			roomManager = esRoomManager.battleGetRoomManager();
			usersManager = esRoomManager.battleGetUsersManager();
			interfaceOfSon = new InterfaceOfBattle(this);
		}
		
		override public function sendPreEvent():void
		{
			// TODO Auto Generated method stub
			var message:AppEvent =new AppEvent(AppEvent.ScenePrepare);
			message.objHander = interfaceOfSon;
			message.resObj = ResLoad.getRess;
			InterfaceOfBattle(interfaceOfSon).sonProject.addEventListener(AppEvent.ScenePrepareDone,function(e:AppEvent):void{onpreSceneDone(tmpRoomName, tmpZoneName)});
			InterfaceOfBattle(interfaceOfSon).sonProject.dispatchEvent(message);
		}
		
		override public function onpreSceneDone(_roomName:String, _zoneName:String):void
		{
			// TODO Auto Generated method stub
			initListeners();
			battleProtocolHandler = new BattleProtocolHandler(this);
			for each (var user:User in GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(roomManager.zoneID).roomById(roomManager.roomID).users) 
				onUserEnter(user);
		}
		
		override public function initListeners():void
		{
			// TODO Auto Generated method stub
			super.initListeners();
			battleUserUpdateHandler = new BattleUserUpdateHandler(this);
			battlePublicMessageHandler = new BattlePublicMessageHandler(this);
		}
		
		public function onInitGame():void
		{
			InterfaceOfBattle(interfaceOfSon).sonProject.visible=true;
			esRoomManager.battleInit();
			InterfaceOfBattle(interfaceOfSon).onInitGame();
			battleProtocolHandler.gameStart();
		}
		
		public function onUserEnter(user:User):void
		{
			InterfaceOfBattle(interfaceOfSon).onUserEnter(user);
		}
		
		public function reSetBattle():void
		{
			InterfaceOfBattle(interfaceOfSon).reSetBattle();
		}

		public function onRelaseGame():void
		{
			InterfaceOfBattle(interfaceOfSon).onRelaseGame();
		}
		
		public function onChannelMessage(user:User, e:PublicMessageEvent, channel:String):void
		{
			var gui:EsObject = user.userVariableByName(Constant.GetUserInfo).value;
			if(e.message!="pros"){
				InterfaceOfBattle(interfaceOfSon).onChannelMessage(e.userName, gui.getString("surname") + gui.getString("name"), e.message, channel);
			}
		}
		
		public function onPrivateMessage(senderUserName:String, senderNickname:String, receiverUserName:String, receiverNickname:String, content:String):void
		{
			InterfaceOfBattle(interfaceOfSon).onPrivateMessage(senderUserName, senderUserName, receiverUserName, receiverNickname, content);
		}
		
		public function onUserStateChange(userName:String,state:int):void
		{
			interfaceOfSon.onUserStateChange(userName, state);
		}
		
		
		public function leaveGame():void
		{
			normalOut = true;
			battleProtocolHandler.leaveGame();
		}
		
		public function returnToReady():void
		{
			esRoomManager.battleReturnToReady();
		}
		
		public function onFightHistory(history:String):void
		{
//			esRoomManager.battleOnFightHistory(history);
		}
		
		public function onSendGameStart():void
		{
			interfaceOfSon.sendGameStart();
		}
		
		public function onResProgress(pros:Number):void
		{
			esRoomManager.battleOnResProgress(pros);
		}
		
		public function onResLoadComplete():void
		{
			esRoomManager.battleOnResLoadComplete();
		}
		
		public function sendPackage(es:EsObject, type:int):void
		{
			battleProtocolHandler.sendPackage(es, type);
		}
		
		public function sendChannelMessage(content:String, channel:String, userName:Array):void
		{
			esRoomManager.sendChannelMessage(content, channel, userName);
		}
		
		public function enterGame():void
		{
			if(interfaceOfSon.sonProject==null)
			{
				esRoomManager.loadBattleScene();
			}
			else{
				esRoomManager.battleLoadSceneAlready();
				interfaceOfSon.sonProject.visible = true;
			}
		}
		
		public function rejoinGame():void
		{
			if(interfaceOfSon.sonProject==null)
			{
				esRoomManager.loadBattleScene();
			}
			else{
				esRoomManager.battleLoadSceneAlready();
				interfaceOfSon.sonProject.visible = true;
			}
			esRoomManager.battleInitLoadingOpDone();
		}
	}
}