package com.syndrome.sanguo.lobby.ui
{
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.PublicMessageEvent;
	import com.electrotank.electroserver5.api.ServerGame;
	import com.electrotank.electroserver5.api.UserVariable;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.client.parameters.PublicParameters;
	import com.syndrome.sanguo.classlib.UISprite;
	import com.syndrome.sanguo.lobby.Main;
	import com.syndrome.sanguo.lobby.ui.iteminvition.UIItemInvite;
	import com.syndrome.sanguo.lobby.ui.iteminvition.UIItemInvited;
	import com.syndrome.sanguo.lobby.ui.iteminvition.UIItemInviter;
	import com.syndrome.sanguo.lobby.ui.itemuser.UIItemFriend;
	import com.syndrome.sanguo.lobby.ui.itemuser.UIItemUser;
	import com.syndrome.sanguo.lobby.ui.itemuser.UIItemUserInAuto;
	import com.syndrome.sanguo.lobby.ui.itemuser.UIItemUserInFree;
	import com.syndrome.sanguo.lobby.ui.lobby.UIAutoLobby;
	import com.syndrome.sanguo.lobby.ui.lobby.UIFreeLobby;
	import com.syndrome.sanguocard.uiclass.UISpriteWithSlider;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.text.engine.SpaceJustifier;
	import flash.utils.Timer;


	public class UILobby
	{
		private static var instance:UILobby = null;
		public var main:Main = null;
		public var ui:UI_Lobby_MainPanel = null;
		public var uiUserList:UISpriteWithSlider = null;
		public var uiFriendsList:UISpriteWithSlider = null;
		public var uiInvitersList:UISpriteWithSlider = null;
		public var uiAutoLobby:UIAutoLobby = null;
		public var uiFreeLobby:UIFreeLobby = null;
		public var uiPracticeLobby:UIPracticeLobby = null;
		public var invitedFlag:Boolean = false;
		private var pageCutLobbyOrginalX:Number;
		private var pageCutFriendOrginalX:Number;
		
		public static function CreateInstance(main:Main):UILobby
		{
			if(instance==null)
			{
				instance = new UILobby(main);
				instance.init();
			}
			return instance;
		}
		
		public function UILobby(_main:Main)
		{
			main = _main;
		}
		
		private function init():void
		{
			ui = new UI_Lobby_MainPanel();
			
			uiUserList = new UISpriteWithSlider("userList", ui.sprite_userList, new Vector.<UIItemUser>);
			uiUserList.defineY = 21;
			uiFriendsList = new UISpriteWithSlider("userList", ui.sprite_friendsList, new Vector.<UIItemUser>);
			uiFriendsList.defineY = 21;
			uiInvitersList = new UISpriteWithSlider("userList", ui.sprite_inviterList, new Vector.<UIItemInvite>);
			uiInvitersList.defineY = 21;
			
			if(uiAutoLobby==null)uiAutoLobby = new UIAutoLobby(this);
			ui.addChild(uiAutoLobby.ui);
			if(uiFreeLobby==null)uiFreeLobby = new UIFreeLobby(this);
			ui.addChild(uiFreeLobby.ui);
			if(uiPracticeLobby==null)uiPracticeLobby = new UIPracticeLobby(this);
			ui.addChild(uiPracticeLobby.ui);
			ui.btn_returnToCity.addEventListener(MouseEvent.CLICK, onReturnClick);
			ui.btn_lobby.addEventListener(MouseEvent.CLICK, onBtnLobbyClick);
			ui.btn_friends.addEventListener(MouseEvent.CLICK, onBtnFriendsClick);
			ui.btn_inviters.addEventListener(MouseEvent.CLICK, onBtnInvitersClick);
			pageCutLobbyOrginalX = ui.btn_lobby.x;
			pageCutFriendOrginalX = ui.btn_friends.x;
			initAllList();
			MovieClip(ui.btn_inviters.mc_blink).visible = false;
			MovieClip(ui.btn_inviters.mc_blink).stop();
			ui.sprite_userList.visible = true;
			ui.btn_lobby.selected = true;
		}
		
		private function initAllList():void
		{
			ui.sprite_userList.visible = false;
			ui.sprite_friendsList.visible = false;
			ui.sprite_inviterList.visible = false;
			ui.btn_lobby.selected = false; 
			ui.btn_friends.selected = false;
			ui.btn_inviters.selected = false;
		}
		
		private function onBtnLobbyClick(e:MouseEvent):void
		{
			initAllList();
			ui.btn_lobby.selected = true; 
			ui.sprite_userList.visible = true;
			if(main.entrance.whichLobby==Constant.FREE_LOBBY)
				ui.sprite_title.gotoAndStop("players");
			else if(main.entrance.whichLobby==Constant.AUTO_LOBBY)
				ui.sprite_title.gotoAndStop("autoLobby");
		}
		
		private function onBtnFriendsClick(e:MouseEvent):void
		{
			initAllList();
			if(main.entrance.whichLobby==Constant.FREE_LOBBY)
				ui.sprite_title.gotoAndStop("players");
			else if(main.entrance.whichLobby==Constant.AUTO_LOBBY)
				ui.sprite_title.gotoAndStop("autoLobby");
			ui.btn_friends.selected = true;
			ui.sprite_friendsList.visible = true;
			
			uiFriendsList.children.splice(0,uiFriendsList.children.length);
			uiFriendsList.formateChildrenUI();
			main.entrance.interfaceOfSon.getFriendsList();
		}
		
		private function onBtnInvitersClick(e:MouseEvent):void
		{
			initAllList();
			MovieClip(ui.btn_inviters.mc_blink).visible = false;
			MovieClip(ui.btn_inviters.mc_blink).stop();
			ui.sprite_title.gotoAndStop("invites");
			ui.btn_inviters.selected = true;
			ui.sprite_inviterList.visible = true;
		}
		
		private function onReturnClick(e:MouseEvent):void
		{
			main.entrance.interfaceOfSon.onReturnTown();
		}
		
		public function onGameUpdate(room:Room, zone:Zone, game:ServerGame):void
		{
			if(zone.name==Constant.FREE_LOBBY)
				uiFreeLobby.onGameUpdate(room, zone, game);
			else if(zone.name=="sanguo-practice-zone")
				uiPracticeLobby.onGameUpdate(room, zone, game);
		}
		
		public function recordInvite(account:String, inviterName:String):void
		{
			MovieClip(ui.btn_inviters.mc_blink).visible = true;
			MovieClip(ui.btn_inviters.mc_blink).play();
			uiInvitersList.children.push(new UIItemInvited(this, "UIItemUserInvitersList", uiInvitersList, account, inviterName));
			uiInvitersList.children.sort(sortInvite);
			uiInvitersList.formateChildrenUI();
		}
		
		public function onInvitedToFight(account:String, inviterName:String, roomName:String, zoneName:String):void
		{
			MovieClip(ui.btn_inviters.mc_blink).visible = true;
			MovieClip(ui.btn_inviters.mc_blink).play();
			uiInvitersList.children.push(new UIItemInviter(this, "UIItemUserInvitersList", uiInvitersList, account, inviterName, roomName, zoneName));
			uiInvitersList.children.sort(sortInvite);
			uiInvitersList.formateChildrenUI();
		}
		
		public function onCancelInvite(account:String, inviterName:String, roomName:String, zoneName:String):void
		{
			uiInvitersList.children.some(deleteInvite);
			uiInvitersList.children.sort(sortInvite);
			uiInvitersList.formateChildrenUI();
			
			function deleteInvite(item:UIItemInvite, index:int, vector:Vector.<UIItemInvite>):Boolean
			{
				if(item.account==account)
				{
					vector.splice(index, 1);
					return true;
				}else{
					return false;
				}
			}
		}
		
		private function sortInvite(x:UIItemInvite, y:UIItemInvite):Number
		{
			if(x is UIItemInvited && y is UIItemInvited || x is UIItemInviter && y is UIItemInviter)
				return 0;
			else if(x is UIItemInvited && y is UIItemInviter)
				return -1;
			else
				return 1;
		}
		
		public function onClearAllGame(zoneName:String):void
		{
			if(zoneName==Constant.FREE_LOBBY)
				uiFreeLobby.onClearAllGame();
			else if(zoneName=="sanguo-practice-zone")
				uiPracticeLobby.onClearAllGame();
		}
		
		public function deleteGame(roomId:int):void
		{
			uiFreeLobby.deleteGame(roomId);
		}
		
		public function updataGame(room:Room, zone:Zone, game:ServerGame):void
		{
			uiFreeLobby.updataGame(room, zone, game);
		}
		
		public function addGame(room:Room, zone:Zone, game:ServerGame):void
		{
			uiFreeLobby.addGame(room, zone, game);
		}
		
		public function reflashRoomList(zoneName:String):void
		{
			if(zoneName==Constant.FREE_LOBBY)
				uiFreeLobby.reflashRoomList();
			else if(zoneName=="sanguo-practice-zone")
				uiPracticeLobby.reflashRoomList();
		}
		
		public function onUserJoinRoom(user:User):void
		{
			var result:* = uiUserList.children.filter(function(item:UIItemUser, index:int, vector:Vector.<UIItemUser>):Boolean{
				return searchUser(item, index, user.userName)}
			);
			if(result.length!=0) return;
			if(main.entrance.whichLobby==Constant.FREE_LOBBY)
				uiUserList.children.push(new UIItemUserInFree(this, "UIItemUserInLobby", uiUserList, user));
			else if(main.entrance.whichLobby==Constant.AUTO_LOBBY)
				uiUserList.children.push(new UIItemUserInAuto(this, "UIItemUserInLobby", uiUserList, user));
			uiUserList.formateChildrenUI();
		}
		
		public function onUserStatusUpdate(user:User):void
		{
			uiUserList.children.every(
				function(item:UIItemUser, index:int, vector:Vector.<UIItemUser>):Boolean{return everyNameItem(item, index, vector, user)}
			);
			
			function everyNameItem(item:UIItemUser, index:int, vector:Vector.<UIItemUser>, user:User):Boolean
			{
				if(item.ui.lab_idName.text == user.userName)
				{
					item.switchTheStatus(user.userVariableByName("status").value.getInteger("code"));
					return false;
				}
				else
					return true;
			}
		}
		
		public function onGetCardGroup(esObj:EsObject):void
		{
			if(uiAutoLobby==null)return;
			uiAutoLobby.onGetCardGroup(esObj);
		}
		
		public function onGetCurrentCardGroup(esobj:EsObject):void
		{
			if(uiAutoLobby==null)return;
			uiAutoLobby.onGetCurrentCardGroup(esobj);
			main.entrance.interfaceOfSon.getCardGroup();
		}
		
		public function onSetCurrentCardGroup(esobj:EsObject):void
		{
			if(uiAutoLobby==null)return;
			uiAutoLobby.onSetCurrentCardGroup(esobj);
		}
		
		public function deleteUIItemInviter(_item:UIItemInvite):void
		{
			uiInvitersList.children.some(
				function(item:UIItemInvite, index:int, vector:Vector.<UIItemInvite>):Boolean{return someInviter(item, index, vector)}
			);
			
			function someInviter(item:UIItemInvite, index:int, vector:Vector.<UIItemInvite>):Boolean
			{
				if(item==_item)
				{
					vector.splice(index, 1);
					uiInvitersList.formateChildrenUI();
					return true;
				}
				else
					return false;
			}
		}
		
		public function clearAllInvition():void
		{
			var n:int = uiInvitersList.children.length;
			uiInvitersList.children.splice(0, n);
			uiInvitersList.formateChildrenUI();
		}
		
		public function cancelAllInvition():void
		{
			uiInvitersList.children.some(
				function(item:UIItemInvite, index:int, vector:Vector.<UIItemInvite>):Boolean{return someInviter(item, index, vector)}
			);
			
			function someInviter(item:UIItemInvite, index:int, vector:Vector.<UIItemInvite>):Boolean
			{
				if(item is UIItemInvited)
				{
					vector.splice(index, 1);
					uiInvitersList.formateChildrenUI();
					return true;
				}
				else
					return false;
			}
		}
		
		public function onGetUsersInRoomResponse(user:User, room:Room, zoneName:String, lobbyRoom:Room):void
		{
			if(zoneName==Constant.FREE_LOBBY)
				uiFreeLobby.onGetUsersInRoomResponse(user, room, lobbyRoom);
			else if(zoneName=="sanguo-practice-zone")
				uiPracticeLobby.onGetUsersInRoomResponse(user, room, lobbyRoom);
		}
		
		public function onGetFriendsList(esObj:EsObject, user:User):void
		{
			if(main.entrance.whichLobby==Constant.FREE_LOBBY)
				uiFriendsList.children.push(new UIItemFriend(this, "UIItemUserFriendsList", uiFriendsList, user, esObj));
			else if(main.entrance.whichLobby==Constant.AUTO_LOBBY)
				uiFriendsList.children.push(new UIItemUserInAuto(this, "UIItemUserFriendsList", uiFriendsList, user, esObj));
			uiFriendsList.formateChildrenUI();
		}
		
		private function searchUser(item:UIItemUser, index:int, userAccount:String):Boolean
		{
			if(userAccount == item.ui.lab_idName.text) return true;
			else
				return false;
		}
		
		public function onEnter(user:User):void
		{
			main.entrance.interfaceOfSon.getUserInfo(user.userName, "");
		}
		
		public function onEnterReadyRoom(user:User):void
		{
			
		}
		
		public function setInviteFlag(flag:Boolean):void
		{
			invitedFlag = flag;
			uiUserList.children.forEach(
				function(item:UIItemUser, index:int, vector:Vector.<UIItemUser>):void{everyNameItem(item, index, vector)}
			);
			
			function everyNameItem(item:UIItemUser, index:int, vector:Vector.<UIItemUser>):void
			{
				if(item.isMe())
					item.ui.sprite_float.btn_askForFight.btnEnabled = false;
				else
					item.ui.sprite_float.btn_askForFight.btnEnabled = flag;
			}
		}
		
		public function onUserLeave(user:String):void
		{
			uiUserList.children.every(
				function(item:UIItemUser, index:int, vector:Vector.<UIItemUser>):Boolean{return everyNameItem(item, index, vector, user)}
			);
			
			function everyNameItem(item:UIItemUser, index:int, vector:Vector.<UIItemUser>, userName:String):Boolean
			{
				if(item.ui.lab_idName.text == userName)
				{
					uiUserList.deleteItem(item);
					return false;
				}
				else
					return true;
			}
		}
		
		public function onUserLeaveReadyRoom(user:String):void
		{
			
		}
		
		public function initNameList():void
		{
			uiUserList.children.splice(0,uiUserList.children.length);
			uiUserList.formateChildrenUI();
		}
		
		public function initRoomList(zoneName:String):void
		{
			if(zoneName==Constant.FREE_LOBBY)
				uiFreeLobby.initRoomList();
			else if(zoneName=="sanguo-practice-zone")
				uiPracticeLobby.initRoomList();
		}
		
		public function unSelectedMatchBtn():void
		{
			uiAutoLobby.unselectedMatchBtn();
		}
		
		public function stopTimer():void
		{
			uiAutoLobby.stopTimer();
		}
		
		public function removeInvitionUI(invitedAccount:String):void
		{
			uiInvitersList.children = uiInvitersList.children.filter(removeInvition);
			uiInvitersList.formateChildrenUI();
			
			function removeInvition(item:UIItemInvite, index:int, vector:Vector.<UIItemInvite>):Boolean
			{
				if(item is UIItemInvited && item.account == invitedAccount)
				{
					return false;
				}else
					return true;
			}
		}
		
		private function switchPageCut(which:String):void
		{
			if(which==Constant.AUTO_LOBBY)
			{
				ui.btn_lobby.x = pageCutLobbyOrginalX + 30;
				ui.btn_friends.x = pageCutFriendOrginalX + 30;
				ui.btn_inviters.visible = false;
				ui.sprite_title.gotoAndStop("autoLobby");
			}
			else if(which==Constant.FREE_LOBBY){
				ui.btn_lobby.x = pageCutLobbyOrginalX;
				ui.btn_friends.x = pageCutFriendOrginalX;
				ui.btn_inviters.visible = true;
				ui.sprite_title.gotoAndStop("players");
			}
		}
		
		public function showWhichLobby(which:String):void
		{
			uiAutoLobby.ui.visible = false;
			uiFreeLobby.ui.visible = false;
			uiPracticeLobby.ui.visible = false;
			if(which==Constant.AUTO_LOBBY)
			{
				uiAutoLobby.ui.visible = true;
				main.entrance.interfaceOfSon.getCurrentCardGroup();
			}
			else if(which==Constant.FREE_LOBBY){
				uiFreeLobby.ui.visible = true;
			}
			this.switchPageCut(which);
			this.initAllList();
			ui.sprite_userList.visible = true;
			ui.btn_lobby.selected = true;
		}
		
		public function disableReturnToTown():void
		{
			ui.btn_returnToCity.btnEnabled = false;
		}
		
		public function enableReturnToTown():void
		{
			ui.btn_returnToCity.btnEnabled = true;
		}
		
	}
}