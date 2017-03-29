package com.syndrome.sanguo.battle.combat_ui.card.cardslot
{
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.EffectGroup;
	import com.syndrome.sanguo.battle.property.CardConst;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	
	import flash.geom.Point;

	public class StrategyCardSlot extends CardSlotBase
	{
		
		/**
		 * 谋略槽的宽度
		 */
		public static const stategyWidth:Number = 500; 
		
		/**
		 * 谋略槽
		 */
		public function StrategyCardSlot(isMe:Boolean)
		{
			super(isMe);
		}
		
		override public function getPointByIndex(index:int):Point
		{
			if(cards == null||cards.length<=index){
				return point;
			}
			var result:Point = new Point();
			result.x = point.x;
			result.y = point.y;
			
			if(index==0){  //第一张谋略位置
				if(cards[index]!=null && !cards[index].cardInfo["isAttack"]){
					result.x = result.x+CardConst.height/2 - CardConst.width/2;
				}
			}else{    //其他谋略的位置
				var cardTotalWidth:Number = 0;  //谋略槽中卡片的总宽度
				for(var i:int = 0;i<cards.length;i++){
					if(cards[i]!=null && !cards[i].cardInfo["isAttack"]){
						cardTotalWidth += CardConst.height; 
					}else{
						cardTotalWidth += CardConst.width; 
					}
				}
				var gap:Number = (stategyWidth - cardTotalWidth) / (cards.length-1);
				if(gap>10){
					gap = 10;
				}
				if(cards[index-1]!=null && !cards[index-1].cardInfo["isAttack"]){
					result.x = getPointByIndex(index-1).x+CardConst.height/2+gap;
				}else{
					result.x = getPointByIndex(index-1).x+CardConst.width/2+gap;
				}
				if(cards[index]!=null && !cards[index].cardInfo["isAttack"]){
					result.x = result.x +CardConst.height/2;
				}else{
					result.x = result.x +CardConst.width/2;
				}
			}
			return result;
		}
		
		override public function cardReach(card:GameCard):void
		{
			super.cardReach(card);
			if(card.cardInfo["isPositive"] && card.cardInfo.hasOwnProperty("old_slotType") ){
				EffectGroup.getInstance().showCardCloseness(card.cardInfo["id"],2);
			}
		}
		
		override public function get point():Point
		{
			if(isMe){
				return CardSlotConst.my_SlotPoint[CardSlotConst.strategyCardSlot];
			}else{
				return CardSlotConst.enemy_SlotPoint[CardSlotConst.strategyCardSlot];
			}
		}
		
		override public function get type():int
		{
			return CardSlotConst.strategyCardSlot;
		}
	}
}