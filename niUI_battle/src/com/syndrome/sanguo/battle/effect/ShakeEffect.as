package com.syndrome.sanguo.battle.effect
{
	import com.syndrome.sanguo.battle.effect.effectbase.CustomEffectBase;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.utils.getTimer;

	/**
	 * 震动效果
	 */
	public class ShakeEffect extends CustomEffectBase
	{
		private var target:Object;
		private var duration:int;
		private var needBlur:Boolean;
		private var intensity:int;
		private var blurFiler:BlurFilter;
		private var originalX:Number;
		private var originalY:Number;
		
		public function ShakeEffect(target:DisplayObject,duration:Number = 800,intensity:Number = 6,needBlur:Boolean = false)
		{
			this.target = target;
			this.duration = duration;
			this.needBlur = needBlur;
			this.intensity = intensity;
		}
		
		public static function start(target:DisplayObject,duration:Number = 800,intensity:Number = 6):void
		{
			var shakeEffect:ShakeEffect = new ShakeEffect(target);
			shakeEffect.duration = duration;
			shakeEffect.needBlur = false;
			shakeEffect.intensity = intensity;
			shakeEffect.play();
		}
		
		override public function play():void
		{
			if(!isPlaying){
				this.originalX = this.target.x;
				this.originalY = this.target.y;
				if (this.needBlur && !this.blurFiler)
				{
					this.blurFiler = new BlurFilter();
					targetFilters = this.target.filters;
				}
			}
			super.play();
		}
		
	    override public function end() : void
		{
			this.target.x = this.originalX;
			this.target.y = this.originalY;
			this.removeFilterFromTarget();
			super.end();
		}
		
		override protected function enterFrameHandler(e:Event):void
		{
			var blurX:Number;
			var blurY:Number;
			var time:Number = (getTimer() - effectStartTime) / this.duration;
			if (time >= 1)
			{
				this.end();
			}
			else
			{
				blurX = (Math.random() - 0.5) * this.intensity;
				blurY = (Math.random() - 0.5) * this.intensity;
				if (this.needBlur)
				{
					this.blurFiler.blurX = int(Math.abs(blurX));
					this.blurFiler.blurY = int(Math.abs(blurY));
					this.addFilterToTarget();
				}
				this.target.x = this.originalX + blurX;
				this.target.y = this.originalY + blurY;
			}
		}
		
		protected var targetFilters:Array;
		private function addFilterToTarget() : void
		{
			if (!this.blurFiler)
			{
				return;
			}
			if (!targetFilters)
			{
				this.target.filters = [this.blurFiler];
			}
			else if (targetFilters.indexOf(this.blurFiler) == -1)
			{
				targetFilters.push(this.blurFiler);
				this.target.filters = targetFilters;
			}
		}
		
		private function removeFilterFromTarget() : void
		{
			if (!this.blurFiler)
			{
				return;
			}
			if (targetFilters)
			{
				var index:int = targetFilters.indexOf(this.blurFiler);
				if (index != -1)
				{
					targetFilters.splice(index, 1);
					this.target.filters = targetFilters;
				}
			}
		}
	}
}