package com.syndrome.sanguocard.mainfram.main
{
	public class MainHandlerBase
	{
		protected var main:Main
		
		public function MainHandlerBase(_main:Main)
		{
			main = _main;
			init();
		}
		
		protected function init():void{}
		
	}
}