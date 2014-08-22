package com.syndrome.sanguo.battle.mediator
{
	import manger.HistroyMessageManager;
	
	import net.IProtocolhandler;

	/**
	 * 战场记录展示
	 */
	public class MessageDisplay implements IProtocolhandler
	{
		public function MessageDisplay()
		{
		}
		
		public function handle(message:Object):void
		{
			var formatId:int =message["formatId"];
			var parameters:Array =message["parameters"];
			var param:Object = {};
			for each(var item:Object in parameters)
			{
				var arr:Array =item as Array;
				
				if(arr[0]!=null && arr.length ==2)
				{
					param[arr[0]] = arr[1];
				}
			}
			HistroyMessageManager.displayChatMsg(formatId,param);
		}
	}
}