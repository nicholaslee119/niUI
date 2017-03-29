package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.command.SelectCardFromSlot;
	import com.syndrome.sanguo.battle.command.SelectCardFromWindow;
	import com.syndrome.sanguo.battle.common.ConfigInfo;
	import com.syndrome.sanguo.battle.event.SelectEvent;
	
	import flash.events.Event;
	
	import net.ESB;
	import net.IProtocolhandler;
	import net.parameter.MessageParameters;

	/**
	 * 从列表或者卡槽中选择卡片
	 */
	public class ChooseCardFromListRequest implements IProtocolhandler
	{
		public function ChooseCardFromListRequest()
		{
		}
		
		public function handle(message:Object):void
		{
			var cardAddress:Array =message["cardAddress"];
			var maxAmount:int =message["maxAmount"];
			var minAmount:int =message["minAmount"];
			var cancel:Boolean =message["cancel"]; //0,1 可以取消（cancel=1）时，取消按钮高亮
			var cardID:Array =message["cardID"];//卡片ID
			var isShowInSlot:Boolean =message["showInSlot"];// 是否在槽中选择卡
			var event:int =message["event"];//对应的文字显示
			var timeout:int=message["timeOut"];//超时时间
			var playerName:String =message["playerName"];
			
			var eventStr:String = ConfigInfo.getEventMsg(event);
			
			if(isShowInSlot)
			{
				var selectCardFromSlot:SelectCardFromSlot = new SelectCardFromSlot();
				selectCardFromSlot.show(cardAddress , minAmount , maxAmount , cancel , eventStr);
			}
			else
			{
				var selectCardFromWindow:SelectCardFromWindow = new SelectCardFromWindow();
				selectCardFromWindow.show(cardAddress,cardID,minAmount,maxAmount,cancel,eventStr);
			}
			CombatConsole.getInstance().addEventListener(CombatConsole.CANCEL , onCancel);
			CombatConsole.getInstance().addEventListener(SelectEvent.SELECT , onSelect);
			
			CombatConsole.getInstance().currentRequest = this;
		}
		
		protected function onSelect(event:SelectEvent):void
		{
			var obj:Object = {};
			obj["id"] = MessageParameters.CHOOSE_CARD_FROM_LIST_RESPOND;
			obj["chosenCardAddress"] = event.data;
			obj["cancel"] = false;
			ESB.sendBattleMsg(obj);
			destroy();
		}
		
		protected function onCancel(event:Event):void
		{
			var obj:Object = {};
			obj["id"] = MessageParameters.CHOOSE_CARD_FROM_LIST_RESPOND;
			obj["cancel"] = true;
			ESB.sendBattleMsg(obj);
			destroy();
		}
		
		public function destroy():void
		{
			CombatConsole.getInstance().removeEventListener(CombatConsole.CANCEL , onCancel);
			CombatConsole.getInstance().removeEventListener(SelectEvent.SELECT , onSelect);
		}
	}
}