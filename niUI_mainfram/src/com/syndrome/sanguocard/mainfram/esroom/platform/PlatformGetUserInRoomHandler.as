package com.syndrome.sanguocard.mainfram.esroom.platform
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.GetUsersInRoomRequest;
	import com.electrotank.electroserver5.api.GetUsersInRoomResponse;
	import com.electrotank.electroserver5.api.UserListEntry;
	import com.electrotank.electroserver5.zone.Room;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomGetUsersInRoomHandler;
	
	import flash.external.ExternalInterface;
	
	
	/*
	* @author nic
	* @build-time 2014-7-8
	* @comments
	*
	*/
	public class PlatformGetUserInRoomHandler extends EsRoomGetUsersInRoomHandler
	{
		public function PlatformGetUserInRoomHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			ExternalInterface.addCallback("RequestOnlineList", this.getUsersInRoom);
		}
		
		override protected function onGetUsersInRoomResponse(e:GetUsersInRoomResponse):void
		{
			// TODO Auto Generated method stub
			super.onGetUsersInRoomResponse(e);
			var room:Room = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(e.zoneId).roomById(e.roomId);
			var zoneName:String = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(e.zoneId).name;
			var users:Array = new Array();
			for each (var ule:UserListEntry in e.users)
				users.push(ule.userName);
			ExternalInterface.call("onRequestOnlineList", users);
		}
		
		public function getUsersInRoom():void
		{
			var guir:GetUsersInRoomRequest = new GetUsersInRoomRequest();
			guir.zoneId = PlatformEsRoom(esRoomBase).roomManager.zoneID;
			guir.roomId = PlatformEsRoom(esRoomBase).roomManager.roomID;
			GameCom.getInstance().esServer.engine.send(guir);
		}
	}
}