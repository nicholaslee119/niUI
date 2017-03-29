package com.syndrome.sanguo.battle.combat_ui.card.cardimage
{
	import org.flexlite.domUI.components.SkinnableComponent;

	/**
	 * 谋略卡
	 */
	public class StrategyCardImage extends CardImageBase
	{
		private var cardRoundCount:CardRoundCount;
		
		public function StrategyCardImage()
		{
			super();
		}
		
		/**
		 * 显示回合计数标记
		 */
		public function showCardRoundCount(value:int):void
		{
			if(!cardRoundCount){
				cardRoundCount = new CardRoundCount();
				cardRoundCount.right = 0;
				cardRoundCount.bottom = 0;
				this.addElement(cardRoundCount);
			}
			cardRoundCount.value = value;
		}
		
		/**
		 * 隐藏回合计数标记
		 */
		public function hideCardRoundCount():void
		{
			if(cardRoundCount){
				this.removeElement(cardRoundCount);
				cardRoundCount = null;
			}
		}
	}
}