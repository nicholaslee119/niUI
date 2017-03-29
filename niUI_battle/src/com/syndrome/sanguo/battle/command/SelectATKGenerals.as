package com.syndrome.sanguo.battle.command
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.TipGroup;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Scence2DCantainer;
	import com.syndrome.sanguo.battle.command.CommandBase;
	import com.syndrome.sanguo.battle.event.MyEvent;
	import com.syndrome.sanguo.battle.event.SelectEvent;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	
	import flash.events.Event;
	
	import manger.SoundManager;

	/**
	 * 选择攻击将领
	 */
	public class SelectATKGenerals extends CommandBase
	{
		private var ensureEnable:Boolean = true;
		private var cancelEnable:Boolean = true;
		
		private var eventStr:String = "";
		
		private var allCardsAddress:Array = [];
		private var allCards:Vector.<GameCard> = new Vector.<GameCard>();
		
		/**
		 * 选择参加战斗的武将
		 */
		public function SelectATKGenerals()
		{
			super();
		}
		
		/**
		 * @param allCardsAddress 卡片地址
		 * @param ensureEnable 是否可以确定
		 * @param cancelEnable 是否可以取消
		 * @param confirmClick 确定点击confirmClick()
		 * @param cancelClick 取消点击cancelClick()
		 * @param selectClick 选中卡片selectClick(address:int)
		 */
		public function show(allCardsAddress:Array,ensureEnable:Boolean ,cancelEnable:Boolean , eventStr:String = ""):void
		{
			this.allCardsAddress = allCardsAddress;
			this.cancelEnable = cancelEnable;
			this.ensureEnable = ensureEnable;
			this.eventStr = eventStr;
			this.initCards();
			this.checkButtons();
			TipGroup.showText(eventStr);
		}
		
		private function initCards():void
		{
			if(cancelEnable){
				CombatConsole.getInstance().addEventListener(CombatConsole.CANCEL , cancelClick ,false ,1);
			}
			if(ensureEnable){
				CombatConsole.getInstance().addEventListener(CombatConsole.CONFIRM , confirmClick ,false ,1);
			}
			CombatConsole.getInstance().addEventListener(MyEvent.MOUSE_CLICK_CARD , cardClick);
			var allGeneralCards:Array = CardManager.getSlotByType(CardSlotConst.generalCardSlot , true).getCards();   //所有的武将卡
			allGeneralCards = allGeneralCards.concat(CardManager.getSlotByType(CardSlotConst.generalCardSlot , false).getCards()); 
			allGeneralCards = allGeneralCards.concat(CardManager.getSlotByType(CardSlotConst.phalanxCardSlot , true).getCards());    //阵型卡
			for (var i:int = 0; i < allGeneralCards.length; i++) 
			{
				var card:GameCard = allGeneralCards[i];
				if(card.cardInfo["isSelectable"]){
					if(allCardsAddress.indexOf(card.cardInfo["address"])<0){
						card.cardInfo["isSelectable"] = false;
						card.setImage();
					}else{
						allCards.push(card);
					}
				}else{
					if(allCardsAddress.indexOf(card.cardInfo["address"])>=0){
						card.cardInfo["isSelectable"] = true;
						card.setImage();
						allCards.push(card);
					}
				}
			}
		}
		
		/**
		 * 检查按钮状态
		 */
		private function checkButtons():void
		{
			Scence2DCantainer.getInstance().showOKCancel(ensureEnable , cancelEnable);
		}
		
		private function cardClick(e:MyEvent):void
		{
			var card:GameCard = e.message["card"];
			if(allCards.indexOf(card) <0){
				return;
			}else{
				e.preventDefault();
				card.cardInfo["isSelectable"] = false;
				card.setImage();
			}
			CombatConsole.getInstance().dispatchEvent(new SelectEvent(SelectEvent.SELECT , [card.cardInfo["address"]]));
			super.destroy();
			removeEventListeners();
		}
		
		private function cancelClick(event:Event):void
		{
			destroy();
		}
		
		private function confirmClick(event:Event):void
		{
			destroy();
		}
		
		protected function removeEventListeners():void
		{
			if(cancelEnable){
				CombatConsole.getInstance().removeEventListener(CombatConsole.CANCEL , cancelClick);
			}
			if(ensureEnable){
				CombatConsole.getInstance().removeEventListener(CombatConsole.CONFIRM , confirmClick);
			}
			CombatConsole.getInstance().removeEventListener(MyEvent.MOUSE_CLICK_CARD , cardClick);
		}
		
		override protected function destroy():void
		{
			super.destroy();
			removeEventListeners();
			for (var i:int = 0; i < allCards.length; i++) 
			{
				var card:GameCard = CardManager.getCard(allCardsAddress[i]);
				card.cardInfo["isSelectable"] = false;
				card.setImage();
			}
			allCards.length = 0;
			Scence2DCantainer.getInstance().showOKCancel();
			TipGroup.cleanText();
		}
	}
}