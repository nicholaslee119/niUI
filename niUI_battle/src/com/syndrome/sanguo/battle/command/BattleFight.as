package com.syndrome.sanguo.battle.command
{
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.EffectGroup;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Card2DCantainer;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.Card3DCantainer;
	import com.syndrome.sanguo.battle.effect.ShakeEffect;
	import com.syndrome.sanguo.battle.property.BattleFieldConst;
	import com.syndrome.sanguo.battle.property.CardConst;
	
	import flash.geom.Point;
	
	import utils.Tween;

	public class BattleFight extends CommandBase
	{
		/**
		 * 进攻卡列表
		 */
		private var attackerCards:Array = [];
		
		/**
		 * 防守卡列表
		 */
		private var denfenseCards:Array = [];
		
		private var scale:Number = 2;

		/**
		 * cardInfo 字段  card卡片 isAttacker 是否是进攻卡片  fightInjury受到的战斗伤害  lastInjury受到的永久伤害
		 */
		private var cardInfos:Array;
		private var allComplete:Function;
		
		public function BattleFight()
		{
			super();
		}
		
		/**
		 * 战斗伤害显示
		 * @param cardInfo 字段  card卡片 isAttacker 是否是进攻卡片  fightInjury受到的战斗伤害  lastInjury受到的永久伤害
		 */
		public function play(cardInfos:Array , allComplete:Function = null):void
		{
			this.cardInfos = cardInfos;
			this.allComplete = allComplete;
			this.fight();
		}
		
		public function fight():void
		{
			if(cardInfos.length == 0 && allComplete != null){
				allComplete();
				return;
			}
			for (var i:int = 0; i < cardInfos.length; i++) 
			{
				var cardInfo:Object = cardInfos[i];
				var card:GameCard = cardInfo["card"];
				card.removeBattleGroupEffect();
				if(cardInfo["isAttacker"]){
					attackerCards.push(card);
				}else{
					denfenseCards.push(card);
				}
			}
			moveCardsToBattle();
		}
		
		private function moveCardsToBattle():void
		{
			var totalNum:int = attackerCards.length + denfenseCards.length;
			var completeNum:int = 0;
			var complete:Function = function():void{
				completeNum++;
				if(completeNum == totalNum){
					onCenter();
				}
			};
			
			var card:GameCard;
			var battleFieldWidth:Number = BattleFieldConst.gameCanvas_width;
			var toX:Number;
			var toY:Number;
			
			for(var i:int = 0;i<attackerCards.length;i++){
				card = attackerCards[i] as GameCard;
				Card2DCantainer.getInstance().battleCardGroup.addElement(card);
				if(attackerCards.length ==1){
					toX = battleFieldWidth/2 - CardConst.width*scale/2 - 50;
					toY = 260;	
				}else{
					if(i == 0){
						toX = battleFieldWidth/2 - CardConst.width*scale/2 - 50;
						toY = 260 - CardConst.height*scale/2 -20;	
					}else if(i ==1){
						toX = battleFieldWidth/2 - CardConst.width*scale/2 - 50;
						toY = 260 + CardConst.height*scale/2 +20;	
					}
				}
				Tween.to(card,500,{x:toX, y:toY, scaleX:scale, scaleY:scale,onComplete:complete});
			}
			
			for(i = 0;i<denfenseCards.length;i++){
				card = denfenseCards[i] as GameCard;
				Card2DCantainer.getInstance().battleCardGroup.addElement(card);
				if(attackerCards.length ==1){
					toX = battleFieldWidth/2 + CardConst.width*scale/2 + 50;
					toY = 260;	
				}else{
					if(i == 0){
						toX = battleFieldWidth/2 + CardConst.width*scale/2 + 50;
						toY = 260 - CardConst.height*scale/2 -20;	
					}else if(i ==1){
						toX = battleFieldWidth/2 + CardConst.width*scale/2 + 50;
						toY = 260 + CardConst.height*scale/2 +20;	
					}
				}
				Tween.to(card,500,{x:toX, y:toY, scaleX:scale, scaleY:scale,onComplete:complete});
			}
		}
		
		private function onCenter():void
		{
			playAttackEffect();
		}
		
		private function playAttackEffect():void
		{
			var totalNum:int = attackerCards.length + denfenseCards.length;
			var completeNum:int = 0;
			var complete:Function = function():void{
				completeNum++;
				if(completeNum == totalNum){
					returnToCardCanvas();
//					showHurt();
				}
			};
			var card:GameCard;
			var type:int;
			var point:Point = new Point();
			
			for(var i:int = 0;i<attackerCards.length;i++){
				card = attackerCards[i] as GameCard;
				type = card.cardInfo["base"]["corp"];
				var v_reversal:Boolean = false;
				if(denfenseCards.length == 0){
					if(!card.cardInfo["me"]){
						point = new Point(90 , BattleFieldConst.stage_height-125);
						if(type != 8){
							v_reversal = true;
						}
					}else{
						point = new Point(BattleFieldConst.gameCanvas_width-60 , 60);
					}
				}else{
					point.x = 50 + scale*CardConst.width/2 + BattleFieldConst.gameCanvas_width/2;
					point.y = card.y;
				}
				EffectGroup.getInstance().playAttackEffect(type , point , card.cardInfo["me"],v_reversal ,complete);
			}
			
			for(i = 0;i<denfenseCards.length;i++){
				card = denfenseCards[i] as GameCard;
				type = card.cardInfo["base"]["corp"];
				point.x = -50 - scale*CardConst.width/2  + BattleFieldConst.gameCanvas_width/2;
				point.y = card.y;
				EffectGroup.getInstance().playAttackEffect(type,point,!card.cardInfo["me"],false,complete);
			}
			for (i = 0; i < cardInfos.length; i++) 
			{
				var cardInfo:Object = cardInfos[i];
				if(cardInfo["fightInjury"] != 0 || cardInfo["lastInjury"] != 0){
					ShakeEffect.start(cardInfo["card"]);
				}
			}
		}
		
		private function showHurt():void
		{
			for (var i:int = 0; i < cardInfos.length; i++) 
			{
				var cardInfo:Object = cardInfos[i];
				var card:GameCard = cardInfo["card"];
				card.addHurt(cardInfo["fightInjury"]+cardInfo["lastInjury"]);
			}
			returnToCardCanvas();
		}
		
		private function returnToCardCanvas():void
		{
			var card:GameCard;
			var point:Point;
			var totalNum:int = attackerCards.length + denfenseCards.length;
			var completeNum:int = 0;
			var complete:Function = function():void{
				completeNum++;
				if(completeNum == totalNum && allComplete != null){
					allComplete();
				}
			};
			
			for(var i:int = 0;i<attackerCards.length;i++){
				card = attackerCards[i] as GameCard;
				Card3DCantainer.getInstance().addElement(card);
				point = CardManager.getPointByAddress(card.cardInfo["address"]);
				Tween.to(card,500,{x:point.x, y:point.y, scaleX:1, scaleY:1,onComplete:complete});
			}
			
			for(i = 0;i<denfenseCards.length;i++){
				card = denfenseCards[i] as GameCard;
				Card3DCantainer.getInstance().addElement(card);
				point = CardManager.getPointByAddress(card.cardInfo["address"]);
				Tween.to(card,500,{x:point.x, y:point.y, scaleX:1, scaleY:1,onComplete:complete});
			}
		}
	}
}