package com.syndrome.sanguocard.unpackage
{
	import com.load.resmanager.ResManager;
	import com.load.xmlmanager.XMLManager;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguocard.unpackage.ui.UIItemCard;
	import com.syndrome.sanguocard.unpackage.ui.UIMainPanelFifty;
	import com.syndrome.sanguocard.unpackage.ui.UIMainPanelOne;
	import com.syndrome.sanguocard.unpackage.ui.UIMainPanelTen;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.external.ExternalInterface;
	
	/*
	* @author nic
	* @build-time 2014-5-23
	* @comments
	*
	*/
	public class Main
	{
		private var enterance:Sanguocard_unpackage;
		private var uiMainPanelOne:UIMainPanelOne;
		private var uiMainPanelTen:UIMainPanelTen;
		private var uiMainPanelFifty:UIMainPanelFifty;
		
		public var unpackageCards:*;
		public var sid:int;
		public var amount:String;
		public var rarity_amount:*;
		public var plan:Vector.<int> = new Vector.<int>();
		
		
		public function Main(_enterance:Sanguocard_unpackage)
		{
			enterance = _enterance;
			init();
		}
		
		private function init():void
		{
			ExternalInterface.addCallback("RequestDisplayUnpackage", onUnpackage);
			ExternalInterface.addCallback("DisplayUnpackageResult", displayUnpackageResult);
			ExternalInterface.call("unpackageReady");
		}
		
		private function onUnpackage(kind:int):void
		{
			if(kind==1 && uiMainPanelOne==null)
			{
				uiMainPanelOne = new UIMainPanelOne(this);
				enterance.addChild(uiMainPanelOne.ui);
			}
			else if(kind==2 && uiMainPanelTen==null)
			{
				uiMainPanelTen = new UIMainPanelTen(this);
				enterance.addChild(uiMainPanelTen.ui);
			}
			else if(kind==3 && uiMainPanelFifty==null)
			{
				uiMainPanelFifty = new UIMainPanelFifty(this);
				enterance.addChild(uiMainPanelFifty.ui);
			}else if(kind==1)
				uiMainPanelOne.begin();
			else if(kind==2)
				uiMainPanelTen.begin();
			else if(kind==3)
				uiMainPanelFifty.begin();
		}
		
		private function displayUnpackageResult(_sid:int, cards_ret:* , _amount:*, _plan:*, _rarity_amount:*, nums:int, type:int):void
		{
			sid = _sid;
			unpackageCards = cards_ret;
			amount = _amount[1];
			rarity_amount = _rarity_amount;
			
			plan.splice(0, plan.length);
			for each(var tempPlan:* in _plan){
				plan.push(tempPlan);
			}
			
			if(type==1)uiMainPanelOne.displayResult();
			else if(type==2)uiMainPanelTen.displayResult();
			else if(type==3)uiMainPanelFifty.displayResult();
		}
		
	}
}