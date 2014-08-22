package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	
	import components.MessageWindow;
	
	
	import net.ESB;
	import net.parameter.MessageParameters;
	import net.IProtocolhandler;
	
	/**
	 * 重置手牌询问
	 */
	public class RedealRequest implements IProtocolhandler
	{
		public function RedealRequest()
		{
		}
		
		public function handle(message:Object):void
		{
			MessageWindow.show("是否重置手牌？","提示",click);
		}
		
		private function click(s:String):void
		{
			var obj:Object = {};
			obj["id"] = MessageParameters.REDEAL_RESPOND;
			if(s == MessageWindow.COMFIRM){
				obj["operation"] = 1;
			}else{
				obj["operation"] = 2;
			}
			ESB.sendBattleMsg(obj);
		}
	}
}