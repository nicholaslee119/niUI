package com.syndrome.sanguo.battle.combat_ui
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.card.cardimage.CardImage;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Scence2DCantainer;
	import com.syndrome.sanguo.battle.effect.swfeffect.SwfEffectBase;
	import com.syndrome.sanguo.battle.property.BattleFieldConst;
	import com.syndrome.sanguo.battle.property.CardConst;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import manger.SoundManager;
	
	import org.flexlite.domDll.Dll;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.effects.Scale;
	import org.flexlite.domUI.effects.animation.Animation;
	import org.flexlite.domUI.effects.animation.MotionPath;
	import org.flexlite.domUI.events.EffectEvent;
	
	/**
	 * 结算界面
	 */
	public class ResultWindow extends Group
	{
		private var resultInfo:Object;
		
		
		private var resultEffect:SwfEffectBase;
		private var textEffect:SwfEffectBase;
		
		
		public function ResultWindow()
		{
			super();
			this.width = BattleFieldConst.stage_width;
			this.height = BattleFieldConst.stage_height;
		}
		
		private var isShowText:Boolean;
		
		/**
		 * @param resultInfo  包含字段 winner  oldScore  addScore  cardIds
		 */
		public function show(resultInfo:Object):void
		{
			//关闭背景音乐
			SoundManager.playBattleBGM(false);
			
			//隐藏所有按钮
			Scence2DCantainer.getInstance().disabledAllButton();
			
			this.resultInfo = resultInfo;
			
			if(!resultInfo.hasOwnProperty("cardIds") || resultInfo["cardIds"].length<1)
			{
				isShowText = false;
			}
			else
			{
				isShowText = true;
			}
			
			var clazz:Class;
			if(resultInfo["winner"]){
				clazz = Dll.getRes("Result_Success") as Class;
				SoundManager.play("MP3_Victory");
			}else{
				clazz = Dll.getRes("Result_Defeat") as Class;
				SoundManager.play("MP3_Failure");
			}
			var mc:MovieClip = new clazz();
			resultEffect = new SwfEffectBase(mc);
			resultEffect.x = this.width/2;
			resultEffect.y = this.height/2;
			resultEffect.autoRemove = false;
			resultEffect.addEventListener(SwfEffectBase.SWF_EFFECT_END , swfEnd);
			if(!isShowText){
				mc.addFrameScript(85,function():void{
					mc.addFrameScript(85,null);
					resultEffect.stop();
				});
			}
			resultEffect.startPlay();
			this.addElement(resultEffect);
		}
		
		protected function swfEnd(event:Event = null):void
		{
			if(event)
				event.currentTarget.removeEventListener(SwfEffectBase.SWF_EFFECT_END , swfEnd);
			if(isShowText){
				showScore();
				showRank();
			}else{
				showCard();
			}
		}
		
		/**
		 * 显示积分
		 */
		private function showScore():void
		{
			var label:Label = new Label();
			label.x = 760;
			label.y = 164;
			label.textAlign = "center";
			label.verticalAlign = "middle";
			label.size = 30;
			label.textColor = 0xffffff;
			label.text = resultInfo["oldScore"] + " → " + resultInfo["oldScore"];
			this.addElement(label);
			changeLabel(label , resultInfo["oldScore"] , resultInfo["oldScore"]+resultInfo["addScore"] , function():void{
				if(resultInfo["addScore"] > 0){
					label.text = label.text+" ("+resultInfo["addScore"]+"↑)";
				}else if(resultInfo["addScore"] < 0){
					label.text = label.text+" ("+Math.abs(resultInfo["addScore"])+"↓)";
				}
				showCard();
			});
		}
		
		/**
		 * 显示排名
		 */
		private function showRank():void
		{
			var label:Label = new Label();
			label.x = 760;
			label.y = 226;
			label.textAlign = "center";
			label.verticalAlign = "middle";
			label.size = 30;
			label.textColor = 0xffffff;
			label.text = resultInfo["ranking"][0] + " → " + resultInfo["ranking"][0];
			this.addElement(label);
			changeLabel(label , resultInfo["ranking"][0] , resultInfo["ranking"][1] , function():void{
				if(resultInfo["ranking"][0] >= resultInfo["ranking"][1]){
					label.text = label.text+" ("+(resultInfo["ranking"][0]-resultInfo["ranking"][1])+"↑)";
				}else{
					label.text = label.text+" ("+(resultInfo["ranking"][1]-resultInfo["ranking"][0])+"↓)";
				}
			});
		}
		
		private function changeLabel(label:Label , start:int , end:int , complete:Function = null):void
		{
			var updateFunction:Function = function(animation:Animation):void
			{
				label.text = start +" → "+ int(animation.currentValue["text"]).toString();
			};
			var endFunction:Function = function(animation:Animation):void
			{
				if(complete!=null){
					complete();
				}
			}
			var animation:Animation = new Animation(updateFunction);
			var vector:Vector.<MotionPath> = new Vector.<MotionPath>();
			vector.push(new MotionPath("text",start,end));
			animation.duration = 500;
			animation.motionPaths = vector;
			animation.endFunction = endFunction;
			animation.play();
		}
		
		private function showCard():void
		{
			if(!isShowText){
				showContinue();
				return;
			}
			var cardIds:Array = resultInfo["cardIds"];
			var gap:Number = 50;
			for (var i:int = 0; i < cardIds.length; i++) 
			{
				var cardImage:CardImage = new CardImage();
				cardImage.refreshCardInfo({"id":cardIds[i]},true);
				cardImage.verticalCenter = 150;
				cardImage.horizontalCenter = 140 + (i - (cardIds.length-1)/2)*(gap + CardConst.width);
				cardImage.addEventListener(MouseEvent.CLICK , cardClick);
				this.addElement(cardImage);
			}
		}
		
		private var openCount:int = 0;
		protected function cardClick(event:MouseEvent):void
		{
			openCount ++;
			var effectEnd1:Function = function():void
			{
				if(card.scaleX == 0){
					card.isPositive = true;
					scale.scaleXTo = 1;
					scale.play();
				}else{
					var clazz:Class = Dll.getRes("SWF_ZonedLight") as Class;
					var lightEffect:SwfEffectBase  = new SwfEffectBase(new clazz());
					lightEffect.x = card.x;
					lightEffect.y = card.y;
					lightEffect.startPlay();
					addElement(lightEffect);
					scale.removeEventListener(EffectEvent.EFFECT_END , effectEnd1);
					
					if(openCount == resultInfo["cardIds"].length){
						showContinue();
					}
				}
			}
			
			var card:CardImage = event.currentTarget as CardImage;
			card.removeEventListener(MouseEvent.CLICK , cardClick);
			var scale:Scale = new Scale(card);
			scale.duration = 300;
			scale.scaleXTo = 0;
			scale.play();
			scale.addEventListener(EffectEvent.EFFECT_END , effectEnd1);
		}
		
		private function showContinue():void
		{
			var label:Label = new Label();
			label.textAlign = "center";
			label.verticalAlign = "middle";
			label.size = 30;
			label.textColor = 0xffffff;
			label.text = "按任意键继续...";
			label.horizontalCenter = 140;
			label.verticalCenter = 280;
			this.addElement(label);
			this.stage.addEventListener(MouseEvent.CLICK , stageClick);
		}
		
		protected function stageClick(event:MouseEvent):void
		{
			event.currentTarget.removeEventListener(MouseEvent.CLICK , stageClick);
			this.removeChildren();
			CombatConsole.getInstance().dispatchEvent(new Event(CombatConsole.LEAVE));
		}
	}
}