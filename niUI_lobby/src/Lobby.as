package
{
	import com.communication.AppEvent;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.GetUsersInRoomResponse;
	import com.electrotank.electroserver5.api.ServerGame;
	import com.electrotank.electroserver5.api.UserVariable;
	import com.electrotank.electroserver5.api.ZoneUpdateAction;
	import com.electrotank.electroserver5.api.ZoneUpdateEvent;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;
	import com.load.xmlmanager.XMLManager;
	import com.syndrome.sanguo.lobby.Main;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	[SWF(backgroundColor="0x000000")]
	public class Lobby extends Sprite
	{
		public var Panel:Sprite = new Sprite();
		private var main:Main = null;
		public var interfaceOfSon:Object = null;
		public var whichLobby:String = null;
		public var AlertPanel:*;
		
		public function Lobby()
		{
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandle);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function addToStageHandle(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addToStageHandle);
			this.addChild(Panel);
			this.addEventListener(AppEvent.ScenePrepare,onPreScene);
			ExternalInterface.addCallback("RequestChat", RequestChat);
		}
		
		private function onEnterFrame(e:Event):void
		{
			if(interfaceOfSon!=null)interfaceOfSon.onEnterFrame(new Date().time);
		}
		
		public function reBindingChat():void
		{
			ExternalInterface.addCallback("RequestChat", RequestChat);
		}
		
		private function RequestChat(chat:String):void
		{
			if(chat!=null)
				interfaceOfSon.sendPublicMessage(chat);
		}
		
		public function clearAllInvition():void
		{
			main.uiLobby.clearAllInvition();
		}
		
		public function cancelAllInvition():void
		{
			main.uiLobby.cancelAllInvition();
		}
		
		public function removeInvitionUI(invitedAccount:String):void
		{
			main.uiLobby.removeInvitionUI(invitedAccount);
		}
		
		public function joinGameInstandOfInvite(account:String):void
		{
			main.uiLobby.uiFreeLobby.joinGameInstandOfInvite(account);
		}
		
		public function stopTimer():void
		{
			main.uiLobby.stopTimer();
		}
		
		public  function recordInviteUI(invitedAccount:String, invitedName:String):void
		{
			main.uiLobby.recordInvite(invitedAccount, invitedName);
		}
		
		private function onPreScene(e:AppEvent):void
		{
			this.removeEventListener(AppEvent.ScenePrepare,onPreScene);
			interfaceOfSon = e.objHander as Object;
			whichLobby = e.retStr;
			main = new Main(this);
			dispatchEvent(new AppEvent(AppEvent.ScenePrepareDone));
		}
		
		public function onCostGameGoldConfirm():void
		{
			main.uiLobby.uiAutoLobby.onMatchAllowed();
		}
		
		public function onUserLeave(user:String):void
		{
			main.uiLobby.onUserLeave(user);
		}
		
		public function onUserLeaveReadyRoom(user:String):void
		{
			main.uiLobby.onUserLeaveReadyRoom(user);
		}
		
		public function onInit():void
		{
			
		}
		
		public function setInviteFlag(flag:Boolean):void
		{
			main.uiLobby.setInviteFlag(flag);
		}
		
		public function onEnter(user:User):void
		{
			main.uiLobby.onEnter(user);
		}
		
		public function onEnterReadyRoom(user:User):void
		{
			main.uiLobby.onEnterReadyRoom(user);
		}
		
		public function onGameUpdate(room:Room, zone:Zone, game:ServerGame):void
		{
			main.uiLobby.onGameUpdate(room, zone, game);
		}
		
		public function reflashRoomList(zoneName:String):void
		{
			main.uiLobby.reflashRoomList(zoneName);
		}
		
		public function deleteGame(roomId:int):void
		{
			main.uiLobby.deleteGame(roomId);
		}
		
		public function updataGame(room:Room, zone:Zone, game:ServerGame):void
		{
			main.uiLobby.updataGame(room, zone, game);
		}
		
		public function addGame(room:Room, zone:Zone, game:ServerGame):void
		{
			main.uiLobby.addGame(room, zone, game);
		}
		
		public function onClearAllGame(zoneName:String):void
		{
			main.uiLobby.onClearAllGame(zoneName);
		}
		
		public function onInvitedToFight(account:String, inviterName:String, roomName:String, zoneName:String):void
		{
			main.uiLobby.onInvitedToFight(account, inviterName, roomName, zoneName);
		}
		
		public function onCancelInvite(account:String, inviterName:String, roomName:String, zoneName:String):void
		{
			main.uiLobby.onCancelInvite(account, inviterName, roomName, zoneName);
		}
		
		public function initSome(zoneName:String):void
		{
			main.uiLobby.initNameList();
			main.uiLobby.initRoomList(zoneName);
		}
		
		public function showWhichLobby(which:String):void
		{
			this.whichLobby = which;
			main.uiLobby.showWhichLobby(which);
		}
		
		public function onGetUsersInRoomResponse(user:User, room:Room, zoneName:String, lobbyRoom:Room):void
		{
			main.uiLobby.onGetUsersInRoomResponse(user, room, zoneName, lobbyRoom);
		}
		
		public function onGetFriendsList(esObj:EsObject, user:User):void
		{
			main.uiLobby.onGetFriendsList(esObj, user);
		}
		
		public function enableMatchBtn():void
		{
			main.uiLobby.unSelectedMatchBtn();
		}
		
		public function onSize():void
		{
			Panel.x =(stage.stageWidth -Panel.width)/2;
			Panel.y = 5;
		}
		
		public function disableReturnToTown():void
		{
			main.uiLobby.disableReturnToTown();
		}
		
		public function enableReturnToTown():void
		{
			main.uiLobby.enableReturnToTown();
		}
		
		public function onUserJoinRoom(user:User):void
		{
			main.uiLobby.onUserJoinRoom(user);
		}
		
		public function onUserStatusUpdate(user:User):void
		{
			main.uiLobby.onUserStatusUpdate(user);
		}
		
		public function onGetCardGroup(esObj:EsObject):void
		{
			main.uiLobby.onGetCardGroup(esObj);
		}
		
		public function onGetCurrentCardGroup(esobj:EsObject):void
		{
			main.uiLobby.onGetCurrentCardGroup(esobj);
		}
		
		public function onSetCurrentCardGroup(esObj:EsObject):void
		{
			main.uiLobby.onSetCurrentCardGroup(esObj);
		}
	}
}