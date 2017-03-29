package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.command.DistributeInjury;
	import com.syndrome.sanguo.battle.event.SelectEvent;
	
	import net.ESB;
	import net.IProtocolhandler;
	import net.parameter.MessageParameters;
	
	import utils.ObjectUtil;

	/**
	 * 伤害分配
	 */
	public class DistributeInjuryRequest implements IProtocolhandler
	{
		public function DistributeInjuryRequest()
		{
		}
		
		public function handle(message:Object):void
		{
//			var groupID:int =message["groupID"];
			var attackerAddress:Array =message["attackerAddress"];
			var attackValue:Array =message["attackValue"];
			var defenserAddress:Array =message["defenserAddress"];
			var healthValue:Array = message["healthValue"];
			var defenseAbility:Array = message["defenseAbility"];
			var dsfbility:Array =new Array;
			if(defenseAbility !=null && defenseAbility.length >0)
			{
				for(var i:int =0;i<defenseAbility.length;i++)
				{
					dsfbility.push(defenseAbility[i]);
				}
			}
			var card:GameCard;
			var obj:Object;
			var attackCardArr:Array = [];
			for (i = 0; i < attackerAddress.length; i++) 
			{
				card = CardManager.getCard(attackerAddress[i]);
				obj = {"cardInfo":ObjectUtil.deepCopy(card.cardInfo) , "attackValue":attackValue[i]};
				attackCardArr.push(obj);
			}
			
			var defenseCardArr:Array = [];
			for (i = 0; i < defenserAddress.length; i++) 
			{
				card = CardManager.getCard(defenserAddress[i]);
				obj = {"cardInfo":ObjectUtil.deepCopy(card.cardInfo) , "healthValue":healthValue[i] , "defenseAbility":dsfbility[i]};
				defenseCardArr.push(obj);
			}
			
			var distributeInjury:DistributeInjury = new DistributeInjury();
			distributeInjury.show(attackCardArr , defenseCardArr);
			CombatConsole.getInstance().addEventListener(SelectEvent.SELECT , okClick);
			
			CombatConsole.getInstance().currentRequest = this;
		}
		
		protected function okClick(event:SelectEvent):void
		{
			var obj:Object = {};
			obj["id"] = MessageParameters.DISTRIBUTE_INJURY_RESPOND;
			var arr:Array =new Array(event.data.length);
			for(var i:int =0;i<arr.length;i++)
			{
				arr[i] ={"_val":event.data[i]};
			}
			obj["distributeDetail"] = arr;
			ESB.sendBattleMsg(obj);
			destroy();
		}
		
		public function destroy():void
		{
			CombatConsole.getInstance().removeEventListener(SelectEvent.SELECT , okClick);
		}
	}
}