package com.syndrome.sanguocard.mainfram.esroom.platform
{
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.JoinRoomEvent;
	import com.electrotank.electroserver5.api.JoinRoomRequest;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomBase;
	import com.syndrome.sanguocard.mainfram.esroom.esroombase.EsRoomJoinRoomHandler;
	
	public class PlatformJoinRoomHandler extends EsRoomJoinRoomHandler
	{
		public function PlatformJoinRoomHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override protected function onJoinRoomEvent(e:JoinRoomEvent):void
		{
			// TODO Auto Generated method stub
			super.onJoinRoomEvent(e);
			if(e.roomName==Constant.PLATFORM_ROOM)
			{
				PlatformEsRoom(esRoomBase).roomManager.pluginName = "PlatformLobbyRoom";
				var tmpZone:Zone = GameCom.getInstance().esServer.managerHelper.zoneManager.zoneById(e.zoneId);
				var tmpRoom:Room = tmpZone.roomById(e.roomId);
				if(tmpRoom==null) throw"无法获取onJoinRoomEvent里面的房间消息";
				PlatformEsRoom(esRoomBase).onInitPreRoom(tmpRoom.id,tmpRoom.zoneId,tmpRoom,tmpZone,e.roomName,tmpZone.name);
				for each (var user:User in tmpRoom.users) 
				{
					if(user.isMe)
					{
						PlatformEsRoom(esRoomBase).usersManager.meUser = user;
						var cb:EsObject = new EsObject();
						cb.setString("from", Constant.SCENE_PLATFORM);
						cb.setString("which","me");
						PlatformEsRoom(esRoomBase).getUserInfo(GameCom.getInstance().esServer.managerHelper.userManager.me.userName, cb);
					}
				}
				
				PlatformEsRoom(esRoomBase).getUserList();
			}
		}
		
		
		override public function joinRoomORcreateRoom(_room:String, _zone:String, gameId:int, pwd:String, create:Boolean):void
		{
			// TODO Auto Generated method stub
			super.joinRoomORcreateRoom(_room, _zone, gameId, pwd, create);
			var jnRm:JoinRoomRequest =new JoinRoomRequest();
			jnRm.roomName = _room;
			jnRm.zoneName = _zone;
			jnRm.password = pwd;
			GameCom.getInstance().esServer.engine.send(jnRm);
		}
	}
}