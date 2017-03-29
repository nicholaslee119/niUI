package com.syndrome.sanguocard.mainfram.interfaceOfSon
{
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.PublicMessageEvent;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.syndrome.sanguocard.mainfram.esroom.readyroom.ReadyEsRoom;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	import flash.display.Sprite;

	public class InterfaceOfReadyRoom extends InterfaceOfSonBase
	{

		public function InterfaceOfReadyRoom(esRoom:*)
		{
			super(esRoom);
		}
		
		ThisIsInterface function onUserLeave(userName:String):void
		{
			sonProject.onUserLeave(userName);
		}
		
		ThisIsInterface function onShowSideBar():void
		{
//			sonProject.onShowSideBar();
		}
		
		ThisIsInterface function onHideSiderBar():void
		{
//			sonProject.onHideSiderBar();
		}
		
		ThisIsInterface function onInitHistoryPanel():void
		{
//			sonProject.onInitHistoryPanel();
		}
		
		ThisIsInterface function onGetCardGroup(esobj:EsObject):void
		{
			sonProject.onGetCardGroup(esobj);
		}
		
		ThisIsInterface function onSetCurrentCardGroup(esobj:EsObject):void
		{
			sonProject.onSetCurrentCardGroup(esobj);
		}
		
		ThisIsInterface function onGetUserInfo(user:User):void
		{
			sonProject.onGetUserInfo(user);
		}
		
		ThisIsInterface function onGameReadyStatus(esobj:EsObject, hostReady:Boolean, ready:Boolean):void
		{
			sonProject.onGameReadyStatus(esobj, hostReady, ready);
		}
		
		ThisIsInterface function onShowCount(esobj:EsObject):void
		{
			sonProject.onShowCount(esobj);
		}
		
		ThisIsInterface function initUI(whichLobby:String):void
		{
			sonProject.initUI(whichLobby);
		}
		
		ThisIsInterface function hideSideBar():void
		{
//			sonProject.hideSideBar();
		}
		
		ThisIsInterface function init():void
		{
			
		}
		
		ThisIsInterface function updateRoom(room:Room):void
		{
			sonProject.updateRoom(room);
		}
		
		ThisIsInterface function leaveRoomCompleted():void
		{
			sonProject.visible = false;
			sonProject.leaveRoomCompleted();
		}
		
		ThisIsInterface function onGetUsersInLobbyResponse(user:User):void
		{
			sonProject.onGetUsersInLobbyResponse(user);
		}
		
		ThisIsInterface function lobbyPushUserAdd(user:User):void
		{
			sonProject.lobbyPushUserAdd(user);
		}
		
		ThisIsInterface function lobbyDeleteUser(username:String):void
		{
			try{
				sonProject.lobbyDeleteUser(username);
			}catch(e:Error){
				trace("[InterfaceOfReady]:error is "+e.message);
			}
		}
		
		public function getCardGroup():void
		{
			ReadyEsRoom(esRoom).getCardGroup();
		}
		
		public function gameReady(currentCardId:int):void
		{
			ReadyEsRoom(esRoom).gameReady(currentCardId);
		}
		
		public function gameReadyCancel():void
		{
			ReadyEsRoom(esRoom).gameReadyCancel();
		}
		
		public function clear():void
		{
			ReadyEsRoom(esRoom).clear();
		}
		
		public function getUsersInLobby():void
		{
			ReadyEsRoom(esRoom).getUsersInLobby(ReadyEsRoom(esRoom).esRoomManager.readyGetLobbyRoom());
		}
		
		public function showReadyRoom():void
		{
			ReadyEsRoom(esRoom).showReadyRoom();
		}
		
		public function getCurrentCardGroup(userName:String):void
		{
			ReadyEsRoom(esRoom).getCurrentCardGroup(userName);
		}
		
		public function setCurrentCardGroup(userName:String, cardGroupId:int):void
		{
			ReadyEsRoom(esRoom).setCurrentCardGroup(userName, cardGroupId);
		}
		
		public function enterGame():void
		{
			ReadyEsRoom(esRoom).enterGame();
		}
		
		public function sendPublicMessage(content:String):void
		{
			ReadyEsRoom(esRoom).sendPublicMessage(content);
		}
		
		public function disableReturnToTown():void
		{
			ReadyEsRoom(esRoom).disableReturnToTown();
		}
		
		public function enableReturnToTown():void
		{
			ReadyEsRoom(esRoom).enableReturnToTown();
		}
		
	}
}