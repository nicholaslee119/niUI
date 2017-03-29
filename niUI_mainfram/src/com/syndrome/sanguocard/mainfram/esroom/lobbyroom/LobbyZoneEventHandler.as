package com.syndrome.sanguocard.mainfram.esroom.lobbyroom
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.MessageType;
	import com.electrotank.electroserver5.api.ZoneUpdateAction;
	import com.electrotank.electroserver5.api.ZoneUpdateEvent;
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;

	public class LobbyZoneEventHandler extends LobbyHandlerBase
	{
		public function LobbyZoneEventHandler(_lobbyEsRoom:LobbyEsRoom)
		{
			super(_lobbyEsRoom);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.ZoneUpdateEvent.name,onZoneUpdateEvent);
		}
		
		private function onZoneUpdateEvent(e:ZoneUpdateEvent):void
		{
			if(e.zoneId != LobbyEsRoom(esRoomBase).roomManager.zoneID || e.roomId == 0) return;
			switch (e.action) {
				case ZoneUpdateAction.AddRoom:
					var room:Room = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(e.zoneId).roomById(e.roomId);
					trace("[LobbyZoneEventHandler]:a room just added: " +GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(e.zoneId).roomById(e.roomId).name);
					break;
				case ZoneUpdateAction.DeleteRoom:
					deleteRoomHost(e.roomId);
					trace("[LobbyZoneEventHandler]:DeleteRoom");
					break;
				case ZoneUpdateAction.UpdateRoom:
					if(e.roomCount==2)
					{
						var zone:Zone = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(e.zoneId);
						LobbyEsRoom(esRoomBase).updataGame(zone.roomById(e.roomId), zone);
					}
					trace("[LobbyZoneEventHandler]:Room count for roomId: " + e.roomId + " just changed to: " + e.roomCount);
					break;
				default:
					trace("[LobbyZoneEventHandler]:不能处理的onZoneUpdataEvent");
					break;
			}
		}
		
		private function deleteRoomHost(roomId:int):void
		{
			if(GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(LobbyEsRoom(esRoomBase).roomManager.zoneID).roomById(LobbyEsRoom(esRoomBase).roomManager.roomID).roomVariableByName(roomId.toString())==null)
				return;
			LobbyEsRoom(esRoomBase).lobbyRoomVaribleHandler.deleteRoomHost(roomId);
		}
	}
}