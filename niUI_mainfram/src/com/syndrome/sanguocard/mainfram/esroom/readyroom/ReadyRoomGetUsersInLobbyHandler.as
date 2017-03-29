package com.syndrome.sanguocard.mainfram.esroom.readyroom
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.GetUsersInRoomRequest;
	import com.electrotank.electroserver5.api.GetUsersInRoomResponse;
	import com.electrotank.electroserver5.api.MessageType;
	import com.electrotank.electroserver5.api.UserListEntry;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfReadyRoom;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	
	/*
	* 用于处理准备房间中获取大厅好友列表
	* @author nic
	* @build-time 2014-3-10
	* @comments
	*
	*/
	public class ReadyRoomGetUsersInLobbyHandler extends ReadyRoomHandlerBase
	{
		private var lobbyRoom:Room;
		use namespace ThisIsInterface;
		
		public function ReadyRoomGetUsersInLobbyHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.GetUsersInRoomResponse.name, onGetUsersInLobbyResponse);
		}
		
		private function onGetUsersInLobbyResponse(e:GetUsersInRoomResponse):void
		{
			if(lobbyRoom.id!=e.roomId)return;
			GameCom.getInstance().esServer.engine.removeEventListener(MessageType.GetUsersInRoomResponse.name, onGetUsersInLobbyResponse);
			var room:Room = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(e.zoneId).roomById(e.roomId);
			var zoneName:String = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(e.zoneId).name;
			for each (var user:User in room.users) 
				InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).onGetUsersInLobbyResponse(user);
		}
		
		public function getUsersInLobby(_room:Room):void
		{
			lobbyRoom = _room;
			var guir:GetUsersInRoomRequest = new GetUsersInRoomRequest();
			guir.zoneId = _room.zoneId;
			guir.roomId = _room.id;
			GameCom.getInstance().esServer.engine.send(guir);
		}
		
	}
}