package com.syndrome.sanguo.record
{
	import flash.utils.ByteArray;
	
	/**
	 * 教学脚本和配置库
	 */
	public class RecordLib
	{
		/**
		 * 配置脚本 key对应name ， value对应一个Array
		 */
		private var recordScripts:Object ={};
		
		public function RecordLib()
		{
		}
		
		private var scripts:Object;
		public function init(scripts:Object):void
		{
			this.scripts = scripts;
			recordScripts = {};
		}
		
		/**
		 * 获取教学脚本资源
		 */
		public function getScript(name:String):Array
		{
			if(recordScripts.hasOwnProperty(name))
			{
				return recordScripts[name] as Array;
			}
			else
			{
				var byteArray:ByteArray;
				if(scripts && scripts.hasOwnProperty(name))
					byteArray = scripts[name] as ByteArray;
				if(byteArray && byteArray.length > 0)
				{
					recordScripts[name] = parseScript(byteArray);
					return recordScripts[name] as Array;
				}
				else
				{
					return null;
				}
			}
		}
		
		/**
		 * 解析脚本文件
		 */
		private function parseScript(byteArray:ByteArray):Array
		{
			var result:Array = [];
			var resultStr:String;
			resultStr = byteArray.readUTFBytes(byteArray.length);
			var resultArr:Array = resultStr.split(/\r\n|\r|\n/g);  //匹配换行符
			for each (var str:String in resultArr) 
			{
				if(!str || str.indexOf("#") == 0)
				{
					continue;
				}
				result.push(JSON.parse(str));
			}
			return result;
		}
	}
}