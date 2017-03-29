package com.syndrome.sanguo.battle.effect
{
	import com.syndrome.sanguo.battle.effect.effectbase.AnimateFilterEffectBase;
	
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilter;
	
	/**
	 * 滤镜缓动效果
	 */
	public class AnimateFilterEffect extends AnimateFilterEffectBase
	{
		private var _propertyObject:Object ={};
		
		private var startProperty:Object = {};
		
		public function AnimateFilterEffect(target:DisplayObject, duration:Number, bitmapFilter:BitmapFilter)
		{
			super(target, duration);
			this.bitmapFilter = bitmapFilter;
		}
		
		public function get propertyObject():Object
		{
			return _propertyObject;
		}
		
		/**
		 * 要缓动的滤镜的属性
		 */
		public function set propertyObject(value:Object):void
		{
			_propertyObject = value;
			for(var str:String in propertyObject) 
			{
				if(bitmapFilter.hasOwnProperty(str)){
					startProperty[str] = bitmapFilter[str];
				}
			}
		}
		
		override protected function changeFilterByPercent(percent:Number) : void
		{
			for(var str:String in startProperty) 
			{
				bitmapFilter[str] = (propertyObject[str] - startProperty[str])*percent + startProperty[str];
			}
			super.changeFilterByPercent(percent);
		}
	}
}