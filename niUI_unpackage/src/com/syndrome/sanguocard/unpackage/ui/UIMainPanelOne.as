package com.syndrome.sanguocard.unpackage.ui
{
	import com.greensock.TimelineLite;
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.data.TweenLiteVars;
	import com.greensock.data.TweenMaxVars;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Quart;
	import com.load.resmanager.ResItem;
	import com.load.resmanager.ResManager;
	import com.load.xmlmanager.XMLManager;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguocard.unpackage.Main;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	/*
	* @author nic
	* @build-time 2014-5-23
	* @comments
	*
	*/
	public class UIMainPanelOne extends UIMainPanelBase
	{
		
		public function UIMainPanelOne(_main:Main)
		{
			super(_main);
			ui = new UI_Main_One();
			ui.addEventListener(Event.ENTER_FRAME, onEnd);
		}
		
		override protected function onEnd(e:Event):void
		{
			super.onEnd(e);
			if(ui.currentLabel != "end")return;
			ui.removeEventListener(Event.ENTER_FRAME, onEnd);
			ExternalInterface.call("onUnpackageFinish");
		}
		
		override public function displayResult():void
		{
			// TODO Auto Generated method stub
			super.displayResult();
			instancePanel = ui.mc.mc.mc;
			uiItemCards[0] = new UIItemCard(this, instancePanel.mc_card1.mc, main.unpackageCards[0]);
			uiItemCards[1] = new UIItemCard(this, instancePanel.mc_card2.mc, main.unpackageCards[1]);
			uiItemCards[2] = new UIItemCard(this, instancePanel.mc_card3.mc, main.unpackageCards[2]);
			uiItemCards[3] = new UIItemCard(this, instancePanel.mc_card4.mc, main.unpackageCards[3]);
			uiItemCards[4] = new UIItemCard(this, instancePanel.mc_card5.mc, main.unpackageCards[4]);
			uiItemCards[5] = new UIItemCard(this, instancePanel.mc_card6.mc, main.unpackageCards[5]);
			uiItemCards[6] = new UIItemCard(this, instancePanel.mc_card7.mc, main.unpackageCards[6]);
			uiItemCards[7] = new UIItemCard(this, instancePanel.mc_card8.mc, main.unpackageCards[7]);
			uiItemCards[8] = new UIItemCard(this, instancePanel.mc_card9.mc, main.unpackageCards[8]);
			uiItemCards[9] = new UIItemCard(this, instancePanel.mc_card10.mc, main.unpackageCards[9]);
			ui.mc.mc.btn_again.addEventListener(MouseEvent.CLICK, onAgain);
			ui.mc.mc.btn_confirm.addEventListener(MouseEvent.CLICK, onConfirm);
			//TODO:在这里将各种信息放到UI上
			var timeline:TimelineMax = new TimelineMax();
			var tempLevel:int = -1;
			var barRate:Number = ui.mc.mc.sprite_bar.width/10;
			for each(var everyLevel:int in main.plan)
			{
				if(tempLevel!=-1 && tempLevel>everyLevel)
				{
					timeline.append(TweenMax.to(ui.mc.mc.sprite_bar, 1, {x: -500 + barRate * everyLevel, startAt:{x:-500} }));
				}else{
					timeline.append(TweenMax.to(ui.mc.mc.sprite_bar, 1, {x: -500 + barRate * everyLevel}));
				}
				tempLevel = everyLevel;
			}
			ui.mc.mc.storage.text = main.amount;
			ui.mc.mc.orange.text = int(main.rarity_amount.ORANGE);
			ui.mc.mc.white.text = int(main.rarity_amount.WHITE);
			ui.mc.mc.green.text = int(main.rarity_amount.GREEN);
			ui.mc.mc.blue.text = int(main.rarity_amount.BLUE);
			ui.mc.mc.purple.text = int(main.rarity_amount.PURPLE);
			if(main.amount=="0")
				ui.mc.mc.btn_again.btnEnabled = false;
		}
		
		override protected function onAgain(e:MouseEvent):void
		{
			ExternalInterface.call("onUnpackageAgain", 1, main.sid);
			ui.visible = false;
		}
		
		public function begin():void
		{
			ui.addEventListener(Event.ENTER_FRAME, onEnd);
			ui.visible = true;
			ui.mc.mc.mc.gotoAndPlay(1);
			ui.mc.mc.gotoAndPlay(1);
			ui.mc.gotoAndPlay(1);
			ui.gotoAndPlay(1);
		}
		
	}
}