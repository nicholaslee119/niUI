package com.syndrome.sanguocard.mainfram.esroom.platform
{
	import com.communication.ComEvent;
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.UpdateUserVariableRequest;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguocard.mainfram.enum.EnumCheckTask;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomProtocolHandler;
	
	import flash.external.ExternalInterface;
	
	public class PlatformProtocolHandler extends EsRoomProtocolHandler
	{
		protected var hasReceivedHB:Boolean = false;
		
		public function PlatformProtocolHandler(_esRoomBase:EsRoomBase)
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
				//收到服务器级插件消息
				if(receiveEsObject.doesPropertyExist("tx"))
				{
					switch(receiveEsObject.getString("tx"))
					{
						case Constant.GetUserInfo:
							if( receiveEsObject.getEsObject("cb").getString("from")!=Constant.SCENE_PLATFORM )return;
							if( receiveEsObject.getEsObject("cb").doesPropertyExist("which") && receiveEsObject.getEsObject("cb").getString("which")=="me" )
							{
								PlatformEsRoom(esRoomBase).usersManager.meNickName = receiveEsObject.getEsObject(Constant.GetUserInfo).getString("surname")+receiveEsObject.getEsObject(Constant.GetUserInfo).getString("name");
								PlatformEsRoom(esRoomBase).updataUserVariable(receiveEsObject.getEsObject(Constant.GetUserInfo));
							}
						default:
							break;
					}
					return;
				}
				//任务消息
				if(receiveEsObject.doesPropertyExist("task"))
				{
					var userTaskId:int = receiveEsObject.getEsObject("task").getInteger("userTaskId");
					var goal:String = receiveEsObject.getEsObject("task").getString("goal");
					var isComplete:Boolean = receiveEsObject.getEsObject("task").getBoolean("isComplete");
					ExternalInterface.call(EnumCheckTask.API_CHECK_TASK, userTaskId, goal, isComplete);
				}
			}
			else if(e.data.data.originRoomId == PlatformEsRoom(esRoomBase).roomManager.roomID && e.data.data.originZoneId == PlatformEsRoom(esRoomBase).roomManager.zoneID) 
			{
				//处理平台消息
				if(e.data.data.parameters.doesPropertyExist("a"))
				{
					switch(e.data.data.parameters.getString("a"))
					{
						case Constant.HEARTBEAT:
							//TODO 心跳消息的解析
							handleHB(e.data.data.parameters);
							break;
						default:
							break;
					}
				}
				return;
			}
		}
		
		private function handleHB(hb:EsObject):void
		{
			if(!hb.doesPropertyExist(Constant.HEARTBEAT))return;
			hasReceivedHB = true;
		}
		
		public function onCheckHeartBeatReceived():void
		{
			if(hasReceivedHB)
				hasReceivedHB = false;
			else{
				//做掉线处理
//				ExternalInterface.call("onConnectionClosedEvent");
				trace("掉线！");
			}
				
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
		
	}
}