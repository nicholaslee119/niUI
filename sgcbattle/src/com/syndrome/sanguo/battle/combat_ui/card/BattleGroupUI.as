package com.syndrome.sanguo.battle.combat_ui.card
{
	import com.syndrome.sanguo.battle.skin.DefenseIconSkin;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.filters.DropShadowFilter;
	
	import org.flexlite.domUI.components.SkinnableComponent;
	import org.flexlite.domUI.components.UIAsset;
	
	public class BattleGroupUI extends SkinnableComponent
	{
		public var colorUI:UIAsset;
		
		public function BattleGroupUI()
		{
			super();
			this.filters = [new DropShadowFilter(4,90)];
			this.mouseChildren = false;
			this.mouseEnabled = false;
		}
		
		private var _color:uint;
		public function get color():uint
		{
			return _color;
		}

		private var colorChanged:Boolean;
		public function set color(value:uint):void
		{
			if(value != _color){
				_color = value;
				colorChanged = true;
			}
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(colorChanged){
				colorChanged = false;
				changeColor();
			}
		}
		
		private function changeColor():void{
			var bitmapdata:BitmapData = (colorUI.skin as Bitmap).bitmapData;
			for(var i:int=0;i<bitmapdata.width;i++){
				for(var j:int=0;j<bitmapdata.height;j++){
					var c:uint=bitmapdata.getPixel32(i,j);
					bitmapdata.setPixel32(i,j,c&0xFF000000|color);
				}
			}
		}
	}
}