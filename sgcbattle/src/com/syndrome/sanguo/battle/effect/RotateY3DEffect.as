package com.syndrome.sanguo.battle.effect
{
	import com.syndrome.sanguo.battle.effect.effectbase.CustomEffectBase;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;

	/**
	 * 翻转特效
	 */
    public class RotateY3DEffect extends CustomEffectBase
    {
        public var target:Sprite;
        public var yFrom:Number;
        public var yTo:Number;
        public var duration:int;

        public function RotateY3DEffect(target:Sprite, yFrom:Number, yTo:Number, duration:int)
        {
            this.target = target;
            this.yFrom = yFrom;
            this.yTo = yTo;
            this.duration = duration;
        }

        override public function end() : void
        {
            this.target.rotationY = this.yTo;
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
                this.target.rotationY = this.yFrom + (this.yTo - this.yFrom) * percent;
            }
        }
    }
}
