package com.syndrome.sanguocard.mainfram.esroom.readyroom
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.MessageType;
	import com.electrotank.electroserver5.api.UpdateRoomVariableRequest;
	import com.electrotank.electroserver5.api.UserUpdateAction;
	import com.electrotank.electroserver5.api.UserUpdateEvent;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomUserUpdateHandler;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfBattle;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfLobby;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfReadyRoom;
	import com.syndrome.sanguocard.mainfram.ui.AlertPanel;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	public class ReadyRoomUserUpdateHandler extends EsRoomUserUpdateHandler
	{
		use namespace ThisIsInterface;
		
		public function ReadyRoomUserUpdateHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function onUserUpdateEvent(e:UserUpdateEvent):void
		{
			if(e.roomId != ReadyEsRoom(esRoomBase).roomManager.roomID || e.zoneId != ReadyEsRoom(esRoomBase).roomManager.zoneID) return;
			var user:User = null;
			switch (e.action)
			{
				case UserUpdateAction.AddUser:
					user=GameCom.getInstance().esServer.managerHelper.userManager.userByName(e.userName);
					if(user.isMe)
						ReadyEsRoom(esRoomBase).usersManager.meUser = user;
					else{
						ReadyEsRoom(esRoomBase).usersManager.users.push(user);
						ReadyEsRoom(esRoomBase).oppoUserEnter(user);
						ReadyEsRoom(esRoomBase).esRoomManager.switchUserStatus(Constant.USER_STATUS_FULL);
					}
					InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).onGetUserInfo(user);
					break;
				case UserUpdateAction.DeleteUser:
					if(ReadyEsRoom(esRoomBase).esRoomManager.readyGetUILoadingDisplayStatus()==true)
						AlertPanel.creatInstance().show("对方掉线", onOpOffline, onOpOffline);
					ReadyEsRoom(esRoomBase).changeRoomHost();
					ReadyEsRoom(esRoomBase).esRoomManager.switchUserStatus(Constant.USER_STATUS_WAITING);
					InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).onUserLeave(e.userName);
					break;
				default:
					trace("Action not handled: " + e.action.name);
					break;
			}
		}
		
		private function onOpOffline(e:MouseEvent):void
		{
			ReadyEsRoom(esRoomBase).esRoomManager.visiablizeLobby();
			InterfaceOfReadyRoom(ReadyEsRoom(esRoomBase).interfaceOfSon).sonProject.visible=true;
			ReadyEsRoom(esRoomBase).esRoomManager.readyHideUILoading();
			ReadyEsRoom(esRoomBase).esRoomManager.unvisiablizeBattle();
			ExternalInterface.call("onExitFullScreen");
		}
		
		
	}
}