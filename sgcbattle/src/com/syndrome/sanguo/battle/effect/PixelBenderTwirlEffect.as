package com.syndrome.sanguo.battle.effect
{
	import com.syndrome.sanguo.battle.effect.effectbase.PixelBenderEffectBase;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 * 扭曲特效
	 */
    public class PixelBenderTwirlEffect extends PixelBenderEffectBase
    {
        private var maxRadius:Number;
        private var reverse:Boolean;
        private var centerPoint:Point;
		
		[Embed (source="resource/ui/PixelBenderTwirlEffect.pbj", 
		        mimeType="application/octet-stream")]
		private static var cls:Class;
		
        public function PixelBenderTwirlEffect(target:DisplayObject, duration:Number, centerPoint:Point = null, reverse:Boolean = false)
        {
			if(!centerPoint){
				centerPoint = new Point(target.width/2 , target.height/2);
			}
            this.centerPoint = centerPoint;
            this.reverse = reverse;
            super(target, duration, cls);
        }

        override protected function initFilter(clazz:Class) : void
        {
            super.initFilter(clazz);
            this.maxRadius = this.centerPoint.x > this.centerPoint.y ? (this.centerPoint.x) : (this.centerPoint.y);
            shader.data["twirlAngle"].value = [600];
            shader.data["center"].value = [this.centerPoint.x, this.centerPoint.y];
            shader.data["radius"].value = [0.1];
        }

        override protected function changeFilterByPercent(percent:Number) : void
        {
            var percent2:Number = this.reverse ? (1 - percent) : (percent);
            shader.data["radius"].value = [0.1 + this.maxRadius * percent2];
            shader.data["scale"].value = [1 - percent2];
            super.changeFilterByPercent(percent);
        }
    }
}
