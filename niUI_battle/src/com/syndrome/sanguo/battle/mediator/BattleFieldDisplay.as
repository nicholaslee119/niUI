package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.common.UserInfo;
	
	import net.IProtocolhandler;

	/**
	 * 战团展示
	 */
	public class BattleFieldDisplay implements IProtocolhandler
	{
		private static var colorsObject:Object = {};
		
		public function BattleFieldDisplay()
		{
		}
		
		private var colors:Array =[0x9FCC66,0xFFFF00,0x6A66CC,0xFF0000,0x7700FF,0xCC66CC,0x66CCB8];
		private function getColor(groupID:String):uint
		{
			if(!colorsObject.hasOwnProperty(groupID)){
				var i:int = 0;
				for(var id:String in colorsObject) 
				{
					i++;
				}
				colorsObject[groupID] = colors[i];
			}
			return colorsObject[groupID];
		}
		
		public function handle(message:Object):void
		{
			var playerName:String = message["playerName"];
			var attackList:Array = message["attackList"];
			var defenseList:Array = message["defenseList"];
			
			removePreAttackEffect();
			if(attackList.length == 0 && defenseList.length == 0){  //重置战团
				colorsObject = {};
			}
			var battleGroup:Object = {};
			for (var j:int = 0; j < attackList.length; j++) 
			{
				var attackGroup:Array = attackList[j];
				var attackGroupID:String = attackGroup[0];   //战团编号	
				var attackGroupGenerals:Array =[];	//战团武将
				for(var i:int = 1;i<attackGroup.length;i++){
					if(UserInfo.myUserName != playerName)
					{
						attackGroup[i] = CardManager.convertAddress(attackGroup[i]);
					}
					attackGroupGenerals.push(CardManager.getCard(attackGroup[i]));
				}
				battleGroup[attackGroupID] = {"attackCards":attackGroupGenerals };
			}
			
			for ( j = 0; j < defenseList.length; j++) 
			{
				var defensenGroup:Array = defenseList[j];
				var defensenGroupID:String = defensenGroup[0];   //战团编号	
				var defensenGroupGenerals:Array =[];	//战团武将
				for(i = 1;i<defensenGroup.length;i++){
					if(UserInfo.myUserName != playerName)
					{
						defensenGroup[i] = CardManager.convertAddress(defensenGroup[i]);
					}
					defensenGroupGenerals.push(CardManager.getCard(defensenGroup[i]));
				}
				if(battleGroup.hasOwnProperty(defensenGroupID)){
					battleGroup[defensenGroupID]["defenseCards"] = defensenGroupGenerals;
				}
			}
			CardManager.getInstance().battleCards = battleGroup;
			addPreAttackEffect();
		}
		
		public function addPreAttackEffect():void
		{
			var battleGroup:Object = CardManager.getInstance().battleCards;
			for(var groupid:String in battleGroup)
			{
				for each (var card:GameCard in battleGroup[groupid]["attackCards"]) 
				{
					if(card==null)continue;
					card.cardInfo["groupid"] = groupid;
					card.addBattleGroupEffect(getColor(groupid) , true);
				}
				for each ( card in battleGroup[groupid]["defenseCards"]) 
				{
					if(card==null)continue;
					card.cardInfo["groupid"] = groupid;
					card.addBattleGroupEffect(getColor(groupid) , false);
				}
			}
		}
		
		public function removePreAttackEffect():void
		{
			var battleGroup:Object = CardManager.getInstance().battleCards;
			for(var groupid:String in battleGroup)
			{
				for each (var card:GameCard in battleGroup[groupid]["attackCards"]) 
				{
					if(card.cardInfo.hasOwnProperty("groupid")){
						delete card.cardInfo["groupid"];
					}
					card.removeBattleGroupEffect();
				}
				for each (card in battleGroup[groupid]["defenseCards"]) 
				{
					if(card.cardInfo.hasOwnProperty("groupid")){
						delete card.cardInfo["groupid"];
					}
					card.removeBattleGroupEffect();
				}
			}
		}
	}
}