package com.syndrome.sanguo.guide.config
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.guide.GuideSystem;
	import com.syndrome.sanguo.guide.func.GuideFunction;
	
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import net.IProtocolhandler;
	
	public class CommandAdapter implements ICommandAdapter
	{
		public function CommandAdapter()
		{
		}
		
		private var guideFunction:GuideFunction = new GuideFunction();
		public function run(command:String, param:Object, guideSystem:GuideSystem):void
		{
			var fun:Function;
			if(guideFunction.hasOwnProperty(command))  //函数库中存在这个函数
			{
				fun = guideFunction[command];
			}
			else
			{
				try
				{
					var clazz:Class = getDefinitionByName( "com.syndrome.sanguo.battle.mediator." + command ) as Class;
					fun = (new clazz() as IProtocolhandler).handle;
				} 
				catch(error:Error) 
				{
					throw(new Error("无法解析命令"+command));
				}
			}
			fun(param);
			var delayFun:Function = function(event:Event):void
			{
				event.stopImmediatePropagation();
				CombatConsole.getInstance().removeEventListener(CombatConsole.WAITING , delayFun);
				if(guideSystem.auto)
				{
					guideSystem.doNext();
				}
			}
			CombatConsole.getInstance().addEventListener(CombatConsole.WAITING , delayFun);
		}
	}
}