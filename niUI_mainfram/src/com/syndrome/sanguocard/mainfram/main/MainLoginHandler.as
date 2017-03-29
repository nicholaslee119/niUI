package com.syndrome.sanguocard.mainfram.main
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.LoginRequest;
	import com.electrotank.electroserver5.api.LoginResponse;
	import com.electrotank.electroserver5.api.MessageType;
	import com.syndrome.client.parameters.PublicParameters;
	
	import flash.external.ExternalInterface;

	public class MainLoginHandler extends MainHandlerBase
	{
		public function MainLoginHandler(_main:Main)
		{
			super(_main);
		}
		
		override protected function init():void
		{
			super.init();
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.LoginResponse.name, onLoginResponse);
		}
		
		public function login(userName:String,pwd:String="000000"):void
		{
			if(PublicParameters.isDebug()) trace("onLogin");
			if(!GameCom.getInstance().esServer.engine.connected) return;
			var lr:LoginRequest = new LoginRequest();
			lr.userName = userName;
			lr.password = pwd;
			GameCom.getInstance().esServer.engine.send(lr);
		}
		
		private function onLoginResponse(e:LoginResponse):void
		{
			if (!e.successful) {
				ExternalInterface.call("onLoginResult", false, e.error.name);
				trace(e.error.name);
			}else{
				ExternalInterface.call("onLoginResult", true, null);
				GameCom.getInstance().esServer.engine.removeEventListener(MessageType.LoginResponse.name, onLoginResponse);
				ExternalInterface.addCallback("RequestLeaveGame", main.RequestLeaveGame);
				main.onLoadConfigXml();
			}
		}
		
	}
}