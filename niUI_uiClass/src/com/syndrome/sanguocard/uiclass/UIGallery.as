package com.syndrome.sanguocard.uiclass
{
	import com.syndrome.sanguo.classlib.UIBase;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	
	/*
	* 画廊组件
	* @author nic
	* @build-time 2014-3-11
	* @comments
	*/
	public class UIGallery extends UIBase
	{
		private var btnClass:Class;
		private var index:int = 0;
		private var uiRadio:UIRadio;
		
		public function UIGallery(_ui:Sprite, _class:Class)
		{
			super();
			ui = _ui;
			btnClass = _class;
			init();
		}
		
		override public function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			uiRadio = new UIRadio(ui.sprite_btns, false);
			index = 0;
		}
		
		public function addPic(bitmap:Object):void
		{
			bitmap.x = index*bitmap.width;
			ui.sprite_gallery.addChild(bitmap);
			var btn:MCButton = new MCButton(new btnClass(), true);
			btn.tags = new Object(); 
			btn.tags = index;
			btn.addEventListener(MouseEvent.CLICK, galleryBtnClick);
			btn.x = index*btn.width;
			ui.sprite_btns.addChild(btn);
			index = index+1;
			uiRadio.clear();
			uiRadio.init();
		}
		
		private function galleryBtnClick(e:MouseEvent):void
		{
			ui.sprite_gallery.x = -(int(MCButton(e.currentTarget).tags))*(ui.sprite_gallery.getChildAt(0).width);
		}
		
	}
}