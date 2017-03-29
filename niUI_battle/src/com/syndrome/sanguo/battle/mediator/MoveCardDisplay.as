package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.CardSlotBase;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.EquipmentCardSlot;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.HandCardSlot;
	import com.syndrome.sanguo.battle.common.CardInfo;
	import com.syndrome.sanguo.battle.common.UserInfo;
	import com.syndrome.sanguo.battle.property.CardConst;
	
	import net.IProtocolhandler;
	
	import utils.ObjectUtil;
	
	/**
	 * 卡片移动展示
	 */
	public class MoveCardDisplay implements IProtocolhandler
	{
		private var originAddress:Array;
		private var amount:int;
		private var destinationAddress:Array;
		private var cardState:Array;
		private var cardID:Array;
		private var playerName:String;
		private var reason:int;
		
		public function MoveCardDisplay()
		{
		}
		
		private function convertAdress(addresses:Array):void
		{
			for(var i:int = 0;i<addresses.length;i++){
				addresses[i] = CardManager.convertAddress(addresses[i]);
			}
		}
		
		public function handle(message:Object):void
		{
			originAddress = message["originAddress"];
			amount = message["amount"];
			destinationAddress = message["destinationAddress"];
			cardState = message["cardState"];
			cardID = message["cardID"];
			playerName = message["playerName"];
			if(message.hasOwnProperty("reason"))
				reason = message["reason"];
			
			if(UserInfo.myUserName != playerName)
			{
				convertAdress(originAddress);
				convertAdress(destinationAddress);
			}
			
			for (var i:int = 0; i < destinationAddress.length; i++) 
			{
				var card:GameCard = CardManager.getCard(originAddress[i]);
				if(card == null){
					throw(new Error("地址为:"+originAddress[i]+"的卡牌不存在！"));
					return;
				}
				var originSlot:CardSlotBase = CardManager.getSlotByAddress(originAddress[i]);   //起始槽
				var destinationSlot:CardSlotBase = CardManager.getSlotByAddress(destinationAddress[i]);  //终止槽
				var toBack:Boolean;
				var toDefensive:Boolean;
				if(cardState.length<=i){		//状态未更新
					toBack = !card.cardInfo["isPositive"];
					toDefensive = !card.cardInfo["isAttack"];
				}else{			//状态更新
					card.cardInfo["state"] = cardState[i];
					if(!destinationSlot.isMe && destinationSlot is HandCardSlot){
						toBack = true;
					}else{
						toBack = !CardManager.getCardPositive(cardState[i]);
					}
					toDefensive = !CardManager.getCardAttack(cardState[i]);
				}
				var index:int = CardManager.getCardIndex(destinationAddress[i]);
				var changeController:Boolean = !(destinationSlot.isMe == originSlot.isMe);
				if(originSlot == destinationSlot && destinationAddress[i] == originAddress[i]){    //位置不变
					CardManager.getInstance().changeState(card , !toBack , !toDefensive);  //仅仅改变卡的状态
				}else{
					var delay:Number = (i==destinationAddress.length - 1)?300:-1;
					if(destinationSlot is EquipmentCardSlot){
						CardManager.getInstance().addEquipCard(card , (destinationSlot as EquipmentCardSlot).generalCard);
					}else{
						CardManager.getInstance().addCard(card,destinationSlot.type,toBack,toDefensive,index,changeController,delay);
					}
				}
				if(	cardID.length> i && cardID[i]!=-1 && card.cardInfo["id"] != cardID[i]){
					card.cardInfo["id"] = cardID[i];
					card.cardInfo["base"] = CardInfo.getCardInfoById(cardID[i]);
					card.refreshCardInfo();
				}
			}
		}
	}
}