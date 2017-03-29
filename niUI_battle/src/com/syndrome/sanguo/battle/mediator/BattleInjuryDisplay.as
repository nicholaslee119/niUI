package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.command.BattleFight;
	import com.syndrome.sanguo.battle.common.UserInfo;
	
	import manger.HistroyMessageManager;
	
	import net.IProtocolhandler;

	/**
	 * 战斗展示
	 */
	public class BattleInjuryDisplay implements IProtocolhandler
	{
		public function BattleInjuryDisplay()
		{
		}
		
		public function handle(message:Object):void
		{
			/**
			 * 战团ID
			 */
			var groupId:String =message["groupId"];
			
			/**
			 * 卡牌地址
			 */
			var cardAddress:Array = message["cardAddress"];
			
			/**
			 * 战斗伤害
			 */
			var fightInjury:Array = message["fightInjury"];
			
			/**
			 * 永久伤害
			 */
			var lastInjury:Array =message["lastInjury"];
			
			/**
			 * 进攻玩家名称
			 */
			var attackerName:String =message["attackerName"];
			
			var cardHurtInfos:Array = [];
			var attackIds:Array = [];
			var defenseIds:Array = [];
			
			for(var i:int =0;i<cardAddress.length;i++)
			{
				var cardHurtInfo:Object = {};
				if(UserInfo.myUserName != attackerName){   			//防守方转地址!
					cardAddress[i] = CardManager.convertAddress(cardAddress[i]);
					if(CardManager.getSlotByAddress(cardAddress[i]).isMe){
						cardHurtInfo["isAttacker"] = false;
					}else{
						cardHurtInfo["isAttacker"] = true;
					}
				}else{
					if(CardManager.getSlotByAddress(cardAddress[i]).isMe){
						cardHurtInfo["isAttacker"] = true;
					}else{
						cardHurtInfo["isAttacker"] = false;
					}
				}
				cardHurtInfo["card"] = CardManager.getCard(cardAddress[i]);
				if(cardHurtInfo["isAttacker"]){
					attackIds.push(cardHurtInfo["card"].cardInfo["id"]);
				}else{
					defenseIds.push(cardHurtInfo["card"].cardInfo["id"]);
				}
				cardHurtInfo["fightInjury"] = fightInjury[i];
				cardHurtInfo["lastInjury"] = lastInjury[i];
				cardHurtInfos.push(cardHurtInfo);
			}
			
			var battleFight:BattleFight = new BattleFight();
			CombatConsole.getInstance().enableActionList = false;
			var complete:Function = function():void
			{
				CombatConsole.getInstance().enableActionList = true;
			}
			battleFight.play(cardHurtInfos , complete);
			
			/**
			 [ATTACKER 对阵 DEFENDER]
			 */
			if(defenseIds.length > 0){
				HistroyMessageManager.displayChatMsg(10,
					{	"ATTACKER":attackIds,
						"DEFENDER":defenseIds
					});
			}else{
				HistroyMessageManager.displayChatMsg(21,
					{	"ATTACKER":attackIds
					});
			}
		}
	}
}