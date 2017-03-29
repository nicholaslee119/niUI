package com.syndrome.sanguo.guide
{
	import com.syndrome.sanguo.guide.config.ConvertRule;
	import com.syndrome.sanguo.guide.config.IConvertRule;
	
	import flash.utils.ByteArray;
	
	/**
	 * 教学脚本和配置库
	 */
	public class GuideLib
	{
		/**
		 * 配置脚本 key对应name ， value对应一个Array
		 */
		private var guideScripts:Object ={};
		
		/**
		 * 配置命令数组
		 */
		private var guideConfig:Object = {};
		
		public function GuideLib()
		{
		}
		
		private var scripts:Object;
		public function init(command:XML , scripts:Object):void
		{
			parseCommand(command);
			this.scripts = scripts;
		}
		
		/**
		 * 解析配置文件
		 */
		private function parseCommand(config:XML):void
		{
			var groups:XMLList = config.group;
			for each(var group:XML in groups)
			{
				var groupName:String = String(group.@name);
				var groupLabel:String = String(group.@label);
				var commands:XMLList = group.command;		//命令
				for each(var command:XML in commands)
				{
					var commandName:String = String(command.@name);
					var params:XMLList = command.param;
					var paramObject:Object = {};
					for each (var param:XML in params) 
					{
						paramObject[ String(param.@name) ] = String(param.@type) ? String(param.@type) : "String";
					}
					guideConfig[commandName] = paramObject;
				}
			}
		}
		
		/**
		 * 获取教学脚本资源
		 */
		public function getScript(name:String):Array
		{
			if(guideScripts.hasOwnProperty(name))
			{
				return guideScripts[name] as Array;
			}
			else
			{
				var byteArray:ByteArray;
				if(scripts && scripts.hasOwnProperty(name))
					byteArray = scripts[name] as ByteArray;
				if(byteArray && byteArray.length > 0)
				{
					guideScripts[name] = parseScript(byteArray);
					return guideScripts[name] as Array;
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
			var resultArr:Array = resultStr.split(new RegExp("\r[\s| ]*\n","g"));  //匹配换行符
			for (var i:int = 0; i < resultArr.length; i++) 
			{
				var step:String = resultArr[i];
				var stepObj:Object = {};
				if(step == ""){
					continue;
				}
				var element:Array = step.replace(/(\s+)/g," ").split(" ");   //匹配空格，多个空格，TAB
				var command:String;
				if(element.length>0 && element[0].indexOf("//")<0){
					command = element[0] as String;
					stepObj["command"] = command;
					stepObj["param"] = {};
				}else{
					continue;
				}
				for (var j:int = 1; j < element.length; j++)
				{
					var elementStr:String = element[j];
					if(elementStr.indexOf(":")<0){
						continue;
					}
					var param:Array = elementStr.split(":");
					var paramType:String = guideConfig[command][param[0]] as String;   //参数类型
					stepObj["param"][param[0]] = convertRule.convertParam(paramType,param[1]);   //参数列表
				}
				result.push(stepObj);
			}
			return result;
		}
		
		private var defaultCovertRule:ConvertRule;
		/**
		 * 获取转换规则
		 */
		public function get convertRule():IConvertRule
		{
			//TODO将来这里可以做成依赖注入
			if(!defaultCovertRule)
			{
				defaultCovertRule = new ConvertRule();
			}
			return defaultCovertRule;
		}
	}
}