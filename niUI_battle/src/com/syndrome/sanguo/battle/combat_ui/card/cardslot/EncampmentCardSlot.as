package com.syndrome.sanguo.battle.combat_ui.card.cardslot
{
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.Effect3DCantainer;
	import com.syndrome.sanguo.battle.common.CardInfo;
	import com.syndrome.sanguo.battle.effect.ShuffleEffect;
	import com.syndrome.sanguo.battle.effect.effectbase.CustomEffectEvent;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	
	import flash.geom.Point;
	
	import manger.SoundManager;

	public class EncampmentCardSlot extends CardSlotBase
	{
		/**
		 * 最大显示的数量，其他的将隐藏
		 */
		private var maxDisplayCount:int = 50;
		
		/**
		 * 营地槽
		 */
		public function EncampmentCardSlot(isMe:Boolean)
		{
			super(isMe);
		}
		
		override public function getPointByIndex(index:int):Point
		{
			var result:Point = new Point();
			if(index >= maxDisplayCount){
				result.x = point.x + maxDisplayCount * 0.08;
				result.y =point.y - maxDisplayCount * 0.64;
			}else{
				result.x = point.x + (index) * 0.08;
				result.y =point.y - (index) * 0.64;
			}
			return result;
		}
		
		/**
		 * 洗切卡组
		 */
		public function washCampsite(cardIds:Array):void
		{
			for (var i:int = 0; i < cards.length; i++) 
			{
				cards[i].cardInfo["id"] = cardIds[i];
				cards[i].cardInfo["base"] = CardInfo.getCardInfoById(cardIds[i]);
				cards[i].refreshCardInfo();
			}
			var shuffleEffectEndHandle:Function = function(event:CustomEffectEvent):void
			{
				shuffle.removeEventListener(CustomEffectEvent.END , shuffleEffectEndHandle);
				refreshCardsPosition();
			};
			SoundManager.play("MP3_Shuffle");
			var shuffle:ShuffleEffect = new ShuffleEffect(getCards());
			shuffle.play();
			shuffle.addEventListener(CustomEffectEvent.END , shuffleEffectEndHandle);
		}
		
		override public function cardLeave(card:GameCard):void
		{
			super.cardLeave(card);
			card.visible = true;
			Effect3DCantainer.getInstance().setEncampmentNum(getCardNum(), isMe);
		}
		
		override public function cardReach(card:GameCard):void
		{
			super.cardReach(card);
			if(CardManager.getCardIndex(card.cardInfo["address"]) >= maxDisplayCount){
				card.visible = false;
			}
			Effect3DCantainer.getInstance().setEncampmentNum(getCardNum(), isMe);
		}
		
		override public function get point():Point
		{
			if(isMe){
				return CardSlotConst.my_SlotPoint[CardSlotConst.encampmentCardSlot]
			}else{
				return CardSlotConst.enemy_SlotPoint[CardSlotConst.encampmentCardSlot]
			}
		}
		
		override public function get type():int
		{
			return CardSlotConst.encampmentCardSlot;
		}
	}
}