package com.syndrome.sanguo.lobby.ui.lobby
{
	import com.electrotank.electroserver5.api.EsObject;
	import com.load.resmanager.ResManager;
	import com.load.xmlmanager.XMLManager;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.client.parameters.PublicParameters;
	import com.syndrome.sanguo.lobby.ui.cardgroup.UICardGroup;
	import com.syndrome.sanguocard.uiclass.UIGallery;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import com.syndrome.sanguo.lobby.ui.UILobby;

	public class UIAutoLobby
	{
		public var ui:UI_AutoMatchPanel = new UI_AutoMatchPanel();
		public var uilobby:UILobby;
		private var second:int;
		private var timer:Timer = null;
		private var uiCardGroup:UICardGroup;
		
		public function UIAutoLobby(_uilobby:UILobby)
		{
			uilobby = _uilobby;
			init();
		}
		
		private function init():void
		{
			timer = new Timer(1000); 
			timer.addEventListener(TimerEvent.TIMER, onTick);
			ui.btn_match.addEventListener(MouseEvent.CLICK, onMatchBtnClick);
			uiCardGroup = new UICardGroup(this, ui.sprite_cardGroup);
			ui.visible = false;
			initGallery();
		}
		
		private function initGallery():void
		{
			var gallery:UIGallery = new UIGallery(ui.sprite_gallery, UI_Gallery_Btn);
			
			for each(var url:String in XMLManager.getUrlsByLocalName(Constant.RES_AD))
				ResManager.getInstance().getRes(url, onGet);
			
			function onGet(res:Object):void
			{
				if(res==null)return;
				gallery.addPic(res);
			}
		}
		
		private function onTick(e:TimerEvent):void
		{
			second = second + 1;
			ui.lab_timeCostSec.text = String(second%60);
			ui.lab_timeCostMin.text = String(int(second/60));
		}
		
		private function onMatchBtnClick(e:MouseEvent):void
		{
			if(ui.btn_match.selected == true)
			{
				ui.btn_match.selected = false;
				uilobby.main.entrance.interfaceOfSon.costGold(uiCardGroup.preSetCurrentCardItem.provision);
			}else{
				uilobby.main.entrance.interfaceOfSon.onCancelMatch();
				this.stopTimer();
			}
		}
		
		public function onMatchAllowed():void
		{
			second = 0;
			ui.lab_timeCostMin.text = "0";
			ui.lab_timeCostSec.text = "0";
			
			if(ui.btn_match.selected == false)
			{
				ui.btn_match.selected = true;
				uilobby.main.entrance.interfaceOfSon.createRoom("sanguo-pair-interfaceOfSon",Constant.AUTO_LOBBY);
				timer.start();
			}else{
				ui.btn_match.selected = false;
				uilobby.main.entrance.interfaceOfSon.onCancelMatch();
			}
		}
		
		
		
		private function costGoldIndeed():void
		{
			uilobby.main.entrance.interfaceOfSon.costGoldIndeed(uiCardGroup.preSetCurrentCardItem.provision);
		}
		
		public function unselectedMatchBtn():void
		{
			ui.btn_match.selected = false;
		}
		
		public function unableMatchBtn():void
		{
			ui.btn_match.btnEnabled = false;
		}
		
		public function ableMatchBtn():void
		{
			ui.btn_match.btnEnabled = true;
		}
		
		public function stopTimer():void
		{
			if(timer!=null)timer.stop();
			ui.btn_match.selected = false;
			ui.lab_timeCostMin.text = "0";
			ui.lab_timeCostSec.text = "0";
		}
		
		public function onGetCardGroup(esObj:EsObject):void
		{
			uiCardGroup.onGetCardGroup(esObj);
		}
		
		public function onGetCurrentCardGroup(esObj:EsObject):void
		{
			uiCardGroup.onGetCurrentCardGroup(esObj);
		}
		
		public function onSetCurrentCardGroup(esObj:EsObject):void
		{
			uiCardGroup.onSetCurrentCardGroup(esObj);
		}
	}
}