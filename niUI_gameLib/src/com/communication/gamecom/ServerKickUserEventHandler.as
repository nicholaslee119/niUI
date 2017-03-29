package com.communication.gamecom
{
	import com.electrotank.electroserver5.api.MessageType;
	import com.electrotank.electroserver5.api.ServerKickUserEvent;
	import com.syndrome.client.parameters.PublicParameters;
	
	import flash.external.ExternalInterface;
	
	/*
	* @author nic
	* @build-time 2014-3-1
	* @comments
	*
	*/
	public class ServerKickUserEventHandler
	{
		public function ServerKickUserEventHandler()
		{
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.ServerKickUserEvent.name, onServerKickUserEvent);
		}
		
		private function onServerKickUserEvent(e:ServerKickUserEvent):void
		{
			if(PublicParameters.isDebug())
				trace("[GameCom]you are kicked from server,the error type is "+e.error.name);
			else
				ExternalInterface.call("onKickedFromServer", e.error.name);	
		}
	}
}