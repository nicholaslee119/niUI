package com.syndrome.sanguo.battle.effect.effectbase
{
	
	import flash.display.DisplayObject;
	import flash.display.Shader;
	import flash.filters.ShaderFilter;
	import flash.utils.ByteArray;

    public class PixelBenderEffectBase extends AnimateFilterEffectBase
    {
        protected var shader:Shader;

        public function PixelBenderEffectBase(target:DisplayObject, duration:Number, clazz:Class)
        {
            super(target, duration);
            this.initFilter(clazz);
        }

        protected function initFilter(clazz:Class) : void
        {
            this.shader = new Shader(new clazz() as ByteArray);
            bitmapFilter = new ShaderFilter(this.shader);
        }
    }
}
