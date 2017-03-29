package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.EffectGroup;
	import com.syndrome.sanguo.battle.common.UserInfo;
	
	import manger.HistroyMessageManager;
	
	import net.IProtocolhandler;
	
	/**
	 * 先手玩家展示
	 */
	public class FirstActionPlayerDisplay implements IProtocolhandler
	{
		public function FirstActionPlayerDisplay()
		{
		}
		
		public function handle(message:Object):void
		{
			var playerName:String = message["playerName"];
			CombatConsole.getInstance().addActionList([250,[EffectGroup.getInstance().playAttackOrderEffect , UserInfo.myUserName == playerName]]);
			
			/**
			游戏开始，PLAYER为先手玩家
			 */
			HistroyMessageManager.displayChatMsg(1,
				{	"PLAYER":playerName
				});
		}
	}
}