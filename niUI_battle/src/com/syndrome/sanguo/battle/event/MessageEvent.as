package com.syndrome.sanguo.battle.event
{
	import flash.events.Event;
	
	public class MessageEvent extends Event
	{
		public static const SEND:String = "send";
		
		public var username:String;
		public var nickname:String;
		public var message:String;
		public var channel:int;
		
		public function MessageEvent(type:String , message:String , channel:int , username:String = null, nickname:String = null)
		{
			super(type, bubbles, cancelable);
			this.username = username;
			this.nickname = nickname;
			this.message = message;
			this.channel = channel;
		}
	}
}