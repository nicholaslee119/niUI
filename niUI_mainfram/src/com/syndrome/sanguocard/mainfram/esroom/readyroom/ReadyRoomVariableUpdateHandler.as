package com.syndrome.sanguocard.mainfram.esroom.readyroom
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.CreateRoomVariableRequest;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.MessageType;
	import com.electrotank.electroserver5.api.RoomVariable;
	import com.electrotank.electroserver5.api.RoomVariableUpdateAction;
	import com.electrotank.electroserver5.api.RoomVariableUpdateEvent;
	import com.electrotank.electroserver5.api.UpdateRoomVariableRequest;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.syndrome.client.enum.EnumFightType;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfReadyRoom;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	public class ReadyRoomVariableUpdateHandler extends ReadyRoomHandlerBase
	{
		use namespace ThisIsInterface;
		
		public function ReadyRoomVariableUpdateHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.RoomVariableUpdateEvent.name, onRoomVariableUpdateEvent);
		}
		
		private function onRoomVariableUpdateEvent(e:RoomVariableUpdateEvent):void
		{
			var room:Room = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(e.zoneId).roomById(e.roomId);
			if(room.name==Constant.FREE_LOBBY_ROOM||room.name==Constant.AUTO_LOBBY_ROOM||room.name=="sanguo-practice-lobby-room")return;
			ReadyEsRoom(esRoomBase).roomManager.room = room;
			var roomVar:RoomVariable;
			var user:User;
			var cb:EsObject; 
			switch (e.action) {
				case RoomVariableUpdateAction.VariableCreated:
					onRoomVariableChange();
					ReadyEsRoom(esRoomBase).getGameStatus();
//					this.getCardGroup();
//					this.getCurrentCardGroup();
					trace("[ReadyRoomVariableUpdateHandler]:readyRoom variable created. Name: " + roomVar.name + ", value: " + roomVar.value.toString());
					break;
				case RoomVariableUpdateAction.VariableDeleted:
					trace("[ReadyRoomVariableUpdateHandler]:readyRoom variable deleted. Name: " + e.name);
					break;
				case RoomVariableUpdateAction.VariableUpdated:
					onRoomVariableChange();
					trace("[ReadyRoomVariableUpdateHandler]:readyRoom variable updated. Name: " + roomVar.name + ", value: " + roomVar.value.toString());
					break;
				default:
					trace("未能处理的RoomVariable消息");
					break;
			}
			
			function onRoomVariableChange():void
			{
				roomVar = room.roomVariableByName(e.name);
				if(roomVar.name=="roomDetails")return;
				InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).updateRoom(room);
				for each (user in ReadyEsRoom(esRoomBase).roomManager.room.users) 
					InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).onGetUserInfo(user);
			}
		}
		
		private function getCurrentCardGroup():void{
			ReadyEsRoom(esRoomBase).getCurrentCardGroup(ReadyEsRoom(esRoomBase).usersManager.meUser.userName);
		}
		
		public function changeRoomHost():void
		{
			var urvr:UpdateRoomVariableRequest = new UpdateRoomVariableRequest();
			urvr.roomId = ReadyEsRoom(esRoomBase).roomManager.room.id;
			urvr.zoneId = ReadyEsRoom(esRoomBase).roomManager.room.zoneId;
			urvr.locked = false;
			urvr.valueChanged = true;
			urvr.name = "roomHost";
			urvr.value = new EsObject();
			urvr.value.setString("userName", GameCom.getInstance().esServer.managerHelper.userManager.me.userName);
			GameCom.getInstance().esServer.engine.send(urvr);
		}
		
	}
}