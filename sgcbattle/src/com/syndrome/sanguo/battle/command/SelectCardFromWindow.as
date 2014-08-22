package com.syndrome.sanguo.battle.command
{
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.window.cardwindow.CardSelectableWindow;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.PopUpGroup;
	import com.syndrome.sanguo.battle.common.CardInfo;
	import com.syndrome.sanguo.battle.effect.CardSelectableEffect;
	
	import utils.ObjectUtil;
	
	public class SelectCardFromWindow extends CommandBase
	{
		private var maxCount:int;
		private var minCount:int;
		private var eventStr:String = "";
		
		private var cancelEnable:Boolean = true;
		
		private var cardID:Array = [];
		private var allCardsAddress:Array = [];
		
		/**
		 * 选中的卡的地址
		 */
		private var selectedCards:Array = [];
		
		private var window:CardSelectableWindow;
		
		public function SelectCardFromWindow()
		{
			super();
		}
		
		/**
		 * 在卡槽中选择卡片
		 * @param cardAddress 卡片地址
		 * @param cardID 卡片ID列表
		 * @param minCount 最少选择数量
		 * @param maxCount 最大选择数量
		 * @param cancelEnable 是否可以取消
		 * @param confirmClick 确定点击confirmClick(selectedCards:Array)  selectedCards选中卡片的地址
		 * @param cancelClick 取消点击cancelClick()
		 * @param eventStr 事件文本
		 */
		public function  show(cardAddress:Array,cardID:Array,minCount:int,maxCount:int,cancelEnable:Boolean ,eventStr:String = "" ):void
		{
			this.allCardsAddress = cardAddress;
			this.cardID = cardID;
			this.minCount = minCount;
			this.maxCount = maxCount;
			this.cancelEnable = cancelEnable;
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
			window = new CardSelectableWindow();
			window.addCardInfos(cardsArr);
			window.setInfo(maxCount , minCount , cancelEnable , eventStr);
			PopUpGroup.getInstance().addPopUp(window);
		}
		
		override protected function destroy():void
		{
			super.destroy();
			PopUpGroup.getInstance().removePopUp(window);
		}
	}
}