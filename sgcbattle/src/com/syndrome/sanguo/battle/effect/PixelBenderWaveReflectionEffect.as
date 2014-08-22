package com.syndrome.sanguo.battle.effect
{
    import com.syndrome.sanguo.battle.effect.effectbase.PixelBenderEffectBase;
    
    import flash.display.DisplayObject;
    
	/**
	 * 波浪效果
	 */
    public class PixelBenderWaveReflectionEffect extends PixelBenderEffectBase
    {
        public var progressFrom:Number = 0;
        public var progressTo:Number = 0;
        public var amplitudeFrom:Number = 0.33;
        public var amplitudeTo:Number = 0.33;
        public var frequencyFrom:Number = 0.22;
        public var frequencyTo:Number = 0.22;
		
		[Embed (source="resource/ui/PixelBenderWaveReflectionEffect.pbj", 
		        mimeType="application/octet-stream")]
		private static var cls:Class;

        public function PixelBenderWaveReflectionEffect(target:DisplayObject, duration:Number)
        {
            super(target, duration, cls);
        }

        override protected function changeFilterByPercent(percent:Number) : void
        {
            shader.data["progress"].value = [this.progressFrom + (this.progressTo - this.progressFrom) * percent];
            shader.data["amplitude"].value = [this.amplitudeFrom + (this.amplitudeTo - this.amplitudeFrom) * percent];
            shader.data["frequency"].value = [this.frequencyFrom + (this.frequencyTo - this.frequencyFrom) * percent];
            super.changeFilterByPercent(percent);
        }

    }
}
