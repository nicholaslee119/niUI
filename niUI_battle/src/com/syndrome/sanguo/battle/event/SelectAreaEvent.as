package com.syndrome.sanguo.battle.event
{
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.CardSlotBase;
	
	import flash.events.Event;
	
	public class SelectAreaEvent extends Event
	{
		public static const SELECTAREA:String = "selectarea";
		
		/**
		 * 选择区域的类型
		 */
		public var cardSlot:CardSlotBase;
		
		public function SelectAreaEvent(type:String, cardSlot:CardSlotBase)
		{
			super(type, bubbles, true);
			this.cardSlot = cardSlot;
		}
	}
}