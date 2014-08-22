package com.syndrome.sanguo.battle.effect
{
	import com.syndrome.sanguo.battle.effect.effectbase.CustomEffectBase;
	
	import flash.events.Event;
	import flash.utils.getTimer;

	/**
	 * 移动效果
	 */
    public class MoveEffect extends CustomEffectBase
    {
        public var target:Object;
        public var xTo:Number;
        public var yTo:Number;
        public var duration:int;
        private var xDistance:Number;
        private var yDistance:Number;
        private var xFrom:Number;
        private var yFrom:Number;

        public function MoveEffect(target:Object, duration:Number = 1000)
        {
            this.target = target;
            this.duration = duration;
        }

        override public function play() : void
        {
            this.xFrom = this.target.x;
            this.yFrom = this.target.y;
            this.xDistance = this.xTo - this.xFrom;
            this.yDistance = this.yTo - this.yFrom;
            super.play();
        }

        override public function end() : void
        {
            this.target.x = this.xTo;
            this.target.y = this.yTo;
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
                this.target.x = this.xFrom + percent * this.xDistance;
                this.target.y = this.yFrom + percent * this.yDistance;
            }
        }

    }
}
