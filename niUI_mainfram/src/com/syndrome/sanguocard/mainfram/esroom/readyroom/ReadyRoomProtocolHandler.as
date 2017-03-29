package com.syndrome.sanguocard.mainfram.esroom.readyroom
{
	import com.communication.ComEvent;
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.EsObjectDataHolder;
	import com.syndrome.client.enum.EnumFightType;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomProtocolHandler;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfReadyRoom;
	import com.syndrome.sanguocard.mainfram.ui.AlertPanel;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	import flash.external.ExternalInterface;
	
	public class ReadyRoomProtocolHandler extends EsRoomProtocolHandler
	{
		use namespace ThisIsInterface;
		private const GET_CURRENT_CARDGROUP:String = "getCurrentCardGroup";
		
		public function ReadyRoomProtocolHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function onProtocol(e:ComEvent):void
		{
			// TODO Auto Generated method stub
			super.onProtocol(e);
			var receiveEsObject:EsObject = e.data.data.parameters ;
			if(e.data.data.originRoomId == -1 || e.data.data.originZoneId == -1)
			{
				if(receiveEsObject.doesPropertyExist("tx"))
				{
					if(receiveEsObject.getEsObject("cb").getString("from")!=Constant.SCENE_READYROOM)return;
					switch(receiveEsObject.getString("tx"))
					{
						case Constant.GetCardGroup:
							if(receiveEsObject.getEsObject("cb").getString("action")!="getCardGroup")return;
							InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).onGetCardGroup(receiveEsObject.getEsObject(Constant.GetCardGroup));
							break;
						case Constant.GetPracticeCardGroup:
							InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).onGetCardGroup(receiveEsObject.getEsObject(Constant.GetPracticeCardGroup));
							break;
						case Constant.GetCurrentCardGroup:
							break;
						case Constant.SetCurrentCardGroup:
							InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).onSetCurrentCardGroup(receiveEsObject.getEsObject(Constant.SetCurrentCardGroup));
							break;
						case Constant.CostGameGold:
							handleCGG(receiveEsObject);
							break;
						default:
							break;
					}
					return;
				}
			}
			
			//房间级插件消息
			if(e.data.data.originRoomId == ReadyEsRoom(esRoomBase).roomManager.roomID && e.data.data.originZoneId == ReadyEsRoom(esRoomBase).roomManager.zoneID)
			{
				if(receiveEsObject.doesPropertyExist("a"))
				{
					switch(receiveEsObject.getString("a"))
					{
						case Constant.GameReady:
							handleGS(receiveEsObject.getEsObject(Constant.GameReady));
							break;
						case Constant.GameReadyCancel:
							handleGS(receiveEsObject.getEsObject(Constant.GameReadyCancel));
							break;
						case Constant.GameStauts:
							handleGS(receiveEsObject.getEsObject(Constant.GameStauts));
							break;
						default:
							break;
					}
					return;
				}
			}
		}
		
		private function handleGS(GS:EsObject):void
		{
			for each (var esDate:EsObjectDataHolder in GS.getEntries()) 
			{
				if(esDate.getName()=="gameStatus")return;
				if(esDate.getName()==esRoomBase.roomManager.room.roomVariableByName("roomHost").value.getString("userName"))
					if(esDate.getRawValue()=="READY")
						InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).onGameReadyStatus(GS,true,true);
					else
						InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).onGameReadyStatus(GS,true,false);
				else
					if(esDate.getRawValue()=="READY")
						InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).onGameReadyStatus(GS,false,true);
					else
						InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).onGameReadyStatus(GS,false,false);
			}
		}
		
		private function handleCGG(receiveEsObject:EsObject):void
		{
			if(receiveEsObject.getEsObject(Constant.CostGameGold).getBoolean("_val"))
			{
				ExternalInterface.call("onMeInfoUpdate");
				AlertPanel.creatInstance().showSeconds("匹配成功!", null, null);
			}
			else
				AlertPanel.creatInstance().show("铜线不足！", null, null);
		}
		
		internal function onCancelMatch():void
		{
			ReadyEsRoom(esRoomBase).roomManager.zoneName=Constant.AUTO_LOBBY;
			ReadyEsRoom(esRoomBase).roomManager.roomName=Constant.AUTO_LOBBY_ROOM;
			ReadyEsRoom(esRoomBase).roomManager.pluginName="PairLobbyRoom";
			if(ReadyEsRoom(esRoomBase).roomManager.zone==null)ReadyEsRoom(esRoomBase).roomManager.zone = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneByName(ReadyEsRoom(esRoomBase).roomManager.zoneName);
			ReadyEsRoom(esRoomBase).roomManager.room = ReadyEsRoom(esRoomBase).roomManager.zone.roomByName(ReadyEsRoom(esRoomBase).roomManager.roomName);
			var object:EsObject = new EsObject();
			object.setString("a", "cm");
			sendPackage(object,0);
		}
		
		internal function gameReady(currentCardGroupId:int):void
		{
			var object:EsObject = new EsObject();
			object.setString("a", Constant.GameReady);
			var para:EsObject = new EsObject();
			para.setInteger("cardGroupId", currentCardGroupId);
			object.setEsObject(Constant.GameReady, para);
			sendPackage(object);
		}
		
		internal function gameReadyCancel():void
		{
			var object:EsObject = new EsObject();
			object.setString("a", "grc");
			sendPackage(object);
		}
		
		internal function getGameStatus():void
		{
			var object:EsObject = new EsObject();
			object.setString("a", "ggs");
			sendPackage(object);
		}
		
		internal function getCurrentCardGroup(userName:String):void
		{
			if(ReadyEsRoom(esRoomBase).getWhichLobby()==Constant.PRACTISE_LOBBY)return;
			var object:EsObject = new EsObject();
			object.setString("tx", "cgq");
			var paraObj:EsObject = new EsObject();
			paraObj.setString("_val", userName);
			object.setEsObject("cgq",paraObj)
			var cb:EsObject = new EsObject();
			cb.setString("from", Constant.SCENE_READYROOM);
			cb.setString("action", GET_CURRENT_CARDGROUP);
			object.setEsObject("cb", cb);
			sendServerPackage(object);
		}
		
		internal function getCardGroup():void
		{
			var object:EsObject = new EsObject();
			var whichLobby:String = ReadyEsRoom(esRoomBase).getWhichLobby();
			var fightType:String = ReadyEsRoom(esRoomBase).fightType;
			if((whichLobby==Constant.FREE_LOBBY&&fightType==EnumFightType.FREE) || ReadyEsRoom(esRoomBase).getWhichLobby()==Constant.AUTO_LOBBY)
			{
				object.setString("tx", "cgl");
				var paraObj:EsObject = new EsObject();
				paraObj.setString("_val", GameCom.getInstance().esServer.managerHelper.userManager.me.userName);
				object.setEsObject("cgl",paraObj);
			}else if(whichLobby == Constant.FREE_LOBBY && fightType==EnumFightType.PRACTICE){
				object.setString("tx", "pcg");
			}
			var cb:EsObject = new EsObject();
			cb.setString("from", Constant.SCENE_READYROOM);
			cb.setString("action", "getCardGroup");
			object.setEsObject("cb", cb);
			sendServerPackage(object);
		}
		
		internal function setCurrentCardGroup(userName:String, cardGroupId:int):void
		{
			var object:EsObject = new EsObject();
			object.setString("tx", "cgs");
			var paraObjArray:Array = new Array();
			var paraESObj0:EsObject = new EsObject();
			paraESObj0.setString("_val", userName);
			paraObjArray[0]= paraESObj0;
			var paraESObj1:EsObject = new EsObject();
			paraESObj1.setInteger("_val", cardGroupId);
			paraObjArray[1]= paraESObj1;
			object.setEsObjectArray("cgs", paraObjArray);
			var cb:EsObject = new EsObject();
			cb.setString("from", Constant.SCENE_READYROOM);
			cb.setString("action", "getCardGroup");
			object.setEsObject("cb", cb);
			sendServerPackage(object);
		}
		
	}
}