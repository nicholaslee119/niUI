package com.syndrome.sanguocard.mainfram.esroom.platform
{
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.PublicMessageEvent;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomPublicMessageHandler;
	
	public class PlatformPublicMessageHandler extends EsRoomPublicMessageHandler
	{
		public function PlatformPublicMessageHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function onGetOpPros(pros:Number):void
		{
			// TODO Auto Generated method stub
			super.onGetOpPros(pros);
		}
		
		override protected function onPublicMessageEvent(e:PublicMessageEvent):void
		{
			// TODO Auto Generated method stub
			super.onPublicMessageEvent(e);
			if(e.roomId != PlatformEsRoom(esRoomBase).roomManager.roomID || e.zoneId != PlatformEsRoom(esRoomBase).roomManager.zoneID) return;
			PlatformEsRoom(esRoomBase).esRoomManager.platformOnPublicMessageEvent(esRoomBase.usersManager.findUser(e.userName), e);
		}
	}
}