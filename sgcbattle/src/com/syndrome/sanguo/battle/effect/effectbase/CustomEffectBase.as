package com.syndrome.sanguo.battle.effect.effectbase
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;

    public class CustomEffectBase extends EventDispatcher
    {
        public var isPlaying:Boolean;
        protected var effectStartTime:uint;
        public static var FRAME_RATE:int = 60;
        private static var _shape:Shape = new Shape();

        public function CustomEffectBase()
        {
        }

        public function play() : void
        {
            this.effectStartTime = getTimer();
            this.isPlaying = true;
            _shape.addEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
            dispatchEvent(new CustomEffectEvent(CustomEffectEvent.START));
        }

        public function end() : void
        {
            this.isPlaying = false;
            _shape.removeEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
            dispatchEvent(new CustomEffectEvent(CustomEffectEvent.END));
        }

        public function stop() : void
        {
            this.isPlaying = false;
            _shape.removeEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
            dispatchEvent(new CustomEffectEvent(CustomEffectEvent.STOP));
        }

        public function pause() : void
        {
            this.isPlaying = false;
            _shape.removeEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
            dispatchEvent(new CustomEffectEvent(CustomEffectEvent.PAUSE));
        }

        public function resume() : void
        {
            this.isPlaying = true;
            _shape.addEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
            dispatchEvent(new CustomEffectEvent(CustomEffectEvent.RESUME));
        }

        protected function enterFrameHandler(event:Event) : void
        {
        }

    }
}
