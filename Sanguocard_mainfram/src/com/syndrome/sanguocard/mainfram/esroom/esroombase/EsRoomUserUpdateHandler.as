package com.syndrome.sanguocard.mainfram.esroom.esroombase
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.MessageType;
	import com.electrotank.electroserver5.api.UserUpdateEvent;
	
	/*
	* @author nic
	* @build-time 2014-7-8
	* @comments
	*
	*/
	public class EsRoomUserUpdateHandler extends EsRoomHandlerBase
	{
		public function EsRoomUserUpdateHandler(_esRoomBase:EsRoomBase)
		{
			//TODO: implement function
			super(_esRoomBase);
		}
		
		final override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.UserUpdateEvent.name, onUserUpdateEvent);
		}
		
		protected function onUserUpdateEvent(e:UserUpdateEvent):void{}
		
		
	}
}