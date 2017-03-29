package com.syndrome.sanguocard.mainfram.esroom.lobbyroom
{
	import com.electrotank.electroserver5.api.LeaveRoomEvent;
	import com.syndrome.client.parameters.PublicParameters;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomLeaveRoomHandler;
	
	import flash.external.ExternalInterface;
	
	/*
	* @author nic
	* @build-time 2014-5-5
	* @comments
	*
	*/
	public class LobbyLeaveRoomHandler extends EsRoomLeaveRoomHandler
	{
		public function LobbyLeaveRoomHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function onLeaveRoomEvent(e:LeaveRoomEvent):void
		{
			// TODO Auto Generated method stub
			super.onLeaveRoomEvent(e);
			if(e.roomId!=LobbyEsRoom(esRoomBase).roomManager.roomID || e.zoneId!=LobbyEsRoom(esRoomBase).roomManager.zoneID)return;
			LobbyEsRoom(esRoomBase).clearAllInvition();
			if(PublicParameters.isDebug()){
				LobbyEsRoom(esRoomBase).interfaceOfSon.sonProject.visible = false;
				LobbyEsRoom(esRoomBase).esRoomManager.hidePlatform();
				LobbyEsRoom(esRoomBase).stopTimer();
			}else{
				ExternalInterface.call("onReturnTown");
			}
		}
	}
}