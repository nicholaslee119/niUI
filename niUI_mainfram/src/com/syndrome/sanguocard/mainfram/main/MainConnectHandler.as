package com.syndrome.sanguocard.mainfram.main
{
	import com.communication.ComEvent;
	import com.communication.gamecom.GameCom;
	import com.syndrome.client.parameters.PublicParameters;
	
	import flash.external.ExternalInterface;

	public class MainConnectHandler extends MainHandlerBase
	{
		public function MainConnectHandler(_main:Main)
		{
			super(_main);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			GameCom.getInstance().addEventListener(ComEvent.CONNECTED,onConnectCompelete);
			GameCom.getInstance().addEventListener(ComEvent.CONNECTCUT,onConnectCut);
			GameCom.getInstance().connect();
		}
		
		private function onConnectCompelete(e:ComEvent):void
		{
			if(e.sucss){
				GameCom.getInstance().removeEventListener(ComEvent.CONNECTED,onConnectCompelete);
				ExternalInterface.addCallback("RequestLogin", RequestLogin);
				ExternalInterface.call("onReadyForLogin");
			}else{
				ExternalInterface.call("onConnectFailed", e.msg);
				trace("es连接失败,原因： "+e.msg);
			}
		}
		
		private function RequestLogin(account:String, password:String):void
		{
			main.login(account, password);
		}
		
		private function onConnectCut(e:ComEvent):void
		{
			if(PublicParameters.isDebug())
				trace("onConnectCut"+e.msg);
			else
				ExternalInterface.call("onConnectCut", e.msg);
		}
	}
}