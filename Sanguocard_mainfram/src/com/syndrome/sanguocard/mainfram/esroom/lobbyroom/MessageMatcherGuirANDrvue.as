package com.syndrome.sanguocard.mainfram.esroom.lobbyroom
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.GetUsersInRoomResponse;
	import com.electrotank.electroserver5.api.RoomVariableUpdateEvent;
	import com.electrotank.electroserver5.api.UserListEntry;
	import com.electrotank.electroserver5.zone.Room;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfLobby;

	public class MessageMatcherGuirANDrvue
	{
		public var getUsersInRoomResponse:GetUsersInRoomResponse = null;
		public var roomVariableUpdateEvent:RoomVariableUpdateEvent = null;
		private var messageBufferLobby:MessageBufferLobby;
		
		public function MessageMatcherGuirANDrvue(_messageBufferLobby:MessageBufferLobby)
		{
			messageBufferLobby = _messageBufferLobby;
		}
		
		public function MessageMatch(index:int, guirANDrvueBuffer:Vector.<MessageMatcherGuirANDrvue>, e:*):Boolean
		{
			if(e is GetUsersInRoomResponse && roomVariableUpdateEvent!=null)
			{
				try{
					if(GetUsersInRoomResponse(e).roomId.toString() == GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(roomVariableUpdateEvent.zoneId).roomById(roomVariableUpdateEvent.roomId).roomVariableByName(roomVariableUpdateEvent.name).name)  
					{
						getUsersInRoomResponse = e;
						triggerGetUsersInRoomResponseANDroomVariableUpdateEvent(index);
						return true;
					}
				}catch(err:Error){
					trace("[MessageMatcher]: "+err.message);
				}
			}
			else if(e is RoomVariableUpdateEvent && getUsersInRoomResponse!=null)
			{
				try{
					if(GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(RoomVariableUpdateEvent(e).zoneId).roomById(RoomVariableUpdateEvent(e).roomId).roomVariableByName(RoomVariableUpdateEvent(e).name).name == getUsersInRoomResponse.roomId.toString())
					{
						roomVariableUpdateEvent = e;
						triggerGetUsersInRoomResponseANDroomVariableUpdateEvent(index);
						return true;
					}
				}catch(err:Error){
					trace("[MessageMatcher]: "+err.message);
				}
			}
			return false;
		}
		
		public function triggerGetUsersInRoomResponseANDroomVariableUpdateEvent(index:int):void
		{
			var room:Room = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(getUsersInRoomResponse.zoneId).roomById(getUsersInRoomResponse.roomId);
			var zoneName:String = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(getUsersInRoomResponse.zoneId).name;
			var lobbyRoom:Room = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(roomVariableUpdateEvent.zoneId).roomById(roomVariableUpdateEvent.roomId);
			for each (var ule:UserListEntry in getUsersInRoomResponse.users) {
				messageBufferLobby.lobbyEsRoom.sendUsersInRoom(messageBufferLobby.lobbyEsRoom.usersManager.findUser(ule.userName), room, zoneName, lobbyRoom);
			}
			messageBufferLobby.deleteMessageMatcherGuirANDrvue(index);
			getUsersInRoomResponse = null;
			roomVariableUpdateEvent = null;
		}
	}
}