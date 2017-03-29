package com.syndrome.sanguocard.mainfram.interfaceOfSon
{
	import com.communication.AppEvent;
	import com.syndrome.sanguocard.mainfram.esroom.platform.PlatformEsRoom;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;

	public class InterfaceOfPlatform extends InterfaceOfSonBase
	{
		public function InterfaceOfPlatform(esRoom:*)
		{
			super(esRoom);
		}
		
		ThisIsInterface function addGameBstartListener(_roomName:String, _zoneName:String):void
		{
			var message:AppEvent = new AppEvent(AppEvent.ScenePrepare);
			message.objHander = this;
			sonProject.addEventListener(AppEvent.ScenePrepareDone,function(e:AppEvent):void{esRoom.onpreSceneDone(_roomName, _zoneName)});
			sonProject.dispatchEvent(message);
		}
		
		public function choiceLobby(which:String):void
		{
			PlatformEsRoom(esRoom).choiceLobby(which);
		}
		
		public function sendPrivateMessage(chat:String, usersName:Array):void 
		{
			PlatformEsRoom(esRoom).sendPrivateMessage(chat, usersName);
		}
		
		public function sendPublicMessage(chat:String):void
		{
			PlatformEsRoom(esRoom).sendPublicMessage(chat);
		}
		
		public function sendFriendRequest(userName:String):void
		{
			PlatformEsRoom(esRoom).sendFriendRequest(userName);
		}
		
		public function sendMailRequest(userName:String):void
		{
			PlatformEsRoom(esRoom).sendMailRequest(userName);
		}
		
		public function updateGUI():void
		{
			PlatformEsRoom(esRoom).reflashSelfGUI();
		}
	}
}