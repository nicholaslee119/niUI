package com.load.resmanager
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.utils.Timer;
	
	
	/*
	* @author nic
	* @build-time 2014-3-12
	* @comments
	*
	*/
	public class GetResHandler
	{
		private var delayTimer:Timer = new Timer(500, 1);
		private var url:String;
		private var onGet:Function;
		private var onProcess:Function;
		private var resItems:Vector.<ResItem>;
		
		
		public function GetResHandler(_url:String, _resItems:Vector.<ResItem>, _onGet:Function=null, _onProcess:Function=null )
		{
			url = _url;
			resItems = _resItems;
			onGet = _onGet;
			onProcess = _onProcess;
			init();
		}
		
		private function init():void
		{
			var index:int = findRes(url);
			if(index!=-1)
			{
				delayTimer.addEventListener(TimerEvent.TIMER, delayTimerHandler);
				delayTimer.start();
			}
			else
				LoadRes(url, onGet, onProcess);
			
			function delayTimerHandler(e:TimerEvent):void
			{
				delayTimer.removeEventListener(TimerEvent.TIMER, delayTimerHandler);
				delayTimer.reset();
				if(onProcess!=null)onProcess(1);
				if(Vector.<ResItem>(resItems.slice(index, index+1)).pop().res==null)
				{
					delayTimer.addEventListener(TimerEvent.TIMER, delayTimerHandler);
					delayTimer.start();
				}
				else
					onGet(Vector.<ResItem>(resItems.slice(index, index+1)).pop().res);
			}
		}
		
		private function findRes(url:String):int
		{
			var index:int = -1;
			resItems.some(function(item:ResItem, _index:int, vector:Vector.<ResItem>):Boolean{
				if(searchRes(item, _index, url))				
				{	
					index = _index;
					return true;
				}
				else
					return false;
			}, null);
			return index;
			
			function searchRes(item:ResItem, index:int, url:String):Boolean
			{
				if(item.url == url)
					return true;
				else
					return false;
			}
		}
		
		private function LoadRes(url:String, onGet:Function, onProcess:Function):void
		{
			var tempResItem:ResItem = new ResItem();
			tempResItem.url = url;
			resItems.push(tempResItem);
			var loader:Loader = new Loader();
			if(onGet!=null)loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void{onGet(e.target.content); pushResItem(e.target.content);});
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onErr);
			if(onProcess!=null)loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, function(e:ProgressEvent):void{onProcess(e.bytesLoaded/e.bytesTotal)});
			loader.load(new URLRequest(url), new LoaderContext(false, ApplicationDomain.currentDomain));
			function pushResItem(obj:Object):void
			{
				tempResItem.res = obj;
			}
			function onErr(e:IOErrorEvent):void
			{
				trace("[GetResHandler]:"+e.type);
			}
		}
		
	}
}