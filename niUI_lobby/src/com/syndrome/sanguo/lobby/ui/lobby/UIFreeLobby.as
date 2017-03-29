package com.syndrome.sanguo.lobby.ui.lobby
{
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.ServerGame;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;
	import com.syndrome.client.enum.EnumFightType;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguo.lobby.Main;
	import com.syndrome.sanguo.lobby.ui.cardgroup.UICardGroup;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import com.syndrome.sanguo.lobby.ui.UILobby;

	public class UIFreeLobby extends UILobbyBase
	{
		public function UIFreeLobby(_uiLobby:UILobby)
		{
			super(_uiLobby); 
		}
		
		override protected function onComfirmBtnClick(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			super.onComfirmBtnClick(e);
			trace(uicreatRoomPanel.sprite_radioLevel.getSelection());
			var filter:EsObject = new EsObject();
			filter.setString("password", uicreatRoomPanel.input_roomPsw.text);
			filter.setInteger("time", uicreatRoomPanel.sprite_radioTime.getSelection());
			filter.setInteger("level", uicreatRoomPanel.sprite_radioLevel.getSelection());
			filter.setInteger("win", uicreatRoomPanel.sprite_radioWin.getSelection());
			filter.setInteger("esc", uicreatRoomPanel.sprite_radioEsc.getSelection());
			var fightType:String;
			if(ui.tab_fightType.btn_commom.selected)
				fightType = EnumFightType.FREE;
			else if(ui.tab_fightType.btn_practice.selected)
				fightType = EnumFightType.PRACTICE;
			if(uicreatRoomPanel.input_roomName.text=="请输入房间名称")
				uiLobby.main.entrance.interfaceOfSon.createGame("房间名为空", Constant.FREE_LOBBY, filter, fightType);
			else
				uiLobby.main.entrance.interfaceOfSon.createGame(uicreatRoomPanel.input_roomName.text, Constant.FREE_LOBBY, filter, fightType);
			uiLobby.main.entrance.interfaceOfSon.removeFromFloat(uicreatRoomPanel);
		}
		
	}
}