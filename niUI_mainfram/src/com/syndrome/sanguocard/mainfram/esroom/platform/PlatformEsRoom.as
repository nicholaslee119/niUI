package com.syndrome.sanguocard.mainfram.esroom.platform
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.syndrome.client.enum.EnumP2PMessageType;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfPlatform;
	import com.syndrome.sanguocard.mainfram.managers.ESRoomManager;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	
	public class PlatformEsRoom extends EsRoomBase
	{
		use namespace ThisIsInterface;
		private var platformJoinRoomHandler:PlatformJoinRoomHandler;
		private var platformPublicMessageHandler:PlatformPublicMessageHandler;
		private var platformPrivateMessageHandler:PlatformPrivateMessageHandler;
		private var platformProtocolHandler:PlatformProtocolHandler;
		private var platformUserVariableHandler:PlatformUserVariableHandler;
		private var platformGetUserInRoomHandler:PlatformGetUserInRoomHandler;
		private var platformUserUpdateHandler:PlatformUserUpdateHandler;
		
		public function PlatformEsRoom(_esRoomManager:ESRoomManager)
		{
			super(_esRoomManager);
			interfaceOfSon = new InterfaceOfPlatform(this);
			platformJoinRoomHandler = new PlatformJoinRoomHandler(this);
		}
		
		override public function initListeners():void
		{
			// TODO Auto Generated method stub
			super.initListeners();
			platformPublicMessageHandler = new PlatformPublicMessageHandler(this);
			platformPrivateMessageHandler = new PlatformPrivateMessageHandler(this);
			platformUserVariableHandler = new PlatformUserVariableHandler(this);
			platformUserUpdateHandler = new PlatformUserUpdateHandler(this);
			platformProtocolHandler = new PlatformProtocolHandler(this);
			platformGetUserInRoomHandler = new PlatformGetUserInRoomHandler(this);
		}
		
		override public function onpreSceneDone(_roomName:String, _zoneName:String):void
		{
			// TODO Auto Generated method stub
			super.onpreSceneDone(_roomName, _zoneName);
			ExternalInterface.call("onReadyForChoiceLobby");
		}
		
		override public function joinRoomORcreateRoom(_room:String, _zone:String):void
		{
			// TODO Auto Generated method stub
			platformJoinRoomHandler.joinRoomORcreateRoom(_room, _zone, 0, "", false);
		}
		
		override protected function onCheckHeartBeatReceived(e:TimerEvent):void
		{
			// TODO Auto Generated method stub
			super.onCheckHeartBeatReceived(e);
			platformProtocolHandler.onCheckHeartBeatReceived();
		}
		
		public function sendPublicMessage(ChatContent:String):void
		{
			platformPublicMessageHandler.sendPublicMessage(ChatContent);
		}
		
		public function choiceLobby(which:String):void
		{
			esRoomManager.platformEnterLobby(which);
		}
		
		public function sendPrivateMessage(chat:String, usersName:Array):void 
		{
			platformPrivateMessageHandler.sendPrivateChatMessage(chat, usersName);
		}
		
		public function sendFriendRequest(userName:String):void
		{
			platformPrivateMessageHandler.sendP2PMessage(EnumP2PMessageType.FRIENDREQUEST, userName);
		}
		
		public function sendMailRequest(userName:String):void
		{
			platformPrivateMessageHandler.sendP2PMessage(EnumP2PMessageType.MAILREQUEST, userName);
		}
		
		public function updataGUI():void
		{
			
		}
		
		public function onPrivateMessage(senderUserName:String, senderNickname:String, receiverUserName:String, receiverNickname:String, content:String):void
		{
			esRoomManager.platformOnPrivateMessage(senderUserName, senderNickname, receiverUserName, receiverNickname, content);
		}
		
		public function getUserInfo(userName:String, cb:EsObject):void
		{
			platformProtocolHandler.getUserInfo(userName, cb);
		}
		
		public function reflashSelfGUI():void
		{
			var cb:EsObject = new EsObject();
			cb.setString("from", Constant.SCENE_PLATFORM);
			cb.setString("which", "me");
			if(GameCom.getInstance().esServer.managerHelper.userManager.me == null)return;
			platformProtocolHandler.getUserInfo(GameCom.getInstance().esServer.managerHelper.userManager.me.userName, cb);
		}
		
		public function updataUserVariable(value:EsObject):void
		{
			platformUserVariableHandler.updataUserVariable(value);
		}
		
		public function LoadScene():void
		{
			tmpRoomName = Constant.PLATFORM_ROOM;
			tmpZoneName = "sanguo-zone";
			esRoomManager.loadPlatformScene();
		}
		
		public function getUserList():void
		{
			platformGetUserInRoomHandler.getUsersInRoom();
		}
		
		public function switchUserStatus(status:int):void
		{
			platformUserVariableHandler.switchUserStatus(status);
		}
	}
}