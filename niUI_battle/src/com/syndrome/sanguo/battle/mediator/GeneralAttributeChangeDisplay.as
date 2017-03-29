package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.common.UserInfo;
	
	import manger.HistroyMessageManager;
	
	import net.IProtocolhandler;

	/**
	 * 武将属性改变
	 */
	public class GeneralAttributeChangeDisplay implements IProtocolhandler
	{
		public function GeneralAttributeChangeDisplay()
		{
		}
		
		public function handle(message:Object):void
		{
			//移除还是增加，true-移除，false-增加
			var  reason:int = message["reason"];
			//引起修正的卡牌ID
//			var  cardID:int =  message["cardID"];
//			var  fixed:Boolean = message["fixed"];
			//玩家编号
			var  playerName:String= message["playerName"];
			//改变属性的武将的位置
			var  generalAddress:int = message["generalAddress"];
			//攻击值
			var  attack:int =  message["attack"];
			//攻击值修正，前端直接执行加法运算
//			var  attackAmend:int = message["attackAmend"];
			//生命值
			var  health:int = message["health"];
			//生命值修正，前端直接执行加法运算
//			var  healthAmend:int = message["healthAmend"];
			//智力值
			var  intelligence:int = message["intelligence"];
			//智力值修正，前端直接执行加法运算
//			var  intelligenceAmend:int =message["intelligenceAmend"];
			
			if(UserInfo.myUserName != playerName)
			{
				generalAddress = CardManager.convertAddress(generalAddress);
			}
			var card:GameCard = CardManager.getCard(generalAddress);
			card.setAttribInfo(attack,health,intelligence);
			CombatConsole.getInstance().addActionList([1000,[card.playLaunch]]);
			
			/**
			GENERAL_TYPECARD的属性变为ATTRIBUTE
			 */
			HistroyMessageManager.displayChatMsg(2,
				{
					"GENERAL_TYPE":card.cardInfo["base"]["corp"],
					"CARD":card.cardInfo["id"],
					"ATTRIBUTE":attack+"/"+health+"/"+intelligence
				});
		}
	}
}