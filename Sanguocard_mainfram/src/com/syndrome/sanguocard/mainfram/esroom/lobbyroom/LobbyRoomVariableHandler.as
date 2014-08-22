package com.syndrome.sanguocard.mainfram.esroom.lobbyroom
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.CreateRoomRequest;
	import com.electrotank.electroserver5.api.CreateRoomVariableRequest;
	import com.electrotank.electroserver5.api.DeleteRoomVariableRequest;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.MessageType;
	import com.electrotank.electroserver5.api.RoomVariable;
	import com.electrotank.electroserver5.api.RoomVariableUpdateAction;
	import com.electrotank.electroserver5.api.RoomVariableUpdateEvent;
	import com.electrotank.electroserver5.api.UpdateRoomVariableRequest;
	import com.syndrome.client.parameters.Constant;
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;

	public class LobbyRoomVariableHandler extends LobbyHandlerBase
	{
		
		public function LobbyRoomVariableHandler(_lobbyEsRoom:LobbyEsRoom)
		{
			super(_lobbyEsRoom);
		}
		
		override protected function init():void
		{
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.RoomVariableUpdateEvent.name, onRoomVariableUpdateEvent);
		}
		
		private function onRoomVariableUpdateEvent(e:RoomVariableUpdateEvent):void {
			var room:Room = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(e.zoneId).roomById(e.roomId);
			var zone:Zone = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(e.zoneId);
			if(room.name==Constant.FREE_LOBBY_ROOM||room.name==Constant.AUTO_LOBBY_ROOM||room.name=="sanguo-practice-lobby-room")
			{
				var roomVar:RoomVariable;
				switch (e.action) {
					case RoomVariableUpdateAction.VariableCreated:
//						LobbyEsRoom(esRoomBase).messageBuffer.getUsersInRoomResponseANDroomVariableUpdateEvent(e);
						roomVar = room.roomVariableByName(e.name);
						LobbyEsRoom(esRoomBase).addGame(zone.roomById(int(roomVar.name)), zone);
						trace("[LobbyRoomVariableHandler]:LobbyRoom variable created. Name: " + roomVar.name + ", value: " + roomVar.value.toString());
						break;
					case RoomVariableUpdateAction.VariableDeleted:
						LobbyEsRoom(esRoomBase).deleteGame(int(e.name));
						trace("[LobbyRoomVariableHandler]:LobbyRoom variable deleted. Name: " + e.name);
						break;
					case RoomVariableUpdateAction.VariableUpdated:
						roomVar = room.roomVariableByName(e.name);
						LobbyEsRoom(esRoomBase).updataGame(zone.roomById(int(roomVar.name)), zone);
						trace("[LobbyRoomVariableHandler]:LobbyRoom variable updated. Name: " + roomVar.name + ", value: " + roomVar.value.toString());
						break;
				}
			}
		}
		
		public function createRoomHost(room:Room):void
		{
			if(LobbyEsRoom(esRoomBase).roomManager.room.roomVariableByName(room.id.toString())!=null)return;
			var crvr:CreateRoomVariableRequest = new CreateRoomVariableRequest();
			crvr.roomId = LobbyEsRoom(esRoomBase).roomManager.roomID;
			crvr.zoneId = LobbyEsRoom(esRoomBase).roomManager.zoneID;
			crvr.locked = false;
			crvr.persistent = false;
			crvr.name = room.id.toString();
			crvr.value = new EsObject();
			crvr.value.setString("roomHost", GameCom.getInstance().esServer.managerHelper.userManager.me.userName);
			GameCom.getInstance().esServer.engine.send(crvr);
		}
		
		internal function changeRoomHost(room:Room):void
		{
			var urvr:UpdateRoomVariableRequest = new UpdateRoomVariableRequest();
			urvr.roomId = LobbyEsRoom(esRoomBase).roomManager.roomID;
			urvr.zoneId = LobbyEsRoom(esRoomBase).roomManager.zoneID;
			urvr.locked = false;
			urvr.valueChanged = true;
			urvr.name = room.id.toString();
			urvr.value = new EsObject();
			urvr.value.setString("roomHost", room.users[0].userName);
			GameCom.getInstance().esServer.engine.send(urvr);
		}
		
		public function deleteRoomHost(roomId:int):void
		{
			var drvr:DeleteRoomVariableRequest = new DeleteRoomVariableRequest();
			drvr.name = roomId.toString();
			drvr.roomId = LobbyEsRoom(esRoomBase).roomManager.roomID;
			drvr.zoneId = LobbyEsRoom(esRoomBase).roomManager.zoneID;
			GameCom.getInstance().esServer.engine.send(drvr);
		}
	}
}