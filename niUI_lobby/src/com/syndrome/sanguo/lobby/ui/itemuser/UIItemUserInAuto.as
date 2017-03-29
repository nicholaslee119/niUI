package com.syndrome.sanguo.lobby.ui.itemuser
{
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.user.User;
	import com.syndrome.client.enum.EnumGUI;
	import com.syndrome.sanguo.lobby.ui.UILobby;
	import com.syndrome.sanguocard.uiclass.UISpriteWithSlider;
	
	
	/*
	* @author nic
	* @build-time 2014-5-19
	* @comments
	*
	*/
	public class UIItemUserInAuto extends UIItemUser
	{
		public function UIItemUserInAuto(_uiLobby:UILobby, _type:String, _uiUserList:UISpriteWithSlider, _user:User=null, _gui:EsObject=null)
		{
			super(_uiLobby, _type, _uiUserList, _user, _gui);
		}
		
		override protected function setInfo(_gui:EsObject):void
		{
			// TODO Auto Generated method stub
			super.setInfo(_gui);
			ui.lab_record.text = _gui.getInteger(EnumGUI.SCORE).toString();
		}
		
	}
}