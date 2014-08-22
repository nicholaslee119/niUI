package com.syndrome.sanguo.battle.effect
{
	import com.syndrome.sanguo.battle.effect.effectbase.AnimateFilterEffectBase;
	
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;
	
	import utils.ColorUtil;
	
	/** 
	 * 亮度渐变效果  亮度变化范围为-1到1
	 */
	public class BrightnessFilterEffect extends AnimateFilterEffectBase
	{
		public var brightnessFrom:Number;
		public var brightnessTo:Number;
		
		public function BrightnessFilterEffect(target:DisplayObject, duration:Number, brightnessFrom:Number = 0, brightnessTo:Number = 0)
		{
			this.brightnessFrom = brightnessFrom;
			this.brightnessTo = brightnessTo;
			bitmapFilter = new ColorMatrixFilter();
			super(target, duration);
		}
		
		override protected function changeFilterByPercent(percent:Number) : void
		{
			(bitmapFilter as ColorMatrixFilter).matrix = ColorUtil.getColorMatrixByBrightness(this.brightnessFrom + (this.brightnessTo - this.brightnessFrom) * percent);
			super.changeFilterByPercent(percent);
		}
	}
}