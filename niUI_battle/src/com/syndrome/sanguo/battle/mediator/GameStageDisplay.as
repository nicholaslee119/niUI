package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.EffectGroup;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Scence2DCantainer;
	import com.syndrome.sanguo.battle.common.UserInfo;
	
	import manger.HistroyMessageManager;
	
	import net.IProtocolhandler;
	
	/**
	 * 回合阶段展示
	 */
	public class GameStageDisplay implements IProtocolhandler
	{
		public function GameStageDisplay()
		{
		}
		
		public function handle(message:Object):void
		{
			
			var gameState:int = message["gameState"];
			var roundIndex:int = message["roundIndex"];//第几回合
			var playerName:String = message["playerName"];
			var isMyturn:Boolean;
			if(UserInfo.myUserName == playerName)//自己回合
			{
				isMyturn=true;
			}else{
				isMyturn=false;
			}
			CombatConsole.getInstance().addActionList([1000,[EffectGroup.getInstance().playProcessesEffect,gameState]]);
			CombatConsole.getInstance().addActionList([50,[Scence2DCantainer.getInstance().setState,gameState , isMyturn , roundIndex+1]]);;
			
			HistroyMessageManager.displayChatMsg(gameState+16,
				{	"PLAYER":playerName
				});
			trace("Time Swtich");
		}
	}
}