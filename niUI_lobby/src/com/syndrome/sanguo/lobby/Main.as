package com.syndrome.sanguo.lobby
{
	
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;
	import com.syndrome.sanguo.lobby.ui.UILobby;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Main
	{
		public var entrance:Lobby = null;
		public var uiLobby:UILobby = null;
		
		public function Main(_entrance:Lobby)
		{
			entrance = _entrance;
			init();
		}
		
		private function init():void
		{
			uiLobby = UILobby.CreateInstance(this);
			uiLobby.showWhichLobby(entrance.whichLobby);
			entrance.Panel.addChild(uiLobby.ui);
			entrance.onSize();
		}
		
		public function onUserLeave(user:String):void
		{
			uiLobby.onUserLeave(user);
		}
		
	}
}