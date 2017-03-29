package com.syndrome.sanguo.battle.command
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.CombatStage;
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.TipGroup;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Scence2DCantainer;
	import com.syndrome.sanguo.battle.event.MyEvent;
	import com.syndrome.sanguo.battle.event.SelectEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * 从卡槽选择卡片
	 */
	public class SelectCardFromSlot extends CommandBase
	{
		private var maxCount:int;
		private var minCount:int;
		private var eventStr:String = "";
		
		private var ensureEnable:Boolean = true;
		private var cancelEnable:Boolean = true;
		
		private var allCardsAddress:Array = [];
		private var allCards:Vector.<GameCard> = new Vector.<GameCard>();
		
		/**
		 * 选中的卡的地址
		 */
		private var selectedCards:Array = [];
		
		public function SelectCardFromSlot()
		{
			super();
		}
		
		/**
		 * 在卡槽中选择卡片
		 * @param allCardsAddress 卡片地址
		 * @param minCount 最少选择数量
		 * @param maxCount 最大选择数量
		 * @param cancelEnable 是否可以取消
		 * @param eventStr 事件文本
		 */
		public function show(allCardsAddress:Array , minCount:int , maxCount:int , cancelEnable:Boolean , eventStr:String = ""):void
		{
			this.allCardsAddress = allCardsAddress;
			this.minCount = minCount;
			this.maxCount = maxCount;
			this.cancelEnable = cancelEnable;
			this.eventStr = eventStr;
			
			setTip();
			checkNum();
			displayCards();
		}
		
		private function setTip():void
		{
			if(minCount == maxCount){
				TipGroup.showText(eventStr + ":" + selectedCards.length + "/" + minCount);
			}else{
				TipGroup.showText(eventStr + ":" + selectedCards.length);
			}
		}
		
		private function cleanCardsSelect():void
		{
			while(allCards.length>0){
				var card:GameCard = allCards.pop() as GameCard;
				card.cardInfo["isSelectable"] = false;
				card.cardInfo["isSelected"] = false;
				card.setImage();
			}
		}
		
		private function displayCards():void
		{
			if(allCardsAddress.length>0){
				CombatConsole.getInstance().addEventListener(MyEvent.MOUSE_CLICK_CARD , cardClick);
				CombatConsole.getInstance().addEventListener(CombatConsole.CANCEL , cancelClick , false ,1);
				CombatConsole.getInstance().addEventListener(CombatConsole.CONFIRM , confirmClick);
			}
			CombatStage.getInstance().cleanAllCardSelect();
			for (var i:int = 0; i < allCardsAddress.length; i++) 
			{
				var card:GameCard = CardManager.getCard(allCardsAddress[i]);
				card.cardInfo["isSelectable"] = true;
				card.cardInfo["isSelected"] = false;
				card.setImage();
				allCards.push(card);
			}
		}
		
		/**
		 * 检查按钮状态
		 */
		private function checkNum():void
		{
			if(selectedCards.length>=minCount&&selectedCards.length<=maxCount){
				Scence2DCantainer.getInstance().showOKCancel(true , cancelEnable);
			}else{
				Scence2DCantainer.getInstance().showOKCancel(false , cancelEnable);
			}
		}
		
		protected function confirmClick(event:Event):void
		{
			destroy();
			Scence2DCantainer.getInstance().showOKCancel();
			CombatConsole.getInstance().dispatchEvent(new SelectEvent(SelectEvent.SELECT , selectedCards));
		}
		
		protected function cancelClick(event:Event):void
		{
			event.stopImmediatePropagation();
			destroy();
			Scence2DCantainer.getInstance().showOKCancel();
			CombatConsole.getInstance().dispatchEvent(new Event("cancel"));
		}
		
		protected function cardClick(event:MyEvent):void
		{
			var card:GameCard = event.message["card"] as GameCard;
			if(allCards.indexOf(card)<0){
				return;
			}
			if(selectedCards.indexOf(card.cardInfo["address"])<0){
				if(selectedCards.length == maxCount){
					return;
				}else{
					card.cardInfo["isSelectable"] = false;
					card.cardInfo["isSelected"] = true;
					card.setImage();
					selectedCards.push(card.cardInfo["address"]);
					if(selectedCards.length == maxCount){
						for (var i:int = 0; i < allCards.length; i++) 
						{
							if(selectedCards.indexOf(allCards[i].cardInfo["address"])<0){
								allCards[i].cardInfo["isSelectable"] = false;
								allCards[i].cardInfo["isSelected"] = false;
								allCards[i].setImage();
							}
						}
					}
				}
			}else{
				card.cardInfo["isSelectable"] = true;
				card.cardInfo["isSelected"] = false;
				card.setImage();
				if(selectedCards.length == maxCount){
					for (i = 0; i < allCards.length; i++) 
					{
						if(selectedCards.indexOf(allCards[i].cardInfo["address"])<0){
							allCards[i].cardInfo["isSelectable"] = true;
							allCards[i].cardInfo["isSelected"] = false;
							allCards[i].setImage();
						}
					}
				}
				selectedCards.splice(selectedCards.indexOf(card.cardInfo["address"]),1);
			}
			setTip();
			checkNum();
		}
		
		override protected function destroy():void
		{
			super.destroy();
			CombatConsole.getInstance().removeEventListener(MyEvent.MOUSE_CLICK_CARD , cardClick);
			CombatConsole.getInstance().removeEventListener(CombatConsole.CANCEL , cancelClick);
			CombatConsole.getInstance().removeEventListener(CombatConsole.CONFIRM , confirmClick);
			TipGroup.cleanText();
			cleanCardsSelect();
		}
	}
}