package com.load
{
	import flash.display.DisplayObject;
	import flash.events.Event;

	public class gameFramEvent extends Event
	{
		
		public static const updateProgress:String="progress";
		public static const complete:String="sucss";
		public static const err:String="err";
		public var	 errMsg:String="";
		public var	bytesLoaded:uint=0;
		public var	bytesTotal:uint=0;
		public var diplayObj:DisplayObject=null;
		public function gameFramEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}