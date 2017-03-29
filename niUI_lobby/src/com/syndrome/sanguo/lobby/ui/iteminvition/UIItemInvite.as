package com.syndrome.sanguo.lobby.ui.iteminvition
{
	import com.syndrome.sanguo.classlib.UIItemBase;
	import com.syndrome.sanguocard.uiclass.UISpriteWithSlider;
	
	import flash.events.MouseEvent;
	import com.syndrome.sanguo.lobby.ui.UILobby;
	
	
	/*
	* @author nic
	* @build-time 2014-4-14
	* @comments
	*
	*/
	public class UIItemInvite extends UIItemBase
	{
		protected var userName:String;
		protected var _account:String;
		protected var uiUserList:UISpriteWithSlider;
		protected var uiLobby:UILobby;
		
		public function UIItemInvite(_uiLobby:UILobby, _type:String, _uiUserList:UISpriteWithSlider)
		{
			super(_type);
			uiLobby = _uiLobby;
			uiUserList = _uiUserList;
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
		}
		
		public function formateSelf():void
		{
			if((Vector.<UIItemInvite>(uiUserList.children).indexOf(this)+1)%2 == 1)
				ui.gotoAndStop("odd");
			else
				ui.gotoAndStop("even");
		}
		
		public function get account():String
		{
			return _account;
		}

		
	}
}