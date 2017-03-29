package com.communication
{
	import flash.events.Event;

	public class ComEvent extends Event
	{
		public static const CONNECTED:String="connected";//连接成功
		public static const CONNECTCUT:String="connectcut";//登陆成功
		public static const PROTOCOL:String="protocol";//发送游戏协议
		
		public var msg:String="";
		public var data:EventObj=null; //通讯数据
		public var sucss:Boolean =false;
		public function ComEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}