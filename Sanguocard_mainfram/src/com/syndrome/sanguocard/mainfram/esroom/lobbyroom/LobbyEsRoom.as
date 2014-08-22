package com.syndrome.sanguocard.mainfram.esroom.lobbyroom
{
	import com.communication.AppEvent;
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.ServerGame;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;
	import com.load.resmanager.ResManager;
	import com.load.xmlmanager.XMLManager;
	import com.syndrome.client.enum.EnumFightType;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.client.parameters.PublicParameters;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.lobbyroom.privatemessage.LobbyPrivateMessageHandler;
	import com.syndrome.sanguocard.mainfram.esroom.readyroom.GameManager;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfLobby;
	import com.syndrome.sanguocard.mainfram.managers.ESRoomManager;
	import com.syndrome.sanguocard.mainfram.managers.gamesmanager.GamesManager;
	import com.syndrome.sanguocard.mainfram.ui.AlertPanel;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import org.hamcrest.object.nullValue;
	
	public class LobbyEsRoom extends EsRoomBase
	{
		use namespace ThisIsInterface;
		internal var messageBuffer:MessageBufferLobby;
		private var whichLobby:String;
		private var fightType:String = EnumFightType.FREE;
		internal var lobbyRoomVaribleHandler:LobbyRoomVariableHandler;
		private var lobbyUserEventHandler:LobbyUserUpdateHandler;
		private var lobbyZoneEventHandler:LobbyZoneEventHandler;
		private var lobbyJoinRoomHandler:LobbyJoinRoomHandler;
		public var lobbyPublicMessageHandler:LobbyPublicMessageHandler;
		private var lobbyProtocolHandler:LobbyProtocolHandler;
		private var lobbyGetUsersInRoomHandler:LobbyGetUsersInRoomHandler;
		private var lobbyPrivateMessageHandler:LobbyPrivateMessageHandler;
		private var lobbyLeaveRoomHandler:LobbyLeaveRoomHandler;
		private var lobbyGameHandler:LobbyGameHandler;
		
		public function LobbyEsRoom( _esRoomManager:ESRoomManager)
		{
			super(_esRoomManager);
			interfaceOfSon = new InterfaceOfLobby(this);
			messageBuffer = new MessageBufferLobby(this);
			lobbyProtocolHandler = new LobbyProtocolHandler(this);
		}
		
		override public function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			interfaceOfSon.initSome(whichLobby);
		}
		
		override public function clear():void
		{
			// TODO Auto Generated method stub
			super.clear();
		}
		
		public function createRoom(_roomName:String, _zoneName:String):void
		{
			esRoomManager.lobbyCreateRoom(_roomName, _zoneName);
		}
		
		override public function sendPreEvent():void
		{
			// TODO Auto Generated method stub
			var message:AppEvent =new AppEvent(AppEvent.ScenePrepare);
			message.objHander = InterfaceOfLobby(interfaceOfSon);
			if(whichLobby!=null)message.retStr = whichLobby;
			InterfaceOfLobby(interfaceOfSon).sonProject.addEventListener(AppEvent.ScenePrepareDone,function(e:AppEvent):void{onpreSceneDone(tmpRoomName, tmpZoneName)});
			InterfaceOfLobby(interfaceOfSon).sonProject.dispatchEvent(message);
		}
		
		override public function initListeners():void
		{
			// TODO Auto Generated method stub
			super.initListeners();
			lobbyRoomVaribleHandler = new LobbyRoomVariableHandler(this);
			lobbyUserEventHandler = new LobbyUserUpdateHandler(this);
			lobbyZoneEventHandler = new LobbyZoneEventHandler(this);
			lobbyGameHandler = new LobbyGameHandler(this);
			lobbyJoinRoomHandler = new LobbyJoinRoomHandler(this);
			lobbyPublicMessageHandler = new LobbyPublicMessageHandler(this);
			lobbyGetUsersInRoomHandler = new LobbyGetUsersInRoomHandler(this);
			lobbyPrivateMessageHandler = new LobbyPrivateMessageHandler(this);
			lobbyLeaveRoomHandler = new LobbyLeaveRoomHandler(this);
		}
		
		override protected function heartBeat():void
		{
			// TODO Auto Generated method stub
			super.heartBeat();
			if(roomManager.zoneName==Constant.FREE_LOBBY)
				lobbyGameHandler.findGame(Constant.FREE_LOBBY);
		}
		
		public function getUserInfo(userName:String, cb:EsObject):void
		{
			lobbyProtocolHandler.getUserInfo(userName, cb);
		}
		
		public function rejoinGame(roomId:int, zoneId:int):void
		{
			esRoomManager.lobbyRejoinGame(roomId, zoneId);
		}
		
		public function onUserStatusUpdate():void
		{
			try{
				var tmpRoom:Room = roomManager.zone.roomById(roomManager.roomID);
				for each (var user:User in tmpRoom.users)
				InterfaceOfLobby(interfaceOfSon).onUserStatusUpdate(user);
			}catch(e:Error){
				trace("[LobbyEsRoom]:"+e.message);
			}
		}
		
		private var preCostGameGold:int=0;
		public function costGold(gold:int):void
		{
			
			if(GameCom.getInstance().esServer.managerHelper.userManager.me.userVariableByName(Constant.GetUserInfo).value.getInteger("gameGold")<gold)
			{
				AlertPanel.creatInstance().show("铜钱不足", null, null);
				return;
			}
			
			if(gold==0)
			{
				InterfaceOfLobby(interfaceOfSon).onCostGameGoldConfirm();
				preCostGameGold = gold;
			}
			else
				AlertPanel.creatInstance().show("是否消耗铜钱： "+gold+" ?", confirm, null);
			
			function confirm(e:MouseEvent):void
			{
				InterfaceOfLobby(interfaceOfSon).onCostGameGoldConfirm();
				preCostGameGold = gold;
			}
		}
		
		public function outReadyRoom():void
		{
			esRoomManager.lobbyOutReadyRoom();
		}
		
		public function removeInvitionUI(invitedAccount:String):void
		{
			InterfaceOfLobby(interfaceOfSon).removeInvitionUI(invitedAccount);
		}
		
		public function enterGame():void
		{
			lobbyPrivateMessageHandler.cancelAllInvition();
		}
		
		public function getPreCostGameGold():int
		{
			return preCostGameGold;
		}
		
		public function clearAllInvition():void
		{
			InterfaceOfLobby(interfaceOfSon).clearAllInvition();
			lobbyPrivateMessageHandler.clearInvition();
		}
		
		public function costGoldIndeed():void
		{
			if(getWhichLobby()==Constant.AUTO_LOBBY)
				lobbyProtocolHandler.costGameGold(preCostGameGold, Constant.SCENE_LOBBY);
		}
		
		public function sendPublicMessage(ChatContent:String):void
		{
			lobbyPublicMessageHandler.sendPublicMessage(ChatContent);
		}
		
		public function askForFight(invitedAccount:String, invitedName:String):void
		{
			lobbyPrivateMessageHandler.sendAskForFight(invitedAccount, invitedName, esRoomManager.lobbyGetReadyRoomName(), esRoomManager.lobbyGetReadyZoneName());
		}
		
		public function cancelInvite(invitedAccount:String):void
		{
			lobbyPrivateMessageHandler.cancelAskForFight(invitedAccount, esRoomManager.lobbyGetReadyRoomName(), esRoomManager.lobbyGetReadyZoneName());
		}
		
		public function joinGame(gameId:int, fightType:String):void
		{
			esRoomManager.lobbyJoinGame(gameId, fightType);
		}
		
		public function createRoomHost(room:Room):void
		{
			lobbyRoomVaribleHandler.createRoomHost(room);
		}
		
		public function getCurrentCardGroup():void
		{
			lobbyProtocolHandler.getCurrentCardGroup();
		}
		
		public function getCardGroup():void
		{
			lobbyProtocolHandler.getCardGroup();
		}
		
		public function setCurrentCardGroup(cardGroupId:int):void
		{
			lobbyProtocolHandler.setCurrentCardGroup(cardGroupId)
		}
		
		public function changeRoomHost(room:Room):void
		{
			lobbyRoomVaribleHandler.changeRoomHost(room);
		}
		
		public function showWhichLobby(which:String):void
		{
			interfaceOfSon.showWhichLobby(which);
		}
		
		public function onSize():void
		{
			interfaceOfSon.onSize();
		}
		
		public function enableMatchBtn():void
		{
			interfaceOfSon.enableMatchBtn();
		}
		
		public function stopTimer():void
		{
			interfaceOfSon.stopTimer();
		}
		
		public function getUsersInRoomWithId(_roomId:int, _zoneId:int):void
		{
			lobbyGetUsersInRoomHandler.getUsersInRoomWithId(_roomId, _zoneId);
		}
		
		public function getUsersInRoom(_room:Room):void
		{
			lobbyGetUsersInRoomHandler.getUsersInRoom(_room);
		}
		
		public function sendUsersInRoom(user:User, room:Room, zoneName:String, lobbyRoom:Room):void
		{
			InterfaceOfLobby(interfaceOfSon).onGetUsersInRoomResponse(user, room, zoneName, lobbyRoom);
		}
		
		public function getFriendsList():void
		{
			lobbyProtocolHandler.getFriendsList();
		}
		
		public function onCancelMatch():void
		{
			esRoomManager.lobbyCancelMatch();
		}
		
		public function createGame(_roomName:String, _zoneName:String, fillter:EsObject, fightType:String):void
		{
			esRoomManager.lobbyCreateGame(_roomName,_zoneName,fillter,fightType);
		}
		
		public function quickJoinGame(fightType:String):void
		{
			esRoomManager.lobbyQuickJoinGame(fightType);
		}
		
		public function disableReturnToTown():void
		{
			InterfaceOfLobby(interfaceOfSon).disableReturnToTown();
		}
		
		public function enableReturnToTown():void
		{
			InterfaceOfLobby(interfaceOfSon).enableReturnToTown();
		}
		
		public function getWhichLobby():String
		{
			if(whichLobby==null)
				trace("[LobbyEsRoom]: whichLobby为空！");
			return whichLobby;
		}
		
		override public function joinRoomORcreateRoom(_room:String, _zone:String):void
		{
			// TODO Auto Generated method stub
			super.joinRoomORcreateRoom(_room, _zone);
			if(whichLobby==Constant.FREE_LOBBY)
				lobbyJoinRoomHandler.joinRoomORcreateRoom(Constant.FREE_LOBBY_ROOM,Constant.FREE_LOBBY,0,"",false);
			else if(whichLobby==Constant.AUTO_LOBBY)
				lobbyJoinRoomHandler.joinRoomORcreateRoom(Constant.AUTO_LOBBY_ROOM,Constant.AUTO_LOBBY,0,"",false);
		}
		
		public function invitedToFight(account:String, inviterName:String, roomName:String, zoneName:String):void
		{
			InterfaceOfLobby(interfaceOfSon).onInvitedToFight(account, inviterName, roomName, zoneName);
		}
		
		public function onCancelInvite(account:String, inviterName:String, roomName:String, zoneName:String):void
		{
			InterfaceOfLobby(interfaceOfSon).onCancelInvite(account, inviterName, roomName, zoneName);
		}
		
		public function recordInviteUI(invitedAccount:String, invitedName:String):void
		{
			InterfaceOfLobby(interfaceOfSon).recordInviteUI(invitedAccount, invitedName);
		}
		
		public function acceptInviter(roomName:String, zoneName:String):void
		{
			this.outReadyRoom();
			esRoomManager.lobbyInvitedToFight(roomName, zoneName);
		}
		
		public function answerInviter(account:String, isAccept:Boolean):void
		{
			lobbyPrivateMessageHandler.answerInvite(account, isAccept);
		}
		
		public function readyOppUserEnter(user:User):void
		{
			lobbyPrivateMessageHandler.readyOppUserEnter(user);
		}
		
		public function chooseLobby(which:String):void
		{
			esRoomManager.lobbyRemoveBackPanel();
			if(which==Constant.AUTO_LOBBY)
			{
				whichLobby = Constant.AUTO_LOBBY;
				ResManager.getInstance().getRes(XMLManager.getUrlByName(Constant.RES_MAINFRAM), onAutoLobbyLoading);	
				function onAutoLobbyLoading(res:Object):void
				{
					res.UI_AutoLobbyBG.alpha = 0.6;
					esRoomManager.lobbyAddBackPanel(res.UI_AutoLobbyBG);
					esRoomManager.reflash();
				}
			}
			else if(which==Constant.FREE_LOBBY)
			{
				whichLobby = Constant.FREE_LOBBY;
				ResManager.getInstance().getRes(XMLManager.getUrlByName(Constant.RES_MAINFRAM), onFreeLobbyLoading);	
				function onFreeLobbyLoading(res:Object):void
				{
					res.UI_FreeLobbyBG.alpha = 0.6;
					esRoomManager.lobbyAddBackPanel(res.UI_FreeLobbyBG);
					esRoomManager.reflash();
				}
			}
			if(interfaceOfSon.sonProject==null)
			{
				if(whichLobby==Constant.FREE_LOBBY)
				{
					tmpRoomName = Constant.FREE_LOBBY_ROOM;
					tmpZoneName = Constant.FREE_LOBBY;
				}
				else if(whichLobby==Constant.AUTO_LOBBY)
				{
					tmpRoomName = Constant.AUTO_LOBBY_ROOM;
					tmpZoneName = Constant.AUTO_LOBBY;
				}
				esRoomManager.loadLobbyScene();
			}
			else{
				interfaceOfSon.sonProject.visible = true;
				init();
				showWhichLobby(whichLobby);
				if(which==Constant.FREE_LOBBY)
				{
					lobbyJoinRoomHandler.joinRoomORcreateRoom(Constant.FREE_LOBBY_ROOM,Constant.FREE_LOBBY,0,"",false);
				}
				else if(which==Constant.AUTO_LOBBY)
				{
					lobbyJoinRoomHandler.joinRoomORcreateRoom(Constant.AUTO_LOBBY_ROOM,Constant.AUTO_LOBBY,0,"",false);
				}
			}
		}
		
		public function deleteGame(roomId:int):void
		{
			InterfaceOfLobby(interfaceOfSon).deleteGame(roomId);
		}
		
		public function updataGame(room:Room, zone:Zone):void
		{
			lobbyGameHandler.updataGame(room, zone);
		}
		
		public function addGame(room:Room, zone:Zone):void
		{
			lobbyGameHandler.addGame(room, zone);
		}
		
		public function findGame(zoneName:String):void
		{
			lobbyGameHandler.findGame(zoneName);
		}
		
		public function readyEnterLobby():void
		{
			this.cancelAllInvition();
			if(whichLobby == Constant.AUTO_LOBBY)this.getCurrentCardGroup();
			this.reBindingChat();
		}
		
		public function onReturnTown():void
		{
			esRoomManager.lobbyReturnToTown();
		}
		
		public function cancelAllInvition():void
		{
			lobbyPrivateMessageHandler.cancelAllInvition();
			InterfaceOfLobby(interfaceOfSon).cancelAllInvition();
		}
		
		public function setInviteFlag(flag:Boolean):void
		{
			InterfaceOfLobby(interfaceOfSon).setInviteFlag(flag);
		}
	}
}