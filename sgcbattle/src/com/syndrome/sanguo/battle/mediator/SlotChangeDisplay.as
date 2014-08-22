package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.Effect3DCantainer;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.Scence3DCantainer;
	import com.syndrome.sanguo.battle.common.UserInfo;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	
	import net.IProtocolhandler;
	
	/**
	 * 卡槽变化展示
	 */
	public class SlotChangeDisplay implements IProtocolhandler
	{
		public function SlotChangeDisplay()
		{
		}
		
		public function handle(message:Object):void
		{
			var playerName:String = message["playerName"];
			var slotType:int = message["slotType"];
			var slotIndex:int = message["slotIndex"];
			var slotState:int = message["slotState"];   //1：不可用，2：可用
			
			if(slotType == CardSlotConst.generalCardSlot && slotIndex == 0 )
			{
				if(slotState == 1){
					Effect3DCantainer.getInstance().generalSlotBreak(UserInfo.myUserName == playerName);
				}else if(slotState == 2){
					Effect3DCantainer.getInstance().generalSlotBreak(UserInfo.myUserName == playerName , true);
				}
			}
		}
	}
}