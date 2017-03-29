package com.syndrome.sanguocard.mainfram.esroom.battle
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.MessageType;
	import com.electrotank.electroserver5.api.UserUpdateAction;
	import com.electrotank.electroserver5.api.UserUpdateEvent;
	import com.electrotank.electroserver5.user.User;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomHandlerBase;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfBattle;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	public class BattleUserUpdateHandler extends EsRoomHandlerBase
	{
		use namespace ThisIsInterface;
		
		public function BattleUserUpdateHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.UserUpdateEvent.name, onUserUpdateEvent);
		}
		
		private function onUserUpdateEvent(e:UserUpdateEvent):void
		{
			if(e.roomId != BattleEsRoom(esRoomBase).roomManager.roomID || e.zoneId != BattleEsRoom(esRoomBase).roomManager.zoneID) return;
			var user:User = null;
			switch (e.action)
			{
				case UserUpdateAction.AddUser:
					user= BattleEsRoom(esRoomBase).usersManager.findUser(e.userName);
					if(user!=null)BattleEsRoom(esRoomBase).onUserEnter(user);
					break;
				case UserUpdateAction.DeleteUser:
					//TODO:判断是否正常退出还是掉线
					if(BattleEsRoom(esRoomBase).normalOut){
						InterfaceOfBattle(BattleEsRoom(esRoomBase).interfaceOfSon).onUserWillLeave(e.userName);
					}
					else{
						InterfaceOfBattle(BattleEsRoom(esRoomBase).interfaceOfSon).onOpUserDisconnect(e.userName);
					}
					BattleEsRoom(esRoomBase).normalOut = false;
					break;
				default:
					trace("Action not handled: " + e.action.name);
					break;
			}
		}
		
	}
}