package com.syndrome.sanguo.battle.combat_ui.card.cardslot
{
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.CardSlotBase;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.Scence3DCantainer;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	import com.syndrome.sanguo.battle.property.ConstInterFace;
	
	import flash.geom.Point;
	import flash.utils.setTimeout;

	public class MilitaryCardSlot extends CardSlotBase
	{
		/**
		 * 各种兵权类型对应的卡 type 类型 谋士  骑兵 弓兵  步兵
		 */
		private var militaryType:Array;
		
		/**
		 * 兵权槽
		 */
		public function MilitaryCardSlot(isMe:Boolean)
		{
			super(isMe);
			militaryType = new Array([],[],[],[]);
		}
		
		override public function getPointByIndex(index:int):Point
		{
			var result:Point = new Point();
			result.x =point.x+(index) * 0.08;
			result.y =point.y+(-index) * 0.12;
			return result;
		}
		
		override public function cardLeave(card:GameCard):void
		{
			super.cardLeave(card);
			var type:int = ConstInterFace.getMilitaryType(card.cardInfo["base"]["military_type"]);
			var index:int = (militaryType[type] as Array).indexOf(card);
			if(index>=0){
				(militaryType[type] as Array).splice(index,1);
			}
			Scence3DCantainer.getInstance().setMilitaryNum(militaryType[type].length , type ,isMe);
			card.visible = true;
		}
		
		override public function cardReach(card:GameCard):void
		{
			super.cardReach(card);
			var type:int = ConstInterFace.getMilitaryType(card.cardInfo["base"]["military_type"]);
			(militaryType[type] as Array).push(card);
			setTimeout(function():void
			{
				card.visible = false;
				Scence3DCantainer.getInstance().setMilitaryNum(militaryType[type].length , type ,isMe);
			},800);
		}
		
		override public function get point():Point
		{
			if(isMe){
				return CardSlotConst.my_SlotPoint[CardSlotConst.militaryCardSlot];
			}else{
				return CardSlotConst.enemy_SlotPoint[CardSlotConst.militaryCardSlot];
			}
		}
		
		override public function get type():int
		{
			return CardSlotConst.militaryCardSlot;
		}
		
		/**
		 * 获取指定兵权类型的卡
		 */
		public function getMilitaryCards(type:int):Array
		{
			if(!militaryType.hasOwnProperty(type)){
				return null;
			}
			return militaryType[type] as Array;
		}
	}
}