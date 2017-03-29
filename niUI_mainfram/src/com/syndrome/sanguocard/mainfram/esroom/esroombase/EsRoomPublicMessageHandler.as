package com.syndrome.sanguocard.mainfram.esroom.esroombase
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.MessageType;
	import com.electrotank.electroserver5.api.PublicMessageEvent;
	import com.electrotank.electroserver5.api.PublicMessageRequest;
	import com.syndrome.client.enum.EnumGUI;
	import com.syndrome.client.parameters.Constant;
	
	import flash.external.ExternalInterface;

	public class EsRoomPublicMessageHandler extends EsRoomHandlerBase
	{
		public function EsRoomPublicMessageHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.PublicMessageEvent.name, onPublicMessageEvent);
		}
		
		protected function onPublicMessageEvent(e:PublicMessageEvent):void
		{
			if(e.roomId != esRoomBase.roomManager.roomID || e.zoneId != esRoomBase.roomManager.zoneID) return;
			if(e.message=="pros" && e.userName != esRoomBase.usersManager.meUser.userName)
			{
				onGetOpPros(e.esObject.getFloat("pros"));
			}else if(e.message!="pros"){
				var gui:EsObject = esRoomBase.usersManager.findUser(e.userName).userVariableByName(Constant.GetUserInfo).value;
				var wholeName:String = gui.getString("surname") + gui.getString("name");
				ExternalInterface.call("onChatMessageEvent", '{"account":"'+e.userName+'","official":"'+gui.getString("official")+'","'+EnumGUI.NICKNAME+'":"'+wholeName+'","content":"'+e.message+'","zoneId":"'+e.zoneId+'","roomId":"'+e.roomId+'"}')
			}
		}
		
		public function sendPublicMessage(ChatContent:String):Boolean
		{
			if(!GameCom.getInstance().esServer.engine.connected) return false;
			var pmr:PublicMessageRequest = new PublicMessageRequest();
			if(GameCom.getInstance().esServer.managerHelper.userManager.me.userVariableByName(Constant.GetUserInfo)!=null)
			{
				esRoomBase.usersManager.meNickName = GameCom.getInstance().esServer.managerHelper.userManager.me.userVariableByName(Constant.GetUserInfo).value.getString("surname")
													+GameCom.getInstance().esServer.managerHelper.userManager.me.userVariableByName(Constant.GetUserInfo).value.getString("name");
				var es:EsObject = new EsObject();
				es.setString(EnumGUI.NICKNAME, esRoomBase.usersManager.meNickName);
				pmr.esObject = es;
			}
			pmr.message = ChatContent;
			if(esRoomBase.roomManager.room == null)trace("room is null");
			pmr.roomId = esRoomBase.roomManager.room.id;
			pmr.zoneId = esRoomBase.roomManager.room.zoneId ;				
			GameCom.getInstance().esServer.engine.send( pmr );
			return true;
		}
		
		protected function onGetOpPros(pros:Number):void{};
		
	}
}