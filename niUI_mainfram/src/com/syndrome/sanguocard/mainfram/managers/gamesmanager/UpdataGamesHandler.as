package com.syndrome.sanguocard.mainfram.managers.gamesmanager
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.FindGamesResponse;
	import com.electrotank.electroserver5.api.MessageType;

	public class UpdataGamesHandler
	{
		private var handleUpdateGame:Function = null;
		private var handleComplete:Function = null;
		
		public function UpdataGamesHandler(handler:Function, complete:Function)
		{
			handleUpdateGame = handler;
			handleComplete = complete;
			init();
		}
		
		private function init():void
		{
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.FindGamesResponse.name, onFindGamesResponse);
		}
		
		private function onFindGamesResponse(e:FindGamesResponse):void 
		{
			if(handleUpdateGame!=null)
			{
				e.games.forEach(handleUpdateGame);
				handleUpdateGame = null;
			}
			if(handleComplete!=null)
			{
				handleComplete();
				handleComplete = null;
			}
		}
	}
}