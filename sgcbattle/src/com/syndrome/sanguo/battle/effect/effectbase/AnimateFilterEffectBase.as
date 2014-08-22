package com.syndrome.sanguo.battle.effect.effectbase
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.filters.BitmapFilter;
	import flash.utils.getTimer;

	public class AnimateFilterEffectBase extends CustomEffectBase
	{
		public var target:DisplayObject;
		public var duration:Number;
		protected var bitmapFilter:BitmapFilter;
		protected var targetFilters:Array;
		
		public function AnimateFilterEffectBase(target:DisplayObject, duration:Number)
		{
			this.target = target;
			this.duration = duration;
		}
		
		protected function addFilterToTarget() : void
		{
			targetFilters = this.target.filters;
			if (!targetFilters)
			{
				this.target.filters = [this.bitmapFilter];
			}
			else if (targetFilters.indexOf(this.bitmapFilter) == -1)
			{
				targetFilters.push(this.bitmapFilter);
				this.target.filters = targetFilters;
			}
		}
		
		protected function removeFilterFromTarget() : void
		{
			if (targetFilters)
			{
				var index:int = targetFilters.indexOf(this.bitmapFilter);
				if (index != -1)
				{
					targetFilters.splice(index, 1);
					this.target.filters = targetFilters;
				}
			}
		}
		
		override public function play() : void
		{
			this.addFilterToTarget();
			super.play();
			this.enterFrameHandler(null);
		}
		
		override public function end() : void
		{
			this.removeFilterFromTarget();
			super.end();
		}
		
		override protected function enterFrameHandler(event:Event) : void
		{
			var percent:Number = (getTimer() - effectStartTime) / this.duration;
			if (percent >= 1)
			{
				this.end();
			}
			else
			{
				this.changeFilterByPercent(percent);
			}
		}
		
		protected function changeFilterByPercent(percent:Number) : void
		{
			this.target.filters = targetFilters;
		}
		
	}
}
