package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.command.SelectATKGenerals;
	import com.syndrome.sanguo.battle.common.ConfigInfo;
	import com.syndrome.sanguo.battle.event.SelectEvent;
	
	import flash.events.Event;
	
	import net.ESB;
	import net.IProtocolhandler;
	import net.parameter.MessageParameters;

	/**
	 * 选择参加战斗的卡片
	 */
	public class BattleCardRequest implements IProtocolhandler
	{
		public function BattleCardRequest()
		{
		}
		
		public function handle(message:Object):void
		{
			var event:int =int(message["event"]);
			var eventStr:String = ConfigInfo.getEventMsg(event);
			var cardAddress:Array = message["cardAddress"];
			var must:Boolean = message["must"];
			var generalAmount:int = message["generalAmount"];
			var generalChosenAmount:int = message["generalChosenAmount"];
			var confirm:Boolean = message["confirm"];
			var cancel:Boolean = message["cancel"];
			
			var selectATKGenerals:SelectATKGenerals = new SelectATKGenerals();
			selectATKGenerals.show(cardAddress , confirm , cancel , eventStr);
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
			obj["id"] = MessageParameters.BATTLE_CARD_RESPOND;
			obj["cardAddress"] = event.data[0] ;
			obj["cancel"] = false;
			obj["confirm"] = false;
			ESB.sendBattleMsg(obj);
			destroy();
		}
		
		protected function cancelClick(event:Event):void
		{
			var obj:Object = {};
			obj["id"] = MessageParameters.BATTLE_CARD_RESPOND;
			obj["cardAddress"] = 0 ;
			obj["cancel"] = true;
			obj["confirm"] = false;
			ESB.sendBattleMsg(obj);
			destroy();
		}
		
		protected function confirmClick(event:Event):void
		{
			var obj:Object = {};
			obj["id"] = MessageParameters.BATTLE_CARD_RESPOND;
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