package com.syndrome.sanguo.guide.config
{
	import flash.utils.getDefinitionByName;

	/**
	 * 默认的引导教学的转换规则
	 */
	public class ConvertRule implements IConvertRule
	{
		public function ConvertRule()
		{
		}
		
		/**
		 * 具体项目的转换规则，可以修改这里
		 * 将命令参数的值转换成正确的类型
		 */
		public function convertParam(type:String , value:String):*
		{
			if(type == "String")
			{
				return value;
			}
			else if(type == "Boolean")
			{
				return value=="true"?true:false;
			}
			else if(type == "Array_Array_int")
			{
				var valueArray:Array = value.split(";");
				var res:Array = new Array();
				for(var i:int =0; i<valueArray.length; i++){
					res.push(converStringToArrayArray(valueArray[i]));
				}
				return res;
			}
			else if(type.indexOf("Array") == 0)
			{
				if(type.split("_",2).length<2)
				{
					return convertStringToArray("String" , value);
				}
				else
				{
					return convertStringToArray(type.split("_")[1] , value);
				}
			}
			else
			{
				return getDefinitionByName(type)(value);
			}
		}
		
		private function converStringToArrayArray(value:String):Array{
			
			var res:Array = new Array();
			value = value.replace(/\[|\]/g,"");   //去除 [ ]  
			var valueArray:Array = value.split(",");
			for(var i:int = 0; i<valueArray.length; i++){
				res.push(valueArray[i]);
			}
			return res;
		}
		
		
		/**
		 * 将字符串转换为数组
		 * @param arrType 数组类型
		 * @param value 要转换的值
		 * @return 转换后的数组
		 */
		private function convertStringToArray(arrType:String , value:String):Array
		{
			value = value.replace(/\[|\]/g,"");   //去除 [ ]  
			if(value == ""){
				return [];
			}
			var arr:Array = value.split(",");
			for (var i:int = 0; i < arr.length; i++) 
			{
				convertParam(arrType , arr[i]);
			}
			return arr;
		}
	}
}