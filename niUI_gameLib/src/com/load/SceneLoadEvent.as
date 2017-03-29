package com.load
{
	import flash.events.Event;
	
	public class SceneLoadEvent extends Event
	{
		public static const updateProgress:String="progress";
		public static const compelteProgress:String="onesucss";
		public static const complete:String="sucss";
		public static const err:String="err";
		public var	  msgLog:String="";//日志
		public var	 errMsg:String="";
		public var	bytesLoaded:uint=0;
		public var	bytesTotal:uint=0;
		public var	count:int=0;
		public var	nIndex:int=0;
		public function SceneLoadEvent(type:String,Logs:String=null)
		{
			msgLog=Logs;
			super(type);
		}
	}
}