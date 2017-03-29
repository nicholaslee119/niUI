package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.common.UserInfo;
	
	import net.IProtocolhandler;
	
	/**
	 * 卡片回合标记展示
	 */
	public class CardRoundDisplay implements IProtocolhandler
	{
		public function CardRoundDisplay()
		{
		}
		
		public function handle(message:Object):void
		{
			/**
			 * 卡牌玩家
			 */
			var  playerName:String =message["playerName"];
			/**
			 * 卡牌地址
			 */
			var cardAddress:int =message["cardAddress"];
			/**
			 * 剩余回合数 ， -1表示永久
			 */
			var round:int = message["round"];
			
			if(UserInfo.myUserName != playerName){
				cardAddress = CardManager.convertAddress(cardAddress);
			}
			var card:GameCard = CardManager.getCard(cardAddress);
			if(round == 0)
				card.hideCardRoundCount();
			else
				card.showCardRoundCount(round);
		}
	}
}