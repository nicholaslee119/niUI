package com.syndrome.sanguo.readyroom
{
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.user.User;
	import com.syndrome.sanguo.readyroom.ui.UIReadyRoom;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Main
	{
		public var entrance:ReadyRoom = null;
		public var uiReadyRoom:UIReadyRoom = null;
		public var whichLobby:String;
		
		public function Main(_entrance:ReadyRoom)
		{
			entrance = _entrance;
			init();
		}
		
		private function init():void
		{
			uiReadyRoom = UIReadyRoom.CreateInstance(this);
			entrance.Panel.addChild(uiReadyRoom.ui);
			entrance.onSize();
		}
		
	}
}