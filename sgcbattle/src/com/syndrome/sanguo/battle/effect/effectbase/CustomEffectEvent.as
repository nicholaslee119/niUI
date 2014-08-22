package com.syndrome.sanguo.battle.effect.effectbase
{
    import flash.events.*;

    dynamic public class CustomEffectEvent extends Event
    {
        public static const START:String = "constom_effect_start";
        public static const END:String = "constom_effect_end";
        public static const STOP:String = "constom_effect_stop";
        public static const PAUSE:String = "constom_effect_pause";
        public static const RESUME:String = "constom_effect_resume";

        public function CustomEffectEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
        }
    }
}
