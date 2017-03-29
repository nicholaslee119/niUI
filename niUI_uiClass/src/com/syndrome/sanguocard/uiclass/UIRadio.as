package com.syndrome.sanguocard.uiclass
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/*
	* 单选组件
	* @author nic
	* @build-time 2014-3-12
	* @comments
	*/
	public class UIRadio
	{
		private var selection:int = 0;
		private var container:Array = new Array();
		private var sprite:Sprite;
		
		public function UIRadio(_sprite:Sprite, _initFirst:Boolean=true)
		{
			sprite = _sprite;
			if(_initFirst)init();
		}
		
		public function init():void
		{
			MCButton(sprite.getChildAt(0)).selected = true;
			for(var i:Number=0; i<sprite.numChildren; i++)
			{
				container.push(sprite.getChildAt(i));
				sprite.getChildAt(i).addEventListener(MouseEvent.CLICK, onBtnClick);
			}
		}
		
		public function clear():void
		{
			for(var i:Number=0; i<sprite.numChildren; i++)
			{
				sprite.getChildAt(i).removeEventListener(MouseEvent.CLICK, onBtnClick);
			}
			container.splice(0);
		}
		
		private function onBtnClick(e:MouseEvent):void
		{
			container.forEach(clearSelection);
			MCButton(e.currentTarget).selected = true;
			selection = container.indexOf(MovieClip(e.target));
		}
		
		private function clearSelection(item:MovieClip, index:int, array:Array):void
		{
			item.selected = false;
		}
		
		public function getSelection():int
		{
			return selection;
		}
	}
}