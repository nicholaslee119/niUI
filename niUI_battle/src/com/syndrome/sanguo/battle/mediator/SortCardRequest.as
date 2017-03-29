package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.command.SortCardFromWindow;
	import com.syndrome.sanguo.battle.common.ConfigInfo;
	import com.syndrome.sanguo.battle.event.SelectEvent;
	
	import net.ESB;
	import net.IProtocolhandler;
	import net.parameter.MessageParameters;
	
	/**
	 * 卡牌排序
	 */
	public class SortCardRequest implements IProtocolhandler
	{
		public function SortCardRequest()
		{
		}
		
		public function handle(message:Object):void
		{
			var event:int = int(message["event"]);
			var eventStr:String = ConfigInfo.getEventMsg(event);
			
			var address:Array =message["cardAddress"];
			var cardIDs:Array =message["cardID"];
			
			var sortCardFromWindow:SortCardFromWindow = new SortCardFromWindow();
			sortCardFromWindow.show(address , cardIDs , eventStr);
			CombatConsole.getInstance().addEventListener(SelectEvent.SELECT , selectClick);
			
			CombatConsole.getInstance().currentRequest = this;
		}
		
		private function selectClick(event:SelectEvent):void
		{
			var obj:Object = {};
			obj["id"] = MessageParameters.SORT_CARD_RESPOND;
			obj["cardAddress"] = event.data;
			ESB.sendBattleMsg(obj);
			destroy();
		}
		
		public function destroy():void
		{
			CombatConsole.getInstance().removeEventListener(SelectEvent.SELECT , selectClick);
		}
	}
}