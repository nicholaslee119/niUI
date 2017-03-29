package net
{
	import com.communication.InterfaceOfSonBattleEvent;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.EsObjectDataHolder;
	import com.electrotank.electroserver5.api.UserVariable;
	import com.electrotank.electroserver5.user.User;
	import com.hurlant.math.BigInteger;
	import com.syndrome.client.parameters.Constant;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.DebugWindow;
	
	import flash.utils.ByteArray;
	

	public class ESB 
	{
		public static var interfaceOfSon:Object;
		public function ESB()
		{
		}
		
		public static  function init(obj:Object):void
		{
			interfaceOfSon = obj;
			if(!interfaceOfSon){
				return;
			}
			if(!interfaceOfSon.hasEventListener(InterfaceOfSonBattleEvent.ON_INIT)){
				interfaceOfSon.addEventListener(InterfaceOfSonBattleEvent.ON_INIT , handleMsg);
			}
			if(!interfaceOfSon.hasEventListener(InterfaceOfSonBattleEvent.ON_PROTOCOL)){
				interfaceOfSon.addEventListener(InterfaceOfSonBattleEvent.ON_PROTOCOL , handleMsg);
			}
			if(!interfaceOfSon.hasEventListener(InterfaceOfSonBattleEvent.ON_USER_ENTER)){
				interfaceOfSon.addEventListener(InterfaceOfSonBattleEvent.ON_USER_ENTER , handleMsg);
			}
			if(!interfaceOfSon.hasEventListener(InterfaceOfSonBattleEvent.ON_CHANNEL_MESSAGE)){
				interfaceOfSon.addEventListener(InterfaceOfSonBattleEvent.ON_CHANNEL_MESSAGE , handleMsg);
			}
		}
		
		public static function destroy():void
		{
			if(interfaceOfSon){
				interfaceOfSon.removeEventListener(InterfaceOfSonBattleEvent.ON_PROTOCOL , handleMsg);
				interfaceOfSon.removeEventListener(InterfaceOfSonBattleEvent.ON_USER_ENTER , handleMsg);
				interfaceOfSon.removeEventListener(InterfaceOfSonBattleEvent.ON_CHANNEL_MESSAGE , handleMsg);
			}
		}
		
		protected static function handleMsg(event:InterfaceOfSonBattleEvent):void
		{
			switch(event.type){
				case InterfaceOfSonBattleEvent.ON_PROTOCOL:
//					var battleEs:EsObject = event.messagePara.data;
//					BattleMessageCenter.receive(trasformESToObject(battleEs.getEsObject("f")));
					BattleMessageCenter.receive(event.messagePara);
					break;
				case InterfaceOfSonBattleEvent.ON_USER_ENTER:
					var userObj:Object = trasformUserToObject(event.messagePara.user as User);
					userObj["type"] = "userEnter";
					BattleMessageCenter.receive2("UserUpdate" ,userObj);
					break;
				case InterfaceOfSonBattleEvent.ON_INIT:
					BattleMessageCenter.receive2("GameStateUpdate" ,{"type":"onInit"});
					break;
				case InterfaceOfSonBattleEvent.ON_CHANNEL_MESSAGE:
					BattleMessageCenter.receive2("ChannelMessageUpdate" ,event.messagePara);
					break;
			}
		}
		
		/**
		 * 发送聊天消息  index 1表示对战频道 ， 2表示世界频道
		 */
		public static function sendChannelMsg(content:String , index:int):void
		{
			var channel:String;
			if(index == 1){
				channel = Constant.CHANNEL_FIGHT;
			}else if(index == 2){
				channel = Constant.CHANNEL_WORLD;
			}else{
				return;  //TODO
			}
			if(interfaceOfSon){
				interfaceOfSon.sendChannelMessage(content , channel);
			}
		}
		
		
		/**
		 * 发送消息到服务器
		 */
		public static function sendBattleMsg(message:Object):void
		{
			DebugWindow.traceMsg(message);
			if(interfaceOfSon==null)
			{
				return;
			}
			else
			{
				var esdata:EsObject =new EsObject();
				esdata.setString("a","f");
				esdata.setEsObject("f",trasformObjectToES(message));
				interfaceOfSon.sendPackage(esdata,1);
			}
		}
		
		private static function trasformUserToObject(user:User):Object
		{
			if(user == null){
				return null;
			}
			var varArr:Array = user.userVariables;
			var result:Object = {"userName":user.userName , "isMe":user.isMe , 
				"isLoggedIn":user.isLoggedIn , "isSendingVideo":user.isSendingVideo};
			for (var i:int = varArr.length - 1; i >=0; i--) 
			{
				var userVariable:UserVariable = varArr[i] as UserVariable;
				if(!result.hasOwnProperty(userVariable.name)){
					result[userVariable.name] = trasformESToObject(userVariable.value);
				}
			}
			return result;
		}
		
		private static function trasformESToObject(es:EsObject):Object
		{
			if(es == null){
				return null;
			}
			var arr:Array = es.getEntries();
			var result:Object = {};
			for (var i:int = 0; i < arr.length; i++) 
			{
				var esd:EsObjectDataHolder = arr[i] as EsObjectDataHolder;
				var value:Object = esd.getRawValue();
				if(value is EsObject){
					value = trasformESToObject(value as EsObject);
				}else if(value is BigInteger){
					value = (value as BigInteger).valueOf();
				}else if(value is Array){
					var valueArr:Array = [];
					for (var j:int = 0; j < value.length; j++) 
					{
						if(value[j] is EsObject){
							valueArr.push(trasformESToObject(value[j]));
						}else if(value[j] is BigInteger){
							valueArr.push(value[j].valueOf());
						}else{
							valueArr.push(value[j]);
						}
					}
					value = valueArr;
				}
				result[esd.getName()] = value;
			}
			return result;
		}
		
		private static function trasformObjectToES(obj:Object):EsObject
		{
			var es:EsObject = new EsObject();	
			for(var key:String in obj){
				if(obj[key] is int){
					es.setInteger(key,obj[key]);
				}
				else if(obj[key] is uint){
					es.setLong(key,obj[key]);
				}
				else if(obj[key] is Number){
					es.setNumber(key,obj[key]);
				}
				else if(obj[key] is String){
					es.setString(key,obj[key]);
				}
				else if(obj[key] is Boolean){
					es.setBoolean(key,obj[key]);
				}
				else if(obj[key] is ByteArray){
					es.setByteArray(key,obj[key]);
				}
				else if(obj[key] is Array){
					setESArray(key,obj[key],es)
				}
				else if(obj[key] is EsObject){
					es.setEsObject(key,obj[key]);
				}
				else if(obj[key] is Object){
					es.setEsObject(key,trasformObjectToES(obj[key]));
				}
				else{
					trace("未知类型");
				}
			}
			es.setInteger("type",12);
			return es;
		}
		
		private static function setESArray(key:String,vector:Array,es:EsObject):void
		{
			if(vector.length<1){
				return;
			}
			var object:* = vector[0];
			if(object is int){
				es.setIntegerArray(key,(vector));
			}
			else if(object is uint){
				es.setLongArray(key,(vector));
			}
			else if(object is Number){
				es.setNumberArray(key,(vector));
			}
			else if(object is String){
				es.setStringArray(key,(vector));
			}
			else if(object is Boolean){
				es.setBooleanArray(key,(vector));
			}
			else if(object is EsObject){
				es.setEsObjectArray(key,(vector));
			}
			else if(object is Object){
				var esArray:Array = [];
				for(var i:int = 0; i<vector.length ; i++){
					esArray.push((trasformObjectToES(vector[i])));
				}
				es.setEsObjectArray(key,esArray);
			}
		}
	}
}