package com.syndrome.sanguo.record.config
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.CombatGroup;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.DebugWindow;
	import com.syndrome.sanguo.battle.common.UserInfo;
	import com.syndrome.sanguo.battle.mediator.UserUpdate;
	import com.syndrome.sanguo.record.RecordSystem;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import net.BattleMessageCenter;
	import net.IProtocolhandler;

	public class RecordAdapter implements IRecordAdapter
	{
		public function RecordAdapter()
		{
		}
		
		public function run(record:Object , recordSystem:RecordSystem):void
		{
			var message:Object = record["message"];
			DebugWindow.traceMsg(message);
			if(!message.hasOwnProperty("id")){
				return;
			}
			var id:int =message["id"];
			if(id == 1)   //玩家初始化
			{
				(new UserUpdate()).handle(message);
				recordSystem.doNext();
				return;
			}
			else if(UserInfo.enemyUserName == record["target"])   //对方玩家的消息
			{
				recordSystem.doNext();
				return;
			}
			else if(id>=20000 && id<30000)   //request
			{
				CombatConsole.getInstance().addActionList([500,[recordSystem.doNext]]);	
				return;
			}
			else if(id>=30000)   //response
			{
				recordSystem.doNext();
				return;
			}
			else if(id == 2)  //断线重连
			{
				CombatGroup.getInstance().destroy();
				CombatGroup.getInstance().enter();
				recordSystem.doNext();
				return;
			}
			
			var protocol:IProtocolhandler = BattleMessageCenter.getMessageClass(id);
			protocol.handle(message);
			var delayFun:Function = function(event:Event):void
			{
				event.stopImmediatePropagation();
				CombatConsole.getInstance().removeEventListener(CombatConsole.WAITING , delayFun);
				if(recordSystem.auto)
				{
					recordSystem.doNext();
				}
			}
			CombatConsole.getInstance().addEventListener(CombatConsole.WAITING , delayFun);
		}
	}
}