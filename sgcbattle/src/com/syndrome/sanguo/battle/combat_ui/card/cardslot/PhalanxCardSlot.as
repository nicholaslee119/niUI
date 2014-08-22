package com.syndrome.sanguo.battle.combat_ui.card.cardslot
{
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.CardSlotBase;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.EffectGroup;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	
	import flash.geom.Point;

	public class PhalanxCardSlot extends CardSlotBase
	{
		
		/**
		 * 阵型槽
		 */
		public function PhalanxCardSlot(isMe:Boolean)
		{
			super(isMe);
		}
		
		override public function getPointByIndex(index:int):Point
		{
			var result:Point = new Point();
			result.x =point.x+(index) * 0.08;
			result.y =point.y+(-index) * 0.12;
			return result;
		}
		
		override public function get point():Point
		{
			if(isMe){
				return CardSlotConst.my_SlotPoint[CardSlotConst.phalanxCardSlot];
			}else{
				return CardSlotConst.enemy_SlotPoint[CardSlotConst.phalanxCardSlot];
			}
		}
		
		override public function cardStateChanged(card:GameCard, isPositiveOld:Boolean, isAttackOld:Boolean):void
		{
			super.cardStateChanged(card , isPositiveOld , isAttackOld);
			if(card.cardInfo["isPositive"] && !isPositiveOld){   //翻转成正面
				EffectGroup.getInstance().showCardCloseness(card.cardInfo["id"]);
			}
		}
		
		override public function cardLeave(card:GameCard):void
		{
			super.cardLeave(card);
			card.setAttribInfo(0,0,0,false);
		}
		
		override public function cardReach(card:GameCard):void
		{
			super.cardReach(card);
			if(card.cardInfo["isPositive"] && card.cardInfo.hasOwnProperty("old_slotType") ){
				EffectGroup.getInstance().showCardCloseness(card.cardInfo["id"]);
			}
		}
		
		override public function get type():int
		{
			return CardSlotConst.phalanxCardSlot;
		}
	}
}