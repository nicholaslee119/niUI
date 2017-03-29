package com.syndrome.sanguo.platform
{
	import com.electrotank.electroserver5.user.User;
	import com.syndrome.client.parameters.Constant;
	
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	

	public class Main 
	{
		private var entrance:PlatForm = null;
		private static var instance:Main = null;
		private var ui:UI_MainPanel = null;
		private var FlagForMessage:Boolean = true;
		
		public static function CreateInstance(_entrance:PlatForm):Main
		{
			if(instance == null)
			{
				instance = new Main(_entrance);
				instance.init();
			}
			return instance;
		}
		
		public function Main(_entrance:PlatForm)
		{
			entrance = _entrance;
			ui = new UI_MainPanel();
		}
		
		private function init():void
		{
			ui.btn_autoMatch.addEventListener(MouseEvent.CLICK, onAutoBtnClick);
			ui.btn_free.addEventListener(MouseEvent.CLICK, onFreeBtnClick);
			ui.btn_practice.addEventListener(MouseEvent.CLICK, onPracticeClick);
			ui.btn_chat.addEventListener(MouseEvent.CLICK, onChatBtnClick);
			ExternalInterface.addCallback("RequestChoiceLobby", RequestChoiceLobby);
			entrance.Panel.addChild(ui);
		}
		
		private function onChatBtnClick(e:MouseEvent):void
		{
			var a:Array = new Array("player2");
			entrance.RequestPrivateChat(ui.iput_chat.text, a);
		}
		
		private function RequestChoiceLobby(whichLobby:int):void
		{
			switch(whichLobby)
			{
				case 1:
					entrance.interfaceOfSon.choiceLobby(Constant.FREE_LOBBY);
					break;
				case 2:
					entrance.interfaceOfSon.choiceLobby(Constant.AUTO_LOBBY);
					break;
				case 3:
					entrance.interfaceOfSon.choiceLobby("PracticeLobby");
					break;
				default:
					throw "whichLobby is wrong,please check RequestChoiceLobby API's parameters!";
					break;
			}
		}
		
		private function onAutoBtnClick(e:MouseEvent):void
		{
			entrance.interfaceOfSon.choiceLobby(Constant.AUTO_LOBBY);
		}
		
		private function onFreeBtnClick(e:MouseEvent):void
		{
			entrance.interfaceOfSon.choiceLobby(Constant.FREE_LOBBY);
		}
		
		private function onPracticeClick(e:MouseEvent):void
		{
			entrance.interfaceOfSon.choiceLobby("PracticeLobby");
		}
	}
}