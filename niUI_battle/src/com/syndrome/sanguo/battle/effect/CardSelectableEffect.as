package com.syndrome.sanguo.battle.effect
{
	import com.syndrome.sanguo.battle.effect.effectbase.CustomEffectBase;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	
	/**
	 * 卡片可选效果，暂时弃用
	 */
	public class CardSelectableEffect extends CustomEffectBase
	{
		private static var allCardSelectableEffect:Array = [];

		private var targetFilters:Array;
		private var target:DisplayObject;
		private var glowFilter:GlowFilter;
		
		private var speed:Number = 3;
		private var maxValue:Number = 50;
		
		public function CardSelectableEffect(target:DisplayObject)
		{
			super();
			this.target = target;
		}
		
		public static function clearAllCardSelectableEffect():void
		{
			while(allCardSelectableEffect.length>0)
			{
				(allCardSelectableEffect.pop()).end();
			}
		}
		
		protected function createFilter():void
		{
			if(!glowFilter){
				glowFilter = new GlowFilter(0xffffff,0.6,100,100,4,1,true,false);
			}
			if(allCardSelectableEffect && allCardSelectableEffect.length>0){
				glowFilter.blurX = allCardSelectableEffect[0].glowFilter.blurX;
				glowFilter.blurY = allCardSelectableEffect[0].glowFilter.blurY;
				flag = allCardSelectableEffect[0].flag;
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
			super.play();
			createFilter();
			addFilterToTarget();
			if(allCardSelectableEffect.indexOf(this)<0){
				allCardSelectableEffect.push(this);
			}
		}
		
		override public function end():void
		{
			super.end();
			removeFilterFromTarget();
			if(allCardSelectableEffect.indexOf(this)>=0){
				allCardSelectableEffect.splice(allCardSelectableEffect.indexOf(this),1);
			}
		}
		
		private var flag:Boolean = false;
		override protected function enterFrameHandler(event:Event):void
		{
			var blurX:Number;
			var blurY:Number;
			if(flag){
				blurX = glowFilter.blurX+speed;
				blurY = glowFilter.blurY+speed;
				if(blurX>maxValue){
					flag = false;
				}
			}else{
				blurX = glowFilter.blurX-speed;
				blurY = glowFilter.blurY-speed;
				if(blurX<10){
					flag = true;
				}
			}
			blurX = Math.min(maxValue,Math.max(10,blurX));
			blurY = Math.min(maxValue,Math.max(10,blurY));
			
			glowFilter.blurX = blurX;
			glowFilter.blurY = blurY;
			this.target.filters = targetFilters;
		}
	}
}