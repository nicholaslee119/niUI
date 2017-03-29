package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.command.SelectSlot;
	import com.syndrome.sanguo.battle.common.UserInfo;
	import com.syndrome.sanguo.battle.event.SelectEvent;
	import com.syndrome.sanguo.battle.event.SelectSlotEvent;
	
	import flash.events.Event;
	
	import net.ESB;
	import net.parameter.MessageParameters;
	import net.IProtocolhandler;

	/**
	 * 选择卡槽，比如武将上场选择卡槽
	 */
	public class ChooseSlotFromListRequest implements IProtocolhandler
	{
		private var slotAddress:Array;
		public function ChooseSlotFromListRequest()
		{
		}
		
		public function handle(message:Object):void
		{
			slotAddress = message["slotAddress"];//0主,1军师,2
			var cancel:Boolean = message["cancel"]; //0,1 可以取消（cancel=1）时，取消按钮高亮
			var playerName:String = message["playerName"];
			
			var selectSlot:SelectSlot = new SelectSlot();
			selectSlot.show(slotAddress , cancel);
			CombatConsole.getInstance().addEventListener(SelectSlotEvent.SELECTSLOT , slotClick);
			if(cancel){
				CombatConsole.getInstance().addEventListener(CombatConsole.CANCEL , cancelClick);
			}
			
			CombatConsole.getInstance().currentRequest = this;
		}
		
		private function slotClick(selectSlotEvent:SelectSlotEvent):void
		{
			var obj:Object = {};
			obj["id"] = MessageParameters.CHOOSE_SLOT_FROM_LIST_RESPOND;
			obj["chosenSlotAddress"] = [slotAddress[selectSlotEvent.index]];
			obj["cancel"] = false;
			ESB.sendBattleMsg(obj);
			destroy();
		}
		
		private function cancelClick(event:Event):void
		{
			var obj:Object = {};
			obj["id"] = MessageParameters.CHOOSE_SLOT_FROM_LIST_RESPOND;
			obj["chosenSlotAddress"] = [0,0,0];
			obj["cancel"] = true;
			ESB.sendBattleMsg(obj);
			destroy();
		}
		
		public function destroy():void
		{
			CombatConsole.getInstance().removeEventListener(CombatConsole.CANCEL , cancelClick);
			CombatConsole.getInstance().removeEventListener(SelectSlotEvent.SELECTSLOT , slotClick);
		}
	}
}