package com.syndrome.sanguocard.mainfram.esroom.lobbyroom
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.JoinRoomEvent;
	import com.electrotank.electroserver5.api.JoinRoomRequest;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomJoinRoomHandler;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfLobby;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	public class LobbyJoinRoomHandler extends EsRoomJoinRoomHandler
	{
		use namespace ThisIsInterface;
		
		public function LobbyJoinRoomHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function onJoinRoomEvent(e:JoinRoomEvent):void
		{
			// TODO Auto Generated method stub
			super.onJoinRoomEvent(e);
			if(e.roomName==Constant.AUTO_LOBBY_ROOM || e.roomName==Constant.FREE_LOBBY_ROOM)
			{
				if(e.roomName==Constant.AUTO_LOBBY_ROOM)LobbyEsRoom(esRoomBase).roomManager.pluginName="PairLobbyRoom";
				else if(e.roomName==Constant.FREE_LOBBY_ROOM)LobbyEsRoom(esRoomBase).roomManager.pluginName="FreeLobbyRoom";
				var tmpZone:Zone = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(e.zoneId);
				var tmpRoom:Room = tmpZone.roomById(e.roomId);
				if(tmpRoom==null) throw"无法获取onJoinRoomEvent里面的房间消息";
				LobbyEsRoom(esRoomBase).onInitPreRoom(tmpRoom.id,tmpRoom.zoneId,tmpRoom,tmpZone,e.roomName,tmpZone.name);
				if(e.roomName==Constant.FREE_LOBBY_ROOM)LobbyEsRoom(esRoomBase).findGame(tmpZone.name);
				for each (var user:User in tmpRoom.users)
				{
					var cb:EsObject = new EsObject();
					if(user.isMe)
						LobbyEsRoom(esRoomBase).usersManager.meUser = user;
					InterfaceOfLobby(LobbyEsRoom(esRoomBase).interfaceOfSon).onUserJoinRoom(user);
				}
			}
		}
		
		override public function joinRoomORcreateRoom(_room:String, _zone:String, gameId:int, pwd:String, create:Boolean):void
		{
			// TODO Auto Generated method stub
			super.joinRoomORcreateRoom(_room, _zone, gameId, pwd, create);
			var jnRm:JoinRoomRequest =new JoinRoomRequest();
			jnRm.roomName = _room;
			jnRm.zoneName = _zone;
			jnRm.password = pwd;
			GameCom.getInstance().esServer.engine.send(jnRm);
		}
	}
}