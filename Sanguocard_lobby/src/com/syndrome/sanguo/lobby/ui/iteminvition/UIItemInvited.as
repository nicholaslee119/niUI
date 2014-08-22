package com.syndrome.sanguo.lobby.ui.iteminvition
{
	import com.syndrome.sanguo.lobby.ui.UILobby;
	import com.syndrome.sanguocard.uiclass.UISpriteWithSlider;
	
	import flash.events.MouseEvent;
	
	/*
	* @author nic
	* @build-time 2014-4-25
	* @comments
	*
	*/
	public class UIItemInvited extends UIItemInvite
	{
		public function UIItemInvited(_uiLobby:UILobby, _type:String, _uiUserList:UISpriteWithSlider, __account:String, _userName:String)
		{
			userName = _userName;
			_account = __account;
			super(_uiLobby, _type, _uiUserList);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			ui = new UI_Lobby_ItemInvited();
			UI_Lobby_ItemInvited(ui).lab_name.text = userName;
			UI_Lobby_ItemInvited(ui).btn_cancel.addEventListener(MouseEvent.CLICK, onCancel);
		}
		
		private function onCancel(e:MouseEvent):void
		{
			uiLobby.main.entrance.interfaceOfSon.cancelInviteFight(account);
			uiLobby.deleteUIItemInviter(this);
		}
		
	}
}