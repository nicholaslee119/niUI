package
{
	import com.communication.AppEvent;
	import com.electrotank.electroserver5.user.User;
	import com.hurlant.math.NullReduction;
	import com.syndrome.sanguo.platform.Main;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	[SWF(backgroundColor="0x000000")]
	public class PlatForm extends Sprite
	{
		public var Panel:Sprite = new Sprite();
		private var main:Main = null;
		public var interfaceOfSon:Object = null;
		
		public function PlatForm()
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
			ExternalInterface.addCallback("RequestPrivateChat", RequestPrivateChat);
			ExternalInterface.addCallback("RequestFriendApply", requestFriend);
			ExternalInterface.addCallback("RequestEmailEvent", requestEmailEvent);
			ExternalInterface.addCallback("RequestUserInfoUpdate", requestUserInfoUpdate);
			main = Main.CreateInstance(this);
		}
		
		private function onEnterFrame(e:Event):void
		{
			var now:Number =new Date().time;
			if(interfaceOfSon!=null)interfaceOfSon.onEnterFrame(now);
		}
		
		public function reBindingChat():void
		{
			ExternalInterface.addCallback("RequestChat", RequestChat);
		}
		
		private function requestUserInfoUpdate():void
		{
			interfaceOfSon.updateGUI();
		}
		
		private function requestFriend(receiverAccount:String):void
		{
			if(receiverAccount!=null)
				interfaceOfSon.sendFriendRequest(receiverAccount);
		}
		
		private function requestEmailEvent(receiverAccount:String):void
		{
			if(receiverAccount!=null)
				interfaceOfSon.sendMailRequest(receiverAccount);
		}
		
		
		public function RequestPrivateChat(chat:String, usersName:Array):void
		{
			if(chat!=null && usersName!=null)
				interfaceOfSon.sendPrivateMessage(chat, usersName);
		}
		
		private function RequestChat(chat:String):void
		{
			if(chat!=null)
				interfaceOfSon.sendPublicMessage(chat);
		}
		
		private function onPreScene(e:AppEvent):void
		{
			this.removeEventListener(AppEvent.ScenePrepare,onPreScene);	
			interfaceOfSon = e.objHander as Object;
			dispatchEvent(new AppEvent(AppEvent.ScenePrepareDone));
		}
		
		public function onUserLeave(user:String):void
		{
			trace("game: "+user+" Leave");
		}
		
		public function onGameStateChange(oldstate:int,nowState:int):void
		{
			trace("onGameStateChange["+nowState+"]");
		}
		
		public function onUserStateChange(userName:String,nowState:int):void
		{
			trace("onUserStateChange["+userName+"]"+nowState);
		}
		
		public function onInit():void
		{
			
		}
		
		public function onEnterGame(user:User):void
		{
			trace("onEnterGamePlatForm");
		}
	}
}