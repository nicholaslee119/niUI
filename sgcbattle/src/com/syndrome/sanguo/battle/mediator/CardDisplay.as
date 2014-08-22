package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.window.cardwindow.CardDisplayWindow;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.PopUpGroup;
	import com.syndrome.sanguo.battle.common.CardInfo;
	
	import net.IProtocolhandler;

	/**
	 * 卡片展示
	 */
	public class CardDisplay implements IProtocolhandler
	{
		public function CardDisplay()
		{
		}
		
		public function handle(message:Object):void
		{
			var cardIDs:Array = message["cardID"];
			
			var cardInfos:Array = [];
			for (var i:int = 0; i < cardIDs.length; i++)
			{
				var cardInfo:Object = {};
				if(cardIDs[i]>0){
					cardInfo["id"] = cardIDs[i];
					cardInfo["base"] = CardInfo.getCardInfoById(cardIDs[i]);
				}
				cardInfo["isSelectable"] = false;
				cardInfo["isSelected"] = false;
				cardInfo["isPositive"] = cardInfo["id"]>0?true:false;
				cardInfos.push(cardInfo);
			}
			var cardWindow:CardDisplayWindow = new CardDisplayWindow();
			cardWindow.title = "对方展示卡牌";
			cardWindow.addCardInfos(cardInfos);
			
			CombatConsole.getInstance().addActionList([2000,[PopUpGroup.getInstance().addPopUp,cardWindow]]);
			CombatConsole.getInstance().addActionList([100,[PopUpGroup.getInstance().removePopUp,cardWindow]]);
		}
	}
}