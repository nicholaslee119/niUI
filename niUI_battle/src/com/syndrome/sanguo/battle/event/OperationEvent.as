package com.syndrome.sanguo.battle.event
{
	import flash.events.Event;
	
	public class OperationEvent extends Event
	{
		public static const OPERATION:String = "operation";

		/**
		 * 0：摆放兵权	1：征兵	2：取镇	3：伏将	4：伏谋	5：遣将  6：点击事件  7：点击阵型  99 : 作弊
		 */
		public var index:int;
		
		public function OperationEvent(type:String,  index:int =0)
		{
			super(type, bubbles, cancelable);
			this.index = index;
		}
	}
}