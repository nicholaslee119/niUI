package com.syndrome.sanguocard.mainfram.loader
{
	import com.model.business.fileService.UrlSwfLoader;
	import com.model.business.fileService.interf.IUrlSwfLoaderReceiver;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.sampler.Sample;

	public class loadSWF implements IUrlSwfLoaderReceiver
	{
		private var _loader:UrlSwfLoader;
		protected var _movie : Sprite;
		private var _class : String;
		private var _swf :Object;
		private var _process : int;
		private var _processFun:Function;
		private var _comFun:Function;
		
		public function loadSWF(url:String, classStr:String, _fun:Function=null, _fun1:Function=null)
		{
			_class = classStr;
			_loader = new UrlSwfLoader(this);
			_loader.autoParse = true;
			_loader.loadSwf(url, null, true);
			_processFun = _fun;
			_comFun = _fun1;
		}
		
		public function urlSwfReceive(url:String, swf:Object, info:Object):void
		{
			_swf = swf;
			var tmp:Class = _swf.loaderInfo.applicationDomain.getDefinition(_class) as Class;
			_movie = new tmp() as Sprite;
			_comFun(_movie);
		}
		
		public function urlSwfProgress(url:String, progress:Number, info:Object):void
		{
			_process = progress*100;
			_processFun(progress);
		}
		
		public function urlSwfError(url:String, info:Object):void
		{
			trace("load err:" + url);
		}	
		
		public function destroy():void
		{
//			if(_swf)
//			{
//				_swf.stop();
//				_swf = null;
//			}
			
			if(_loader)
			{
				_loader.destroy();
				_loader = null;
			}
		}
		
		public function get movie():Sprite
		{
			return _movie;
		}
		
		public function get process():int
		{
			return _process;
		}
		
	}
}