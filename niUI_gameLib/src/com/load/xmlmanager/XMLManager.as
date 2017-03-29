package com.load.xmlmanager
{
	import com.load.XmlLoad;
	import com.load.xmlLoadEvent;
	import com.syndrome.client.parameters.ParametersXMLLoader;
	import com.syndrome.client.parameters.PublicParameters;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/*
	* XML获取的类
	* @author nic
	* @build-time 2014-3-4
	* @comments XML管理器
	*/
	public class XMLManager
	{
		private static var instance:XMLManager=new XMLManager();
		private static var xmlItems:Vector.<XMLItem>;
		private var delayTimer:Timer = new Timer(500, 1);
		
		public function XMLManager()
		{
			
		}
		
		/**
		 * 每个模块使用XMLMananger之前必须初始化，而且是异步使用 
		 * @param onSuccess
		 * 
		 */		
		public static function init(onSuccess:Function):void
		{
			xmlItems = new Vector.<XMLItem>();
			new ParametersXMLLoader(onCompleted);
			function onCompleted(resUrls:XMLList):void
			{
				for each(var resUrl:XML in resUrls)
					xmlItems.push(new XMLItem(resUrl.attribute("name"), resUrl.attribute("url"), resUrl.localName()));
				onSuccess();
			}
		}
		
		/**
		 * 通过localName获取URL 
		 * @param localName
		 * @param onSuccess
		 * 
		 */		
		public static function getUrlsByLocalName(localName:String):Vector.<String>
		{
			if(xmlItems==null)
			{
				trace("[XMLManager]:配置文件未加载成功");
				return null;
			}else{
				var items:Vector.<String>=new Vector.<String>();
				xmlItems.forEach(function(item:XMLItem, index:int, vector:Vector.<XMLItem>):void{
					if(item.localName==localName)
						items.push(item.url);
				});
				return items;
			}
		}
		
		/**
		 * 通过Name获取URL 
		 * @param name
		 * @param onSuccess
		 */		
		public static function getUrlByName(name:String):String
		{
			if(xmlItems==null)
			{
				trace("[XMLManager]:配置文件未加载成功");
				return null;
			}else{
				var url:String;
				xmlItems.some(function(item:XMLItem, index:int, vector:Vector.<XMLItem>):Boolean{
					if(item.name==name)
					{
						url = item.url;
						return true;
					}
					else
						return false;
				});
				if(url==null)trace("[XMLManager]:未找到对应资源URL");
				return url;
			}
		}
	}
}