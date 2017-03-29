package com.communication.gamecom
{
	import com.communication.ComEvent;
	import com.communication.EventObj;
	import com.electrotank.electroserver5.ElectroServer;
	import com.electrotank.electroserver5.api.ConnectionClosedEvent;
	import com.electrotank.electroserver5.api.ConnectionResponse;
	import com.electrotank.electroserver5.api.EsEvent;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.GenericErrorResponse;
	import com.electrotank.electroserver5.api.LeaveRoomEvent;
	import com.electrotank.electroserver5.api.LeaveRoomRequest;
	import com.electrotank.electroserver5.api.MessageType;
	import com.electrotank.electroserver5.api.PluginMessageEvent;
	import com.electrotank.electroserver5.api.PluginRequest;
	import com.electrotank.electroserver5.api.PrivateMessageRequest;
	import com.electrotank.electroserver5.api.PublicMessageRequest;
	import com.electrotank.electroserver5.api.ServerKickUserEvent;
	import com.electrotank.electroserver5.api.UserEvictedFromRoomEvent;
	import com.electrotank.electroserver5.zone.Room;
	import com.electrotank.electroserver5.zone.Zone;
	import com.load.xmlmanager.XMLManager;
	import com.syndrome.client.parameters.PublicParameters;
	
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.utils.setTimeout;
	
	public class GameCom extends EventDispatcher
	{
		private var blockref:int =0;
		private var buflist:Array=null;
		private static var instance:GameCom = new GameCom();
		public var esServer:ElectroServer = null;
		public var EsSettings:Array = new Array(2);
		private var connectionClosedEventHandler:ConnectionClosedEventHandler;
		private var connectionHandler:ConnectionHandler;
		private var genericErrorHandler:GenericErrorHandler;
		private var pluginMessageEventHandler:PluginMessageEventHandler
		private var serverKickUserEventHandler:ServerKickUserEventHandler;
		private var userEvictedFromRoomEventHandler:UserEvictedFromRoomEventHandler;
		
		public static function getInstance():GameCom
		{
			return instance;
		}
		
		public function GameCom()
		{
			super(this);
//			clear();
			init();
		}
		
		public function init():void
		{
			if(esServer==null) esServer=new ElectroServer();
		}
		
		public function connect():void
		{
			if(PublicParameters.isDebug()) trace("onconnect");
			else ExternalInterface.call("onConnect");
			buflist =new Array(0);
			connectionHandler = new ConnectionHandler();
			connectionClosedEventHandler = new ConnectionClosedEventHandler();
			genericErrorHandler = new GenericErrorHandler();
			pluginMessageEventHandler = new PluginMessageEventHandler();
			serverKickUserEventHandler = new ServerKickUserEventHandler();
			userEvictedFromRoomEventHandler = new UserEvictedFromRoomEventHandler();
			connectionHandler.connect();
		}
		
		internal function sendMsg(type:String,data:EventObj=null,flag:Boolean=false,errmsg:String=""):void
		{
			var evt:ComEvent =new ComEvent(type);
			evt.msg=errmsg;
			evt.data=data;
			evt.sucss =flag;
			dispatchEvent(evt);
		}
		
		internal function onCallBack(e:EventObj):void
		{
			if(buflist == null) return;
			if(e.bxy)buflist.push(e);
			var bnempty:Boolean =true;
			while(bnempty && blockref==0 && hasEventListener(ComEvent.PROTOCOL))
			{
				if(buflist.length>0)
				{
					var obj:EventObj = buflist.shift() as EventObj;
					sendMsg(ComEvent.PROTOCOL,obj);
					if(buflist!=null && buflist.length>0) bnempty=true;
					else bnempty=false;
				}
				else bnempty=false;
			}
		}
		
		public function BlockRecv():int
		{
			blockref++;
			if(blockref ==0 && esServer.engine.connected)
			{
				var evtObj:EventObj =new EventObj();
				evtObj.bxy =false;
				evtObj.data =null;
				setTimeout(CallBackWait,1,evtObj);
			}
			return blockref;
		}
		
		public function get BlockCount():int
		{
			return blockref;
		}
		
		public function UnBlockRecv(bDirect:Boolean =false):int
		{
			if(bDirect) blockref=0;
			else blockref--;
			if(blockref == 0 && esServer.engine.connected)
			{
				var evtObj:EventObj =new EventObj();
				evtObj.bxy =false;
				evtObj.data =null;
				setTimeout(CallBackWait,1,evtObj);
			}
			return blockref;
		}
		
		private function CallBackWait():void
		{
			var evtObj:EventObj = arguments[0] as EventObj;
			onCallBack(evtObj);
		}
		
		public function toSend(esob:EsObject):void
		{
			var e:PluginMessageEvent =new PluginMessageEvent();
			e.parameters =esob;
			var obj:EventObj =new EventObj();
			obj.bxy=true;
			obj.data =e;
			onCallBack(obj);
		}
		
		public function clear():void
		{
			blockref=0;
			buflist=null;
			esServer=null;
		}
	}
}