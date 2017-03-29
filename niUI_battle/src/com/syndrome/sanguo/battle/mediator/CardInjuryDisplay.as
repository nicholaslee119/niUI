package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.common.UserInfo;
	
	import net.IProtocolhandler;
	
	/**
	 * 卡片伤害展示
	 */
	public class CardInjuryDisplay implements IProtocolhandler
	{
		public function CardInjuryDisplay()
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
			 * 永久伤害
			 */
			var lastInjury:int =message["lastInjury"];
			/**
			 * 战斗伤害
			 */
			var fightInjury:int =message["fightInjury"];
			
			if(UserInfo.myUserName != playerName){
				cardAddress = CardManager.convertAddress(cardAddress);
			}
			var card:GameCard = CardManager.getCard(cardAddress);
			card.removeHurt();
			card.addHurt(lastInjury + fightInjury);
		}
	}
}