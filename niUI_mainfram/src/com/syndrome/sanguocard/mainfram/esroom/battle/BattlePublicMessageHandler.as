package com.syndrome.sanguocard.mainfram.esroom.battle
{
	import com.electrotank.electroserver5.api.PublicMessageEvent;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.client.parameters.PublicParameters;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomPublicMessageHandler;
	
	
	/*
	* @author nic
	* @build-time 2014-3-21
	* @comments
	*
	*/
	public class BattlePublicMessageHandler extends EsRoomPublicMessageHandler
	{
		public function BattlePublicMessageHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function onPublicMessageEvent(e:PublicMessageEvent):void
		{
			// TODO Auto Generated method stub
			super.onPublicMessageEvent(e);
			if(e.roomId != BattleEsRoom(esRoomBase).roomManager.roomID || e.zoneId != BattleEsRoom(esRoomBase).roomManager.zoneID) return;
			if(e.message!="pros"){
				BattleEsRoom(esRoomBase).onChannelMessage(esRoomBase.usersManager.findUser(e.userName), e, Constant.CHANNEL_FIGHT);
			}
		}
	}
}