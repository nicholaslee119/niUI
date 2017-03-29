package com.syndrome.sanguo.battle.effect
{
	import com.syndrome.sanguo.battle.effect.effectbase.CustomEffectBase;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	/**
	 * 洗切效果
	 */
	public class ShuffleEffect extends CustomEffectBase
	{
		private var cards:Array;
		private var points:Array;
		
		private var maxOffset:Number;
		private var times:int;
		private var duration:int;
		
		public function ShuffleEffect(cards:Array , duration:int = 500 , maxOffset:Number =30)
		{
			super();
			this.cards = cards;
			this.duration = duration;
			this.maxOffset = maxOffset;
			times = Math.ceil(duration/maxOffset);
			initPosition();
		}
		
		private function initPosition():void
		{
			points = [];
			for (var i:int = 0; i < cards.length; i++) 
			{
				points.push(cards[i].x);
			}
		}
		
		override public function play():void
		{
			super.play();
		}
		
		private function getOffSet(i:int , percent:Number):Number
		{
			var onePercent:Number = times*percent - Math.floor(times*percent);
			var lineFunction:Function = function(per:Number):Number
			{
				if(per<0.25){
					return -4*maxOffset*per;
				}else if(per>=0.25&&per<=0.75){
					return 4*maxOffset*per - 2*maxOffset;
				}else{
					return -4*maxOffset*per + 4*maxOffset;
				}
			}
			if(i%2){
				return lineFunction(onePercent);
			}else{
				return -1*lineFunction(onePercent);
			}
		}
		
		override public function end() : void
		{
			for (var i:int = 0; i < cards.length; i++) 
			{
				var card:DisplayObject = cards[i] as DisplayObject;
				card.x = points[i];
			}
			super.end();
		}
		
		override protected function enterFrameHandler(event:Event):void
		{
			var percent:Number = (getTimer() - effectStartTime) / this.duration;
			if (percent >= 1)
			{
				this.end();
			}
			else
			{
				for (var i:int = 0; i < cards.length; i++) 
				{
					var card:DisplayObject = cards[i] as DisplayObject;
					if(card.visible){
						card.x = points[i] + getOffSet(i , percent);
					}
				}
			}
		}
	}
}