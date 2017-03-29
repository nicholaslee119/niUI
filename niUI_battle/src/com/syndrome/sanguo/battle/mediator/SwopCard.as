package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.CardSlotBase;
	import com.syndrome.sanguo.battle.common.UserInfo;
	
	import net.IProtocolhandler;

	/**
	 * 交换卡片
	 */
	public class SwopCard implements IProtocolhandler
	{
		public function SwopCard()
		{
		}
		
		public function handle(message:Object):void
		{
			var playerName:String = message["playerName"];
			var address:Array = message["address"];
			
			if(UserInfo.myUserName != playerName){
				for (var i:int = 0; i < address.length; i++) 
				{
					address[i] = CardManager.convertAddress(address[i]);
				}
			}
			var card1:GameCard = CardManager.getCard(address[0]);
			var card1Index:int = CardManager.getCardIndex(address[0]);
			var card1Slot:CardSlotBase = CardManager.getSlotByAddress(address[0]);
			
			var card2:GameCard = CardManager.getCard(address[1]);
			var card2Index:int = CardManager.getCardIndex(address[1]);
			var card2Slot:CardSlotBase= CardManager.getSlotByAddress(address[1]);
			
			card1Slot.replaceCard(card2,card1Index);
			card2Slot.replaceCard(card1,card2Index);
			
			card1Slot.refreshCards();
			card1Slot.refreshCardsPosition();
			if(card1Slot != card2Slot){
				card2Slot.refreshCards();
				card2Slot.refreshCardsPosition();
			}
		}
	}
}