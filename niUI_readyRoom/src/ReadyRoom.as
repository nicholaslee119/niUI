package
{
	import com.communication.AppEvent;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.PublicMessageEvent;
	import com.electrotank.electroserver5.api.UserUpdateEvent;
	import com.electrotank.electroserver5.user.User;
	import com.electrotank.electroserver5.zone.Room;
	import com.load.xmlmanager.XMLManager;
	import com.syndrome.sanguo.readyroom.Main;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	public class ReadyRoom extends Sprite
	{
		public var Panel:Sprite = new Sprite();
		private var main:Main = null;
		public var interfaceOfSon:Object = null;
		private var now:Number;
		
		public function ReadyRoom()
		{
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandle);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function addToStageHandle(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addToStageHandle);
			this.addChild(Panel);
			this.addEventListener(AppEvent.ScenePrepare,onPreScene);
			ExternalInterface.addCallback("RequestChat", RequestChat);
		}
		
		private function onEnterFrame(e:Event):void
		{
			now =new Date().time;
			if(interfaceOfSon!=null)interfaceOfSon.onEnterFrame(now);
		}
		
		public function reBindingChat():void
		{
			ExternalInterface.addCallback("RequestChat", RequestChat);
		}
		
		public function sendChannelPublicMessage(content:String, channel:String):void
		{
			interfaceOfSon.sendChannelPublicMessage(content,channel);
		}
		
		public function RequestChat(chat:String):void
		{
			if(chat!=null)
				interfaceOfSon.sendPublicMessage(chat);
		}
		
		private function onPreScene(e:AppEvent):void
		{
			this.removeEventListener(AppEvent.ScenePrepare,onPreScene);	
			main = new Main(this);	
			interfaceOfSon = e.objHander as Object;
			dispatchEvent(new AppEvent(AppEvent.ScenePrepareDone));
		}
		
		public function onInit(whichLobby:String):void
		{
			main.whichLobby = whichLobby;
		}
		
		public function onGetUserInfo(user:User):void
		{
			main.uiReadyRoom.onGetUserInfo(user);
		}
		
		public function lobbyPushUserAdd(user:User):void
		{
			main.uiReadyRoom.lobbyPushUserAdd(user);
		}
		
		public function lobbyDeleteUser(username:String):void
		{
			main.uiReadyRoom.lobbyDeleteUser(username);
		}
		
		public function onUserLeave(user:String):void
		{
			main.uiReadyRoom.onUserLeave(user);
		}
		
		public function onUserUpdate(e:UserUpdateEvent):void
		{
			
		}
		
		public function onGetCardGroup(esObj:EsObject):void
		{
			main.uiReadyRoom.onGetCardGroup(esObj);
		}
		
		public function onSetCurrentCardGroup(esObj:EsObject):void
		{
			main.uiReadyRoom.onSetCurrentCardGroup(esObj);
		}
		
		public function onGameReadyStatus(esobj:EsObject, hostReady:Boolean, ready:Boolean):void
		{
			main.uiReadyRoom.onGameReadyStatus(esobj, hostReady, ready);
		}
		
		public function onGetUsersInLobbyResponse(user:User):void
		{
			main.uiReadyRoom.onGetUsersInLobbyResponse(user);
		}
		
		public function onSize():void
		{
			Panel.x =(stage.stageWidth -Panel.width)/2;
		}
		
		public function addToFloat(_ui:*):void
		{
			interfaceOfSon.addToFloat(_ui);
		}
		
		public function removeFromFloat(_ui:*):void
		{
			interfaceOfSon.removeFromFloat(_ui);
		}
		
		public function initUI(whichLobby:String):void
		{
			main.whichLobby = whichLobby;
			main.uiReadyRoom.initUI();
		}
		
		public function updateRoom(room:Room):void
		{
			main.uiReadyRoom.updateRoom(room);
		}
		
		public function leaveRoomCompleted():void
		{
			main.uiReadyRoom.leaveRoomCompleted();
		}
	}
}