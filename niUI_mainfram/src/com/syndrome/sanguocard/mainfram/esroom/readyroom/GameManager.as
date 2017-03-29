package com.syndrome.sanguocard.mainfram.esroom.readyroom
{
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.ServerGame;
	

	public class GameManager
	{
		private var _gameFilter:EsObject;
		public var password:String;
		public var gameId:int;
		public var serverGame:ServerGame;
		private var esRoom:ReadyEsRoom;
		
		public function GameManager(_esRoom:ReadyEsRoom)
		{
			esRoom = _esRoom;
		}

		public function get gameFilter():EsObject
		{
			return _gameFilter;
		}

		public function set gameFilter(value:EsObject):void
		{
			_gameFilter = value;
		}

	}
}