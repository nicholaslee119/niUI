package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.common.UserInfo;
	
	import net.IProtocolhandler;
	
	/**
	 * 初始化卡槽展示
	 */
	public class InitCardSlotDisplay implements IProtocolhandler
	{
		public function InitCardSlotDisplay()
		{
		}
		
		private function convertAddress(addresses:Array):void
		{
			for(var i:int = 0;i<addresses.length;i++){
				addresses[i] = CardManager.convertAddress(addresses[i]);
			}
		}
		
		public function handle(message:Object):void
		{
			var cardStates:Array = message["cardStates"];
			var cardIds:Array = message["cardIds"];
			var cardAddresses:Array = message["cardAddress"];
			var playerName:String = message["playerName"]
			
			if(UserInfo.myUserName != playerName){
				convertAddress(cardAddresses);
			}
			
			for(var i:int = 0; i<cardAddresses.length ;i++){
				CardManager.getInstance().createCard2(cardAddresses[i] , cardIds[i] , cardStates[i]);
			}
		}
	}
}