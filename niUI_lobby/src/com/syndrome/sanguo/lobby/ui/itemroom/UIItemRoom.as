package com.syndrome.sanguo.lobby.ui.itemroom
{
	import com.electrotank.electroserver5.api.ServerGame;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;
	import com.syndrome.client.enum.EnumFightType;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguo.classlib.UIItemBase;
	import com.syndrome.sanguo.lobby.loader.ItemRoomUsersLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.net.URLRequest;

	public class UIItemRoom extends UIItemBase
	{
		public var room:Room = null;
		public var zone:Zone = null;
		public var game:ServerGame = null;
		private var uiSomeLobby:* = null;
		public var lobbyRoom:Room;
		
		public function UIItemRoom(_room:Room, _zone:Zone, _game:ServerGame, _uiSomeLobby:*)
		{
			if(room==null) room = _room;
			if(zone==null) zone = _zone;
			if(game==null) game = _game;
			if(uiSomeLobby==null) uiSomeLobby = _uiSomeLobby;
			super(_room.name);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			if(game.gameDetails.getString(EnumFightType.NAME)==EnumFightType.FREE)
				ui = new UI_ItemRoom_Free();
			else
				ui = new UI_ItemRoom_Fixed();
			uiSomeLobby.uiLobby.main.entrance.interfaceOfSon.getUsersInRoom(room);
			ui.lab_roomId.text = room.id;
			ui.lab_roomName.text = game.gameDetails.getString("roomName");
			if(game.passwordProtected)
				ui.lab_password.text = "有密码";
			else
				ui.lab_password.text = "无密码";
			ui.mouseChildren = true;
			ui.addEventListener(MouseEvent.CLICK, onRoomItemClick);
		}
		
		private function onRoomItemClick(e:MouseEvent):void
		{
			if( (e.currentTarget).lab_guestName.text=="" )
				uiSomeLobby.uiLobby.main.entrance.interfaceOfSon.joinGame(game.id, game.gameDetails.getString(EnumFightType.NAME));
		}
		
		public function tryEnterGame():void
		{
			if(game!=null)
				uiSomeLobby.uiLobby.main.entrance.interfaceOfSon.joinGame(game.id, game.gameDetails.getString(EnumFightType.NAME));
		}
		
		public function updateInfo(user:User, _room:Room, _lobbyRoom:Room):void
		{
			room = _room;
			lobbyRoom = _lobbyRoom;
			var wholeName:String = user.userVariableByName(Constant.GetUserInfo).value.getString("surname")+user.userVariableByName(Constant.GetUserInfo).value.getString("name");
			if(lobbyRoom.roomVariableByName(room.id.toString())==null)
				if(ui.lab_hostName.text=="")
					ui.lab_hostName.text =  wholeName;
				else
					ui.lab_guestName.text = wholeName;
			else{
				if(lobbyRoom.roomVariableByName(room.id.toString()).value.getString("roomHost")==user.userName)
					ui.lab_hostName.text =  wholeName;
				else
					ui.lab_guestName.text = wholeName;
				
			}
				
			var itemRoomUsersLoader:ItemRoomUsersLoader = new ItemRoomUsersLoader(this, user);
		}
	}
}