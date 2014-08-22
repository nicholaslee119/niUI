package com.syndrome.sanguo.classlib
{
	public class UISpriteWithChildren extends UISprite
	{
		public var children:* = null;
		
		public function UISpriteWithChildren(_type:String, _sprite:*, _children:*)
		{
			super(_type, _sprite);
			if(children==null)children = _children;
		}
		     
		public function formateChildrenUI():void{}
	}
}