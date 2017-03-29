package com.syndrome.sanguo.battle.combat_ui.card
{
	import com.syndrome.sanguo.battle.combat_ui.card.cardimage.CardImage;
	import com.syndrome.sanguo.battle.effect.AnimateFilterEffect;
	import com.syndrome.sanguo.battle.effect.BrightnessFilterEffect;
	import com.syndrome.sanguo.battle.effect.PixelBenderWaveReflectionEffect;
	import com.syndrome.sanguo.battle.effect.ShakeEffect;
	import com.syndrome.sanguo.battle.effect.effectbase.CustomEffectEvent;
	
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.utils.setTimeout;
	
	import org.flexlite.domUI.core.IVisualElementContainer;
	import org.flexlite.domUI.effects.Fade;
	import org.flexlite.domUI.effects.Scale;
	import org.flexlite.domUI.events.EffectEvent;
	import org.flexlite.domUI.events.UIEvent;
	
	public class CardCloseness extends CardImage
	{
		public var type:int = 1;
		
		public function CardCloseness()
		{
			super();
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.scaleX = 3;
			this.scaleY = 3;
			this.addEventListener(UIEvent.CREATION_COMPLETE , createComplete);
		}
		
		protected function createComplete(event:UIEvent):void
		{
			setAttribInfo(0,0,0,false);  //隐藏攻击力
			this.removeEventListener(UIEvent.CREATION_COMPLETE , createComplete);
			switch(this.type)
			{
				case 1:
				{
					this.showGlowEffect();
					break;
				}
				case 2:
				{
					this.showBrightnessEffect();
					break;
				}
				case 3:
				{
					this.showShakeEffect();
					break;
				}
				case 4:
				{
					this.showWaveEffect();
					break;
				}
				default:
				{
					break;
				}
			}
		}
		
		private function showWaveEffect() : void
		{
			var waveEffectEndHandler:Function = function (event:CustomEffectEvent) : void
			{
				waveEffect.removeEventListener(CustomEffectEvent.END, waveEffectEndHandler);
				setTimeout(function():void{
					playRemoveEffect();
				},300);
			}
			var fade:Fade = new Fade(this);
			fade.duration = 200;
			fade.alphaFrom = 0;
			fade.alphaTo = 1;
			fade.play();
			
			var waveEffect:PixelBenderWaveReflectionEffect = new PixelBenderWaveReflectionEffect(this, 500);
			waveEffect.progressFrom = 0;
			waveEffect.progressTo = 0.1;
			waveEffect.amplitudeFrom = 1;
			waveEffect.amplitudeTo = 0;
			waveEffect.play();
			waveEffect.addEventListener(CustomEffectEvent.END, waveEffectEndHandler);
		}

		private function showGlowEffect() : void
		{
			var This:CardCloseness = this;
			var fadeInEffectEndHandler:Function = function (event:EffectEvent) : void
			{
				fade.removeEventListener(EffectEvent.EFFECT_END, fadeInEffectEndHandler);
				var glowEffectEnd:Function = function (event:CustomEffectEvent) : void
				{
					animateEffect.removeEventListener(CustomEffectEvent.END, glowEffectEnd);
					playRemoveEffect();
				}
				var glowFilter:GlowFilter = new GlowFilter(0xff0000,0.8,0,0,3);
				var propertyObject:Object = {"alpha":0 , "blurX":200 , "blurY":200};
				var animateEffect:AnimateFilterEffect = new AnimateFilterEffect(This  , 500 , glowFilter);
				animateEffect.propertyObject = propertyObject;
				animateEffect.play();
				animateEffect.addEventListener(CustomEffectEvent.END , glowEffectEnd);
			}
			var fade:Fade = new Fade(this);
			fade.duration = 200;
			fade.alphaFrom = 0;
			fade.alphaTo = 1;
			fade.play();
			fade.addEventListener(EffectEvent.EFFECT_END, fadeInEffectEndHandler);
		}
		
		private function showBrightnessEffect() : void
		{
			var scale:Scale = new Scale(this);
			var This:CardCloseness = this;
			var scaleEndHandler:Function = function (event:EffectEvent) : void
			{
				scale.removeEventListener(EffectEvent.EFFECT_END, scaleEndHandler);
				var brightEffect:BrightnessFilterEffect = new BrightnessFilterEffect(This, 150, 0, 0.7);
				var brightEffectEndHandler:Function = function (event:CustomEffectEvent) : void
				{
					var brightEffect2EndHandler:Function = function (event:CustomEffectEvent) : void
					{
						brightEffect.removeEventListener(CustomEffectEvent.END, brightEffect2EndHandler);
						playRemoveEffect();
					}
					brightEffect.removeEventListener(CustomEffectEvent.END, brightEffectEndHandler);
					brightEffect = new BrightnessFilterEffect(This, 250, 0.7, 0);
					brightEffect.play();
					brightEffect.addEventListener(CustomEffectEvent.END, brightEffect2EndHandler);
				}
				brightEffect.play();
				brightEffect.addEventListener(CustomEffectEvent.END, brightEffectEndHandler);
			}
			scale.scaleXFrom = 0.01;
			scale.scaleXTo = 3;
			scale.duration = 300;
			scale.play();
			scale.addEventListener(EffectEvent.EFFECT_END, scaleEndHandler);
		}
		
		private function showShakeEffect() : void
		{
			var shakeEffectEndHandler:Function = function (event:CustomEffectEvent) : void
			{
				this.includeInLayout = true;
				shakeEffect.removeEventListener(CustomEffectEvent.END, shakeEffectEndHandler);
				setTimeout(function():void{
					playRemoveEffect();
				},300);
			}
			var fade:Fade = new Fade(this);
			fade.duration = 200;
			fade.alphaFrom = 0;
			fade.alphaTo = 1;
			fade.play();
			this.includeInLayout = false;
			var shakeEffect:ShakeEffect = new ShakeEffect(this, 500, 15);
			shakeEffect.play();
			shakeEffect.addEventListener(CustomEffectEvent.END, shakeEffectEndHandler);
		}
		
		
		private function playRemoveEffect():void
		{
			var effectEnd:Function = function(event:EffectEvent):void
			{
				fade.removeEventListener(EffectEvent.EFFECT_END , effectEnd);
				removeSelf();
			}
			var fade:Fade = new Fade(this);
			fade.startDelay = 200;
			fade.duration = 250;
			fade.alphaFrom = 1;
			fade.alphaTo = 0;
			fade.play();
			fade.addEventListener(EffectEvent.EFFECT_END , effectEnd);
		}
		
		private function removeSelf():void
		{
			if(this.parent){
				(this.parent as IVisualElementContainer).removeElement(this);
			}
		}
	}
}