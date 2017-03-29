package com.syndrome.sanguo.battle.combat_ui.card.cardslot
{
	
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	
	import flash.geom.Point;
	
	import org.flexlite.domUI.core.IVisualElementContainer;

	public class EquipmentCardSlot extends CardSlotBase
	{
		/**
		 * 对应的武将卡
		 */
		public var generalCard:GameCard;
		
		/**
		 * 装备槽
		 */
		public function EquipmentCardSlot(isMe:Boolean,generalCard:GameCard)
		{
			super(isMe);
			this.generalCard = generalCard;
			generalCard.cardInfo["equipSlot"] = this;
		}
		
		override public function getPointByIndex(index:int):Point
		{
			var result:Point = CardManager.getPointByAddress(generalCard.cardInfo["address"]);
			result.y = point.y - (index+1)*10;
			return result;
		}
		
		override public function addCard(card:GameCard, index:int=-1):void
		{
			super.addCard(card , index);
		}
		
		override public function deleteCard(card:GameCard, destinationSlot:CardSlotBase=null):void
		{
			super.deleteCard(card , destinationSlot);
			if(cards.length == 0){
				delete generalCard.cardInfo["equipSlot"];
			}
		}
		
		/**
		 * 刷新卡槽中卡牌的属性( 地址，状态等)
		 */
		override public function refreshCards():void
		{
			isMe = generalCard.cardInfo["me"];
			
			var generalCardIsInGeneralSlot:Boolean = generalCard.cardInfo["slotType"] == CardSlotConst.generalCardSlot;
			for(var i:int = cards.length - 1; i>=0 ; i--){
				if(cards[i] != null){
					var address:int = (isMe?type:(type+10))*10000 + CardManager.getCardIndex(generalCard.cardInfo["address"])*100+ i;
					if(generalCardIsInGeneralSlot){
						if(generalCard.cardInfo["isPositive"]){
							cards[i].cardInfo["me"] = isMe;
							cards[i].cardInfo["address"] = address;
							cards[i].changePosition(true , generalCard.cardInfo["isAttack"]);
						}else{
							equipCardToGraveyard(cards[i]);
						}
					}else{
						equipCardToGraveyard(cards[i]);
					}
				}
			}
		}
		
		private function equipCardToGraveyard(card:GameCard):void
		{
			var changeController:Boolean = !(card.isMe == card.cardInfo["me"]);
			CardManager.getInstance().addCard(card , CardSlotConst.graveyardCardSlot , false , false , -1 , changeController , 0);
		}
		
		override public function cardReach(card:GameCard):void
		{
			super.cardReach(card);
			var cardIndex:int = CardManager.getCardIndex(card.cardInfo["address"]);
			if(cardIndex == 0){
				var generalCardIndex:int = (generalCard.parent as IVisualElementContainer).getElementIndex(generalCard);
				container.setElementIndex(card , generalCardIndex>0?(generalCardIndex-1):0);
			}else{
				var preCard:GameCard = this.getCard(cardIndex-1);
				var preCardIndex:int = container.getElementIndex(preCard);
				container.setElementIndex(card,preCardIndex>0?(preCardIndex-1):0);
			}
		}
		
		override public function cardLeave(card:GameCard):void
		{
			super.cardLeave(card);
		}
		
		override public function get point():Point
		{
			if(isMe){
				return CardSlotConst.my_SlotPoint[CardSlotConst.equipmentCardSlot];
			}else{
				return CardSlotConst.enemy_SlotPoint[CardSlotConst.equipmentCardSlot];
			}
		}
		
		override public function get type():int
		{
			return CardSlotConst.equipmentCardSlot;
		}
	}
}