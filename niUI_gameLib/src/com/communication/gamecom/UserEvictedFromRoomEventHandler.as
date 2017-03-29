package com.communication.gamecom
{
	import com.electrotank.electroserver5.api.MessageType;
	import com.electrotank.electroserver5.api.UserEvictedFromRoomEvent;
	import com.electrotank.electroserver5.zone.Zone;
	import com.syndrome.client.parameters.Constant;
	
	/*
	* @author nic
	* @build-time 2014-3-1
	* @comments
	*
	*/
	public class UserEvictedFromRoomEventHandler
	{
		public function UserEvictedFromRoomEventHandler()
		{
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.UserEvictedFromRoomEvent.name, onUserEvictedFromRoomEvent);
		}
		
		private function onUserEvictedFromRoomEvent(e:UserEvictedFromRoomEvent):void
		{
			trace("[UserEvictedFromRoomEventHandler]: "+e.reason);
			var zone:Zone = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneByName(Constant.AUTO_LOBBY);
		}
	}
}