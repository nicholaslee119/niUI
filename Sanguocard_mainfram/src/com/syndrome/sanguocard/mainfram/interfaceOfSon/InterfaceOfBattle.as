package com.syndrome.sanguocard.mainfram.interfaceOfSon
{
	import com.communication.EventObj;
	import com.communication.InterfaceOfSonBattleEvent;
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.user.User;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.client.parameters.PublicParameters;
	import com.syndrome.sanguocard.mainfram.esroom.battle.BattleEsRoom;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	import flash.events.Event;

	public class InterfaceOfBattle extends InterfaceOfSonBase
	{
		public function InterfaceOfBattle(esRoom:*)
		{
			super(esRoom);
		}
		
		private function sendToSonProject(eventType:String, para:Object=null):void
		{
			this.dispatchEvent(new InterfaceOfSonBattleEvent(eventType, para));
		}
		
		ThisIsInterface function onInitGame():void
		{
			sendToSonProject(InterfaceOfSonBattleEvent.ON_INIT);
		}
		
		ThisIsInterface function sendGameStart():void
		{
			sendToSonProject(InterfaceOfSonBattleEvent.SEND_GAME_START);
		}
		
		ThisIsInterface function onRelaseGame():void
		{
			sendToSonProject(InterfaceOfSonBattleEvent.ON_RELEASE);
		}
		
		ThisIsInterface function onUserEnter(user:User):void
		{
			var para:Object = new Object();
			para.user = user;
			sendToSonProject(InterfaceOfSonBattleEvent.ON_USER_ENTER, para);
		}
		
		ThisIsInterface function reSetBattle():void
		{
			sendToSonProject(InterfaceOfSonBattleEvent.RESET_BATTLE);
		}
		
		ThisIsInterface function onUserWillLeave(user:String):void
		{
			sendToSonProject(InterfaceOfSonBattleEvent.ON_USER_WILL_LEAVE);
		}
		
		ThisIsInterface function onOpUserDisconnect(user:String):void
		{
			sendToSonProject(InterfaceOfSonBattleEvent.ON_OPUSER_DISCONNECT);
		}
		
		ThisIsInterface function onGameStateChange(old:int,now:int):void
		{
			var para:Object = new Object();
			para.old = old;
			para.now = now;
			sendToSonProject(InterfaceOfSonBattleEvent.ON_USER_WILL_LEAVE, para);
		}
		
		ThisIsInterface function onUserStateChange(userName:String,state:int):void
		{
			var para:Object = new Object();
			para.userName = userName;
			para.state = state;
			sendToSonProject(InterfaceOfSonBattleEvent.ON_USER_STATE_CHANGE, para);
		}
		
		ThisIsInterface function onProtocol(data:Object):void
		{
			sendToSonProject(InterfaceOfSonBattleEvent.ON_PROTOCOL, data);
		}
		
		ThisIsInterface function onChannelMessage(username:String, nickname:String, message:String, channel:String):void
		{
			var para:Object = new Object();
			para.userName = username;
			para.nickname = nickname;
			para.message = message;
			para.channel = channel;
			sendToSonProject(InterfaceOfSonBattleEvent.ON_CHANNEL_MESSAGE, para);
		}
		
		ThisIsInterface function onPrivateMessage(senderUserName:String, senderNickname:String, receiverUserName:String, receiverNickname:String, message:String):void
		{
			var para:Object = new Object();
			para.senderUserName = senderUserName;
			para.senderNickname = senderNickname;
			para.receiverUserName = receiverUserName;
			para.receiverNickname = receiverNickname;
			para.message = message;
			para.channel = Constant.CHANNEL_PRIVATE;
			sendToSonProject(InterfaceOfSonBattleEvent.ON_CHANNEL_MESSAGE, para);
		}
		
		public function getGameState():int
		{
			return 1;
		}
		
		public function BlockRecv():int
		{
			return GameCom.getInstance().BlockRecv();
		}
		
		public function UnBlockRecv(b:Boolean =false):int
		{
			return GameCom.getInstance().UnBlockRecv(b);
		}
		
		public function SwitchToRoom():void
		{
			
		}
		
		public function sendPackage(es:EsObject, type:int):void
		{
			BattleEsRoom(esRoom).sendPackage(es, type);
		}
		
		public function findUserByName(name:String):User
		{
			return BattleEsRoom(esRoom).usersManager.findUser(name);
		}
		
		public function leaveGame():void
		{
			BattleEsRoom(esRoom).leaveGame();
		}
		
		public function onFightHistory(history:String):void
		{
			BattleEsRoom(esRoom).onFightHistory(history);
		}
		
		public function returnToReady():void
		{
			BattleEsRoom(esRoom).returnToReady();
		}
		
		public function toPackage(es:EsObject):void
		{
			es.setString("a","f");
			BattleEsRoom(esRoom).toPackage(es);
		}
		
		public function onResProgress(pros:Number):void
		{
			BattleEsRoom(esRoom).onResProgress(pros);
		}
		
		public function onResLoadComplete():void
		{
			BattleEsRoom(esRoom).onResLoadComplete();
		}
		
		public function sendChannelMessage(content:String, channel:String, userName:Array=null):void
		{
			BattleEsRoom(esRoom).sendChannelMessage(content, channel, userName);
		}
		
	}
}