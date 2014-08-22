package com.syndrome.sanguocard.mainfram.managers.gamesmanager
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.CreateOrJoinGameResponse;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.FindGamesRequest;
	import com.electrotank.electroserver5.api.FindGamesResponse;
	import com.electrotank.electroserver5.api.JoinGameRequest;
	import com.electrotank.electroserver5.api.MessageType;
	import com.electrotank.electroserver5.api.SearchCriteria;
	import com.electrotank.electroserver5.api.ServerGame;
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;
	import com.syndrome.sanguocard.mainfram.main.Main;
	import com.syndrome.sanguocard.mainfram.ui.AlertPanel;

	public class GamesManager
	{
		private var _games:Array = new Array;
		private var main:Main = null;
		private var handleFindGameByRoom:Function = null;
		private static var instance:GamesManager = null;
		
		public static function getInstance():GamesManager
		{
			if(instance==null)
				instance = new GamesManager();
			return instance;
		}
		
		public function updateGames(handler:Function, complete:Function):void
		{
			var updataGamesHandler:UpdataGamesHandler = new UpdataGamesHandler(handler, complete);
			findGames();
		}
		
		public function findGameByRoom(room:Room, handler:Function):void
		{
			handleFindGameByRoom = handler;
			findGames();
		}
		
		private function findGames():void
		{
			var fgr:FindGamesRequest = new FindGamesRequest();
			fgr.searchCriteria = new SearchCriteria();
			fgr.searchCriteria.gameType = "SanguoGame";
			GameCom.getInstance().esServer.engine.send(fgr);
		}
		
		public function GamesManager()
		{
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.FindGamesResponse.name, onFindGamesResponse);
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.CreateOrJoinGameResponse.name,  onCreateOrJoinGameResponse);
		}
		
		private function onCreateOrJoinGameResponse(e:CreateOrJoinGameResponse):void {
			trace("[GamesManager]: " + e.successful.toString());
			if(!e.successful)
				AlertPanel.creatInstance().show("加入游戏失败，原因:"+e.error.name, null, null);
		}
		
		private function onFindGamesResponse(e:FindGamesResponse):void
		{
			games = e.games;
			if(handleFindGameByRoom!=null)
				e.games.some(handleFindGameByRoom);
		}
		
		public function joinGame(gameId:int, password:String):void
		{
			var jgr:JoinGameRequest = new JoinGameRequest();
			jgr.gameId = gameId;
			jgr.password =	password;
			GameCom.getInstance().esServer.engine.send(jgr);
		}
		
		public function filterMatchEntrance(gameDetails:EsObject, gui:EsObject):Boolean
		{
			try{
				if(GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(gameDetails.getInteger("zoneId"))==null || GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(gameDetails.getInteger("zoneId")).roomById(gameDetails.getInteger("roomId")).userCount==2)
				{
					AlertPanel.creatInstance().show("房间已满！",null,null);
					return false;
				}
			}catch(e:Error){
				return false;
			}
			var filter:EsObject = gameDetails.getEsObject("gameFilter");
			return levelMatch();
			
			function levelMatch():Boolean
			{
				switch(filter.getInteger("level"))
				{
					case 0:
						return winMatch(filter, gui);
						break;
					case 1:
						if(gui.getInteger("level")>=10)
							return winMatch(filter, gui);
						else{
							AlertPanel.creatInstance().show("房间需要等级大于10",null,null);
							return false;
						}
						break;
					case 2:
						if(gui.getInteger("level")>=20)
							return winMatch(filter, gui);
						else{
							AlertPanel.creatInstance().show("房间需要等级大于20",null,null);
							return false;
						}
						break;
					case 3:
						if(gui.getInteger("level")>=30)
							return winMatch(filter, gui);
						else{
							AlertPanel.creatInstance().show("房间需要等级大于30",null,null);
							return false;
						}
						break;
					default:
						return false;
						break;
				}
			}
			
			function winMatch():Boolean
			{
				var win:Number = gui.getInteger("freeWin")/(gui.getInteger("freeWin")+gui.getInteger("freeLose"));
				switch(filter.getInteger("win"))
				{
					case 0:
						return true;
						break;
					case 1:
						if(win>=0.5)
							return true;
						else{
							AlertPanel.creatInstance().show("房间需要胜率大于50%",null,null);
							return false;
						}
						break;
					case 2:
						if(win>0.6)
							return true;
						else{
							AlertPanel.creatInstance().show("房间需要胜率大于60%",null,null);
							return false;
						}
						break;
					case 3:
						if(win>0.7)
							return true;
						else{
							AlertPanel.creatInstance().show("房间需要胜率大于70%",null,null);
							return false;
						}
						break;
					default:
						return false;
						break;
				}
			}
		}

		public function get games():Array
		{
			return _games;
		}

		public function set games(value:Array):void
		{
			_games = value;
		}

	}
}