package com.syndrome.sanguocard.mainfram.esroom.esroombase
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.GetUsersInRoomResponse;
	import com.electrotank.electroserver5.api.MessageType;
	
	/*
	* @author nic
	* @build-time 2014-7-8
	* @comments
	*
	*/
	public class EsRoomGetUsersInRoomHandler extends EsRoomHandlerBase
	{
		public function EsRoomGetUsersInRoomHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.GetUsersInRoomResponse.name, onGetUsersInRoomResponse);
		}
		
		protected function onGetUsersInRoomResponse(e:GetUsersInRoomResponse):void{}
		
	}
}