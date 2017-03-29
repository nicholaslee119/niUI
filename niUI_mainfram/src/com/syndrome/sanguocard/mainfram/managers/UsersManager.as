package com.syndrome.sanguocard.mainfram.managers
{
	import com.electrotank.electroserver5.user.User;

	public class UsersManager
	{
		private var _users:Array = new Array();
		private var _meUser:User;
		private var _meNickName:String;
		private var roomManager:RoomManager;
		
		public function UsersManager(_roomManager:RoomManager)
		{
			roomManager = _roomManager;
		}
		
		public function findOpUsers():Array
		{
			var uA:Array = new Array();
			if(roomManager.room == null) 
				uA= null;
			else
				for each (var user:User in roomManager.room.users) 
				{
					if(!user.isMe)
					{
						uA.push(user);
					}
				}
			return uA;
		}

		public function findUser(name:String):User
		{
			var u:User =null;
			if(roomManager.room == null) 
				u= null;
			else
				for each (var user:User in roomManager.room.users) 
				{
					if(user.userName == name)
					{
						u = user;
						break;
					}
				}
			return u;
		}

		public function get meUser():User
		{
			return _meUser;
		}

		public function set meUser(value:User):void
		{
			_meUser = value;
		}

		public function get meNickName():String
		{
			return _meNickName;
		}

		public function set meNickName(value:String):void
		{
			_meNickName = value;
		}

		public function get users():Array
		{
			return _users;
		}

		public function set users(value:Array):void
		{
			_users = value;
		}


	}
}