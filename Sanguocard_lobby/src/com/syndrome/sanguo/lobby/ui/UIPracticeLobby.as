package com.syndrome.sanguo.lobby.ui
{
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.ServerGame;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;
	import com.syndrome.sanguo.lobby.Main;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import com.syndrome.sanguo.lobby.ui.lobby.UILobbyBase;
	
	public class UIPracticeLobby extends UILobbyBase
	{
		
		public function UIPracticeLobby(_uiLobby:UILobby)
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
			if(uicreatRoomPanel.input_roomName.text=="请输入房间名称")
				uiLobby.main.entrance.interfaceOfSon.createGame("房间名为空", "sanguo-practice-zone", filter);
			else
				uiLobby.main.entrance.interfaceOfSon.createGame(uicreatRoomPanel.input_roomName.text, "sanguo-practice-zone", filter);
			uiLobby.main.entrance.interfaceOfSon.removeFromFloat(uicreatRoomPanel);
		}
		
	}
}