package com.syndrome.sanguocard.mainfram.managers
{
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;

	public class RoomManager
	{
		private var _room:Room =null;
		private var _zone:Zone =null;
		private var _roomID:int = NullInt;
		private var _zoneID:int = NullInt;
		private var _gameId:int = NullInt;
		private var _roomName:String = null;
		private var _zoneName:String = null;
		private var _pluginName:String = "";
		private var _fightType:String = null;
		private const NullInt:int = -100;
		
		public function RoomManager(){}
		
		
		public function get room():Room
		{
			return _room;
		}

		public function set room(value:Room):void
		{
			_room = value;
		}

		public function get zone():Zone
		{
			return _zone;
		}

		public function set zone(value:Zone):void
		{
			_zone = value;
		}

		public function get roomID():int
		{
			return _roomID;
		}

		public function set roomID(value:int):void
		{
			_roomID = value;
		}

		public function get zoneID():int
		{
			return _zoneID;
		}

		public function set zoneID(value:int):void
		{
			_zoneID = value;
		}

		public function get roomName():String
		{
			return _roomName;
		}

		public function set roomName(value:String):void
		{
			_roomName = value;
		}

		public function get zoneName():String
		{
			return _zoneName;
		}

		public function set zoneName(value:String):void
		{
			_zoneName = value;
		}

		public function get pluginName():String
		{
			return _pluginName;
		}

		public function set pluginName(value:String):void
		{
			_pluginName = value;
		}

		public function get gameId():int
		{
			return _gameId;
		}

		public function set gameId(value:int):void
		{
			_gameId = value;
		}

		public function get fightType():String
		{
			return _fightType;
		}

		public function set fightType(value:String):void
		{
			_fightType = value;
		}


	}
}