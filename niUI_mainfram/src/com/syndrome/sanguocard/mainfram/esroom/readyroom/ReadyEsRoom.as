package com.syndrome.sanguocard.mainfram.esroom.readyroom
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.PublicMessageEvent;
	import com.electrotank.electroserver5.api.ServerGame;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;
	import com.syndrome.client.enum.EnumFightType;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguocard.mainfram.enum.EnumCheckTask;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfReadyRoom;
	import com.syndrome.sanguocard.mainfram.main.Main;
	import com.syndrome.sanguocard.mainfram.managers.ESRoomManager;
	import com.syndrome.sanguocard.mainfram.managers.gamesmanager.GamesManager;
	import com.syndrome.sanguocard.mainfram.ui.AlertPanel;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	public class ReadyEsRoom extends EsRoomBase
	{
		use namespace ThisIsInterface;
		private var tmpGameId:int;
		private var tmpGamePsw:String = "";
		private var createGameFlag:Boolean = true;
		private var invitedFlag:Boolean = false;
		public var fightType:String;
		private var readyRoomJoinRoomHandler:ReadyRoomJoinRoomHandler;
		private var readyRoomLeaveRoomHandler:ReadyRoomLeaveRoomHandler;
		private var readyRoomPublicMessageHandler:ReadyRoomPublicMessageHandler;
		private var readyRoomProtocolHandler:ReadyRoomProtocolHandler;
		private var readyRoomLobbyUserUpdataHandler:ReadyRoomLobbyUserUpdataHandler;
		private var readyRoomVariableUpdateHandler:ReadyRoomVariableUpdateHandler;
		private var readyRoomUserUpdateHandler:ReadyRoomUserUpdateHandler;
		
		public function ReadyEsRoom(_esRoomManager:ESRoomManager)
		{
			super(_esRoomManager);
			interfaceOfSon = new InterfaceOfReadyRoom(this);
			readyRoomJoinRoomHandler = new ReadyRoomJoinRoomHandler(this);
			readyRoomLobbyUserUpdataHandler = new ReadyRoomLobbyUserUpdataHandler(this);
		}
		
		override public function clear():void
		{
			// TODO Auto Generated method stub
			super.clear();
			onRelaseRoom();
		}
		
		override public function init():void
		{
			// TODO Auto Generated method stub
			super.init();
		}
		
		override public function joinRoomORcreateRoom(_room:String, _zone:String):void
		{
			if(!createGameFlag)
			{
				readyRoomJoinRoomHandler.joinGameRoom(tmpGameId, tmpGamePsw);
				createGameFlag = true;
				tmpGamePsw = "";
				return;
			}
			if(tmpRoomName && tmpZoneName)
			{
				if(invitedFlag)
					//TODO:被邀请情况下，直接加入房间！！！
					readyRoomJoinRoomHandler.joinRoomORcreateRoom(tmpRoomName, tmpZoneName,  0, "", false);
				else
					readyRoomJoinRoomHandler.joinRoomORcreateRoom(tmpRoomName, tmpZoneName,  0, "", true);
				tmpRoomName = null;
				tmpZoneName = null;
				invitedFlag = false;
				return;
			}
		}
		
		public function onCancelMatch():void
		{
			readyRoomProtocolHandler.onCancelMatch();
		}
		
		public function lobbyPushUserAdd(user:User):void
		{
			if(readyRoomLobbyUserUpdataHandler==null)return;
			readyRoomLobbyUserUpdataHandler.lobbyPushUserAdd(user);
		}
		
		public function lobbyDeleteUser(userName:String):void
		{
			if(readyRoomLobbyUserUpdataHandler==null)return;
			readyRoomLobbyUserUpdataHandler.lobbyDeleteUser(userName);
		}
		
		public function changeRoomHost():void
		{
			esRoomManager.readyChangeRoomHost(roomManager.room);
			readyRoomVariableUpdateHandler.changeRoomHost();
		}
		
		public function getUsersInLobby(lobbyRoom:Room):void
		{
			var readyRoomGetUsersInLobbyHandler:ReadyRoomGetUsersInLobbyHandler = new ReadyRoomGetUsersInLobbyHandler(this);
			readyRoomGetUsersInLobbyHandler.getUsersInLobby(lobbyRoom);
		}
		
		public function createGame(_roomName:String, _zoneName:String, filter:EsObject, _fightType:String):void
		{
			readyRoomJoinRoomHandler.gameManager.gameFilter = filter;
			fightType = _fightType;
			this.join(_roomName, _zoneName, true);
		}
		
		private function join(_roomName:String, _zoneName:String, create:Boolean):void
		{
			if(interfaceOfSon.sonProject==null){
				tmpRoomName = _roomName;
				tmpZoneName = _zoneName;
				esRoomManager.loadReadyScene();
			}
			else{
				if(_zoneName!=Constant.AUTO_LOBBY)interfaceOfSon.sonProject.visible = true;
				readyRoomJoinRoomHandler.joinRoomORcreateRoom(_roomName,_zoneName, 0, "", create);
			}
		}
		
		public function clearAllInvition():void
		{
			esRoomManager.readyClearAllInvition();
		}
		
		public function oppoUserEnter(user:User):void
		{
			esRoomManager.readyOppUserEnter(user);
		}
		
		private function costGoldIndeed(goldAmount:int):void
		{
			if(getWhichLobby()==Constant.AUTO_LOBBY)
				readyRoomProtocolHandler.costGameGold(goldAmount, Constant.SCENE_READYROOM);
		}
		
		public function invitedToFight(_roomName:String, _zoneName:String):void
		{
			if(interfaceOfSon.sonProject==null)
			{
				tmpRoomName = _roomName;
				tmpZoneName = _zoneName;
				invitedFlag = true;
				esRoomManager.loadReadyScene();
			}else{
				readyRoomJoinRoomHandler.joinRoomORcreateRoom(_roomName,_zoneName, 0, "", false);
			}
		}
		
		public function rejoinGame(roomId:int, zoneId:int):void
		{
			var zone:Zone = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(zoneId);
			var room:Room = zone.roomById(roomId);
			if(interfaceOfSon.sonProject==null){
				tmpRoomName = roomId.toString();
				tmpZoneName = zoneId.toString();
				esRoomManager.loadReadyScene();
			}
			else{
				if(zone.name!=Constant.AUTO_LOBBY)interfaceOfSon.sonProject.visible = true;
				readyRoomJoinRoomHandler.joinRoomORcreateRoom(roomId.toString(), zoneId.toString(), 0, "", false);
			}
		}
		
		public function createRoom(_roomName:String, _zoneName:String):void
		{
			if(interfaceOfSon.sonProject==null)
			{
				tmpRoomName = _roomName;
				tmpZoneName = _zoneName;
				esRoomManager.loadReadyScene();
			}
			else{
				if(_zoneName!=Constant.AUTO_LOBBY)interfaceOfSon.sonProject.visible = true;
				readyRoomJoinRoomHandler.joinRoomORcreateRoom(_roomName,_zoneName, 0, "", true);
			}
		}
		
		public function joinGame(gameId:int, _fightType:String):void
		{
			fightType = _fightType;
			var game:ServerGame = GamesManager.getInstance().games.filter(function(item:ServerGame, index:int, array:Array):Boolean{return findGameById(item)}).pop();
			if(!game)trace("没有找到加入游戏！");
			if(game.gameDetails.getEsObject("gameFilter").getString("password")!="")
			{
				AlertPanel.creatInstance().showInput("请输入密码", function(e:MouseEvent):void{onPswInput(e, game.gameDetails.getEsObject("gameFilter").getString("password"))}, null);
				return;
			}
			if(filterMatchEntrance(game.gameDetails, GameCom.getInstance().esServer.managerHelper.userManager.me.userVariableByName(Constant.GetUserInfo).value))
				if(interfaceOfSon.sonProject==null)
				{
					tmpGameId = gameId;
					createGameFlag = false;
					esRoomManager.loadReadyScene();
				}
				else
					readyRoomJoinRoomHandler.joinGameRoom(gameId, "");
			
			function findGameById(item:ServerGame):Boolean
			{
				if(item.id == gameId)
					return true;
				else 
					return false;
			}
			
			function onPswInput(e:MouseEvent, psw:String):void
			{
				if(e.target.parent.lab_input.text == psw)
					if(interfaceOfSon.sonProject==null)
					{
						tmpGameId = gameId;
						tmpGamePsw = psw;
						createGameFlag = false;
						esRoomManager.loadReadyScene();
					}
					else{
						interfaceOfSon.sonProject.visible = true;
						readyRoomJoinRoomHandler.joinGameRoom(gameId, psw);
					}
				else
					AlertPanel.creatInstance().show("密码不正确", null, null);
				e.target.parent.lab_input.text = "";
			}
		}
		
		private function filterMatchEntrance(gameDetails:EsObject, gui:EsObject):Boolean
		{
			if(gameDetails.getString(EnumFightType.NAME)!=fightType)
				return false;
			return GamesManager.getInstance().filterMatchEntrance(gameDetails, gui);
		}
		
		public function sendPublicMessage(ChatContent:String):void
		{
			readyRoomPublicMessageHandler.sendPublicMessage(ChatContent);
		}
		
		public function quickJoinGame(_fightType:String):void
		{
			fightType = _fightType;
			if(GamesManager.getInstance().games.some(findRightGame)==false)
				AlertPanel.creatInstance().show("没有找到合适的房间", null, null);
			
			function findRightGame(item:ServerGame, index:int, array:Array):Boolean
			{
				if(item.gameDetails.getEsObject("gameFilter").getString("password")!="") return false;
				if(filterMatchEntrance(item.gameDetails, GameCom.getInstance().esServer.managerHelper.userManager.me.userVariableByName(Constant.GetUserInfo).value))
				{
					if(interfaceOfSon.sonProject==null)
					{
						tmpGameId = item.id;
						createGameFlag = false;
						esRoomManager.loadReadyScene();
					}
					else{
						interfaceOfSon.sonProject.visible = true;
						readyRoomJoinRoomHandler.joinGameRoom(item.id, "");
					}
					return true;
				}
				return false;
			}
		}
		
		override public function initListeners():void
		{
			// TODO Auto Generated method stub
			super.initListeners();
			readyRoomLeaveRoomHandler = new ReadyRoomLeaveRoomHandler(this);
			readyRoomPublicMessageHandler = new ReadyRoomPublicMessageHandler(this);
			readyRoomProtocolHandler = new ReadyRoomProtocolHandler(this);
			readyRoomVariableUpdateHandler = new ReadyRoomVariableUpdateHandler(this);
			readyRoomUserUpdateHandler = new ReadyRoomUserUpdateHandler(this);
		}
		
		public function onSize():void
		{
			interfaceOfSon.onSize();
		}
		
		public function enterGame():void
		{
			costGoldIndeed(esRoomManager.readyGetPreCostGameGold());
			esRoomManager.readyEnterBattle();
		}
		
		public function rejoinBattle():void
		{
			esRoomManager.readyRejoinBattle();
		}
		
		public function onShowSideBar():void
		{
			InterfaceOfReadyRoom(interfaceOfSon).onShowSideBar();
		}
		
		public function gameReady(currentCardGroupId:int):void
		{
			readyRoomProtocolHandler.gameReady(currentCardGroupId);
		}
		
		public function gameReadyCancel():void
		{
			readyRoomProtocolHandler.gameReadyCancel();
		}
		
		public function getGameStatus():void
		{
			readyRoomProtocolHandler.getGameStatus();
		}
		
		public function LOG(log:String):void
		{
			
		}
		
		public function onInitHistoryPanel():void
		{
			interfaceOfSon.onInitHistoryPanel();
		}
		
		public function getCurrentCardGroup(userName:String):void
		{
			readyRoomProtocolHandler.getCurrentCardGroup(userName);
		}
		
		public function getCardGroup():void
		{
			readyRoomProtocolHandler.getCardGroup();
		}
		
		public function setCurrentCardGroup(userName:String, cardGroupId:int):void
		{
			readyRoomProtocolHandler.setCurrentCardGroup(userName, cardGroupId);
		}
		
		public function showReadyRoom():void
		{
			interfaceOfSon.sonProject.visible = true;
			esRoomManager.readyShowSelf();
		}
		
		public function dispatchPros(pros:Number):void
		{
			readyRoomPublicMessageHandler.dispatchPros(pros);
		}
		
		public function onHideSiderBar():void
		{
			interfaceOfSon.onHideSiderBar();
		}
		
		public function disableReturnToTown():void
		{
			esRoomManager.readyDisableReturnToTown();
		}
		
		public function enableReturnToTown():void
		{
			esRoomManager.readyAbleReturnToTown();
		}
		
		public function refreshUsersInfo():void
		{
			try{
				var tmpRoom:Room = roomManager.zone.roomById(roomManager.roomID);
				for each (var user:User in tmpRoom.users)
					InterfaceOfReadyRoom(interfaceOfSon).onGetUserInfo(user);
			}catch(e:Error){
				trace("[ReadyEsRoom]:"+e.message);
			}
		}
		
		public function sendPackage(es:EsObject, type:int=0):void
		{
			readyRoomProtocolHandler.sendPackage(es, type);
		}
		
		public function getWhichLobby():String
		{
			return esRoomManager.readyGetWhichLobby();
		}
		
	}
}