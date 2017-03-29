package com.syndrome.sanguocard.mainfram.esroom.lobbyroom
{
	import com.electrotank.electroserver5.api.PublicMessageEvent;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomPublicMessageHandler;
	
	public class LobbyPublicMessageHandler extends EsRoomPublicMessageHandler
	{
		public function LobbyPublicMessageHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function onPublicMessageEvent(e:PublicMessageEvent):void
		{
			// TODO Auto Generated method stub
			super.onPublicMessageEvent(e);
			if(e.roomId != LobbyEsRoom(esRoomBase).roomManager.roomID || e.zoneId != LobbyEsRoom(esRoomBase).roomManager.zoneID) return;
			LobbyEsRoom(esRoomBase).esRoomManager.lobbyOnPublicMessageEvent(esRoomBase.usersManager.findUser(e.userName), e);
		}
		
	}
}