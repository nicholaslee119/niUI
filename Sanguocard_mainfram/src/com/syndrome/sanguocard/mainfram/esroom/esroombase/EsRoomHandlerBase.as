package com.syndrome.sanguocard.mainfram.esroom.esroombase
{
	public class EsRoomHandlerBase
	{
		protected var esRoomBase:EsRoomBase;
		
		public function EsRoomHandlerBase(_esRoomBase:EsRoomBase)
		{
			esRoomBase = _esRoomBase;
			init();
		}
		
		protected function init():void{}
	}
}