package com.syndrome.sanguocard.mainfram.esroom.readyroom
{
	import com.electrotank.electroserver5.user.User;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfReadyRoom;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	
	/*
	* @author nic
	* @build-time 2014-3-10
	* @comments
	*
	*/
	public class ReadyRoomLobbyUserUpdataHandler extends ReadyRoomHandlerBase
	{
		use namespace ThisIsInterface;
		
		public function ReadyRoomLobbyUserUpdataHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
		}
		
		public function lobbyPushUserAdd(user:User):void
		{
			if(InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).sonProject==null)return;
			InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).lobbyPushUserAdd(user);
		}
		
		public function lobbyDeleteUser(userName:String):void
		{
			InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).lobbyDeleteUser(userName);
		}
	}
}