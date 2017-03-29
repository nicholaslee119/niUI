package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.common.UserInfo;
	
	import flash.utils.Dictionary;
	
	import net.IProtocolhandler;
	
	/**
	 * 阵型属性改变
	 */
	public class PhalanxAttributeChangeDisplay implements IProtocolhandler
	{
		public function PhalanxAttributeChangeDisplay()
		{
		}
		
		public function handle(message:Object):void
		{
			var playerName:String = message["playerName"];
			var phalanxAddress:int = message["phalanxAddress"];
			var generalAddress:Array = message["generalAddress"];
			var health:int = message["health"];
			var attack:int = message["attack"];
			var reason:int = message["reason"];
			
			if(UserInfo.myUserName != playerName){
				phalanxAddress = CardManager.convertAddress(phalanxAddress);
				for (var i:int = 0; i < generalAddress.length; i++) 
				{
					generalAddress[i] = CardManager.convertAddress(generalAddress[i]);
				}
			}
			var phalanxCard:GameCard = CardManager.getCard(phalanxAddress);
			if(generalAddress.length == 0){
				phalanxCard.setAttribInfo(0,0,0,false);
			}else{
				phalanxCard.setAttribInfo(attack,health,0);
			}
			
			addPhalanxDisplay(phalanxCard , generalAddress);
		}
		
		private function addPhalanxDisplay(phalanxCard:GameCard , generalAddress:Array):void
		{
			var phalanxCards:Dictionary = CardManager.getInstance().phalanxCards;
			var oldPhalanxCard:*;
			for(oldPhalanxCard in phalanxCards) 
			{
				oldPhalanxCard.hidePhalanxFlag();
				for each (var oldGeneralCard:GameCard in phalanxCards[oldPhalanxCard]) 
				{
					oldGeneralCard.hidePhalanxFlag();
				}
			}
			
			if(generalAddress.length>0){
				phalanxCards[phalanxCard] = [] ;
//				phalanxCard.addPhalanxFlag();
				for (var i:int = 0; i < generalAddress.length; i++) 
				{
					var card:GameCard = CardManager.getCard(generalAddress[i]);
					card.showPhalanxFlag();
					phalanxCards[phalanxCard].push(card);
				}
			}
		}
	}
}