package com.syndrome.sanguo.readyroom.ui
{
	import com.electrotank.electroserver5.api.EsObject;
	import com.syndrome.sanguo.classlib.UIItemBase;
	import com.syndrome.sanguocard.uiclass.UISpriteWithSlider;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	
	/*
	* @author nic
	* @build-time 2014-3-11
	* @comments
	*
	*/
	public class UIItemUserInLobby extends UIItemBase
	{
		private var esObj:EsObject = null;
		private var uiUserList:UISpriteWithSlider = null;
		private var tempChildIndex:int = -1;
		
		public function UIItemUserInLobby(_type:String, _esObj:EsObject, _uiUserList:UISpriteWithSlider)
		{
			if(esObj==null)esObj = _esObj;
			if(uiUserList==null) uiUserList = _uiUserList;
			super(_type);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			if(ui==null) ui = new UI_Readyroom_ItemUser();
			ui.sprite_float.visible = false;
			ui.mouseChildren = false;
			ui.sprite_float.btn_chat.addEventListener(MouseEvent.CLICK, onBtnChatClick);
			ui.sprite_float.btn_info.addEventListener(MouseEvent.CLICK, onBtnInfoClick);
			//			ui.sprite_float.btn_addFriend.addEventListener(MouseEvent.CLICK, onBtnAddClick);
			ui.addEventListener(MouseEvent.CLICK, onUserItemClick);
			ui.addEventListener(MouseEvent.ROLL_OUT, onUserItemOut);
			setInfo(esObj);
		}
		private function onBtnChatClick(e:MouseEvent):void
		{
			trace((e.target.parent.parent as UI_Readyroom_ItemUser).lab_idName.text+"onBtnChatClick");
			ExternalInterface.call("onPrivateChatInvoke", (e.target.parent.parent as UI_Readyroom_ItemUser).lab_name.text, (e.target.parent.parent as UI_Readyroom_ItemUser).lab_idName.text);
		}
		
		private function onBtnInfoClick(e:MouseEvent):void
		{
			trace((e.target.parent.parent as UI_Readyroom_ItemUser).lab_idName.text+"onBtnInfoClick");
			ExternalInterface.call("onDetailInfoInvoke", (e.target.parent.parent as UI_Readyroom_ItemUser).lab_idName.text);
		}
		
		private function onBtnAddClick(e:MouseEvent):void
		{
			trace((e.target.parent.parent as UI_Readyroom_ItemUser).lab_idName.text+"onBtnAddClick");
			ExternalInterface.call("onAddFriendInvoke", (e.target.parent.parent as UI_Readyroom_ItemUser).lab_idName.text);
		}
		
		private function onUserItemClick(e:MouseEvent):void
		{
			ui.removeEventListener(MouseEvent.CLICK, onUserItemClick);
			ui.mouseChildren = true;
			trace((e.target as UI_Readyroom_ItemUser).lab_idName.text);
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
		
		public function setInfo(_esObj:EsObject):void
		{
			if(ui==null) throw type + "ui is null";
			ui.lab_name.text = _esObj.getString("surname")+_esObj.getString("name");
			//			ui.lab_level.text = _esObj.getByte("pvpLevel").toString();
			ui.lab_record.text = _esObj.getInteger("jifen").toString();
			//			ui.lab_status.text = "在线";
			if(_esObj.doesPropertyExist("online") && _esObj.getBoolean("online"))
				UI_Readyroom_ItemUser(ui).lab_light.gotoAndStop("online");
			else if(_esObj.doesPropertyExist("online") && !_esObj.getBoolean("online"))
				UI_Readyroom_ItemUser(ui).lab_light.gotoAndStop("offline");
			ui.lab_idName.text = _esObj.getString("account");
		}
		
		public function formateSelf():void
		{
			if((Vector.<UIItemUserInLobby>(uiUserList.children).indexOf(this)+1)%2 == 1)
				UI_Readyroom_ItemUser(ui).gotoAndStop("odd");
			else
				UI_Readyroom_ItemUser(ui).gotoAndStop("even");
		}
	}
}