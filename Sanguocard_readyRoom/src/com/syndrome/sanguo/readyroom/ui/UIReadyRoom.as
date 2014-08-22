package com.syndrome.sanguo.readyroom.ui
{
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.RoomVariable;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.greensock.TimelineLite;
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.data.TweenLiteVars;
	import com.greensock.data.TweenMaxVars;
	import com.syndrome.client.enum.EnumFightType;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguo.readyroom.Main;
	import com.syndrome.sanguo.readyroom.ui.cardgroup.UICardGroup;
	import com.syndrome.sanguocard.uiclass.MCButton;
	import com.syndrome.sanguocard.uiclass.UISpriteWithSlider;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	public class UIReadyRoom
	{
		private static var instance:UIReadyRoom = null;
		public var ui:UI_Readyroom_MainPanel = null;
		public var main:Main = null;
		private var uiCardGroupList:UISpriteWithSlider = null;
		public var meUser:User = null;
		public var opUser:User = null;
		private var timer:Timer = null;
		private var second:int;
		private var tempBitmapData:BitmapData=null;
		private var tempBitmap:Bitmap = null;
		private var loader:Loader = null;
		public var room:Room = null;
		private var uiItemHostUser:UIItemUser = new UIItemUser("uiItemHostUser");
		private var uiItemGuestUser:UIItemUser = new UIItemUser("uiItemGuestUser");
		private var uiCardGroup:UICardGroup;
		private var uiFriendBtn:MCButton;
		private var uiUserList:UISpriteWithSlider = null;
		
		public static function CreateInstance(main:Main):UIReadyRoom
		{
			if(instance==null)
			{
				instance = new UIReadyRoom(main);
				instance.init();
			}
			return instance;
		}
		
		public function UIReadyRoom(_main:Main)
		{
			if(main==null)main = _main;
		}
		
		public function init():void
		{
			ui = new UI_Readyroom_MainPanel();
			uiCardGroup = new UICardGroup(this, ui.sprite_cardGroup);
			ui.btn_ready.addEventListener(MouseEvent.CLICK, onReadyBtnClick);
			ui.btn_leave.addEventListener(MouseEvent.CLICK, onLeaveBtnClick);
			ui.btn_invite.addEventListener(MouseEvent.CLICK, onFriendBtnClick);
			uiFriendBtn = new MCButton(ui.btn_friend, true);
			uiFriendBtn.addEventListener(MouseEvent.CLICK, onFriendBtnClick);
			uiFriendBtn.visible = false;
			
			ui.addChild(uiFriendBtn);
			uiItemHostUser.ui = UI_Readyroom_MainPanel(ui).sprite_host;
			uiItemGuestUser.ui = UI_Readyroom_MainPanel(ui).sprite_guest;
			if(timer==null)
			{
				timer = new Timer(1000, 4); 
				timer.addEventListener(TimerEvent.TIMER, onTick);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, onStartGame);
			}
		}
		
		public function initPanelTween():void
		{
			TweenLite.to(ui, 1, {x:0});
			TweenLite.to(ui.mask_readyRoom, 1, {x:0});
		}
		
		public function initUI():void
		{
			if(main.whichLobby==Constant.AUTO_LOBBY)
				ui.sprite_cardGroup.visible = false;
			else if(main.whichLobby==Constant.FREE_LOBBY)
				ui.sprite_cardGroup.visible = true;
			ui.btn_ready.selected = false;
			ui.mc_timeout.visible = false;
			ui.x = 0;
			ui.mask_readyRoom.x = 0;
			ui.lab_hostStatus.gotoAndStop("unready");
			ui.lab_guestStatus.gotoAndStop("unready");
			ui.mc_timeout.gotoAndStop("3");
			uiItemGuestUser.initUI();
			uiItemHostUser.initUI();
		}
		
		private function onReadyBtnClick(e:MouseEvent):void
		{
			TweenLite.to(ui, 1, {x:0});
			TweenLite.to(ui.mask_readyRoom, 1, {x:0});
			ui.btn_ready.btnEnabled = false;
			if(ui.btn_ready.selected==true){
				uiCardGroup.disableCardGroupSelection();
				main.entrance.interfaceOfSon.gameReady(uiCardGroup.currentCardGroupId);
			}else{
				uiCardGroup.ableCardGroupSelection();
				main.entrance.interfaceOfSon.gameReadyCancel();
			}
		}
		
		private function onLeaveBtnClick(e:MouseEvent):void
		{
			main.entrance.interfaceOfSon.clear();
		}
		
		private function onFriendBtnClick(e:MouseEvent):void
		{
			if(ui.btn_invite.selected == true)
			{
				TweenLite.to(ui, 1, {x:220});
				TweenLite.to(ui.mask_readyRoom, 1, {x:-220});
			}else{
				TweenLite.to(ui, 1, {x:0});
				TweenLite.to(ui.mask_readyRoom, 1, {x:0});
			}
		}
		
		public function leaveRoomCompleted():void
		{
			ui.x = 0;
			ui.mask_readyRoom.x = 0;
			ui.btn_ready.selected = false;
			ui.lab_hostStatus.gotoAndStop("unready");
			ui.lab_guestStatus.gotoAndStop("unready");
			ui.mc_timeout.gotoAndStop("3");
			ui.mc_timeout.visible = false;
			uiItemGuestUser.initUI();
			uiItemHostUser.initUI();
		}
		
		public function onGetUserInfo(user:User):void
		{
			if(room.roomVariableByName("roomHost")==null)return;
			var gui:EsObject = user.userVariableByName("gui").value;
			
			if(user.isMe)
				meUser = user;
			else
				opUser = user;
			
			if(user.userName == room.roomVariableByName("roomHost").value.getString("userName"))
			{
				uiItemHostUser.updateInfo(gui);
			}else{
				main.entrance.interfaceOfSon.showReadyRoom();
				uiItemGuestUser.updateInfo(gui);
			}
		}
		
		public function onUserLeave(user:String):void
		{
			initUI();
			stopTimer();
			main.entrance.interfaceOfSon.gameReadyCancel();
		}
		
		public function onGetCardGroup(esObj:EsObject):void
		{
			uiCardGroup.onGetCardGroup(esObj);
		}
		
		public function unableReadyBtn():void
		{
			ui.btn_ready.btnEnabled = false;
		}
		
		public function ableReadyBtn():void
		{
			ui.btn_ready.btnEnabled = true;
		}
		
		public function lobbyPushUserAdd(user:User):void
		{
			var result:* = uiUserList.children.filter(function(item:UIItemUserInLobby, index:int, vector:Vector.<UIItemUserInLobby>):Boolean{
				return searchUser(item, index, user.userName)}
			);
			if(result.length!=0) return;
			uiUserList.children.push(new UIItemUserInLobby("UIItemUserInLobby", user.userVariableByName("gui").value, uiUserList));
			uiUserList.formateChildrenUI();
		}
		
		public function lobbyDeleteUser(user:String):void
		{
			uiUserList.children.every(
				function(item:UIItemUserInLobby, index:int, vector:Vector.<UIItemUserInLobby>):Boolean{return everyNameItem(item, index, vector, user)}
			);
			
			function everyNameItem(item:UIItemUserInLobby, index:int, vector:Vector.<UIItemUserInLobby>, userName:String):Boolean
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
		
		public function onSetCurrentCardGroup(esObj:EsObject):void
		{
			uiCardGroup.onSetCurrentCardGroup(esObj);
		}
		
		public function onGameReadyStatus(esobj:EsObject, hostReady:Boolean, ready:Boolean):void
		{
			if(esobj.getString("gameStatus") == "READY")
			{
				ui.btn_leave.btnEnabled = false;
				ui.btn_ready.btnEnabled = false;
				ui.sprite_cardGroup.btn_cardGroup.btnEnabled = false;
				ui.sprite_cardGroup.sprite_allCardGroup.visible = false;
				ui.mc_timeout.visible = true;
				main.entrance.interfaceOfSon.disableReturnToTown();
				second = 3;
				if(timer!=null)
				{
					timer.reset();
					timer.start();
				}
			}else if(esobj.getString("gameStatus") =="WAITING"){
				stopTimer();
				ui.mc_timeout.visible = false;
				ui.mc_timeout.gotoAndStop("3");
			}
			if(hostReady)
			{
				if(ready && ui.lab_hostStatus.currentLabel!="ready")
				{
					ui.lab_hostStatus.gotoAndStop("ready");
					TweenLite.from(ui.lab_hostStatus, 0.3, {width:220, height:680, onComplete:onReadyCompleted});
				}
				else if(!ready && ui.lab_hostStatus.currentLabel!="unready")
				{
					ui.lab_hostStatus.gotoAndStop("unready");
					onReadyCompleted();
				}
			}
			else
				if(ready && ui.lab_guestStatus.currentLabel!="ready")
				{
					ui.lab_guestStatus.gotoAndStop("ready");
					TweenLite.from(ui.lab_guestStatus, 0.3, {width:220, height:680, onComplete:onReadyCompleted});
				}
				else if(!ready && ui.lab_guestStatus.currentLabel!="unready")
				{
					ui.lab_guestStatus.gotoAndStop("unready");
					onReadyCompleted();
				}
		}
		
		public function onGetUsersInLobbyResponse(user:User):void
		{
			var result:* = uiUserList.children.filter(function(item:UIItemUserInLobby, index:int, vector:Vector.<UIItemUserInLobby>):Boolean{
				return searchUser(item, index, user.userName)}
			);
			if(result.length!=0) return;
			var tempUserItem:UIItemUserInLobby = new UIItemUserInLobby("UIItemUserInLobby", user.userVariableByName("gui").value, uiUserList);
			uiUserList.children.push(tempUserItem);
			uiUserList.formateChildrenUI();
		}
		
		private function searchUser(item:UIItemUserInLobby, index:int, userAccount:String):Boolean
		{
			if(userAccount == item.ui.lab_idName.text) return true;
			else
				return false;
		}
		
		private function onReadyCompleted():void
		{
			ui.btn_ready.btnEnabled = true;
		}
		
		private function onTick(e:TimerEvent):void
		{
			trace(second);
			if(second==1)
				ui.btn_ready.btnEnabled = false;
			ui.mc_timeout.gotoAndStop(second.toString());
			TweenMax.to(ui.mc_timeout, 1, {blurFilter:{blurX:33, blurY:32, remove:true}, width:104, height:126, onComplete:onSecondComplete } );
			second = second - 1;
			
		}
		
		private function onSecondComplete():void
		{
			ui.mc_timeout.width = 52;
			ui.mc_timeout.height = 63;
		}
		
		private function stopTimer():void
		{
			if(timer.running)
			{
				timer.stop();
				ui.mc_timeout.visible = false;
				ui.sprite_cardGroup.btn_cardGroup.btnEnabled = true;
				ui.btn_leave.btnEnabled = true;
				ui.btn_ready.btnEnabled = true;
//				ui.btn_ready.selected = false;
				main.entrance.interfaceOfSon.enableReturnToTown();
			}
		}
		
		private function onStartGame(e:TimerEvent):void
		{
			ui.mc_timeout.visible = false;
			main.entrance.interfaceOfSon.enterGame();
			ui.x = 0;
			ui.mask_readyRoom.x = 0;
			ui.lab_hostStatus.gotoAndStop("unready");
			ui.lab_guestStatus.gotoAndStop("unready");
			ui.mc_timeout.visible = false;
			ui.mc_timeout.gotoAndStop("3");
			ui.sprite_cardGroup.btn_cardGroup.btnEnabled = true;
			ui.btn_leave.btnEnabled = true;
			ui.btn_ready.btnEnabled = true;
			ui.btn_ready.selected = false;
			main.entrance.interfaceOfSon.enableReturnToTown();
			ExternalInterface.call("onEnterFullScreen");
		}
		
		public function updateRoom(_room:Room):void
		{
			if(_room == null)
				trace("room in readyRoom is null");
			else
				room = _room;
		}
	}
}