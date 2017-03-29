package com.communication
{
	import flash.events.Event;
	
	
	/*
	* @author nic
	* @build-time 2014-2-28
	* @comments 用于框架和子模块的消息传递
	*
	*/
	public class InterfaceOfSonBattleEvent extends Event
	{
		/**
		 * 初始化 
		 */		
		public static const ON_INIT:String = "1";
		/**
		 * 游戏开始 
		 */		
		public static const SEND_GAME_START:String = "2";
		/**
		 * 退出战场
		 */		
		public static const ON_RELEASE:String= "3";
		/**
		 * 玩家进入战场 
		 */		
		public static const ON_USER_ENTER:String = "4";
		/**
		 * 重置战场 
		 */		
		public static const RESET_BATTLE:String = "5";
		/**
		 * 玩家将离开
		 */		
		public static const ON_USER_WILL_LEAVE:String = "6";
		/**
		 * 当游戏状态改变 
		 */		
		public static const ON_GAME_STATE_CHANGE:String = "7";
		/**
		 * 但玩家状态改变 
		 */		
		public static const ON_USER_STATE_CHANGE:String = "8";
		/**
		 * 游戏战斗消息 
		 */		
		public static const ON_PROTOCOL:String = "9";
		/**
		 * 聊天消息 
		 */		
		public static const ON_CHANNEL_MESSAGE:String = "10";
		/**
		 * 对方掉线
		 */		
		public static const ON_OPUSER_DISCONNECT:String = "11";
		/**
		 * 消息参数对象
		 */	
		public var messagePara:Object;
		
		public function InterfaceOfSonBattleEvent(type:String, _messagePara:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			messagePara = _messagePara;
		}
	}
}