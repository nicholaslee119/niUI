package com.syndrome.sanguo.battle.command
{
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.TipGroup;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Scence2DCantainer;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	public class TimeControl extends CommandBase
	{
		private var timer:Timer;
		
		private var isMe:Boolean;
		private var currentTime:Number;
		private var totalTime:Number;
		private var startTime:uint;
		private var timeOutFunction:Function;
		
		private static var instance:TimeControl;
		
		/**
		 * 时间控制器
		 */
		public function TimeControl()
		{
			super();
			timer = new Timer(100);
		}
		
		/**
		 * 开始计时 ， 时间以秒为单位,timeOutFunction时间到了触发
		 */
		public static function start(isMe:Boolean , currentTime:Number , totalTime:Number , timeOutFunction:Function = null):void
		{
			if(instance ==null){
				instance = new TimeControl();
			}else{
				instance.destroy();
			}
			instance.startTime = getTimer();
			instance.isMe = isMe;
			instance.currentTime = currentTime;
			instance.totalTime = totalTime;
			instance.timeOutFunction = timeOutFunction;
			instance.play();
//			if(!isMe){
//				TipGroup.showText("等待对方行动....");
//			}else{
//				TipGroup.cleanText();
//			}
		}
		
		private function play():void
		{
			if(!timer.hasEventListener(TimerEvent.TIMER)){
				timer.addEventListener(TimerEvent.TIMER , onTimer);
			}
			timer.start();
		}
		
		private function onTimer(e:TimerEvent):void
		{
			var lostTime:Number =currentTime - (getTimer() - startTime)/1000;
			if(lostTime<0){
				lostTime = 0;
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER , onTimer);
				if(timeOutFunction != null){
					timeOutFunction();
				}
			}
			Scence2DCantainer.getInstance().setTurnTime(lostTime , totalTime , isMe);
		}
		
		override protected function destroy():void
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER , onTimer);
			Scence2DCantainer.getInstance().setTurnTime(currentTime , totalTime , isMe);
			Scence2DCantainer.getInstance().setTurnTime(0 , 0 , !isMe);
			timeOutFunction = null;
		}
	}
}