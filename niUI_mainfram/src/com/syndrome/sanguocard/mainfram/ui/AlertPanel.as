package com.syndrome.sanguocard.mainfram.ui
{
	import com.load.resmanager.ResManager;
	import com.load.xmlmanager.XMLManager;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.client.parameters.PublicParameters;
	import com.syndrome.sanguocard.mainfram.main.Main;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class AlertPanel
	{
		public var ui:* = new Sprite();
		public var uiTempLoading:* = new Sprite();
		public var main:Main;
		public static var instance:AlertPanel = new AlertPanel();
		private var confirm:Function=null;
		private var cancel:Function=null;
		private var timer:Timer=null;
		
		public function AlertPanel()
		{
		}
		
		public function addToPanel(floatPanel:Sprite):void
		{
			ResManager.getInstance().getRes(XMLManager.getUrlByName(Constant.RES_MAINFRAM), onCompleted);
			
			function onCompleted(res:Object):void
			{
				ui = res.UI_AlertPanel;
				ui.btn_confirm.addEventListener(MouseEvent.CLICK, onAlertConfirm);
				ui.btn_cancel.addEventListener(MouseEvent.CLICK, onAlertCancel);
				ui.lab_input.addEventListener(MouseEvent.CLICK, onClickInput);
				ui.lab_input.visible = false;
				ui.visible = false;
				timer = new Timer(5000, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTime);
				uiTempLoading = res.UI_TempLoading;
				uiTempLoading.visible = false;
				uiTempLoading.mc_loading.stop();
				floatPanel.addChild(uiTempLoading);
				floatPanel.addChild(ui);
			}
			
			function onClickInput(e:MouseEvent):void
			{
				ui.lab_input.text = "";
			}
		}
		
		private function onAlertConfirm(e:MouseEvent):void
		{
			ui.visible = false;
			if(timer.running)timer.stop();
			if(confirm!=null)
				confirm(e);
		}
		
		private function onAlertCancel(e:MouseEvent):void
		{
			ui.visible = false;
			if(timer.running)timer.stop();
			if(cancel!=null)
				cancel(e);
		}
		
		public static function creatInstance():AlertPanel
		{
			return instance;
		}
		
		public function show(content:String, _confirm:Function, _cancel:Function):void
		{
			ui.visible = true;
			ui.lab_input.visible = false;
			ui.lab_question.text = content;
			confirm = _confirm;
			cancel = _cancel;
		}
		
		private function onTime(e:TimerEvent):void{
			ui.visible = false;
		}
		
		public function showSeconds(content:String, _confirm:Function, _cancel:Function):void
		{
			timer.reset();
			timer.start();
			ui.visible = true;
			ui.lab_input.visible = false;
			ui.lab_question.text = content;
			confirm = _confirm;
			cancel = _cancel;
		}
		
		public function showInput(content:String, _confirm:Function, _cancel:Function):void
		{
			ui.visible = true;
			ui.lab_input.visible = true;
			ui.lab_input.text = "000000";
			ui.lab_question.text = content;
			confirm = _confirm;
			cancel = _cancel;
		}
		
		public function hide():void
		{
			ui.visible = false;
		}
		
		public function showTempLoading():void
		{
			uiTempLoading.visible = true;
			uiTempLoading.mc_loading.play();
		}
		
		public function hideTempLoading():void
		{
			uiTempLoading.visible = false;
			uiTempLoading.mc_loading.stop();
		}
	}
}