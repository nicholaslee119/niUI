package com.communication.gamecom
{
	import com.communication.EventObj;
	import com.electrotank.electroserver5.api.MessageType;
	import com.electrotank.electroserver5.api.PluginMessageEvent;
	
	/*
	* @author nic
	* @build-time 2014-3-1
	* @comments
	*
	*/
	public class PluginMessageEventHandler
	{
		public function PluginMessageEventHandler()
		{
			GameCom.getInstance().esServer.engine.addEventListener(MessageType.PluginMessageEvent.name, onPluginMessageEvent);
		}
		
		public function onPluginMessageEvent(e:PluginMessageEvent):void
		{
			var obj:EventObj =new EventObj();
			obj.bxy=true;
			obj.data =e;
			GameCom.getInstance().onCallBack(obj);
		}
	}
}