package com.syndrome.sanguocard.mainfram.ui
{
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.UserVariable;
	import com.load.resmanager.ResManager;
	import com.load.xmlmanager.XMLManager;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.client.parameters.PublicParameters;
	import com.syndrome.sanguocard.mainfram.main.Main;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class UILoading
	{
		public var ui:* = null;
		private var main:Main;
		private var myBarOrginX:Number;
		private var opBarOrginX:Number;
		private var myCompletedFlag:Boolean = false;
		private var opCompletedFlag:Boolean = false;
		private var delayTimer:Timer = new Timer(1000, 1);
		
		public function UILoading(_main:Main)
		{
			main = _main;
			ResManager.getInstance().getRes(XMLManager.getUrlByName(Constant.RES_MAINFRAM), onLoading);	
			
			function onLoading(res:Object):void
			{
				ui = res.UI_LoadMainPanel;
				myBarOrginX = ui.sprite_bar.sprite_myBar.x;
				opBarOrginX = ui.sprite_bar.sprite_opBar.x;
				ui.visible = false;
				main.mainfram.loadingPanel.addChild(ui);
			}
		}
		
		public function initUI(_ui:*):void
		{
			
		}
		
		public function init():void
		{
			try{
				ui.visible=true;
				var gui:EsObject = main.esRoomManager.getReadyUsersManager().meUser.userVariableByName("gui").value;
				ui.sprite_bar.myName.text = gui.getString("surname")+gui.getString("name");
				var uA:Array = main.esRoomManager.getReadyUsersManager().findOpUsers();
				if(uA.length>0)
				{
					gui = UserVariable(uA[0].userVariableByName("gui")).value;
					ui.sprite_bar.opName.text = gui.getString("surname")+gui.getString("name");
				}
				main.mainfram.reflash(0,0);
			}catch(e:Error){
				trace("[UILoading]:Error"+e.message);
				throw e;
			}
		}
		
		public function initOpDone():void
		{
			try{
				ui.sprite_bar.sprite_opBar.x = opBarOrginX - 355;
				ui.visible = true;
				myCompletedFlag = false;
				opCompletedFlag = true;
				var gui:EsObject = main.esRoomManager.getReadyUsersManager().meUser.userVariableByName("gui").value;
				ui.sprite_bar.myName.text = gui.getString("surname")+gui.getString("name");
				var uA:Array = main.esRoomManager.getReadyUsersManager().findOpUsers();
				if(uA.length>0)
				{
					gui = UserVariable(uA[0].userVariableByName("gui")).value;
					ui.sprite_bar.opName.text = gui.getString("surname")+gui.getString("name");
				}
				main.mainfram.reflash(0,0);
			}catch(e:Error){
				trace("[UILoading]:Error"+e.message);
			}
			
		}
		
		public function clear():void
		{
			ui.sprite_bar.sprite_myBar.x = myBarOrginX;
			ui.sprite_bar.sprite_opBar.x = opBarOrginX;
			ui.visible = false;
			myCompletedFlag = false;
			opCompletedFlag = false;
		}
		
		public function pros(pros:Number):void
		{
			ui.sprite_bar.sprite_myBar.x = myBarOrginX + 355*pros;
			if(pros==1)
			{
				myCompletedFlag = true;
				hidden();
			}
		}
		
		public function opPros(pros:Number):void
		{
			ui.sprite_bar.sprite_opBar.x = opBarOrginX - 355*pros;
			if(pros==1)
			{
				opCompletedFlag = true;
				hidden();
			}
		}
		
		private function hidden():void
		{
			if(myCompletedFlag && opCompletedFlag)
			{
				delayTimer.addEventListener(TimerEvent.TIMER, delayTimerHandler);
				delayTimer.start();
			}
		}
		
		private function delayTimerHandler(e:TimerEvent):void
		{
			delayTimer.removeEventListener(TimerEvent.TIMER, delayTimerHandler);
			delayTimer.reset();
			clear();
			if(main.esRoomManager.getBattleSonProject()!=null)
			{
				main.esRoomManager.mainOnInitGame();
				delayTimer.addEventListener(TimerEvent.TIMER, delayToStartGame);
				delayTimer.start();
			}
		}
		
		private function delayToStartGame(e:TimerEvent):void
		{
			delayTimer.reset();
			delayTimer.removeEventListener(TimerEvent.TIMER, delayToStartGame);
			main.esRoomManager.mainDelayToStartGame();
		}
	}
}