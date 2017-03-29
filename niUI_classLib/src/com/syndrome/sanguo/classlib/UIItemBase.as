package com.syndrome.sanguo.classlib
{
	public class UIItemBase
	{
		protected var type:String = null;
		public var ui:* = null;
		
		public function UIItemBase(_type:String)
		{
			if(type==null)type = _type; 
			init();
		}     
		
		protected function init():void{}
	}
}