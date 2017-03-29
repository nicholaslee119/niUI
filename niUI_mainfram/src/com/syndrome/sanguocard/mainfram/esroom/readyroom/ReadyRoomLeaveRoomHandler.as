package com.syndrome.sanguocard.mainfram.esroom.readyroom
{
	import com.electrotank.electroserver5.api.LeaveRoomEvent;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomLeaveRoomHandler;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfReadyRoom;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	public class ReadyRoomLeaveRoomHandler extends EsRoomLeaveRoomHandler
	{
		use namespace ThisIsInterface;
		
		public function ReadyRoomLeaveRoomHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function onLeaveRoomEvent(e:LeaveRoomEvent):void
		{
			// TODO Auto Generated method stub
			super.onLeaveRoomEvent(e);
			if(e.roomId!=ReadyEsRoom(esRoomBase).roomManager.roomID || e.zoneId!=ReadyEsRoom(esRoomBase).roomManager.zoneID)return;
			InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).initUI(ReadyEsRoom(esRoomBase).getWhichLobby());
			ReadyEsRoom(esRoomBase).esRoomManager.readyEnterLobby();
			ReadyEsRoom(esRoomBase).esRoomManager.switchUserStatus(Constant.USER_STATUS_IDLE);
			InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).leaveRoomCompleted();
		}
	}
}