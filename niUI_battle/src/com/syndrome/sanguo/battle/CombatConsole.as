package com.syndrome.sanguo.battle
{
	import com.syndrome.sanguo.battle.combat_ui.CombatGroup;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class CombatConsole extends EventDispatcher
	{
		public static const CONFIRM:String = "confirm";
		public static const CANCEL:String = "cancel";
		public static const SKIP:String = "skip";
		public static const WAITING:String = "waiting";
		public static const LEAVE:String = "leave";
		
		private var actionTimer:Timer;
		private var actionList:Array;
		private static var _instance:CombatConsole = new CombatConsole;
		
		public var enableActionList:Boolean = true;
		public var isDule:Boolean = false;
		
		public var currentRequest:Object;
		
		public function CombatConsole()
		{
			this.actionList = new Array();
			this.actionTimer = new Timer(50);
			this.actionTimer.addEventListener(TimerEvent.TIMER, this.actionTimerHandler);
			this.actionTimer.start();
		}
		
		public function start():void
		{
			isDule = true;
			this.actionTimer.start();
		}
		
		public function clearConsole() : void
		{
			this.actionList = new Array();
			this.actionTimer.stop();
			this.actionTimer.removeEventListener(TimerEvent.TIMER, this.actionTimerHandler);
			_instance = new CombatConsole();
			actionTimer.stop();
			enableActionList = false;
			isDule = false;
			if(currentRequest && currentRequest.hasOwnProperty("destroy")){
				currentRequest.destroy();
				currentRequest = null;
			}
		}
		
		public function addActionList(param:Array) : void
		{
			this.actionList.push(param);
		}
		
		public function get actionLength():int
		{
			return this.actionList.length;
		}
		
		public function actionTimerHandler(event:TimerEvent = null) : void
		{
			if (!this.enableActionList || CombatGroup.getInstance() == null)
			{
				this.actionTimer.delay = 50;
				return;
			}
			if (this.actionList.length > 0)
			{
				var param:Array = this.actionList.shift();
				this.actionTimer.delay = param[0];
				var i:int = 1;
				while (i < param.length)
				{
					if (param[i].length)
					{
						(param[i].shift() as Function).apply(null, param[i]);
					}
					i++;
				}
			}else{
				dispatchEvent(new Event(CombatConsole.WAITING));
			}
		}
		
		public static function getInstance() : CombatConsole
		{
			return _instance;
		}
	}
}