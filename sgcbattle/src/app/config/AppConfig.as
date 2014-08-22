package app.config
{
	import com.syndrome.sanguo.battle.common.CardInfo;

	/**
	 * 全局配置文件
	 */
	public class AppConfig
	{
		private static var parameters:Object;
		
		public function AppConfig()
		{
		}
		
		/**
		 * 初始化参数
		 */
		public static function initParameters(obj:Object):void
		{
			parameters = obj;
		}
		
		/**
		 * 是否显示控制台
		 */
		public static function get showConsole():Boolean
		{
			if(parameters.hasOwnProperty("showConsole") && parameters["showConsole"] == "true"){
				return true;
			}
			return false;
		}
		
		/**
		 * 是否是Debug模式
		 */
		public static function get debug():Boolean
		{
			if(parameters.hasOwnProperty("debug") && parameters["debug"] == "true"){
				return true;
			}
			return false;
		}
		
		/**
		 * 默认的资源路径
		 */
		public static function get defaultSourceFolder():String
		{
			if(debug){
				return "resource/";
			}else{
				return "./Public/Game/resource/";
			}
		}
		
		/**
		 * 人物头像路径
		 */
		public static function get roleIconFolder():String
		{
			return "http://ytsgc.qiniudn.com/";
		}
		
		/**
		 * 大图文件格式
		 */
		public static function get bigCardType():String
		{
			return ".jpg";
		}
		
		/**
		 * 大图文件夹
		 */
		public static function get bigCardFolder():String
		{
			return "http://ytsgc.qiniudn.com/Public/Home/Image/cards/toolip/";
		}
		
		/**
		 * 初始化全局配置
		 */
		public static function initConfig():void
		{
			CardInfo.buildCardsInfo();
		}
	}
}