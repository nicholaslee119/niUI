package com.syndrome.sanguo.battle.combat_ui.card.cardslot
{
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.Effect3DCantainer;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	
	import flash.geom.Point;

	public class GraveyardCardSlot extends CardSlotBase
	{
		
		/**
		 * 墓地槽
		 */
		public function GraveyardCardSlot(isMe:Boolean)
		{
			super(isMe);
		}
		
		override public function getPointByIndex(index:int):Point
		{
			var result:Point = new Point();
			result.x =point.x;
			result.y =point.y;
			return result;
		}
		
		override public function cardReach(card:GameCard):void
		{
			super.cardReach(card);
			card.playGrave();
			card.setAttribInfo(0,0,0,false);
			Effect3DCantainer.getInstance().setMDNum(getCardNum(),isMe);
		}
		
		override public function cardLeave(card:GameCard):void
		{
			super.cardLeave(card);
			card.setAttribInfo(-1,-1,-1,true);
			Effect3DCantainer.getInstance().setMDNum(getCardNum(),isMe);
		}
		
		override public function get point():Point
		{
			if(isMe){
				return CardSlotConst.my_SlotPoint[CardSlotConst.graveyardCardSlot];
			}else{
				return CardSlotConst.enemy_SlotPoint[CardSlotConst.graveyardCardSlot];
			}
		}
		
		override public function get type():int
		{
			return CardSlotConst.graveyardCardSlot;
		}
	}
}