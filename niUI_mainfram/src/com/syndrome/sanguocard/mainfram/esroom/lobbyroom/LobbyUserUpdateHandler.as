package com.syndrome.sanguocard.mainfram.esroom.lobbyroom
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.MessageType;
	import com.electrotank.electroserver5.api.UserUpdateAction;
	import com.electrotank.electroserver5.api.UserUpdateEvent;
	import com.electrotank.electroserver5.user.User;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomUserUpdateHandler;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfLobby;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;

	public class LobbyUserUpdateHandler extends EsRoomUserUpdateHandler
	{
		use namespace ThisIsInterface;
		
		public function LobbyUserUpdateHandler(_lobbyEsRoom:LobbyEsRoom)
		{
			super(_lobbyEsRoom);
		}
		
		override protected function onUserUpdateEvent(e:UserUpdateEvent):void
		{
			if(e.zoneId != LobbyEsRoom(esRoomBase).roomManager.zoneID)return;
			var user:User = null;
			switch (e.action) 
			{
				case UserUpdateAction.AddUser:
					user= LobbyEsRoom(esRoomBase).usersManager.findUser(e.userName);
					if(user!=null && e.roomId == LobbyEsRoom(esRoomBase).roomManager.roomID)
					{
						InterfaceOfLobby(LobbyEsRoom(esRoomBase).interfaceOfSon).onUserJoinRoom(user);
					}
					break;
				case UserUpdateAction.DeleteUser:
					if(e.roomId == LobbyEsRoom(esRoomBase).roomManager.roomID)
					{
						InterfaceOfLobby(LobbyEsRoom(esRoomBase).interfaceOfSon).onUserLeave(e.userName);
						LobbyEsRoom(esRoomBase).esRoomManager.lobbyDeleteUser(e.userName);
					}
					break;
				default:
					trace("LobbyEsRoom: Action not handled: " + e.action.name);
					break;
			}
		}
	}
}