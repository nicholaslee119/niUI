package com.syndrome.sanguo.battle.common
{
	import org.flexlite.domDll.Dll;

	/**
	 * 一些配置信息
	 */
	public class ConfigInfo
	{
		public function ConfigInfo()
		{
		}
		
		public static function getEventMsg(eventid:int):String
		{
			var xml:XML = Dll.getRes("event");
			return xml.event.(id == eventid).text;
		}
		
		public static  function getReasonMsg(reasonid:int):String
		{
			var xml:XML = Dll.getRes("reason");
			return xml.reason.(id == reasonid).text;
		}
		
		public static  function getFormatMsg(messageid:int):String
		{
			var xml:XML = Dll.getRes("message_format");
			return xml.message.(id == messageid).text;
		}
		
		public static  function getActionMsg(actionid:int):String
		{
			var xml:XML = Dll.getRes("actions");
			return xml.action.(id == actionid).text;
		}
	}
}