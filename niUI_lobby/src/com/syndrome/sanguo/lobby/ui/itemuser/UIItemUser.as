package com.syndrome.sanguo.lobby.ui.itemuser
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.ServerGame;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.syndrome.client.enum.EnumFightType;
	import com.syndrome.client.enum.EnumGUI;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.client.parameters.PublicParameters;
	import com.syndrome.sanguo.classlib.UIItemBase;
	import com.syndrome.sanguocard.uiclass.UISpriteWithSlider;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import com.syndrome.sanguo.lobby.ui.UILobby;
	
	public class UIItemUser extends UIItemBase
	{
		private var user:User = null;
		public var gui:EsObject = null;
		private var uiUserList:UISpriteWithSlider = null;
		private var tempChildIndex:int = -1;
		protected var uiLobby:UILobby;
		private var roomId:int = -100;
		private var zoneId:int = -100;
		
		public function UIItemUser(_uiLobby:UILobby, _type:String, _uiUserList:UISpriteWithSlider, _user:User=null, _gui:EsObject=null)
		{
			user = _user;
			if(_gui==null)gui = user.userVariableByName(Constant.GetUserInfo).value;
			else gui = _gui;
			uiLobby = _uiLobby;
			uiUserList = _uiUserList;
			super(_type);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			if(ui==null) ui = new UI_Lobby_ItemUser();
			ui.sprite_float.visible = false;
			ui.mouseChildren = false;
			ui.sprite_float.btn_chat.addEventListener(MouseEvent.CLICK, onBtnChatClick);
			ui.sprite_float.btn_info.addEventListener(MouseEvent.CLICK, onBtnInfoClick);
			ui.sprite_float.btn_addFriend.addEventListener(MouseEvent.CLICK, onBtnAddClick);
			ui.sprite_float.btn_askForFight.addEventListener(MouseEvent.CLICK, onBtnAskClick);
			ui.sprite_float.btn_askForFight.btnEnabled = uiLobby.invitedFlag;
			ui.addEventListener(MouseEvent.CLICK, onUserItemClick);
			ui.addEventListener(MouseEvent.ROLL_OUT, onUserItemOut);
			this.setInfo(gui);
		}
		private function onBtnChatClick(e:MouseEvent):void
		{
			ExternalInterface.call("onPrivateChatInvoke", (e.target.parent.parent as UI_Lobby_ItemUser).lab_name.text, (e.target.parent.parent as UI_Lobby_ItemUser).lab_idName.text);
		}
		
		protected function onBtnAskClick(e:MouseEvent):void
		{
			if(UI_Lobby_ItemUser(ui).lab_light.currentLabel == "waiting")
			{
				//询问是否直接加入房间
				uiLobby.main.entrance.interfaceOfSon.askJoinGame(gui.getString(EnumGUI.ACCOUNT));
			}
			else if(UI_Lobby_ItemUser(ui).lab_light.currentLabel == "online")
				uiLobby.main.entrance.interfaceOfSon.askForFight(gui.getString(EnumGUI.ACCOUNT), gui.getString(EnumGUI.SURNAME)+gui.getString(EnumGUI.NAME));
		}
		
		private function onBtnInfoClick(e:MouseEvent):void
		{
			ExternalInterface.call("onShowUserPanel", (e.target.parent.parent as UI_Lobby_ItemUser).lab_idName.text);
		}
		
		private function onBtnAddClick(e:MouseEvent):void
		{
			ExternalInterface.call("onAddFriendInvoke", (e.target.parent.parent as UI_Lobby_ItemUser).lab_idName.text);
		}
		
		private function onUserItemClick(e:MouseEvent):void
		{
			ui.removeEventListener(MouseEvent.CLICK, onUserItemClick);
			ui.mouseChildren = true;
			ui.sprite_float.visible = true;
			tempChildIndex = uiUserList.sprite.container.getChildIndex(e.target as Sprite);
			uiUserList.sprite.container.swapChildrenAt(tempChildIndex, uiUserList.sprite.container.numChildren-1);
		}
		
		private function onUserItemOut(e:MouseEvent):void
		{
			if(tempChildIndex!=-1)uiUserList.sprite.container.swapChildrenAt(uiUserList.sprite.container.numChildren-1, tempChildIndex);
			ui.sprite_float.visible = false;
			ui.mouseChildren = false;
			ui.addEventListener(MouseEvent.CLICK, onUserItemClick);
		}
		
		public function isMe():Boolean
		{
			return gui.getString("account")==GameCom.getInstance().esServer.managerHelper.userManager.me.userName;
		}
		
		protected function setInfo(_gui:EsObject):void
		{
			if(ui==null) throw type + "ui is null";
			if(_gui==null) _gui = user.userVariableByName(Constant.GetUserInfo).value;
			ui.lab_name.text = _gui.getString(EnumGUI.SURNAME)+_gui.getString(EnumGUI.NAME);
			if(_gui.doesPropertyExist("online") && _gui.getBoolean("online"))
				UI_Lobby_ItemUser(ui).lab_light.gotoAndStop("online");
			else if(_gui.doesPropertyExist("online") && !_gui.getBoolean("online"))
				UI_Lobby_ItemUser(ui).lab_light.gotoAndStop("offline");
			ui.lab_idName.text = _gui.getString(EnumGUI.ACCOUNT);
			if(user==null) return;
			this.switchTheStatus(user.userVariableByName("status").value.getInteger("code"))
		}
		
		public function formateSelf():void
		{
			if((Vector.<UIItemUser>(uiUserList.children).indexOf(this)+1)%2 == 1)
				UI_Lobby_ItemUser(ui).gotoAndStop("odd");
			else
				UI_Lobby_ItemUser(ui).gotoAndStop("even");
		}
		
		public function switchTheStatus(flag:int):void
		{
			switch(flag)
			{
				case Constant.USER_STATUS_IN_FIGHT:
					UI_Lobby_ItemUser(ui).lab_light.gotoAndStop("busy");
					break;
				case Constant.USER_STATUS_IDLE:
					UI_Lobby_ItemUser(ui).lab_light.gotoAndStop("online");
					break;
				case Constant.USER_STATUS_FULL:
					UI_Lobby_ItemUser(ui).lab_light.gotoAndStop("full");
					break;
				case Constant.USER_STATUS_WAITING:
					UI_Lobby_ItemUser(ui).lab_light.gotoAndStop("waiting");
					break;
				default:
					trace("[UIItemUser]: 未知的玩家状态");
					break;
			}
		}
		
		public function updataRoomInfo(_roomId:int, _zoneId:int):void
		{
			roomId = _roomId;	
			zoneId = _zoneId;
		}
		
	}
}