package com.syndrome.sanguocard.mainfram.main
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.GenericErrorResponse;
	import com.electrotank.electroserver5.api.MessageType;
	import com.syndrome.client.parameters.PublicParameters;
	import com.syndrome.sanguocard.mainfram.ui.AlertPanel;
	
	/*
	* @author nic
	* @build-time 2014-4-26
	* @comments
	*
	*/
	public class MainGenericErrorHander
	{
		private const RAC:String = "RoomAtCapacity";
		
		
		public function MainGenericErrorHander()
		{
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.GenericErrorResponse.name, onGenericErrorResponse);
		}
		
		private function onGenericErrorResponse(e:GenericErrorResponse):void
		{
			if(PublicParameters.isDebug())trace("[MainGenericErrorHander]: "+e.messageType.name);
			if(e.errorType.name==RAC)
				AlertPanel.creatInstance().show("加入房间已满！", null, null);
		}
	}
}