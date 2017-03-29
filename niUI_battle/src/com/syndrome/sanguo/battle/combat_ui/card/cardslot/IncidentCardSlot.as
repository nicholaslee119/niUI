package com.syndrome.sanguo.battle.combat_ui.card.cardslot
{
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.EffectGroup;
	import com.syndrome.sanguo.battle.effect.PixelBenderTwirlEffect;
	import com.syndrome.sanguo.battle.effect.effectbase.CustomEffectEvent;
	import com.syndrome.sanguo.battle.property.CardConst;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	
	import flash.geom.Point;
	
	import manger.SoundManager;

	public class IncidentCardSlot extends CardSlotBase
	{
		
		/**
		 * 事件槽
		 */
		public function IncidentCardSlot(isMe:Boolean)
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
		
		override public function cardStateChanged(card:GameCard, isPositiveOld:Boolean, isAttackOld:Boolean):void
		{
			super.cardStateChanged(card , isPositiveOld , isAttackOld);
			if(card.cardInfo["isPositive"]){
				if(!isPositiveOld){  //翻转成正面
					EffectGroup.getInstance().showCardCloseness(card.cardInfo["id"] , 2 ,function():void{
						moveout(card);
					});
				}else{
					moveout(card);
				}
			}
		}
		
		override public function cardReach(card:GameCard):void
		{
			super.cardReach(card);
			card.visible = true;
			if(card.cardInfo["isPositive"] && card.cardInfo.hasOwnProperty("old_slotType") ){
				SoundManager.play("MP3_Event");
				EffectGroup.getInstance().showCardCloseness(card.cardInfo["id"] , 2 ,function():void{
					moveout(card);
				});
			}
		}
		
		private function moveout(card:GameCard):void
		{
			if(card.cardInfo["state"] == CardConst.state_moveout){   //移除游戏
				var f:PixelBenderTwirlEffect = new PixelBenderTwirlEffect(card, 500);
				var twirlEndHandler:Function = function (event:CustomEffectEvent) : void
				{
					f.removeEventListener(CustomEffectEvent.END, twirlEndHandler);
					deleteCard(card);
				};
				f.play();
			}
		}
		
		override public function cardLeave(card:GameCard):void
		{
			super.cardLeave(card);
			card.visible = false;
		}
		
		override public function get point():Point
		{
			if(isMe){
				return CardSlotConst.my_SlotPoint[CardSlotConst.incidentCardSlot];
			}else{
				return CardSlotConst.enemy_SlotPoint[CardSlotConst.incidentCardSlot];
			}
		}
		
		override public function get type():int
		{
			return CardSlotConst.incidentCardSlot;
		}
	}
}