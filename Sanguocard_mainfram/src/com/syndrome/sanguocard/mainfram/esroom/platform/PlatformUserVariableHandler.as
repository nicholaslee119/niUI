package com.syndrome.sanguocard.mainfram.esroom.platform
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.MessageType;
	import com.electrotank.electroserver5.api.UpdateUserVariableRequest;
	import com.electrotank.electroserver5.api.UserUpdateAction;
	import com.electrotank.electroserver5.api.UserVariable;
	import com.electrotank.electroserver5.api.UserVariableUpdateAction;
	import com.electrotank.electroserver5.api.UserVariableUpdateEvent;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.client.parameters.PublicParameters;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	
	public class PlatformUserVariableHandler extends PlatformHandlerBase
	{
		public function PlatformUserVariableHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.UserVariableUpdateEvent.name, onUserVariableUpdateEvent);
		}
		
		private function onUserVariableUpdateEvent(e:UserVariableUpdateEvent):void {
			var userVar:UserVariable;
			switch (e.action) {
				case UserVariableUpdateAction.VariableCreated:
					userVar = GameCom.getInstance().esServer.managerHelper.userManager.me.userVariableByName(e.variable.name);
					trace("[PlatformUserVariableHandler]:User variable created. Name: " + userVar.name + ", value: " + userVar.value.toString());
					break;
				case UserVariableUpdateAction.VariableDeleted:
					trace("[PlatformUserVariableHandler]:User variable deleted. Name: " + e.variable.name);
					break;
				case UserVariableUpdateAction.VariableUpdated:
					userVar = GameCom.getInstance().esServer.managerHelper.userManager.me.userVariableByName(e.variable.name);
					if(userVar.name==Constant.GetUserStatus)
						PlatformEsRoom(esRoomBase).esRoomManager.platformOnUserStatusUpdate();
					else if(userVar.name==Constant.GetUserInfo)
						PlatformEsRoom(esRoomBase).esRoomManager.platformOnRefreshGUI();
					trace("[PlatformUserVariableHandler]:User variable updated. Name: " + userVar.name + ", value: " + userVar.value.toString());
					break;
			}
		}
		
		public function updataUserVariable(value:EsObject):void
		{
			var uuvr:UpdateUserVariableRequest = new UpdateUserVariableRequest();
			uuvr.name = Constant.GetUserInfo;
			uuvr.value = value;
			GameCom.getInstance().esServer.engine.send(uuvr);
			PlatformEsRoom(esRoomBase).switchUserStatus(Constant.USER_STATUS_IDLE);
		}
		
		public function switchUserStatus(status:int):void
		{
			var uuvr:UpdateUserVariableRequest = new UpdateUserVariableRequest();
			uuvr.name = Constant.GetUserStatus;
			uuvr.value = new EsObject();
			uuvr.value.setInteger("code", status);
			GameCom.getInstance().esServer.engine.send(uuvr);
		}
	}
}