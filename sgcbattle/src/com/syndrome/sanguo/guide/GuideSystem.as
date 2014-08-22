package com.syndrome.sanguo.guide
{
	import com.syndrome.sanguo.guide.config.CommandAdapter;
	import com.syndrome.sanguo.guide.config.ICommandAdapter;

	public class GuideSystem
	{
		private var currentSelectName:String;
		private var currentIndex:int;
		private var currentScript:Array;
		
		private var guideLib:GuideLib = new GuideLib();
		
		public function GuideSystem()
		{
		}
		
		/**
		 * 初始化配置
		 */
		public function init(command:XML , scripts:Object):void
		{
			guideLib.init(command , scripts);
		}
		
		public function guideStart(name:String) : void
		{
			var arr:Array = guideLib.getScript(name);
			if (!arr)
			{
				throw(new Error("配置文件"+name+"无法解析"));
				return;
			}
			_auto = true;
			currentSelectName = name;
			currentScript = arr;
			this.doStep(1);
		}
		
		/**
		 * 结束向导
		 */
		public function guideOver():void
		{
		}
		
		private var _commandAdapter:ICommandAdapter = new CommandAdapter();
		
		public function get commandAdapter():ICommandAdapter
		{
			return _commandAdapter;
		}
		
		public function doStep(index:int):void
		{
			if(index > currentScript.length){
				guideOver();
				return;
			}
			currentIndex = index;
			var currentStep:Object = currentScript[index - 1];
			commandAdapter.run(currentStep["command"] , currentStep["param"] , this);
		}
		
		public function doNext():void
		{
			doStep(currentIndex+1);
		}
		
		public function goto(index:String):void
		{
			if(index == null || index == ""){
				return;
			}else if(index.indexOf("+") == 0){
				doStep(currentIndex+int(index.substring(1)));
			}else if(index.indexOf("-") == 0){
				doStep(currentIndex-int(index.substring(1)));
			}else{
				doStep(int(index));
			}
		}
		
		private var _auto:Boolean;
		/**
		 * 一个标志表示引导是否自动前进
		 */
		public function get auto():Boolean
		{
			return _auto;
		}
		
		public function set auto(value:Boolean):void
		{
			_auto = value;
		}
		
		private static var _instance:GuideSystem;
		public static function getInstance():GuideSystem
		{
			if(_instance == null){
				_instance = new GuideSystem();
			}
			return _instance;
		}
	}
}