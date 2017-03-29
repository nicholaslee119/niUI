package com.syndrome.sanguocard.mainfram.esroom.readyroom
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.JoinGameRequest;
	import com.electrotank.electroserver5.api.JoinRoomEvent;
	import com.electrotank.electroserver5.api.JoinRoomRequest;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;
	import com.syndrome.client.enum.EnumFightType;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomJoinRoomHandler;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfReadyRoom;
	import com.syndrome.sanguocard.mainfram.managers.gamesmanager.GamesManager;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	public class ReadyRoomJoinRoomHandler extends EsRoomJoinRoomHandler
	{
		use namespace ThisIsInterface; 
		internal var gameManager:GameManager = null;
		private var rejoinFlag:Boolean = false;
		public var figthType:String = EnumFightType.FREE;
		
		public function ReadyRoomJoinRoomHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
			gameManager = new GameManager(ReadyEsRoom(esRoomBase));
		}
		
		override protected function onJoinRoomEvent(e:JoinRoomEvent):void
		{
			// TODO Auto Generated method stub
			super.onJoinRoomEvent(e);
			if(e.roomName!=Constant.AUTO_LOBBY_ROOM && e.roomName!=Constant.FREE_LOBBY_ROOM && e.roomName!=Constant.PLATFORM_ROOM && e.roomName!="sanguo-practice-lobby-room")
			{
				InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).initUI(ReadyEsRoom(esRoomBase).getWhichLobby());
				if(GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(e.zoneId).name == Constant.FREE_LOBBY)
				{
					ReadyEsRoom(esRoomBase).enterFreeReadyRoom();
					InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).sonProject.visible = true;
				}
				else if(GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(e.zoneId).name == Constant.AUTO_LOBBY)
				{
					ReadyEsRoom(esRoomBase).enterAutoReadyRoom();
					InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).sonProject.visible = false;
				}
				ReadyEsRoom(esRoomBase).roomManager.pluginName="FightRoom";
				var tmpZone:Zone = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(e.zoneId);
				var tmpRoom:Room = tmpZone.roomById(e.roomId);
				InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).updateRoom(tmpRoom);
				ReadyEsRoom(esRoomBase).onInitPreRoom(tmpRoom.id,tmpRoom.zoneId,tmpRoom,tmpZone,e.roomName,tmpZone.name);
				ReadyEsRoom(esRoomBase).esRoomManager.readyCreateRoomHost(tmpRoom);
				for each (var user:User in tmpRoom.users)
				{
					var cb:EsObject = new EsObject();
					if(user.isMe)
						ReadyEsRoom(esRoomBase).usersManager.meUser = user;
					else
						ReadyEsRoom(esRoomBase).usersManager.users.push(user);
					InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).onGetUserInfo(user);
				}
				if(tmpRoom.users.length==1)
					ReadyEsRoom(esRoomBase).esRoomManager.switchUserStatus(Constant.USER_STATUS_WAITING);
				else
					ReadyEsRoom(esRoomBase).esRoomManager.switchUserStatus(Constant.USER_STATUS_FULL);
				ReadyEsRoom(esRoomBase).getGameStatus();
				if(rejoinFlag)
				{
					rejoinFlag = false;
					ReadyEsRoom(esRoomBase).rejoinBattle();
				}
				ReadyEsRoom(esRoomBase).clearAllInvition();
				ReadyEsRoom(esRoomBase).getCardGroup();
			}
		}
		
		override public function joinRoomORcreateRoom(_room:String, _zone:String, gameId:int, pwd:String, create:Boolean):void
		{
			// TODO Auto Generated method stub
			super.joinRoomORcreateRoom(_room, _zone, gameId, pwd, create);
			ReadyEsRoom(esRoomBase).interfaceOfSon.sonProject.visible = false;
			if(_zone==Constant.FREE_LOBBY){
				if(create)
					createGameRoom(_room, _zone);
				else
					if(gameId!=0)
						joinGameRoom(gameId, gameManager.password);
					else
						invitedToFight(_room, _zone);
			}else if(_zone==Constant.AUTO_LOBBY){
				ReadyEsRoom(esRoomBase).roomManager.zoneName=Constant.AUTO_LOBBY;
				ReadyEsRoom(esRoomBase).roomManager.roomName=Constant.AUTO_LOBBY_ROOM;
				ReadyEsRoom(esRoomBase).roomManager.pluginName="PairLobbyRoom";
				var zoneTmp:Zone = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneByName(ReadyEsRoom(esRoomBase).roomManager.zoneName);
				if(zoneTmp!=null)ReadyEsRoom(esRoomBase).roomManager.zone = zoneTmp;
				ReadyEsRoom(esRoomBase).roomManager.room = ReadyEsRoom(esRoomBase).roomManager.zone.roomByName(ReadyEsRoom(esRoomBase).roomManager.roomName);
				var object:EsObject = new EsObject();
				object.setString("a", "rm");
				ReadyEsRoom(esRoomBase).sendPackage(object,0);
			}else{
				//为重连消息
				rejoinFlag = true;
				var jnRm:JoinRoomRequest = new JoinRoomRequest();
				jnRm.roomId = int(_room);
				jnRm.zoneId = int(_zone);
				GameCom.getInstance().esServer.engine.send(jnRm);
			}
		}
		
		private function invitedToFight(_roomName:String, _zoneName:String):void
		{
			var jnRm:JoinRoomRequest = new JoinRoomRequest();
			jnRm.roomName = _roomName;
			jnRm.zoneName = _zoneName;
			GameCom.getInstance().esServer.engine.send(jnRm);
		}
		
		internal function createGameRoom(_roomName:String, _zoneName:String):void
		{
			if(gameManager.gameFilter==null)
			{
				trace("filter is null");
				return;
			}
			ReadyEsRoom(esRoomBase).roomManager.zoneName=_zoneName;
			if(_zoneName==Constant.FREE_LOBBY)
			{
				ReadyEsRoom(esRoomBase).roomManager.roomName=Constant.FREE_LOBBY_ROOM;
				ReadyEsRoom(esRoomBase).roomManager.pluginName="FreeLobbyRoom";
			}
			else if(_zoneName=="sanguo-practice-zone")
			{
				ReadyEsRoom(esRoomBase).roomManager.roomName="sanguo-practice-lobby-room";
				ReadyEsRoom(esRoomBase).roomManager.pluginName="PracticeLobbyRoom";
			}
			var zoneTmp:Zone = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneByName(ReadyEsRoom(esRoomBase).roomManager.zoneName);
			if(zoneTmp!=null)ReadyEsRoom(esRoomBase).roomManager.zone = zoneTmp;
			ReadyEsRoom(esRoomBase).roomManager.room =ReadyEsRoom(esRoomBase).roomManager.zone.roomByName(ReadyEsRoom(esRoomBase).roomManager.roomName);
			var eo:EsObject = new EsObject();
			var cg:EsObject = new EsObject();
			cg.setString("gameType", "SanguoGame");
			cg.setString("password", gameManager.gameFilter.getString("password"));
			var detail:EsObject = new EsObject();
			detail.setString(EnumFightType.NAME, ReadyEsRoom(esRoomBase).fightType);
			detail.setString("roomName", _roomName);
			detail.setEsObject("gameFilter", gameManager.gameFilter);
			detail.setString("roomHost", GameCom.getInstance().esServer.managerHelper.userManager.me.userName);
			cg.setEsObject("gameDetails", detail);
			eo.setString("a", "cg");
			eo.setEsObject("cg", cg);
			ReadyEsRoom(esRoomBase).sendPackage(eo);
		}
		
		internal function joinGameRoom(gameId:int, psw:String):void
		{
			gameManager.password = psw;
			GamesManager.getInstance().joinGame(gameId, gameManager.password);
		}
		
	}
}