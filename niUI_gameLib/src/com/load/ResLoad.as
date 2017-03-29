package com.load
{
	import com.syndrome.client.parameters.PublicParameters;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	//资源加载管理器
	public class ResLoad extends EventDispatcher
	{
		public function ResLoad()
		{
			super(this);
		}
		private static function getManage():ResLoad
		{
			if(mange==null)mange=new ResLoad();
			return mange;
		}
		public static function getRes(index:int):Object
		{
			return getManage().resSwf[index];
		}
		public static  function get getRess():Array
		{
			return getManage().resSwf;
		}
		public static function addEventListener(type:String ,fun:Function):void
		{
			getManage().addEventListener(type,fun);
		}
		public static function RemoveEventListener(type:String ,fun:Function):void
		{
			getManage().removeEventListener(type,fun);
		}
		
		public static function beginLoad(_resUrl:Array,_resName:Array,_load:Loader=null):void
		{
			getManage().beginLoad(_resUrl,_resName,_load);
		}
		
		private function beginLoad(_resUrl:Array,_resName:Array,_load:Loader=null):void
		{
			swfld =_load;
			resIndex=-1;
			if(swfld==null)swfld=new Loader();
			var lenth:int =_resUrl.length;
			if(lenth>0) resSwf =new Array(lenth);
			for(var i:int =0; i< lenth;i++)
			{
				if(resSwf[i]==null){
					resSwf[i]=new resObject();
					(resSwf[i] as resObject).objName=_resName[i];
					(resSwf[i] as resObject).url =_resUrl[i];
				}
			}
			LoadResIndex();
		}
		
		private function sendMsg(strEvent:String,name:String="",
		err:String="",byteLoaded:uint=0,byteTotal:uint=0):void
		{
			var evt:SceneLoadEvent =new SceneLoadEvent(strEvent);
			evt.msgLog=name;
			evt.errMsg=err;
			evt.bytesLoaded=byteLoaded;
			evt.bytesTotal=byteTotal;
			evt.count =resSwf.length;
			evt.nIndex =resIndex+1;
			dispatchEvent(evt);
		}
		
		private function LoadResIndex():void
		{
			resIndex++;
			var total:int=resSwf.length;
			if(resIndex >=total)
			{
				//发送加载完成
				sendMsg(SceneLoadEvent.complete);
			}
			else
			{
				var tmp:resObject=resSwf[resIndex];
				var conne:LoaderContext =new LoaderContext();
				conne.applicationDomain =new ApplicationDomain(ApplicationDomain.currentDomain);
				swfld.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
				swfld.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onErr)
				swfld.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgress);
				swfld.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
				swfld.load(new URLRequest(tmp.url),conne);
			}
		}
		//进度条
		private function onProgress(e:ProgressEvent):void
		{
			var tmp:resObject =resSwf[resIndex];
			sendMsg(SceneLoadEvent.updateProgress,tmp.objName,"",e.bytesLoaded,e.bytesTotal);
		}
		//完成
		private function onComplete(e:Event):void
		{
			if(PublicParameters.isDebug())trace("onResLoadComplete");
			swfld.contentLoaderInfo.removeEventListener(Event.COMPLETE,onComplete);
			swfld.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onErr)
			swfld.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,onProgress);
			swfld.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
			
			var tmp:resObject =resSwf[resIndex];
			var loaderInfo:LoaderInfo =e.target as LoaderInfo;
			var resHander:Class =loaderInfo.applicationDomain.getDefinition(tmp.objName) as Class;
			tmp.objRes =new resHander();
			sendMsg(SceneLoadEvent.compelteProgress,tmp.objName);
			LoadResIndex();
		}
		//错误
		private function onErr(e:IOErrorEvent):void
		{
			var tmp:resObject =resSwf[resIndex];
			sendMsg(SceneLoadEvent.err,tmp.objName,e.text);
		}
		private function onSecurityError(e:SecurityErrorEvent):void
		{
			var tmp:resObject =resSwf[resIndex];
			sendMsg(SceneLoadEvent.err,tmp.objName,e.text);
		}
		private var resIndex:int=-1;
		private var swfld:Loader =null;
		private  static var mange:ResLoad=null;
		private var resSwf:Array=null;// 文件资源
		//private var bar:ProgressBar =null;//进度条
	}
}