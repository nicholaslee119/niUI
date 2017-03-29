package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Scence2DCantainer;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.Scence3DCantainer;
	import com.syndrome.sanguo.battle.common.UserInfo;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	
	import net.IProtocolhandler;

	/**
	 * 卡槽上限限制
	 */
	public class SlotLimitDisplay implements IProtocolhandler
	{
		public function SlotLimitDisplay()
		{
		}
		
		public function handle(message:Object):void
		{
			var slotType:int = message["slotType"];
			var slotLimit:int = message["slotLimit"];
			var playerName:String = message["playerName"];
			if(slotType == CardSlotConst.handCardSlot){
				Scence2DCantainer.getInstance().setHandNum(UserInfo.myUserName == playerName , -1 , slotLimit);
			}
			else if(slotType == CardSlotConst.generalCardSlot)
			{
				Scence3DCantainer.getInstance().setGeneralNum(UserInfo.myUserName == playerName , -1 , slotLimit);
			}
			
		}
	}
}