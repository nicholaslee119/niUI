package com.syndrome.sanguocard.mainfram.esroom.lobbyroom
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.GetUserVariablesResponse;
	import com.electrotank.electroserver5.api.GetUsersInRoomResponse;
	import com.electrotank.electroserver5.api.RoomVariableUpdateEvent;
	import com.electrotank.electroserver5.api.UserListEntry;
	import com.electrotank.electroserver5.zone.Room;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfLobby;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;

	public class MessageBufferLobby
	{
		use namespace ThisIsInterface;
		public var lobbyEsRoom:LobbyEsRoom;
		private var guirANDrvueBuffer:Vector.<MessageMatcherGuirANDrvue> = new Vector.<MessageMatcherGuirANDrvue>;
		
		public function MessageBufferLobby(_lobbyEsRoom:LobbyEsRoom)
		{
			lobbyEsRoom = _lobbyEsRoom;
		}
		
		public function getUsersInRoomResponseANDroomVariableUpdateEvent(e:*):void
		{
			if(e is GetUsersInRoomResponse)
				triggerGetUsersInRoomResponse(e, GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(lobbyEsRoom.roomManager.zoneID).roomById(lobbyEsRoom.roomManager.roomID));
			if(!guirANDrvueBuffer.some(
					function(item:MessageMatcherGuirANDrvue, index:int, guirANDrvueBuffer:Vector.<MessageMatcherGuirANDrvue>):Boolean{return findMessageMatcherGuirANDrvue(item, index, guirANDrvueBuffer, e)}))
			{
				var tempMatcher:MessageMatcherGuirANDrvue = new MessageMatcherGuirANDrvue(this);
				if(e is GetUsersInRoomResponse)
					tempMatcher.getUsersInRoomResponse = e;
				else if(e is RoomVariableUpdateEvent)
					tempMatcher.roomVariableUpdateEvent = e;
				guirANDrvueBuffer.push(tempMatcher);
			}
		}
		
		private function findMessageMatcherGuirANDrvue(item:MessageMatcherGuirANDrvue, index:int, guirANDrvueBuffer:Vector.<MessageMatcherGuirANDrvue>, e:*):Boolean
		{
			return item.MessageMatch(index, guirANDrvueBuffer, e);
		}
		
		private function triggerGetUsersInRoomResponse(getUsersInRoomResponse:GetUsersInRoomResponse, lobbyRoom:Room):void
		{
			var room:Room = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(getUsersInRoomResponse.zoneId).roomById(getUsersInRoomResponse.roomId);
			var zoneName:String = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(getUsersInRoomResponse.zoneId).name;
			for each (var ule:UserListEntry in getUsersInRoomResponse.users) {
				lobbyEsRoom.sendUsersInRoom(lobbyEsRoom.usersManager.findUser(ule.userName), room, zoneName, lobbyRoom);
			}
		}
		
		public function deleteMessageMatcherGuirANDrvue(index:int):void
		{
			guirANDrvueBuffer.splice(index, 1);
		}
	}
}