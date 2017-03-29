package com.load
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	
	public class gameFramLoad extends EventDispatcher
	{
		public function gameFramLoad()
		{
			super(this);
		}
		private static function getManage():gameFramLoad
		{
			if(mange==null)mange=new gameFramLoad();
			return mange;
		}
		public static function addEventListener(type:String ,fun:Function):void
		{
			getManage().addEventListener(type,fun);
		}
		public static function RemoveEventListener(type:String ,fun:Function):void
		{
			getManage().removeEventListener(type,fun);
		}
		
		private function sendMsg(strEvent:String,obj:DisplayObject,err:String="",byteLoaded:uint=0,byteTotal:uint=0):void
		{
			var evt:gameFramEvent =new gameFramEvent(strEvent);
			evt.diplayObj=obj;
			evt.errMsg=err;
			evt.bytesLoaded=byteLoaded;
			evt.bytesTotal=byteTotal;
			dispatchEvent(evt);
		}
		
		public static function beginLoad(_resUrl:String,fmain:Object):void
		{
			getManage().fmain =fmain;
			getManage().beginLoad(_resUrl);
		}
		private function beginLoad(_resUrl:String):void
		{
			if(swfld==null) swfld =new Loader();
			fmain.addChild(swfld);
			swfld.visible = false;
			//swfld.loaderContext =new LoaderContext();
			//swfld.loaderContext.applicationDomain =new ApplicationDomain(ApplicationDomain.currentDomain);
			swfld.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			swfld.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onErr)
			swfld.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgress);
			swfld.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
			swfld.load(new URLRequest(_resUrl));
		}
		
		//进度条
		private function onProgress(e:ProgressEvent):void
		{
			sendMsg(gameFramEvent.updateProgress,null,"",e.bytesLoaded,e.bytesTotal);
		}
		//完成
		private function onComplete(e:Event):void
		{
			swfld.contentLoaderInfo.removeEventListener(Event.COMPLETE,onComplete);
			swfld.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onErr)
			swfld.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,onProgress);
			swfld.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
			if(fmain.contains(swfld)) fmain.removeChild(swfld);
			onApplication();
		}
		
		private function onApplication():void
		{
			var sys:DisplayObject = swfld.content as DisplayObject;
			sendMsg(gameFramEvent.complete,sys);
		}
		//错误
		private function onErr(e:IOErrorEvent):void
		{
			sendMsg(gameFramEvent.err,null,e.text);
		}
		private function onSecurityError(e:SecurityErrorEvent):void
		{
			sendMsg(gameFramEvent.err,null,e.text);
		}
		
		private var swfld:Loader =null;
		private var fmain:Object =null;
		private  static var mange:gameFramLoad=null;
	}
}