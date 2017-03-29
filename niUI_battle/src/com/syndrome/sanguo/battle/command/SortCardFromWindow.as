package com.syndrome.sanguo.battle.command
{
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.window.cardwindow.CardSortWindow;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.PopUpGroup;
	import com.syndrome.sanguo.battle.common.CardInfo;
	
	import utils.ObjectUtil;

	public class SortCardFromWindow extends CommandBase
	{
		private var window:CardSortWindow;
		private var click:Function;
		
		private var cardID:Array = [];
		private var allCardsAddress:Array = [];
		private var eventStr:String = "";

		/**
		 * 交换窗口中的卡
		 */
		public function SortCardFromWindow()
		{
			super();
		}
		
		/**
		 * 在卡槽中选择卡片
		 * @param cardAddress 卡片地址
		 * @param cardID 卡片ID列表
		 * @param eventStr 事件文本
		 */
		public function  show(cardAddress:Array,cardID:Array ,eventStr:String = "" ):void
		{
			this.allCardsAddress = cardAddress;
			this.cardID = cardID;
			this.eventStr = eventStr;
			this.init();
		}
		
		private function init():void
		{
			var cardsArr:Array = [];
			for (var i:int = 0; i < allCardsAddress.length; i++) 
			{
				var card:GameCard = CardManager.getCard(allCardsAddress[i]);
				var cardInfo:Object = ObjectUtil.deepCopy(card.cardInfo);
				if(cardID.length>i && cardInfo["id"] != cardID[i]){
					cardInfo["id"] = cardID[i];
					cardInfo["base"] = CardInfo.getCardInfoById(cardID[i]);
				}
				cardInfo["isSelectable"] = false;
				cardInfo["isSelected"] = false;
				cardInfo["isPositive"] = cardInfo["id"]>0?true:false;
				cardsArr.push(cardInfo);
			}
			window = new CardSortWindow();
			window.tipText = eventStr;
			window.addCardInfos(cardsArr);
			PopUpGroup.getInstance().addPopUp(window);
		}
		
		override protected function destroy():void
		{
			super.destroy();
			PopUpGroup.getInstance().removePopUp(window);
		}
	}
}