package com.syndrome.sanguocard.mainfram.esroom.lobbyroom
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.GetUserCountRequest;
	import com.electrotank.electroserver5.api.GetUsersInRoomRequest;
	import com.electrotank.electroserver5.api.GetUsersInRoomResponse;
	import com.electrotank.electroserver5.api.MessageType;
	import com.electrotank.electroserver5.api.UserListEntry;
	import com.electrotank.electroserver5.zone.Room;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomGetUsersInRoomHandler;

	public class LobbyGetUsersInRoomHandler extends EsRoomGetUsersInRoomHandler
	{
		public function LobbyGetUsersInRoomHandler(_lobbyEsRoom:LobbyEsRoom)
		{
			super(_lobbyEsRoom);
		}
		
		override protected function onGetUsersInRoomResponse(e:GetUsersInRoomResponse):void
		{
			var room:Room = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(e.zoneId).roomById(e.roomId);
			var zoneName:String = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(e.zoneId).name;
			for each (var ule:UserListEntry in e.users) {
				LobbyEsRoom(esRoomBase).sendUsersInRoom(LobbyEsRoom(esRoomBase).usersManager.findUser(ule.userName), room, zoneName, 
					GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(LobbyEsRoom(esRoomBase).roomManager.zoneID).roomById(LobbyEsRoom(esRoomBase).roomManager.roomID));
			}
		}
		
		public function getUsersInRoomWithId(_roomId:int, _zoneId:int):void
		{
			var guir:GetUsersInRoomRequest = new GetUsersInRoomRequest();
			guir.zoneId = _zoneId;
			guir.roomId = _roomId;
			GameCom.getInstance().esServer.engine.send(guir);
		}
		
		public function getUsersInRoom(_room:Room):void
		{
			var guir:GetUsersInRoomRequest = new GetUsersInRoomRequest();
			guir.zoneId = _room.zoneId;
			guir.roomId = _room.id;
			GameCom.getInstance().esServer.engine.send(guir);
		}
	}
}