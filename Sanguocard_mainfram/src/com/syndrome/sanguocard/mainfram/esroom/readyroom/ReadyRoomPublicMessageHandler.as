package com.syndrome.sanguocard.mainfram.esroom.readyroom
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.PublicMessageEvent;
	import com.electrotank.electroserver5.api.PublicMessageRequest;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomPublicMessageHandler;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	public class ReadyRoomPublicMessageHandler extends EsRoomPublicMessageHandler
	{
		use namespace ThisIsInterface;
		
		public function ReadyRoomPublicMessageHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function onGetOpPros(pros:Number):void
		{
			// TODO Auto Generated method stub
			super.onGetOpPros(pros);
			ReadyEsRoom(esRoomBase).esRoomManager.readyOnGetOpPros(pros);
		}
		
		internal function dispatchPros(pros:Number):void
		{
			if(!GameCom.getInstance().esServer.engine.connected) return;
			var pmr:PublicMessageRequest = new PublicMessageRequest();
			var es:EsObject = new EsObject();
			es.setFloat("pros", pros);
			pmr.esObject = es;
			pmr.message = "pros";
			if(ReadyEsRoom(esRoomBase).roomManager.room == null)trace("room is null");
			pmr.roomId = ReadyEsRoom(esRoomBase).roomManager.room.id;
			pmr.zoneId = ReadyEsRoom(esRoomBase).roomManager.room.zoneId ;				
			GameCom.getInstance().esServer.engine.send( pmr );
		}
	}
}