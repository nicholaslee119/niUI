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
	public class UIItemInviter extends UIItemInvite
	{
		private var roomName:String;
		private var zoneName:String;
		
		public function UIItemInviter(_uiLobby:UILobby, _type:String, _uiUserList:UISpriteWithSlider, __account:String, _userName:String, _roomName:String, _zoneName:String)
		{
			userName = _userName;
			roomName = _roomName;
			zoneName = _zoneName;
			_account = __account;
			super(_uiLobby, _type, _uiUserList);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			ui = new UI_Lobby_ItemInviter();
			UI_Lobby_ItemInviter(ui).lab_name.text = userName;
			UI_Lobby_ItemInviter(ui).btn_accept.addEventListener(MouseEvent.CLICK, onAccept);
			UI_Lobby_ItemInviter(ui).btn_delay.addEventListener(MouseEvent.CLICK, onDelay);
		}
		
	 	protected function onAccept(e:MouseEvent):void
		{
			uiLobby.main.entrance.interfaceOfSon.answerInviter(account, roomName, zoneName, true);
		}
		
		protected function onDelay(e:MouseEvent):void
		{
			uiLobby.main.entrance.interfaceOfSon.answerInviter(account, roomName, zoneName, false);
			uiLobby.deleteUIItemInviter(this);
		}
		
		
	}
}