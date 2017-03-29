package com.syndrome.sanguo.battle.effect
{
	import com.syndrome.sanguo.battle.effect.effectbase.CustomEffectBase;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	/**
	 * 旋转效果
	 */
	public class RotateEffect extends CustomEffectBase
	{
		public var target:Sprite;
		public var rotateFrom:Number;
		public var rotateTo:Number;
		public var duration:int;
		
		public function RotateEffect(target:Sprite, rotateFrom:Number, rotateTo:Number, duration:int)
		{
			this.target = target;
			this.rotateFrom = rotateFrom;
			this.rotateTo = rotateTo;
			this.duration = duration;
		}
		
		override public function end() : void
		{
			this.target.rotation = this.rotateTo;
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
				this.target.rotation = this.rotateFrom + (this.rotateTo - this.rotateFrom) * percent;
			}
		}
	}
}