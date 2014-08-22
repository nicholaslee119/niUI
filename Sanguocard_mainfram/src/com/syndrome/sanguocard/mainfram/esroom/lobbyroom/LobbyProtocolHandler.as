package com.syndrome.sanguocard.mainfram.esroom.lobbyroom
{
	import com.communication.ComEvent;
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomProtocolHandler;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfLobby;
	import com.syndrome.sanguocard.mainfram.ui.AlertPanel;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	public class LobbyProtocolHandler extends EsRoomProtocolHandler
	{
		use namespace ThisIsInterface;
		private var GET_FRIENDS_LIST:String = "getFriendsList";
		
		public function LobbyProtocolHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function onProtocol(e:ComEvent):void
		{
			// TODO Auto Generated method stub
			super.onProtocol(e);
			if(e.data.data.originRoomId == -1 || e.data.data.originZoneId == -1)
			{
				//收到服务器级插件消息
				var receiveEsObject:EsObject = e.data.data.parameters;
				if(receiveEsObject.doesPropertyExist("cb") && receiveEsObject.getEsObject("cb").getString("from")!=Constant.SCENE_LOBBY)return;
				if(receiveEsObject.doesPropertyExist("tx"))
				{
					switch(receiveEsObject.getString("tx"))
					{
						case Constant.GetUserInfo:
							if( receiveEsObject.getEsObject("cb").doesPropertyExist("which") && receiveEsObject.getEsObject("cb").getString("which")=="me" )
								LobbyEsRoom(esRoomBase).usersManager.meNickName = receiveEsObject.getEsObject(Constant.GetUserInfo).getString("surname")+receiveEsObject.getEsObject(Constant.GetUserInfo).getString("name");
							handleGUI(receiveEsObject);
							break;
						case Constant.GetFriendsList:
							handleSFN(receiveEsObject);
							break;
						case Constant.GetCardGroup:
							handleCGL(receiveEsObject);
							break;
						case Constant.GetCurrentCardGroup:
							handleCGQ(receiveEsObject);
							break;
						case Constant.SetCurrentCardGroup:
							handleCGS(receiveEsObject);
							break;
						default:
							break;
					}
				}
				return;
			}
			if(e.data.data.originRoomId == LobbyEsRoom(esRoomBase).roomManager.roomID && e.data.data.originZoneId == LobbyEsRoom(esRoomBase).roomManager.zoneID) 
			{
				//处理大厅消息
				if(e.data.data.parameters.doesPropertyExist("a"))
				{
					switch(e.data.data.parameters.getString("a"))
					{
						case "rg":
							handleRG(e.data.data.parameters);
							break;
						default:
							break;
					}
				}
				return;
			}
		}
		
		private function handleRG(receiveEsObject:EsObject):void
		{
			AlertPanel.creatInstance().show("是否继续掉线前战斗？", comfirm, null);
			function comfirm(e:MouseEvent):void
			{
				if(!receiveEsObject.doesPropertyExist("rg"))return;
				var rg:EsObject = receiveEsObject.getEsObject("rg");
				LobbyEsRoom(esRoomBase).rejoinGame(rg.getInteger("roomId"), rg.getInteger("zoneId"));
			}
		}
		
		private function handleGUI(receiveEsObject:EsObject):void
		{
			if(receiveEsObject.getEsObject("cb").getString("action")==GET_FRIENDS_LIST)
			{
				if(GameCom.getInstance().esServer.managerHelper.userManager.doesUserExist(receiveEsObject.getEsObject(Constant.GetUserInfo).getString("account")))
				{
					receiveEsObject.getEsObject(Constant.GetUserInfo).setBoolean("online", true);
					LobbyEsRoom(esRoomBase).interfaceOfSon.onGetFriendsList(receiveEsObject, GameCom.getInstance().esServer.managerHelper.userManager.userByName(receiveEsObject.getEsObject(Constant.GetUserInfo).getString("account")));
				}
				else{
					receiveEsObject.getEsObject(Constant.GetUserInfo).setBoolean("online", false);
					LobbyEsRoom(esRoomBase).interfaceOfSon.onGetFriendsList(receiveEsObject);
				}
			}
		}
		
		private function handleSFN(receiveEsObject:EsObject):void
		{
			if(receiveEsObject.getEsObject("cb").getString("action")==GET_FRIENDS_LIST)
			{
				var friends:Array = receiveEsObject.getEsObject(Constant.GetFriendsList).getStringArray("_val");
				if(friends.length!=0)
				{
					for each (var userName:String in friends) 
					{
						var cb:EsObject = new EsObject();
						cb.setString("from", Constant.SCENE_LOBBY);
						cb.setString("action", GET_FRIENDS_LIST);
						LobbyEsRoom(esRoomBase).getUserInfo(userName, cb);
					}
				}
			}
		}
		
		private function handleCGL(receiveEsObject:EsObject):void
		{
			if(receiveEsObject.getEsObject("cb").getString("action")!="getCardGroup")return;
			InterfaceOfLobby(LobbyEsRoom(esRoomBase).interfaceOfSon).onGetCardGroup(receiveEsObject.getEsObject(Constant.GetCardGroup));
		}
		
		private function handleCGQ(receiveEsObject:EsObject):void
		{
			if(receiveEsObject.getEsObject("cb").getString("action")!="getCurrentCardGroup")return;
			InterfaceOfLobby(LobbyEsRoom(esRoomBase).interfaceOfSon).onGetCurrentCardGroup(receiveEsObject.getEsObject(Constant.GetCurrentCardGroup));
		}
		
		private function handleCGS(receiveEsObject:EsObject):void
		{
			InterfaceOfLobby(LobbyEsRoom(esRoomBase).interfaceOfSon).onSetCurrentCardGroup(receiveEsObject.getEsObject(Constant.SetCurrentCardGroup));
		}
		
		public function getUserInfo(userName:String, cb:EsObject):void
		{
			var object:EsObject = new EsObject();
			object.setString("tx", Constant.GetUserInfo);
			object.setEsObject("cb", cb);
			var paraObj:EsObject = new EsObject();
			paraObj.setString("_val", userName);
			object.setEsObject("gui",paraObj)
			sendServerPackage(object);
		}
		
		internal function getCurrentCardGroup():void
		{
			var object:EsObject = new EsObject();
			object.setString("tx", "cgq");
			var paraObj:EsObject = new EsObject();
			paraObj.setString("_val", GameCom.getInstance().esServer.managerHelper.userManager.me.userName);
			object.setEsObject("cgq",paraObj);
			var cb:EsObject = new EsObject();
			cb.setString("from", Constant.SCENE_LOBBY);
			cb.setString("action", "getCurrentCardGroup");
			object.setEsObject("cb", cb);
			sendServerPackage(object);
		}
		
		public function getCardGroup():void
		{
			var object:EsObject = new EsObject();
			object.setString("tx", "cgl");
			var paraObj:EsObject = new EsObject();
			paraObj.setString("_val", GameCom.getInstance().esServer.managerHelper.userManager.me.userName);
			object.setEsObject("cgl",paraObj);
			var cb:EsObject = new EsObject();
			cb.setString("from", Constant.SCENE_LOBBY);
			cb.setString("action", "getCardGroup");
			object.setEsObject("cb", cb);
			sendServerPackage(object);
		}
		
		internal function setCurrentCardGroup(cardGroupId:int):void
		{
			var object:EsObject = new EsObject();
			object.setString("tx", "cgs");
			var paraObjArray:Array = new Array();
			var paraESObj0:EsObject = new EsObject();
			paraESObj0.setString("_val", GameCom.getInstance().esServer.managerHelper.userManager.me.userName);
			paraObjArray[0]= paraESObj0;
			var paraESObj1:EsObject = new EsObject();
			paraESObj1.setInteger("_val", cardGroupId);
			paraObjArray[1]= paraESObj1;
			object.setEsObjectArray("cgs", paraObjArray);
			var cb:EsObject = new EsObject();
			cb.setString("from", Constant.SCENE_LOBBY);
			cb.setString("action", "setCurrentCardGroup");
			object.setEsObject("cb", cb);
			sendServerPackage(object);
		}
		
		public function getFriendsList():void
		{
			var object:EsObject = new EsObject();
			object.setString("tx", Constant.GetFriendsList);
			var cb:EsObject = new EsObject();
			cb.setString("from", Constant.SCENE_LOBBY);
			cb.setString("action", GET_FRIENDS_LIST);
			var paraObj:EsObject = new EsObject();
			paraObj.setString("_val", GameCom.getInstance().esServer.managerHelper.userManager.me.userName);
			object.setEsObject("sfn", paraObj);
			object.setEsObject("cb", cb);
			sendServerPackage(object);
		}
	}
}