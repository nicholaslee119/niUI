package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.command.SelectPhalanxGenerals;
	import com.syndrome.sanguo.battle.common.ConfigInfo;
	import com.syndrome.sanguo.battle.event.SelectEvent;
	
	import flash.events.Event;
	
	import net.ESB;
	import net.IProtocolhandler;
	import net.parameter.MessageParameters;
	
	/**
	 * 选择阵型武将
	 */
	public class ChoosePhalanxGeneralRequest implements IProtocolhandler
	{
		public function ChoosePhalanxGeneralRequest()
		{
		}
		
		public function handle(message:Object):void
		{
			var generalAddress:Array = message["generalAddress"];
//			var chosenGeneralAddress:Array = message["chosenGeneralAddress"];
//			var corpType:Array = message["corpType"];
//			var hasCorpType:Array = message["hasCorpType"];
			var confirm:Boolean = message["confirm"];
			var cancel:Boolean = message["cancel"];
			var event:int = message["event"];
			var eventStr:String = ConfigInfo.getEventMsg(event);
			
			var selectPhalanxGenerals:SelectPhalanxGenerals = new SelectPhalanxGenerals();
			selectPhalanxGenerals.show(generalAddress , confirm , cancel , eventStr);
			
			if(confirm){
				CombatConsole.getInstance().addEventListener(CombatConsole.CONFIRM , confirmClick);
			}
			if(cancel){
				CombatConsole.getInstance().addEventListener(CombatConsole.CANCEL , cancelClick);
			}
			CombatConsole.getInstance().addEventListener(SelectEvent.SELECT , selectClick);
			
			CombatConsole.getInstance().currentRequest = this;
		}
		
		protected function selectClick(event:SelectEvent):void
		{
			var obj:Object = {};
			obj["id"] = MessageParameters.CHOOSE_PHALANX_GENERAL_RESPOND;
			obj["generalAddress"] = event.data[0] ;
			obj["cancel"] = false;
			obj["confirm"] = false;
			ESB.sendBattleMsg(obj);
			destroy();
		}
		
		protected function cancelClick(event:Event):void
		{
			var obj:Object = {};
			obj["id"] = MessageParameters.CHOOSE_PHALANX_GENERAL_RESPOND;
			obj["cardAddress"] = 0 ;
			obj["cancel"] = true;
			obj["confirm"] = false;
			ESB.sendBattleMsg(obj);
			destroy();
		}
		
		protected function confirmClick(event:Event):void
		{
			var obj:Object = {};
			obj["id"] = MessageParameters.CHOOSE_PHALANX_GENERAL_RESPOND;
			obj["cardAddress"] = 0 ;
			obj["cancel"] = false;
			obj["confirm"] = true;
			ESB.sendBattleMsg(obj);
			destroy();
		}
		
		public function destroy():void
		{
			CombatConsole.getInstance().removeEventListener(CombatConsole.CONFIRM , confirmClick);
			CombatConsole.getInstance().removeEventListener(CombatConsole.CANCEL , cancelClick);
			CombatConsole.getInstance().removeEventListener(SelectEvent.SELECT , selectClick);
		}
	}
}