package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.command.SelectDEFGenerals;
	import com.syndrome.sanguo.battle.common.ConfigInfo;
	import com.syndrome.sanguo.battle.event.SelectEvent;
	
	import flash.events.Event;
	
	import net.ESB;
	import net.IProtocolhandler;
	import net.parameter.MessageParameters;

	/**
	 * 选择防守武将
	 */
	public class DefenseGeneralRequest implements IProtocolhandler
	{
		public function DefenseGeneralRequest()
		{
		}
		
		public function handle(message:Object):void
		{
			var defenseRelationMap:Array = message["defenseRelationMap"];
			var cancel:Boolean = message["cancel"];
			var confirm:Boolean = message["confirm"];
			var event:int = int(message["event"]);
			var eventStr:String = ConfigInfo.getEventMsg(event);
			// 战团对应的可防守将领  战团id：[武将地址]
			
			var enableDefenseBattleGroup:Object = {};
			var esObj:Object;
			for each(esObj in defenseRelationMap)
			{
				var group:Array =esObj as Array;
				var groupID:String = group[0];
				var enableDefenseGenerals:Array =[];	//可防守武将地址
				for(var i:int = 1;i<group.length;i++){
					enableDefenseGenerals.push(int(group[i]));
				}
				enableDefenseBattleGroup[groupID] = enableDefenseGenerals;
			}
			
			var selectDEFGenerals:SelectDEFGenerals = new SelectDEFGenerals();
			selectDEFGenerals.show(enableDefenseBattleGroup , confirm , cancel , eventStr);
			CombatConsole.getInstance().addEventListener(CombatConsole.CANCEL , cancelClick);
			CombatConsole.getInstance().addEventListener(CombatConsole.CONFIRM , confirmClick);
			CombatConsole.getInstance().addEventListener(SelectEvent.SELECT , selectDEFClick);
			
			CombatConsole.getInstance().currentRequest = this;
		}
		
		private function confirmClick(event:Event):void
		{
			var obj:Object = {};
			obj["id"] = MessageParameters.DEFENSE_GENERAL_RESPOND;
			obj["confirm"] = true;
			ESB.sendBattleMsg(obj);
			destroy();
		}
		
		private function cancelClick(event:Event):void
		{
			var obj:Object = {};
			obj["id"] = MessageParameters.DEFENSE_GENERAL_RESPOND;
			obj["cancel"] = true;
			ESB.sendBattleMsg(obj);
			destroy();
		}
		
		private function selectDEFClick(event:SelectEvent):void
		{
			var obj:Object = {};
			obj["id"] = MessageParameters.DEFENSE_GENERAL_RESPOND;
			obj["battleGroupID"] = CardManager.getCard(event.data[0]).cardInfo["groupid"];
			obj["defenseCardIndex"] = event.data[1];
			obj["cancel"] = false;
			obj["confirm"] = false;
			ESB.sendBattleMsg(obj);
			destroy();
		}
		
		public function destroy():void
		{
			CombatConsole.getInstance().removeEventListener(CombatConsole.CANCEL , cancelClick);
			CombatConsole.getInstance().removeEventListener(CombatConsole.CONFIRM , confirmClick);
			CombatConsole.getInstance().removeEventListener(SelectEvent.SELECT , selectDEFClick);
		}
	}
}