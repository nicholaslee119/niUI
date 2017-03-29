package com.syndrome.sanguo.battle.combat_ui.card.cardslot
{
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.CardSlotBase;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Card2DCantainer;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Scence2DCantainer;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.Card3DCantainer;
	import com.syndrome.sanguo.battle.property.CardConst;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import org.flexlite.domUI.components.Group;
	
	import utils.MatrixUtil;

	public class HandCardSlot extends CardSlotBase
	{
		/**
		 * 手牌
		 */
		public function HandCardSlot(isMe:Boolean)
		{
			super(isMe);
		}
		
		override public function cardLeave(card:GameCard):void
		{
			super.cardLeave(card);
			var currentHandNum:int = Scence2DCantainer.getInstance().getHandNum(isMe);
			Scence2DCantainer.getInstance().setHandNum(isMe,currentHandNum-1);
		}
		
		override public function cardReach(card:GameCard):void
		{
			super.cardReach(card);
			var currentHandNum:int = Scence2DCantainer.getInstance().getHandNum(isMe);
			Scence2DCantainer.getInstance().setHandNum(isMe,currentHandNum+1)
		}
		
		override public function getPointByIndex(index:int):Point
		{
			var result:Point = new Point();
			var gap:Number = 0;
			if(cards.length>7){
				var maxWidth:Number = 616;
				gap = (maxWidth - cards.length*CardConst.width) / (cards.length-1);
			}else{
				gap = 8;
			}
			result.x = point.x +index*CardConst.width +index * gap ;
			result.y = point.y;
			return result;
		}
		
		override public function get point():Point
		{
			if(isMe){
				return CardSlotConst.my_SlotPoint[CardSlotConst.handCardSlot];
			}else{
				return CardSlotConst.enemy_SlotPoint[CardSlotConst.handCardSlot];
			}
		}
		
		override public function get type():int
		{
			return CardSlotConst.handCardSlot;
		}
		
		/**
		 * 卡槽中的卡片所在的容器
		 */
		override public function get container():Group
		{
			if(isMe){
				return Card2DCantainer.getInstance().myHandCardGroup;
			}else{
				return Card2DCantainer.getInstance().enemyHandCardGroup;
			}
		}
	}
}