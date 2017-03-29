package com.syndrome.sanguocard.unpackage.ui
{
	import com.load.resmanager.ResManager;
	import com.load.xmlmanager.XMLManager;
	import com.syndrome.client.parameters.Constant;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	/*
	* @author nic
	* @build-time 2014-5-26
	* @comments
	*
	*/
	public class UIItemCard
	{
		public var ui:*;
		private var uiMainPanel:UIMainPanelBase; 
		private var cardInfo:*;
		private var image:Bitmap;
		
		public function UIItemCard(_uiMainPanel:UIMainPanelBase, _ui:*, _cardInfo:*)
		{
			uiMainPanel = _uiMainPanel;
			ui = _ui;
			if(ui.currentFrame!=1)ui.gotoAndStop(1);
			cardInfo = _cardInfo;
			init();
		}
		
		protected function init():void
		{
			ResManager.getInstance().getRes(XMLManager.getUrlByName(Constant.CARD_IMAGES)+cardInfo.card_code+".jpg", onLoadComplete);
			uiMainPanel.addEventListener("displayCards", onDisplay);
			ui.mc_purple.visible = false;
			ui.mc_orange.visible = false;
			MovieClip(ui).addEventListener(MouseEvent.MOUSE_OVER, onHover);
		}
		
		public function removeListener():void
		{
			if(MovieClip(ui).hasEventListener(MouseEvent.MOUSE_OVER))
				MovieClip(ui).removeEventListener(MouseEvent.MOUSE_OVER, onHover);
		}
		
		private function onHover(e:MouseEvent):void
		{
			ExternalInterface.call("onShowCardPic", cardInfo.card_code);
		}
		
		private function onDisplay():void
		{
			//划光效果完毕时候触发
		}
		
		private function onLoadComplete(res:Object):void
		{
			var tempBitmapData:BitmapData = res.bitmapData as BitmapData;
			var tempBitmap:Bitmap = new Bitmap(tempBitmapData);
			tempBitmap.height = 110;
			tempBitmap.width = 79;
			tempBitmap.x = -40;
			tempBitmap.y = -55;
			image = tempBitmap;
			ui.addEventListener(Event.ENTER_FRAME, onFront);
			ui.play();
		}
		
		private function onFront(e:Event):void
		{
			if(ui.currentLabel != "front_end")return;
			ui.removeEventListener(Event.ENTER_FRAME, onFront);
			ui.mc_front.addChild(image);
			if(cardInfo.rarity=="PURPLE")
				ui.mc_purple.visible = true;
			if(cardInfo.rarity=="ORANGE")
				ui.mc_orange.visible = true;
		}
	}
}