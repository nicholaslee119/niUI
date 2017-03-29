package com.syndrome.sanguocard.mainfram.esroom.esroombase
{
	import com.communication.ComEvent;
	import com.communication.gamecom.GameCom;
	import com.electrotank.electroserver5.api.EsObject;
	import com.electrotank.electroserver5.api.PluginRequest;
	import com.syndrome.client.parameters.Constant;

	public class EsRoomProtocolHandler extends EsRoomHandlerBase
	{
		private const ACTION_COST_GAME_GOLD:String = "costGameGold";
		
		public function EsRoomProtocolHandler(_esRoomBase:EsRoomBase)
		{
			super(_esRoomBase);
		}
		
		override final protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			GameCom.getInstance().addEventListener(ComEvent.PROTOCOL,onProtocol);
		}
		
		protected function onProtocol(e:ComEvent):void{}
		
		public function sendServerPackage(es:EsObject):void
		{
			if(!GameCom.getInstance().esServer.engine.connected) return;
			var pr:PluginRequest = new PluginRequest();
			pr.parameters = es;
			pr.pluginName = "InvokePlugin";
			GameCom.getInstance().esServer.engine.send(pr);
		}
		
		public function sendPackage(es:EsObject,type:int=0):Boolean
		{
			if(!GameCom.getInstance().esServer.engine.connected || esRoomBase.roomManager.room==null || esRoomBase.roomManager.zone==null) return false;
			var pr:PluginRequest = new PluginRequest();
			pr.parameters = es;
			pr.roomId = esRoomBase.roomManager.room.id;
			pr.zoneId = esRoomBase.roomManager.room.zoneId;
			pr.pluginName = esRoomBase.roomManager.pluginName;
			GameCom.getInstance().esServer.engine.send(pr);
			return true;
		}
		
		public function costGameGold(gameGoldAmount:int, from:String):void
		{
			var object:EsObject = new EsObject();
			object.setString("tx", Constant.CostGameGold);
			var cb:EsObject = new EsObject();
			cb.setString("from", from);
			cb.setString("action", ACTION_COST_GAME_GOLD);
			var paraObj:EsObject = new EsObject();
			var _val:Array = new Array(GameCom.getInstance().esServer.managerHelper.userManager.me.userName, gameGoldAmount.toString());
			paraObj.setStringArray("_val", _val);
			object.setEsObject(Constant.CostGameGold, paraObj);
			object.setEsObject("cb", cb);
			sendServerPackage(object);
		}
		
	}
}