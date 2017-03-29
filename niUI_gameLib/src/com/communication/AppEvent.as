package com.communication
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.setTimeout; 

	public class AppEvent extends Event
	{
		/**
		 * 消息类型是：场景准备
		 */		
		public static const ScenePrepare:String = "scenePrepare"; 
		/**
		 * 消息类型是：场景准备完毕
		 */		
		public static const ScenePrepareDone:String = "scenePrepareDone";
		 
		public var objHander:Object =null; 
		public var retStr:String = "";	//返回值 
		public var resObj:Array = null; //资源 
		
		public var resObjName:Array =null; //资源包类名 
		
		public function AppEvent(type:String,obj:*=null,bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			objHander =obj; 
			super(type, bubbles, cancelable); 
		} 
	}
}