package com.load
{
	//单个资源包
	public class resObject
	{
		public var objRes:Object=null;
		public var loadEd:Boolean=false;
		public var objName:String="";
		public var url:String="";
		public function resObject()
		{
			reset();
		}
		private function reset():void
		{
			objRes=null;
			loadEd=false;
			objName="";
			url="";
		}
	}
}