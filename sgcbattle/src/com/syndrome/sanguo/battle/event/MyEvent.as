package com.syndrome.sanguo.battle.event
{
	import flash.events.Event;
	
	public class MyEvent extends Event
	{
		public var message:Object;
		public static const CLEAR_CONSOLE:String = "clearConsole";
		public static const CREATE_CARD:String = "createCard";
		public static const ADD_CARD_LOGIC:String = "addCardLogic";
		public static const ADD_CARD_STAGE:String = "addCardStage";
		public static const SHOW_ATTACK_WINDOW:String = "showAttackWindow";
		public static const DO_ATTACK:String = "doAttack";
		public static const CANCEL_ATTACK:String = "cancelAttack";
		public static const BEGIN_ATTACK:String = "beginAttack";
		public static const END_ROUND:String = "endRound";
		public static const PLAYER_SELECT:String = "playerSelect";
		public static const MOUSE_CLICK_CARD:String = "mouseClickCard";
		public static const MOUSE_OVER_CARD:String = "mouseOverCard";
		public static const MOUSE_OUT_CARD:String = "mouseOutCard";
		public static const DO_ATTACK_SUCCESS_EFFECT:String = "doAttackSuccessEffect";
		public static const DO_ATTACK_CARD_FLIP:String = "doAttackCardFlip";
		public static const SHOW_DUEL_END_WINDOW:String = "showDuelEndWindow";
		
		public function MyEvent(type:String, message:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			this.message = message;
			super(type, bubbles, cancelable);
		}
	}
}