package com.syndrome.sanguocard.mainfram.esroom.esroombase
{
	import com.communication.AppEvent;
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.LeaveRoomRequest;
	import com.electrotank.electroserver5.api.PluginRequest;
	import com.electrotank.electroserver5.api.UserListEntry;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;
	import com.syndrome.sanguocard.mainfram.interfaceOfSon.InterfaceOfSonBase;
	import com.syndrome.sanguocard.mainfram.managers.ESRoomManager;
	import com.syndrome.sanguocard.mainfram.managers.RoomManager;
	import com.syndrome.sanguocard.mainfram.managers.UsersManager;
	import com.syndrome.sanguocard.mainfram.ui.AlertPanel;
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;

	public class EsRoomBase
	{
		use namespace ThisIsInterface;
		
		public var esRoomManager:ESRoomManager;
		protected var _roomManager:RoomManager;
		protected var _usersManager:UsersManager;
		protected var tmpRoomName:String;
		protected var tmpZoneName:String;
		protected var _interfaceOfSon:*;
		private var curTimer:Number = new Date().time;
		protected var esRoomJoinRoomHandler:EsRoomJoinRoomHandler;
		protected var timer:Timer = new Timer(20000);
		
		public function EsRoomBase(_esRoomManager:ESRoomManager)
		{
			esRoomManager = _esRoomManager;
			roomManager = new RoomManager();
			usersManager = new UsersManager(roomManager);
			timer.addEventListener(TimerEvent.TIMER, onCheckHeartBeatReceived);
		}
		
		public function initListeners():void{}
		
		public function joinRoomORcreateRoom(_room:String, _zone:String):void{}
		
		public function init():void{};
		
		public function clear():void{};
		
		public function onRelaseRoom():void
		{
			if(roomManager.room == null)return;
			if(roomManager.room.isJoined && GameCom.getInstance().esServer.engine.connected)
			{
				var lrr:LeaveRoomRequest = new LeaveRoomRequest();
				lrr.roomId = roomManager.room.id;
				lrr.zoneId = roomManager.room.zoneId;
				GameCom.getInstance().esServer.engine.send(lrr);
			}
		}
		
		public function sendPreEvent():void
		{
			var message:AppEvent =new AppEvent(AppEvent.ScenePrepare);
			message.objHander = interfaceOfSon;
			interfaceOfSon.sonProject.addEventListener(AppEvent.ScenePrepareDone,function(e:AppEvent):void{onpreSceneDone(tmpRoomName, tmpZoneName)});
			interfaceOfSon.sonProject.dispatchEvent(message);
		}
		
		public function onpreSceneDone(_roomName:String, _zoneName:String):void
		{
			initListeners();
			joinRoomORcreateRoom(_roomName, _zoneName);
		}
		
		public function onInitPreRoom(_rId:int,_zId:int,_rm:Room,_zone:Zone,_rName:String,_zName:String):void
		{
			roomManager.roomName = _rName;
			roomManager.zoneName = _zName;
			roomManager.roomID = _rId;
			roomManager.zoneID = _zId;
			roomManager.room = _rm;
			roomManager.zone = _zone;
		}
		
		public function enterFreeReadyRoom():void
		{
			esRoomManager.readySetInviteFlag(true);
		}
		
		public function enterAutoReadyRoom():void
		{
			
		}
		
		public function toPackage(es:EsObject):void
		{
			GameCom.getInstance().toSend(es);
		}
		
		public function addToFloat(_ui:*):void
		{
			esRoomManager.addToFloat(_ui);
		}
		
		public function removeFromFloat(_ui:*):void
		{
			esRoomManager.removeFromFloat(_ui);
		}
		
		public function alertFromSonProject(message:String):void
		{
			AlertPanel.creatInstance().show(message, null, null);
		}
		
		public function reBindingChat():void
		{
			if(interfaceOfSon==null)return;
			interfaceOfSon.reBindingChat();
		}
		
		public function onEnterFrame(now:Number):void
		{
			if(now-curTimer>=300000)
			{
				this.heartBeat();
				curTimer=now;
			}
		}
		
		protected function heartBeat():void
		{
			if(!GameCom.getInstance().esServer.engine.connected || roomManager.room==null || roomManager.zone==null || roomManager.pluginName=="" || !roomManager.zone.roomById(roomManager.room.id)) return;
			var esob:EsObject =new EsObject();
			esob.setString("a","hb");
			var pr:PluginRequest = new PluginRequest();
			pr.parameters = esob;
			pr.roomId = roomManager.room.id;
			pr.zoneId = roomManager.room.zoneId;
			pr.pluginName = roomManager.pluginName;
			GameCom.getInstance().esServer.engine.send(pr);
			timer.start();
		}
		
		protected function onCheckHeartBeatReceived(e:TimerEvent):void
		{
			timer.stop();
		}

		public function get roomManager():RoomManager
		{
			return _roomManager;
		}

		public function set roomManager(value:RoomManager):void
		{
			_roomManager = value;
		}

		public function get usersManager():UsersManager
		{
			return _usersManager;
		}

		public function set usersManager(value:UsersManager):void
		{
			_usersManager = value;
		}

		public function get interfaceOfSon():*
		{
			return _interfaceOfSon;
		}

		public function set interfaceOfSon(value:*):void
		{
			_interfaceOfSon = value;
		}

	}
}