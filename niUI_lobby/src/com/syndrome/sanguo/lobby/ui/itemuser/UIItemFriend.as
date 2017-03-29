package com.syndrome.sanguo.lobby.ui.itemuser
{
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.user.User;
	import com.syndrome.client.enum.EnumGUI;
	import com.syndrome.sanguo.lobby.ui.UILobby;
	import com.syndrome.sanguocard.uiclass.UISpriteWithSlider;
	
	import flash.events.MouseEvent;
	
	
	/*
	* @author nic
	* @build-time 2014-7-22
	* @comments
	*
	*/
	public class UIItemFriend extends UIItemUserInFree
	{
		public function UIItemFriend(_uiLobby:UILobby, _type:String, _uiUserList:UISpriteWithSlider, _user:User=null, _gui:EsObject=null)
		{
			super(_uiLobby, _type, _uiUserList, _user, _gui);
		}
		
		override protected function onBtnAskClick(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			if(UI_Lobby_ItemUser(ui).lab_light.currentLabel == "waiting")
			{
				//询问是否直接加入房间
				uiLobby.main.entrance.interfaceOfSon.askJoinGame(gui.getString(EnumGUI.ACCOUNT));
			}
			else if(UI_Lobby_ItemUser(ui).lab_light.currentLabel == "online" && this.isInLobby(gui.getString(EnumGUI.ACCOUNT)))
				uiLobby.main.entrance.interfaceOfSon.askForFight(gui.getString(EnumGUI.ACCOUNT), gui.getString(EnumGUI.SURNAME)+gui.getString(EnumGUI.NAME));
		}
		
		override protected function setInfo(_gui:EsObject):void
		{
			// TODO Auto Generated method stub
			super.setInfo(_gui);
			ui.lab_record.text = _gui.getInteger(EnumGUI.LEVEL).toString();
		}
		
		private function isInLobby(account:String):Boolean
		{
			var res:Boolean = uiLobby.uiUserList.children.some(callback);
			function callback(item:UIItemUser, index:int, vector:*):Boolean
			{
				if(item.gui.getString(EnumGUI.ACCOUNT)==account)
					return true;
				else
					return false;
			}
			if(!res)uiLobby.main.entrance.interfaceOfSon.alertFromSonProject("好友不在此大厅！");
			return res;
		}
	}
}