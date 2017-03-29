package com.syndrome.sanguocard.mainfram.esroom.esroombase
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.MessageType;
	import com.electrotank.electroserver5.api.PrivateMessageEvent;
	import com.electrotank.electroserver5.api.PrivateMessageRequest;
	
	/*
	* @author nic
	* @build-time 2014-4-10
	* @comments
	* 
	*/
	public class EsRoomPrivateMessageHandler extends EsRoomHandlerBase
	{
		public function EsRoomPrivateMessageHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.PrivateMessageEvent.name, onPrivateMessageEvent);
		}
		
		protected function onPrivateMessageEvent(e:PrivateMessageEvent):void
		{
		}
		
		public function sendPrivateMessage(pmr:PrivateMessageRequest):void 
		{
			GameCom.getInstance().esServer.engine.send(pmr);
		}
		
	}
}