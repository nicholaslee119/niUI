package com.syndrome.sanguocard.mainfram.esroom.platform
{
	import com.electrotank.electroserver5.api.UserUpdateAction;
	import com.electrotank.electroserver5.api.UserUpdateEvent;
	import com.electrotank.electroserver5.user.User;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomUserUpdateHandler;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfPlatform;
	
	import flash.external.ExternalInterface;
	
	
	/*
	* @author nic
	* @build-time 2014-7-8
	* @comments
	*
	*/
	public class PlatformUserUpdateHandler extends EsRoomUserUpdateHandler
	{
		public function PlatformUserUpdateHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function onUserUpdateEvent(e:UserUpdateEvent):void
		{
			// TODO Auto Generated method stub
			super.onUserUpdateEvent(e);
			if(e.zoneId != PlatformEsRoom(esRoomBase).roomManager.zoneID)return;
			var user:User = null;
			switch (e.action) 
			{
				case UserUpdateAction.AddUser:
					user = PlatformEsRoom(esRoomBase).usersManager.findUser(e.userName);
					if(user!=null && e.roomId == PlatformEsRoom(esRoomBase).roomManager.roomID)
					{
						ExternalInterface.call("onUpdateOnlineUser", 1, user.userName);
					}
					break;
				case UserUpdateAction.DeleteUser:
					if(e.roomId == PlatformEsRoom(esRoomBase).roomManager.roomID)
					{
						ExternalInterface.call("onUpdateOnlineUser", 0, e.userName);
					}
					break;
				default:
					trace("LobbyEsRoom: Action not handled: " + e.action.name);
					break;
			}
		}
	}
}