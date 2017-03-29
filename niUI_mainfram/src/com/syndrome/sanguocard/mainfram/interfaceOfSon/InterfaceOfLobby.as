package com.syndrome.sanguocard.mainfram.interfaceOfSon
{
	import com.communication.AppEvent;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.ServerGame;
	import com.electrotank.electroserver5.api.UserVariable;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;
	import com.syndrome.sanguocard.mainfram.esroom.lobbyroom.LobbyEsRoom;
	import com.syndrome.sanguocard.mainfram.ui.AlertPanel;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class InterfaceOfLobby extends InterfaceOfSonBase
	{
		public function InterfaceOfLobby(esRoom:*)
		{
			super(esRoom);
		}
		
		ThisIsInterface function initSome(zoneName:String):void
		{
			sonProject.initSome(zoneName);
		}
		
		ThisIsInterface function onGetFriendsList(receiveEsObject:EsObject, user:User=null):void
		{
			sonProject.onGetFriendsList(receiveEsObject.getEsObject("gui"), user);
		}
		
		ThisIsInterface function onGameUpdate(_room:Room, _zone:Zone, _game:ServerGame):void
		{
			sonProject.onGameUpdate(_room, _zone, _game);
		}
		
		ThisIsInterface function cancelAllInvition():void
		{
			sonProject.cancelAllInvition();
		}
		
		ThisIsInterface function onClearAllGame(zoneName:String):void
		{
			sonProject.onClearAllGame(zoneName);
		}
		
		ThisIsInterface function setInviteFlag(flag:Boolean):void
		{
			sonProject.setInviteFlag(flag);
		}
		
		ThisIsInterface function deleteGame(roomId:int):void
		{
			sonProject.deleteGame(roomId);
		}
		
		ThisIsInterface function updataGame(room:Room, zone:Zone, game:ServerGame):void
		{
			sonProject.updataGame(room, zone, game);
		}
		
		ThisIsInterface function addGame(room:Room, zone:Zone, game:ServerGame):void
		{
			sonProject.addGame(room, zone, game);
		}
		
		ThisIsInterface function reflashRoomList(zoneName:String):void
		{
			sonProject.reflashRoomList(zoneName);
		}
		
		ThisIsInterface function clearAllInvition():void
		{
			sonProject.clearAllInvition();
		}
		
		ThisIsInterface function onUserLeave(_userName:String):void
		{
			sonProject.onUserLeave(_userName);
		}
		
		ThisIsInterface function showWhichLobby(_which:String):void
		{
			sonProject.showWhichLobby(_which);
		}
		
		ThisIsInterface function enableMatchBtn():void
		{
			sonProject.enableMatchBtn();
		}
		
		ThisIsInterface function stopTimer():void
		{
			sonProject.stopTimer();
		}
		
		ThisIsInterface function disableReturnToTown():void
		{
			sonProject.disableReturnToTown();			
		}
		
		ThisIsInterface function removeInvitionUI(invitedAccount:String):void
		{
			sonProject.removeInvitionUI(invitedAccount);
		}
		
		ThisIsInterface function enableReturnToTown():void
		{
			sonProject.enableReturnToTown();	
		}
		
		ThisIsInterface function onUserJoinRoom(user:User):void
		{
			sonProject.onUserJoinRoom(user);	
		}
		
		ThisIsInterface function onGetUsersInRoomResponse(user:User, room:Room, zoneName:String, lobbyRoom:Room):void
		{
			sonProject.onGetUsersInRoomResponse(user, room, zoneName, lobbyRoom);
		}
		
		ThisIsInterface function onDeleteGame(roomId:int, zoneId:int):void
		{
			sonProject.onDeleteGame(roomId, zoneId);
		}
		
		ThisIsInterface function onGetCardGroup(esobj:EsObject):void
		{
			sonProject.onGetCardGroup(esobj);
		}
		
		ThisIsInterface function onGetCurrentCardGroup(esobj:EsObject):void
		{
			sonProject.onGetCurrentCardGroup(esobj);
		}
		
		ThisIsInterface function onSetCurrentCardGroup(esobj:EsObject):void
		{
			sonProject.onSetCurrentCardGroup(esobj);
		}
		
		ThisIsInterface function onUserStatusUpdate(user:User):void
		{
			sonProject.onUserStatusUpdate(user);
		}
		
		ThisIsInterface function onCostGameGoldConfirm():void
		{
			sonProject.onCostGameGoldConfirm();
		}
		
		ThisIsInterface function onInvitedToFight(account:String, inviterName:String, roomName:String, zoneName:String):void
		{
			sonProject.onInvitedToFight(account, inviterName, roomName, zoneName);
		}
		
		ThisIsInterface function onCancelInvite(account:String, inviterName:String, roomName:String, zoneName:String):void
		{
			sonProject.onCancelInvite(account, inviterName, roomName, zoneName);
		}
		
		ThisIsInterface function recordInviteUI(invitedAccount:String, invitedName:String):void
		{
			sonProject.recordInviteUI(invitedAccount, invitedName);
		}
		
		public function costTest():void
		{
//			LobbyEsRoom(esRoom).costTest();
		}
		
		public function getCurrentCardGroup():void
		{
			LobbyEsRoom(esRoom).getCurrentCardGroup();
		}
		
		public function askForFight(invitedAccount:String, invitedName:String):void
		{
			LobbyEsRoom(esRoom).askForFight(invitedAccount, invitedName);
		}
		
		public function cancelInviteFight(invitedAccount:String):void
		{
			LobbyEsRoom(esRoom).cancelInvite(invitedAccount);
		}
		
		public function createRoom(_roomName:String, _zoneName:String):void
		{
			LobbyEsRoom(esRoom).createRoom(_roomName, _zoneName);
		}
		
		public function createGame(_roomName:String, _zoneName:String, filter:EsObject, fightType:String):void
		{
			LobbyEsRoom(esRoom).createGame(_roomName, _zoneName, filter, fightType);
		}
		
		public function getUsersInRoomWithId(_roomId:int, _zoneId:int):void
		{
			LobbyEsRoom(esRoom).getUsersInRoomWithId(_roomId, _zoneId);
		}
		
		public function getUsersInRoom(_room:Room):void
		{
			LobbyEsRoom(esRoom).getUsersInRoom(_room);
		}
		
		public function getFriendsList():void
		{
			LobbyEsRoom(esRoom).getFriendsList();
		}
		
		public function onReturnTown():void
		{
			LobbyEsRoom(esRoom).onReturnTown();
		}
		
		public function onCancelMatch():void
		{
			LobbyEsRoom(esRoom).onCancelMatch();
		}
		
		public function getUserInfo(userName:String, cb:EsObject):void
		{
			LobbyEsRoom(esRoom).getUserInfo(userName, cb);
		}
		
		public function sendPublicMessage(ChatContent:String):void
		{
			LobbyEsRoom(esRoom).lobbyPublicMessageHandler.sendPublicMessage(ChatContent);
		}
		
		public function quickJoinGame(fightType:String):void
		{
			LobbyEsRoom(esRoom).quickJoinGame(fightType);
		}
		
		public function askJoinGame(account:String):void
		{
			//关于AlertPanel这里需要优化
			AlertPanel.creatInstance().show("对方已经在房间中，是否直接加入？", confirm, null);
			function confirm(e:MouseEvent):void
			{
				LobbyEsRoom(esRoom).outReadyRoom();
				sonProject.joinGameInstandOfInvite(account);
			}
		}
		
		public function joinGame(gameId:int, fightType:String):void
		{
			LobbyEsRoom(esRoom).joinGame(gameId, fightType);
		}
		
		public function getCardGroup():void
		{
			LobbyEsRoom(esRoom).getCardGroup();
		}
		
		public function setCurrentCardGroup(cardGroupId:int):void
		{
			LobbyEsRoom(esRoom).setCurrentCardGroup(cardGroupId);
		}
		
		public function answerInviter(account:String, roomName:String, zoneName:String, isAccept:Boolean):void
		{
			LobbyEsRoom(esRoom).answerInviter(account, isAccept);
			if(isAccept){
				LobbyEsRoom(esRoom).acceptInviter(roomName, zoneName);
			}
		}
		
	}
}