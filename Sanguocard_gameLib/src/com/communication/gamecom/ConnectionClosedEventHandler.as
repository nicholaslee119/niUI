package com.communication.gamecom
{
	import com.communication.ComEvent;
	import com.electrotank.electroserver5.api.ConnectionClosedEvent;
	import com.electrotank.electroserver5.api.ConnectionResponse;
	import com.electrotank.electroserver5.api.MessageType;
	
	import flash.external.ExternalInterface;
	
	/*
	* @author nic
	* @build-time 2014-3-1
	* @comments
	*
	*/
	public class ConnectionClosedEventHandler
	{
		public function ConnectionClosedEventHandler()
		{
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.ConnectionClosedEvent.name, onConnectionClosedEvent);
		}
		
		private function onConnectionClosedEvent(e:ConnectionClosedEvent):void
		{
			GameCom.getInstance().esServer.engine.removeEventListener(MessageType.ConnectionClosedEvent.name, onConnectionClosedEvent);
			GameCom.getInstance().sendMsg(ComEvent.CONNECTCUT,null,false,"onConnectionClosedEvent");
			ExternalInterface.call("onConnectionClosedEvent");
		}
	}
}