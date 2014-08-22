package com.syndrome.sanguocard.mainfram.esroom.readyroom
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.CreateOrJoinGameResponse;
	import com.electrotank.electroserver5.api.MessageType;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomHandlerBase;
	
	
	/*
	* @author nic
	* @build-time 2014-4-10
	* @comments
	*
	*/
	public class ReadyRoomGameEventHandler extends EsRoomHandlerBase
	{
		public function ReadyRoomGameEventHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.CreateOrJoinGameResponse.name,  onCreateOrJoinGameResponse);
		}
		
		private function onCreateOrJoinGameResponse(e:CreateOrJoinGameResponse):void {
			if(e.roomId!=ReadyEsRoom(esRoomBase).roomManager.roomID)return;
			ReadyEsRoom(esRoomBase).roomManager.gameId = e.gameId;
		}
	}
}