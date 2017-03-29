package com.load
{
	import flash.events.Event;

	public class xmlLoadEvent extends Event
	{
		
		public static const complete:String="sucss";
		public static const err:String="err";
		public var errMsg:String="";
		public var childs:Array=null;
		public var xmlData:XML=null;
		public function xmlLoadEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}