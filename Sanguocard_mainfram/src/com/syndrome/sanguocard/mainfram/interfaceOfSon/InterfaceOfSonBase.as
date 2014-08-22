package com.syndrome.sanguocard.mainfram.interfaceOfSon
{
	import com.syndrome.sanguocard.selfnamespace.ThisIsInterface;
	
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;

	public class InterfaceOfSonBase extends EventDispatcher
	{
		protected var _sonProject:*;	
		protected var _esRoom:*;
		
		public function InterfaceOfSonBase(esRoom:*)
		{
			this.esRoom = esRoom;
		}
		
		ThisIsInterface function onSize():void
		{
			sonProject.onSize();
		}
		
		ThisIsInterface function reBindingChat():void
		{
			if(sonProject==null)return;
			sonProject.reBindingChat();
		}
		
		public function alertFromSonProject(message:String):void
		{
			esRoom.alertFromSonProject(message);
		}
		
		public function onEnterFrame(now:Number):void
		{
			esRoom.onEnterFrame(now);
		}

		public function addToFloat(_ui:*):void
		{
			esRoom.addToFloat(_ui);
		}
		
		public function removeFromFloat(_ui:*):void
		{
			esRoom.removeFromFloat(_ui);
		}
		
		public function costGold(gold:int):void
		{
			esRoom.costGold(gold);
		}
		
		public function costGoldIndeed(gold:int):void
		{
			esRoom.costGoldIndeed(gold);
		}
		
		public function get sonProject():*
		{
			if(_sonProject==null || _sonProject==undefined) 
				trace("未获得子工程引用");
			return _sonProject;
		}

		public function set sonProject(value:*):void
		{
			_sonProject = value;
		}

		public function get esRoom():*
		{
			if(_esRoom==null) trace("esRoom为空");
			return _esRoom;
		}

		public function set esRoom(value:*):void
		{
			_esRoom = value;
		}
		
	}
}