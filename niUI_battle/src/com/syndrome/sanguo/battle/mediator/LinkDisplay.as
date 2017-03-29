package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.command.Chain;
	import com.syndrome.sanguo.battle.common.UserInfo;
	
	import manger.HistroyMessageManager;
	
	import net.IProtocolhandler;

	/**
	 * 连环展示
	 */
	public class LinkDisplay implements IProtocolhandler
	{
		public function LinkDisplay()
		{
		}
		
		public function handle(message:Object):void
		{
			var show:Boolean =message["show"];
			
			var playerName:String =message["playerName"];
			var cardID:int =message["cardID"];
			var linkType:int =message["linkType"];
			var cardAddress:int =message["cardAddress"];
			var targetAddress:Array =message["targetAddress"];
			var uuid:String = message["uuid"];
			
			if(UserInfo.myUserName != playerName){
				cardAddress = CardManager.convertAddress(cardAddress);
				for (var i:int = 0; i < targetAddress.length; i++) 
				{
					targetAddress[i] = CardManager.convertAddress(targetAddress[i]);
				}
			}
			if(show && targetAddress.length > 0){
				var targetIds:Array = [];
				for (var j:int = 0; j < targetAddress.length; j++) 
				{
					targetIds.push(CardManager.getCard(targetAddress[j]).cardInfo["id"]);
				}
				if(linkType<17){
					HistroyMessageManager.displayChatMsg(16,
						{	"PLAYER":playerName,
							"CARD_TYPE":cardAddress,
							"CARD":cardID,
							"SKILL_TYPE":Chain.getChainTypeStr(linkType),
							"CHOOSE_CARD":targetIds
						});
				}else{
					HistroyMessageManager.displayChatMsg(15,
						{	"PLAYER":playerName,
							"CARD_TYPE":cardAddress,
							"CARD":cardID,
							"CHOOSE_CARD":targetIds
						});
				}
			}
			if(show){
				var chain:Chain = new Chain();
				chain.addCard(uuid , cardAddress , cardID , linkType , targetAddress);
			}else{
				Chain.getChain(uuid).removeCard();
			}
		}
	}
}