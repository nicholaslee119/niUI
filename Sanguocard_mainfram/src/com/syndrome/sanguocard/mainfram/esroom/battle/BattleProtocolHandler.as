package com.syndrome.sanguocard.mainfram.esroom.battle
{
	import com.communication.ComEvent;
	import com.communication.EventObj;
	import com.electrotank.electroserver5.api.EsObject;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomProtocolHandler;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfBattle;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	public class BattleProtocolHandler extends EsRoomProtocolHandler
	{
		use namespace ThisIsInterface;
		
		public function BattleProtocolHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function onProtocol(e:ComEvent):void
		{
			// TODO Auto Generated method stub
			super.onProtocol(e);
			if(e.data.data.originRoomId != BattleEsRoom(esRoomBase).roomManager.roomID || e.data.data.originZoneId != BattleEsRoom(esRoomBase).roomManager.zoneID) return;
			if(e.data.data.parameters == null) return;
			switch(e.data.data.parameters.getString("a"))
			{
				case Constant.HEARTBEAT:
					//TODO 心跳消息的解析
					handleHB(e.data.data.parameters);
					break;
				case Constant.GameStart:
					break;
				case Constant.GameReady:
					break;
				case "f":
				{
					var str:String  = e.data.data.parameters.getEsObject("f").getString("_val");
					var json:Object = JSON.parse(str);
					if(json["id"]==10099)
						json["meName"] = esRoomBase.usersManager.meUser.userName;
					esRoomBase.interfaceOfSon.onProtocol(json);
					break;
				}
				default:
					break;
			}
		}
		
		private function handleHB(hb:EsObject):void
		{
			if(!hb.doesPropertyExist(Constant.HEARTBEAT))return;
			var hbESObject:Array = hb.getEsObjectArray(Constant.HEARTBEAT);
			if(EsObject(hbESObject[0]).getString("_val")=="PLAYING" && EsObject(hbESObject[1]).getEsObjectArray("_val").length==1)
			{
//				InterfaceOfBattle(BattleEsRoom(esRoomBase).interfaceOfSon).onOpUserDisconnect();
			}
		}
		
		internal function leaveGame():void
		{
			var esObj:EsObject = new EsObject();
			esObj.setString("a", Constant.GameOver);
			sendPackage(esObj);
		}
		
		internal function gameStart():void
		{
			var esObj:EsObject = new EsObject();
			esObj.setString("a", Constant.GameStart);
			sendPackage(esObj);
		}
	}
}