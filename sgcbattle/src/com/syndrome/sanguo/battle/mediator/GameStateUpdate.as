package com.syndrome.sanguo.battle.mediator
{
	import app.AppContainer;
	
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.event.MessageEvent;
	
	import flash.events.Event;
	
	import net.ESB;
	import net.IProtocolhandler;
	
	import org.flexlite.domUI.core.DomGlobals;
	
	/**
	 * 更新游戏状态
	 */
	public class GameStateUpdate implements IProtocolhandler
	{
		public function GameStateUpdate()
		{
		}
		
		public function handle(message:Object):void
		{
			switch(message["type"])
			{
				case "onInit":
				{
					ESB.init(ESB.interfaceOfSon);
					(DomGlobals.systemManager as AppContainer).enterCombatStage();
					CombatConsole.getInstance().addEventListener(CombatConsole.LEAVE , onLeave);
					CombatConsole.getInstance().addEventListener(MessageEvent.SEND , onSendMessage);
					break;
				}
				case "onLeave":
				{
					ESB.destroy();
					CombatConsole.getInstance().removeEventListener(CombatConsole.LEAVE , onLeave);
					CombatConsole.getInstance().removeEventListener(MessageEvent.SEND , onSendMessage);
					(DomGlobals.systemManager as AppContainer).enterRoom();
					if(ESB.interfaceOfSon){
						ESB.interfaceOfSon.returnToReady();
					}
					break;
				}
				default:
				{
					break;
				}
			}
		}
		
		protected function onSendMessage(event:MessageEvent):void
		{
			ESB.sendChannelMsg(event.message , event.channel);
		}
		
		protected function onLeave(event:Event):void
		{
			if(ESB.interfaceOfSon){
				ESB.interfaceOfSon.leaveGame();
			}
		}
	}
}