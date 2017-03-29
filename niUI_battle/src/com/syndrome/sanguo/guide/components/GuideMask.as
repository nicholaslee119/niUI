package com.syndrome.sanguo.guide.components
{
	import flash.geom.Rectangle;
	
	import org.flexlite.domUI.core.UIComponent;
	
	public class GuideMask extends UIComponent
	{
		public function GuideMask()
		{
			super();
			this.includeInLayout = false;
		}
		
		private var _rect:Rectangle = new Rectangle(0,0,0,0);
		
		/**
		 * 镂空矩形
		 */
		public function get rect():Rectangle
		{
			return _rect;
		}

		public function set rect(value:Rectangle):void
		{
			_rect = value;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth , unscaledHeight);
			this.graphics.clear();
			this.graphics.beginFill(0x00ff00,0);
			this.graphics.drawRect(0,0,unscaledWidth,unscaledHeight);
			if(rect.width!=0&&rect.height!=0)
			{
				this.graphics.drawRect(rect.x,rect.y,rect.width,rect.height);
			}
			this.graphics.endFill();
//			this.graphics.lineStyle(2,0xFFCC00,1);
//			this.graphics.drawRect(rect.x,rect.y,rect.width,rect.height);
//			this.graphics.endFill();
		}
	}
}