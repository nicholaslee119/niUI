package com.syndrome.sanguo.battle.event
{
	import flash.events.Event;
	
	public class SelectEvent extends Event
	{
		public static const SELECT:String = "select";

		/**
		 * 选择的卡片地址
		 */
		public var data:Array;
		public function SelectEvent(type:String , data:Array)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
	}
}