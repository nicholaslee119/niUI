package com.syndrome.sanguo.classlib
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	
	public class UISprite extends EventDispatcher 
	{
		public var sprite:* = null;
		public var type:String = null;
		  
		public function UISprite(_type:String, _sprite:*)
		{
			if(_type != null)
				type = _type;
			else
				trace("[UISprite] _type is null");   
			if(_sprite != null){
				sprite = _sprite;
				init();
			}else
				trace("[UISprite] _sprite is null");
		}
		
		protected function init():void
		{
			
		}
		
		
	}
}