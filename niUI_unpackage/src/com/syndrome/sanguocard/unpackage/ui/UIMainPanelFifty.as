package com.syndrome.sanguocard.unpackage.ui
{
	import com.syndrome.sanguocard.unpackage.Main;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	
	/*
	* @author nic
	* @build-time 2014-6-3
	* @comments
	*
	*/
	public class UIMainPanelFifty extends UIMainPanelBase
	{
		private var packageIndex:int = 0;
		private var UIItemCards:Array = new Array(10);
		
		public function UIMainPanelFifty(_main:Main)
		{
			super(_main);
			ui = new UI_Main_Ten();
			ui.addEventListener(Event.ENTER_FRAME, onEnd);
		}
		
		override protected function onEnd(e:Event):void
		{
			if(ui.currentLabel != "end")return;
			ui.removeEventListener(Event.ENTER_FRAME, onEnd);
			ExternalInterface.call("onUnpackageFinish");
		}
		
		override public function displayResult():void
		{
			// TODO Auto Generated method stub
			super.displayResult();
			instancePanel = ui.mc.mc;
			UIItemCards[0] = new UIItemCard(this, instancePanel.mc_card1.mc, main.unpackageCards[0]);
			UIItemCards[1] = new UIItemCard(this, instancePanel.mc_card2.mc, main.unpackageCards[1]);
			UIItemCards[2] = new UIItemCard(this, instancePanel.mc_card3.mc, main.unpackageCards[2]);
			UIItemCards[3] = new UIItemCard(this, instancePanel.mc_card4.mc, main.unpackageCards[3]);
			UIItemCards[4] = new UIItemCard(this, instancePanel.mc_card5.mc, main.unpackageCards[4]);
			UIItemCards[5] = new UIItemCard(this, instancePanel.mc_card6.mc, main.unpackageCards[5]);
			UIItemCards[6] = new UIItemCard(this, instancePanel.mc_card7.mc, main.unpackageCards[6]);
			UIItemCards[7] = new UIItemCard(this, instancePanel.mc_card8.mc, main.unpackageCards[7]);
			UIItemCards[8] = new UIItemCard(this, instancePanel.mc_card9.mc, main.unpackageCards[8]);
			UIItemCards[9] = new UIItemCard(this, instancePanel.mc_card10.mc, main.unpackageCards[9]);
			instancePanel.btn_again.addEventListener(MouseEvent.CLICK, onAgain);
			instancePanel.btn_confirm.addEventListener(MouseEvent.CLICK, onConfirm);
			//TODO:在这里将各种信息放到UI上
			instancePanel.storage.text = main.amount;
			instancePanel.orange.text = int(main.rarity_amount.ORANGE);
			instancePanel.white.text = int(main.rarity_amount.WHITE);
			instancePanel.green.text = int(main.rarity_amount.GREEN);
			instancePanel.blue.text = int(main.rarity_amount.BLUE);
			instancePanel.purple.text = int(main.rarity_amount.PURPLE);
			instancePanel.btn_pre.visible = true;
			instancePanel.btn_next.visible = true;
			instancePanel.btn_pre.addEventListener(MouseEvent.CLICK, onPre);
			instancePanel.btn_next.addEventListener(MouseEvent.CLICK, onNext);
			if(main.amount=="0")
				instancePanel.btn_again.btnEnabled = false;
		}
		
		
		
		override protected function onAgain(e:MouseEvent):void
		{
			ExternalInterface.call("onUnpackageAgain", 3, main.sid);
			ui.visible = false;
		}
		
		override protected function onConfirm(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			super.onConfirm(e);
			packageIndex=0;
		}
		
		private function onNext(e:MouseEvent):void
		{
			if(packageIndex>3)return;
			packageIndex++;
			this.initNewCards(packageIndex*10);
		}
		
		private function onPre(e:MouseEvent):void
		{
			if(packageIndex<=0)return;
			packageIndex--;
			this.initNewCards(packageIndex*10);
		}
		
		private function initNewCards(baseDecade:int):void
		{
			for each(var uiItemCard:UIItemCard in UIItemCards){
				uiItemCard.removeListener();
			}
			UIItemCards[0] = new UIItemCard(this, instancePanel.mc_card1.mc, main.unpackageCards[baseDecade]);
			UIItemCards[1] = new UIItemCard(this, instancePanel.mc_card2.mc, main.unpackageCards[baseDecade+1]);
			UIItemCards[2] = new UIItemCard(this, instancePanel.mc_card3.mc, main.unpackageCards[baseDecade+2]);
			UIItemCards[3] = new UIItemCard(this, instancePanel.mc_card4.mc, main.unpackageCards[baseDecade+3]);
			UIItemCards[4] = new UIItemCard(this, instancePanel.mc_card5.mc, main.unpackageCards[baseDecade+4]);
			UIItemCards[5] = new UIItemCard(this, instancePanel.mc_card6.mc, main.unpackageCards[baseDecade+5]);
			UIItemCards[6] = new UIItemCard(this, instancePanel.mc_card7.mc, main.unpackageCards[baseDecade+6]);
			UIItemCards[7] = new UIItemCard(this, instancePanel.mc_card8.mc, main.unpackageCards[baseDecade+7]);
			UIItemCards[8] = new UIItemCard(this, instancePanel.mc_card9.mc, main.unpackageCards[baseDecade+8]);
			UIItemCards[9] = new UIItemCard(this, instancePanel.mc_card10.mc, main.unpackageCards[baseDecade+9]);
		}
		
		public function begin():void
		{
			ui.addEventListener(Event.ENTER_FRAME, onEnd);
			ui.visible = true;
			ui.mc.mc.gotoAndPlay(1);
			ui.mc.gotoAndPlay(1);
			ui.gotoAndPlay(1);
		}
	}
}