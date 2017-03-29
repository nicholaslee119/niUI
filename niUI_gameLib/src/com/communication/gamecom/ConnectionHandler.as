package com.communication.gamecom
{
	import com.communication.ComEvent;
	import com.electrotank.electroserver5.api.ConnectionResponse;
	import com.electrotank.electroserver5.api.MessageType;
	import com.load.xmlmanager.XMLManager;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.client.parameters.PublicParameters;
	
	import flash.external.ExternalInterface;
	
	/*
	* @author nic
	* @build-time 2014-3-1
	* @comments
	*
	*/
	public class ConnectionHandler
	{
		public function ConnectionHandler()
		{
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.ConnectionResponse.name, onConnectionResponse);
		}
		
		internal function connect():void
		{
			GameCom.getInstance().esServer.loadAndConnect(XMLManager.getUrlByName(Constant.ES_SETTINGS));
		}
		
		private function onConnectionResponse(e:ConnectionResponse):void
		{
			GameCom.getInstance().esServer.engine.removeEventListener(MessageType.ConnectionResponse.name, onConnectionResponse);
			if(e.error!=null)
			{
				GameCom.getInstance().sendMsg(ComEvent.CONNECTED,null,e.successful,e.error.name);
				ExternalInterface.call("onConnection",e.error.name);
			}
			else{
				GameCom.getInstance().sendMsg(ComEvent.CONNECTED,null,e.successful,"onConnectionResponse");
				ExternalInterface.call("onConnection","success!");
			}
		}
	}
}