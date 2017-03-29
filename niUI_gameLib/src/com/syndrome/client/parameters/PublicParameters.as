package com.syndrome.client.parameters
{
	/*
	* @author nic
	* @build-time 2014-3-3
	* @comments 公用参数类
	*/
	public class PublicParameters
	{
		public function PublicParameters(){}
		
		/**
		 *本地调试环境
		 */		
		private static var LOCAL_DEBUG:String = "localDebug";
		/**
		 *发布环境 
		 */		
		private static var RELEASE:String = "release";
		/**
		 * 运行环境 
		 */		
		public static var RUNTIME_ENVIRONMENT:String = "release";
		
		public static function isDebug():Boolean
		{
			if(RUNTIME_ENVIRONMENT==LOCAL_DEBUG)
				return true;
			else
				return false;
		}
		
	}
}