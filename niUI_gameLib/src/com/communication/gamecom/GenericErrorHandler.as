package com.communication.gamecom
{
	import com.electrotank.electroserver5.api.GenericErrorResponse;
	import com.electrotank.electroserver5.api.MessageType;
	import com.syndrome.client.parameters.PublicParameters;
	
	import flash.external.ExternalInterface;
	
	/*
	* @author nic
	* @build-time 2014-3-1
	* @comments
	*
	*/
	public class GenericErrorHandler
	{
		public function GenericErrorHandler()
		{
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.GenericErrorResponse.name, onGenericErrorResponse);
		}
		
		private function onGenericErrorResponse(e:GenericErrorResponse):void
		{
			if(PublicParameters.isDebug())
				trace("[onGenericErrorResponse]: "+e.messageType.name);
			else
				ExternalInterface.call("onGenericErrorResponse", e.messageType.name);
		}
	}
}