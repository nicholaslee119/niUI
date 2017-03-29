package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.CardSlotBase;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Scence2DCantainer;
	import com.syndrome.sanguo.battle.event.MyEvent;
	import com.syndrome.sanguo.battle.event.OperationEvent;
	import com.syndrome.sanguo.battle.event.SelectAreaEvent;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	
	import flash.events.Event;
	
	import net.ESB;
	import net.IProtocolhandler;
	import net.parameter.MessageParameters;

	public class ChooseActionRequest implements IProtocolhandler
	{
		private var cards:Array = [];
		private var message:Object;
		
		private var incidentCardAddress:Array = []; 
		
		private var actions:Array;
		
		/**
		 * 事件卡对应的Action
		 */
		private static const INCIDENTACTION:String = "15";
		/**
		 * 阵型卡对应的Action
		 */
		private static const PHALANXACTION:String = "10";
		
		/**
		 * 选择操作
		 */
		public function ChooseActionRequest()
		{
		}
		
		public function handle(message:Object):void
		{
			actions =message["actions"];
			var skip:Boolean = message["skip"];
			var cardAddress:Array = message["cardAddress"];
			this.message = message;
			if(skip){
				CombatConsole.getInstance().addEventListener(CombatConsole.SKIP , skipClick);
				Scence2DCantainer.getInstance().showSkip(true);
			}
			
			if(actions&& actions.length>0){
				if(actions.indexOf(INCIDENTACTION)>=0 || actions.indexOf(PHALANXACTION)){
					addAreaSelectable();
					CombatConsole.getInstance().addEventListener(SelectAreaEvent.SELECTAREA , selectArea);
				}
				CombatConsole.getInstance().addEventListener(OperationEvent.OPERATION , doOperation);
				Scence2DCantainer.getInstance().showOperations(actions);
			}
			if(cardAddress){
				CombatConsole.getInstance().addEventListener(MyEvent.MOUSE_CLICK_CARD , cardClick);
				for (var i:int = 0; i < cardAddress.length; i++) 
				{
					var card:GameCard = CardManager.getCard(cardAddress[i]);
					cards.push(card);
				}
				CombatConsole.getInstance().currentRequest = this;
			}
			for (i = 0; i < cards.length; i++) 
			{
				cards[i].cardInfo["isSelectable"] = true;
				cards[i].setImage();
			}
		}
		
		private function addAreaSelectable():void
		{
			var lastCard:GameCard;
			if(actions.indexOf(INCIDENTACTION)>=0){    //事件区域可选
				var incidentCardSlot:CardSlotBase  = CardManager.getSlotByType(CardSlotConst.incidentCardSlot , true);
				lastCard = incidentCardSlot.getCard(incidentCardSlot.getCardNum()-1);
				cards.push(lastCard);
			}
			if(actions.indexOf(PHALANXACTION)>=0){   //阵型区域可选
				var phalanxCardSlot:CardSlotBase  = CardManager.getSlotByType(CardSlotConst.phalanxCardSlot , true);
				lastCard = phalanxCardSlot.getCard(phalanxCardSlot.getCardNum()-1);
				cards.push(lastCard);
			}
		}
		
		private function cleanCardsSelectable():void
		{
			while(cards.length>0){
				var card:GameCard = cards.pop() as GameCard;
				card.cardInfo["isSelectable"] = false;
				card.setImage();
			}
		}
		
		protected function selectArea(event:SelectAreaEvent):void
		{
			if(!event.cardSlot.isMe){
				return;
			}
			if((event.cardSlot.type == CardSlotConst.incidentCardSlot && actions.indexOf(INCIDENTACTION)>=0))
			{
				event.preventDefault();
				doOperation(new OperationEvent(OperationEvent.OPERATION,int(INCIDENTACTION)));
			}else if(event.cardSlot.type == CardSlotConst.phalanxCardSlot && actions.indexOf(PHALANXACTION)>=0){
				event.preventDefault();
				doOperation(new OperationEvent(OperationEvent.OPERATION,int(PHALANXACTION)));
			}
		}
		
		protected function cardClick(event:MyEvent):void
		{
			var card:GameCard = event.message["card"] as GameCard;
			if(cards.indexOf(card)<0  || card.cardInfo["slotType"] == CardSlotConst.incidentCardSlot || card.cardInfo["slotType"] == CardSlotConst.phalanxCardSlot){
				return;
			}else{
				var obj:Object = {};
				obj["id"] = MessageParameters.CHOOSE_ACTION_RESPOND;
				obj["cardAddress"] = card.cardInfo["address"];
				ESB.sendBattleMsg(obj);
			}
			destroy();
		}
		
		protected function doOperation(event:OperationEvent):void
		{
			if(actions.indexOf(event.index +"")<0){
				return;
			}
			var obj:Object = {};
			obj["id"] = MessageParameters.CHOOSE_ACTION_RESPOND;
			obj["action"] = event.index +"";
			obj["skip"] = false;
			obj["cardAddress"] = -1;
			ESB.sendBattleMsg(obj);
			destroy();
		}
		
		protected function skipClick(event:Event):void
		{
			var obj:Object = {};
			obj["id"] = MessageParameters.CHOOSE_ACTION_RESPOND;
			obj["skip"] = true;
			ESB.sendBattleMsg(obj);
			destroy();
		}
		
		public function destroy():void
		{
			cleanCardsSelectable();
			Scence2DCantainer.getInstance().disabledAllButton();
			CombatConsole.getInstance().removeEventListener(SelectAreaEvent.SELECTAREA , selectArea);
			CombatConsole.getInstance().removeEventListener(MyEvent.MOUSE_CLICK_CARD , cardClick);
			CombatConsole.getInstance().removeEventListener(OperationEvent.OPERATION , doOperation);
			CombatConsole.getInstance().removeEventListener(CombatConsole.SKIP , skipClick);
		}		
		
	}
}