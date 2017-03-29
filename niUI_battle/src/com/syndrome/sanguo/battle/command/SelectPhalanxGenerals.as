package com.syndrome.sanguo.battle.command
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.TipGroup;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Scence2DCantainer;
	import com.syndrome.sanguo.battle.event.MyEvent;
	import com.syndrome.sanguo.battle.event.SelectEvent;
	
	import flash.events.Event;

	public class SelectPhalanxGenerals extends CommandBase
	{
		private var generalAddress:Array;
		private var allCards:Vector.<GameCard> = new Vector.<GameCard>();
		
		private var ensureEnable:Boolean = true;
		private var cancelEnable:Boolean = true;
		
		public function SelectPhalanxGenerals()
		{
			super();
		}
		
		/**
		 * @param generalAddress 卡片地址
		 * @param ensureEnable 是否可以确定
		 * @param cancelEnable 是否可以取消
		 */
		public function show(generalAddress:Array,ensureEnable:Boolean ,cancelEnable:Boolean , eventStr:String = ""):void
		{
			this.generalAddress = generalAddress;
			this.cancelEnable = cancelEnable;
			this.ensureEnable = ensureEnable;
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
			for (var i:int = 0; i < generalAddress.length; i++) 
			{
				var card:GameCard = CardManager.getCard(generalAddress[i]);
				card.cardInfo["isSelectable"] = true;
				card.setImage();
				allCards.push(card);
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
				var card:GameCard = CardManager.getCard(generalAddress[i]);
				card.cardInfo["isSelectable"] = false;
				card.setImage();
			}
			allCards.length = 0;
			Scence2DCantainer.getInstance().showOKCancel();
			TipGroup.cleanText();
		}
	}
}