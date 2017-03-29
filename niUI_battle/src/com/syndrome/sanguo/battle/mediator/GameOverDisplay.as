package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.CombatGroup;
	import com.syndrome.sanguo.battle.combat_ui.ResultWindow;
	import com.syndrome.sanguo.battle.common.UserInfo;
	
	import flash.events.Event;
	
	import net.IProtocolhandler;

	/**
	 * 游戏结束展示
	 */
	public class GameOverDisplay implements IProtocolhandler
	{
		public function GameOverDisplay()
		{
		}
		
		public function handle(message:Object):void
		{
			CombatConsole.getInstance().isDule = false;
			
			var winner:String =message["winner"];
			var loser:String = message["loser"];
			var reason:int = message["reason"];
			
			var resultInfo:Object = {};
			resultInfo["winner"] = UserInfo.myUserName == winner;
			
			var resultWindow:ResultWindow = new ResultWindow();
			resultWindow.includeInLayout = false;
			var close:Function = function(e:Event):void
			{
				CombatConsole.getInstance().removeEventListener(CombatConsole.LEAVE , close);
				CombatGroup.getInstance().removeElement(resultWindow);
				(new GameStateUpdate()).handle({"type":"onLeave"});
			};
			CombatConsole.getInstance().addEventListener(CombatConsole.LEAVE , close);
			CombatGroup.getInstance().addElement(resultWindow);
			if(message.hasOwnProperty("cardID"))
			{ 
				var score:int = message["score"];
				var addition:int = message["addition"];
				var ranking:Array = message["ranking"];
				resultInfo["oldScore"] = score - addition;
				resultInfo["addScore"] = addition;
				resultInfo["cardIds"] = message["cardID"];
				resultInfo["ranking"] = message["ranking"]
			}
			resultWindow.show(resultInfo);
		}
	}
}