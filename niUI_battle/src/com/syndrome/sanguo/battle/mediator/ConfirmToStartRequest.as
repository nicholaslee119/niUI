package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.common.ConfigInfo;
	
	import components.MessageWindow;
	
	import net.ESB;
	import net.IProtocolhandler;
	import net.parameter.MessageParameters;

	/**
	 * 技能/禀赋/效果是否发动的询问
	 */
	public class ConfirmToStartRequest implements IProtocolhandler
	{
		public function ConfirmToStartRequest()
		{
		}
		
		public function handle(message:Object):void
		{
			var cancel:Boolean = message["cancel"];
			var event:String = message["event"];
			
			if(!isNaN(int(event))){   //是数字
				event = ConfigInfo.getEventMsg(int(event));
			}
			MessageWindow.show(event , "提示" , clickHandler , true , cancel);
			
			CombatConsole.getInstance().currentRequest = this;
		}
		
		private function clickHandler(detail:String):void
		{
			var obj:Object = {};
			obj["id"] = MessageParameters.CONFIRM_TO_START_RESPOND;
			if(detail == MessageWindow.COMFIRM){
				obj["start"] = true;
			}else{
				obj["start"] = false;
			}
			ESB.sendBattleMsg(obj);
		}
		
		public function destroy():void
		{
			
		}
	}
}