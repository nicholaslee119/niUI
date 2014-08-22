package com.syndrome.sanguocard.unpackage.ui
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.syndrome.sanguocard.unpackage.Main;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	/*
	* @author nic
	* @build-time 2014-5-28
	* @comments
	*
	*/
	public class UIMainPanelBase extends EventDispatcher
	{
		public var ui:*;
		protected var instancePanel:MovieClip;
		protected var main:Main;
		protected var uiItemCards:Array = new Array(10);
		
		
		public function UIMainPanelBase(_main:Main)
		{
			main = _main;
		}
		
		protected function onEnd(e:Event):void{}
		
		public function displayResult():void{}
		
		protected function onAgain(e:MouseEvent):void{}
		
		protected function onConfirm(e:MouseEvent):void
		{
			ExternalInterface.call("onCloseUnpackage");
			ui.visible = false;
		}
	}
}