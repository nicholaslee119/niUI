package com.load.resmanager
{
	import com.load.xmlmanager.XMLManager;
	import com.syndrome.client.parameters.PublicParameters;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.utils.Timer;
	
	import mx.utils.object_proxy;
	
	/**
	 * 资源管理器
	 * @author nic
	 */	
	public class ResManager extends EventDispatcher
	{
		private static var instance:ResManager = null;
		private var resItems:Vector.<ResItem>;
		private var delayTimer:Timer = new Timer(500, 1);
		
		public static function getInstance():ResManager
		{
			if(instance==null)
				instance = new ResManager();
			return instance;
		}
		
		public function ResManager(target:IEventDispatcher=null)
		{
			super(target);
			init();
		}
		
		private function init():void
		{
			resItems = new Vector.<ResItem>;
			Security.loadPolicyFile(XMLManager.getUrlByName("imageDomain"));
		}
		
		public function getRes(url:String, onGet:Function=null, onProcess:Function=null):void
		{
			if(url==null)
			{trace("[ResManager]: 传入的url为空");return;}
			try{
				new GetResHandler(url, resItems, onGet, onProcess);
			}catch(e:Error){
				trace("[ResManager]:发生错误："+e.message);
			}
		}
	}
}