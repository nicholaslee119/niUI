package com.syndrome.sanguocard.mainfram.esroom.esroombase
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.JoinRoomEvent;
	import com.electrotank.electroserver5.api.MessageType;

	public class EsRoomJoinRoomHandler extends EsRoomHandlerBase
	{
		public function EsRoomJoinRoomHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.JoinRoomEvent.name, onJoinRoomEvent);
		}
		
		protected function onJoinRoomEvent(e:JoinRoomEvent):void{}
		
		public function joinRoomORcreateRoom(_room:String, _zone:String, gameId:int, pwd:String, create:Boolean):void
		{
			esRoomBase.reBindingChat();
		}
	}
}