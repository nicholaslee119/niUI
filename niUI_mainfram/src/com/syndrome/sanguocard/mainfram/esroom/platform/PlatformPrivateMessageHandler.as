package com.syndrome.sanguocard.mainfram.esroom.platform
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.MessageType;
	import com.electrotank.electroserver5.api.PrivateMessageEvent;
	import com.electrotank.electroserver5.api.PrivateMessageRequest;
	import com.electrotank.electroserver5.user.User;
	import com.syndrome.client.enum.EnumGUI;
	import com.syndrome.client.enum.EnumP2PMessageType;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomPrivateMessageHandler;
	
	import flash.external.ExternalInterface;
	
	public class PlatformPrivateMessageHandler extends EsRoomPrivateMessageHandler
	{
		public function PlatformPrivateMessageHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function onPrivateMessageEvent(e:PrivateMessageEvent):void
		{
			if(e.esObject!=null && e.esObject.doesPropertyExist(EnumGUI.NICKNAME) && e.esObject.doesPropertyExist("receivers"))
			{
				var senderNickName:String = e.esObject.getString(EnumGUI.NICKNAME);
				var senderOfficial:String = e.esObject.getString("official");
				var receivers:Array = e.esObject.getStringArray("receivers");
				var receiver:User = GameCom.getInstance().esServer.managerHelper.userManager.userByName(String(receivers[0]));
				ExternalInterface.call("onChatPrivateMessageEvent", '{"senderAccount":"'+e.userName+'","senderOfficial":"'+senderOfficial+'","senderNickName":"'+senderNickName+'","receiverAccount":"'+receiver.userName+'","receiverOfficial":"'+receiver.userVariableByName(Constant.GetUserInfo).value.getString("official")+'","receiverNickName":"'+receiver.userVariableByName(Constant.GetUserInfo).value.getString("surname")+receiver.userVariableByName(Constant.GetUserInfo).value.getString("name")+'","content":"'+e.message+'"}'); 
				PlatformEsRoom(esRoomBase).onPrivateMessage(e.userName, senderNickName, receiver.userName, receiver.userVariableByName(Constant.GetUserInfo).value.getString("surname")+receiver.userVariableByName(Constant.GetUserInfo).value.getString("name"), e.message);
			}else if(e.esObject!=null && e.esObject.doesPropertyExist(EnumP2PMessageType.NAME)){
				ExternalInterface.call("onRemindEvent", e.esObject.getInteger(EnumP2PMessageType.NAME));
			}else{
				ExternalInterface.call("onChatPrivateMessageEvent", "error:something wrong with privateMessageEvent!"); 	
			}
		}
		
		public function sendPrivateChatMessage(chat:String, usersName:Array):void 
		{
			if(chat==null||usersName==null) return;
			var pmr:PrivateMessageRequest = new PrivateMessageRequest();
			var me:User = GameCom.getInstance().esServer.managerHelper.userManager.me;
			pmr.esObject = new EsObject();
			pmr.esObject.setString(EnumGUI.NICKNAME, me.userVariableByName(Constant.GetUserInfo).value.getString("surname")+me.userVariableByName(Constant.GetUserInfo).value.getString("name"));
			pmr.esObject.setString("official", me.userVariableByName(Constant.GetUserInfo).value.getString("official"));
			pmr.esObject.setStringArray("receivers", usersName);
			pmr.message = chat;
			usersName.push(me.userName);
			pmr.userNames = usersName;
			sendPrivateMessage(pmr);
		}
		
		public function sendP2PMessage(type:int, userName:String):void
		{
			if(userName==null) return;
			var pmr:PrivateMessageRequest = new PrivateMessageRequest();
			pmr.esObject = new EsObject();
			pmr.esObject.setInteger(EnumP2PMessageType.NAME, type);
			pmr.userNames = new Array(userName);
			sendPrivateMessage(pmr);
		}
	}
}