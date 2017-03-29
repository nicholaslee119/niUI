package com.syndrome.sanguo.record
{
	import com.syndrome.sanguo.record.config.IRecordAdapter;
	import com.syndrome.sanguo.record.config.RecordAdapter;
	
	public class RecordSystem
	{
		private var currentSelectName:String;
		private var currentIndex:int;
		private var currentScript:Array;
		
		private var recordLib:RecordLib = new RecordLib();
		
		public function RecordSystem()
		{
		}
		
		/**
		 * 初始化配置
		 */
		public function init(scripts:Object):void
		{
			recordLib.init(scripts);
		}
		
		public function recordStart(name:String) : void
		{
			var arr:Array = recordLib.getScript(name);
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
		 * 获取脚本信息
		 */
		public function getScript(name:String):Array
		{
			return recordLib.getScript(name);
		}
		
		/**
		 * 结束向导
		 */
		public function recordOver():void
		{
		}
		
		private var _recordAdapter:IRecordAdapter = new RecordAdapter();
		
		public function get recordAdapter():IRecordAdapter
		{
			return _recordAdapter;
		}
		
		public function doStep(index:int):void
		{
			if(index > currentScript.length){
				recordOver();
				return;
			}
			currentIndex = index;
			var currentStep:Object = currentScript[index - 1];
			recordAdapter.run(currentStep , this);
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
		
		private var _auto:Boolean = true;
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
		
		private static var _instance:RecordSystem;
		public static function getInstance():RecordSystem
		{
			if(_instance == null){
				_instance = new RecordSystem();
			}
			return _instance;
		}
	}
}