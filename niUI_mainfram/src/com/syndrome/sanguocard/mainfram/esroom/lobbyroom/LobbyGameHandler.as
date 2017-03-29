package com.syndrome.sanguocard.mainfram.esroom.lobbyroom
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.ServerGame;
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.managers.gamesmanager.GamesManager;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	
	/*
	* @author nic
	* @build-time 2014-6-6
	* @comments
	*
	*/
	public class LobbyGameHandler extends LobbyHandlerBase
	{
		use namespace ThisIsInterface;
		
		public function LobbyGameHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
		}
		
		public function findGame(zoneName:String):void
		{
			LobbyEsRoom(esRoomBase).interfaceOfSon.onClearAllGame(zoneName);
			GamesManager.getInstance().updateGames(function(item:ServerGame, index:int, array:Array):void{onGameUpdate(item)}, function():void{LobbyEsRoom(esRoomBase).interfaceOfSon.reflashRoomList(zoneName)});
			function onGameUpdate(item:ServerGame):void
			{
				var zone:Zone = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(item.gameDetails.getInteger("zoneId"));
				if(zone==null) return;
				if(zone.name!=zoneName)return;
				var room:Room = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(item.gameDetails.getInteger("zoneId")).roomById(item.gameDetails.getInteger("roomId"));
				if(room==null) return;
				LobbyEsRoom(esRoomBase).interfaceOfSon.onGameUpdate(room, zone, item);
			}
		}
		
		public function addGame(room:Room, zone:Zone):void
		{
			GamesManager.getInstance().findGameByRoom(room, onFindGameByRoom);
			function onFindGameByRoom(item:ServerGame, index:int, array:Array):Boolean
			{
				if(item.roomId == room.id && item.zoneId == room.zoneId)
				{
					LobbyEsRoom(esRoomBase).interfaceOfSon.addGame(room, zone, item);
					return true;
				}else
					return false;
			}
		}
		
		public function updataGame(room:Room, zone:Zone):void
		{
			GamesManager.getInstance().findGameByRoom(room, onFindGameByRoom);
			function onFindGameByRoom(item:ServerGame, index:int, array:Array):Boolean
			{
				if(item.roomId == room.id && item.zoneId == room.zoneId)
				{
					LobbyEsRoom(esRoomBase).interfaceOfSon.updataGame(room, zone, item);
					return true;
				}else
					return false;
			}
		}
	}
}