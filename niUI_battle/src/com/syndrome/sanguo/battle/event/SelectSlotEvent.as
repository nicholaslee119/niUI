package com.syndrome.sanguo.battle.event
{
	import flash.events.Event;
	
	public class SelectSlotEvent extends Event
	{
		public static const SELECTSLOT:String = "selectslot";
		
		/**
		 * 选择的卡槽索引
		 */
		public var index:int;
		public function SelectSlotEvent(type:String , index:int)
		{
			super(type, bubbles, cancelable);
			this.index = index;
		}
	}
}