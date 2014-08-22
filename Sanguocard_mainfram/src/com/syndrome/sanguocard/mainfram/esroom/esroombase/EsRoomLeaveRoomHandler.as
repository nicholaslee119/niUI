package com.syndrome.sanguocard.mainfram.esroom.esroombase
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.LeaveRoomEvent;
	import com.electrotank.electroserver5.api.MessageType;

	public class EsRoomLeaveRoomHandler extends EsRoomHandlerBase
	{
		
		public function EsRoomLeaveRoomHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.LeaveRoomEvent.name, onLeaveRoomEvent);
		}
		
		protected function onLeaveRoomEvent(e:LeaveRoomEvent):void{}
	}
}