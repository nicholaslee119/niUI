package com.syndrome.sanguo.battle.combat_ui.card.cardslot
{
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.EffectGroup;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.Scence3DCantainer;
	import com.syndrome.sanguo.battle.property.CardConst;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import manger.SoundManager;

	public class GeneralCardSlot extends CardSlotBase
	{
		 /**
		 * 副将槽的宽度
		 */
		 public static const assistantWidth:Number = 380; 
		 
		/**
		 * 武将槽
		 */
		public function GeneralCardSlot(isMe:Boolean)
		{
			super(isMe);
			cards.length = 2;
		}
		
		override public function getPointByIndex(index:int):Point
		{
			if(cards == null||cards.length<=index){
				return new Point(point.x + index * (CardConst.width+15),point.y);
			}
			var result:Point = new Point();
			result.y = point.y;
			
			if(index<=1){  //主将军师
				result.x = point.x + index * (CardConst.width+15);
			}else if(index == 2){  //第一个副将
				if(cards[index] != null && !cards[index].cardInfo["isAttack"]){
					result.x = point.x + index * (CardConst.width+15) + (CardConst.height-CardConst.width)/2;
				}else{
					result.x = point.x + index * (CardConst.width+15);
				}
			}
			else{    //其他副将的位置
				var cardTotalWidth:Number = 0;  //副将槽中卡片的总宽度
				for(var i:int = 2;i<cards.length;i++){
					if(cards[i] != null && !cards[i].cardInfo["isAttack"]){  
						cardTotalWidth += CardConst.height; //卡片横置
					}else{
						cardTotalWidth += CardConst.width; 
					}
				}
				var gap:Number = (assistantWidth - cardTotalWidth) / (cards.length-2-1);
				if(gap>10){
					gap = 10;
				}
				if(cards[index-1] != null && !cards[index-1].cardInfo["isAttack"]){
					result.x = getPointByIndex(index-1).x+CardConst.height/2+gap;   //前一张卡横置
				}else{
					result.x = getPointByIndex(index-1).x+CardConst.width/2+gap;
				}
				if(cards[index] != null && !cards[index].cardInfo["isAttack"]){
					result.x = result.x +CardConst.height/2;
				}else{
					result.x = result.x +CardConst.width/2;
				}
			}
			return result;
		}
		
		public function getEquipSlot(card:GameCard):EquipmentCardSlot
		{
			if(card.cardInfo.hasOwnProperty("equipSlot"))
			{
				return card.cardInfo["equipSlot"];
			}
			return null;
		}
		
		/**
		 * 刷新卡片对应装备卡的属性和位置
		 */
		private function refreshEquipCard(card:GameCard):void
		{
			var equipSlot:EquipmentCardSlot = getEquipSlot(card);
			if(equipSlot)  //刷新装备卡属性和位置
			{
				equipSlot.refreshCards();
				equipSlot.refreshCardsPosition();
			}
		}
		
		/**
		 * 改变卡牌的表现形式
		 */
		override public function changeCardState(card:GameCard , toPositive:Boolean , toAttack:Boolean):void
		{
			super.changeCardState(card , toPositive , toAttack);
			//改变装备卡
			refreshEquipCard(card);
		}
		
		/**
		 * 向卡槽中添加卡片
		 */
		override public function addCard(card:GameCard ,index:int = -1):void
		{
			super.addCard(card , index);
		}
		
		/**
		 * 从卡槽中移除卡片
		 */
		override public function deleteCard(card:GameCard , destinationSlot:CardSlotBase = null):void
		{
			var index:int = cards.indexOf(card);
			
			if(destinationSlot && !(destinationSlot is GeneralCardSlot)){   //目标槽不是武将槽,则刷新装备卡位置
				card.cardInfo["slotType"] = destinationSlot.type;
				refreshEquipCard(card);
			}
			if(index == 0 || index == 1){   //删除主将或者军师
				cards.splice(index , 0 , null);
			}
			super.deleteCard(card , destinationSlot);
		}
		
		/**
		 * 刷新卡槽中卡牌的属性( 地址，状态等)
		 */
		override public function refreshCards():void
		{
			super.refreshCards();
			for(var i:int = 0;i<cards.length;i++){
				if(cards[i] != null){
					var equipSlot:EquipmentCardSlot = getEquipSlot(cards[i]);
					if(equipSlot)  //刷新装备卡属性
					{
						equipSlot.refreshCards();
					}
				}
			}
		}
		
		/**
		 * 刷新卡槽中卡片的位置
		 */
		override public function refreshCardsPosition():void
		{
			super.refreshCardsPosition();
			for(var i:int = 0;i<cards.length;i++){
				if(cards[i] != null){
					var equipSlot:EquipmentCardSlot = getEquipSlot(cards[i]);
					if(equipSlot)  //刷新装备卡位置
					{
						equipSlot.refreshCardsPosition();
					}
				}
			}
		}
		
		override public function cardStateChanged(card:GameCard, isPositiveOld:Boolean, isAttackOld:Boolean):void
		{
			super.cardStateChanged(card , isPositiveOld , isAttackOld);
			if(!card.cardInfo["isPositive"] && isPositiveOld){  //翻转成反面
				card.setAttribInfo(card.cardInfo["base"]["attack"],card.cardInfo["base"]["health"],card.cardInfo["base"]["intelligence"]);
			}
			if(card.cardInfo["isPositive"] && !isPositiveOld){   //翻转成正面
				EffectGroup.getInstance().showCardCloseness(card.cardInfo["id"]);
			}
		}
		
		override public function cardLeave(card:GameCard):void
		{
			super.cardLeave(card);
			Scence3DCantainer.getInstance().setGeneralNum(isMe , getGeneralNum());
			card.setAttribInfo(card.cardInfo["base"]["attack"],card.cardInfo["base"]["health"],card.cardInfo["base"]["intelligence"]);
		}
		
		override public function cardReach(card:GameCard):void
		{
			super.cardReach(card);
			
			Scence3DCantainer.getInstance().setGeneralNum(isMe , getGeneralNum());
			
			if(card.cardInfo["isPositive"] && card.cardInfo.hasOwnProperty("old_slotType") ){
				SoundManager.play("MP3_Debut");
				EffectGroup.getInstance().showCardCloseness(card.cardInfo["id"]);
			}
		}
		
		/**
		 * 获取副将数量
		 */
		public function getGeneralNum():int
		{
			var num:int = 0;
			for (var i:int = 2; i < cards.length; i++) 
			{
				if(cards[i] != null){
					num++;
				}
			}
			return num;
		}
		
		override public function get point():Point
		{
			if(isMe){
				return CardSlotConst.my_SlotPoint[CardSlotConst.generalCardSlot];
			}else{
				return CardSlotConst.enemy_SlotPoint[CardSlotConst.generalCardSlot];
			}
		}
		
		override public function get type():int
		{
			return CardSlotConst.generalCardSlot;
		}
	}
}