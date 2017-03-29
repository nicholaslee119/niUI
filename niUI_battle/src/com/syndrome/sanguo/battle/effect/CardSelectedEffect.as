package com.syndrome.sanguo.battle.effect
{
	import com.syndrome.sanguo.battle.effect.effectbase.CustomEffectBase;
	
	import flash.display.DisplayObject;
	import flash.filters.GlowFilter;
	
	/**
	 * 卡片选中效果，暂时弃用
	 */
	public class CardSelectedEffect extends CustomEffectBase
	{
		private var targetFilters:Array;
		private var target:DisplayObject;
		private var glowFilter:GlowFilter;
		
		public function CardSelectedEffect(target:DisplayObject)
		{
			super();
			this.target = target;
		}
		
		protected function createFilter():void
		{
			if(!glowFilter){
				glowFilter = new GlowFilter(16773120,0.5,120,120,4,1,true,false);
			}
		}
		
		protected function addFilterToTarget() : void
		{
			targetFilters = this.target.filters;
			if (!targetFilters)
			{
				this.target.filters = [glowFilter];
			}
			else if (targetFilters.indexOf(this.glowFilter) == -1)
			{
				targetFilters.push(this.glowFilter);
				this.target.filters = targetFilters;
			}
		}
		
		protected function removeFilterFromTarget() : void
		{
			if (targetFilters)
			{
				var index:int = targetFilters.indexOf(this.glowFilter);
				if (index != -1)
				{
					targetFilters.splice(index, 1);
					this.target.filters = targetFilters;
				}
			}
		}
		
		override public function play():void
		{
			if(isPlaying){
				return;
			}
			isPlaying = true;
//			super.play();
			createFilter();
			addFilterToTarget();
		}
		
		override public function end():void
		{
//			super.end();
			isPlaying = false;
			removeFilterFromTarget();
		}
	}
}