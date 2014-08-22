package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.EncampmentCardSlot;
	import com.syndrome.sanguo.battle.common.UserInfo;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	
	import net.IProtocolhandler;

	/**
	 * 洗切卡组
	 */
	public class ShuffleCardSlotDisplay implements IProtocolhandler
	{
		public function ShuffleCardSlotDisplay()
		{
		}
		
		public function handle(message:Object):void
		{
			var cardIds:Array  = message["cardIds"];
			var playerName:String = message["playerName"];
			var encampmentCardSlot:EncampmentCardSlot;
			if(UserInfo.myUserName == playerName)
			{
				encampmentCardSlot = CardManager.getSlotByType(CardSlotConst.encampmentCardSlot , true ) as EncampmentCardSlot ;
			}
			else
			{
				encampmentCardSlot = CardManager.getSlotByType(CardSlotConst.encampmentCardSlot , false ) as EncampmentCardSlot ;
			}
			CombatConsole.getInstance().addActionList([500,[encampmentCardSlot.washCampsite,cardIds]]);
		}
	}
}