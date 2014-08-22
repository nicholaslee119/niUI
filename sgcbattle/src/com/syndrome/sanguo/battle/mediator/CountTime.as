package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Scence2DCantainer;
	import com.syndrome.sanguo.battle.common.UserInfo;
	
	import net.IProtocolhandler;

	/**
	 * 超时数量展示
	 */
	public class CountTime implements IProtocolhandler
	{
		public function CountTime()
		{
		}
		
		public function handle(message:Object):void
		{
			var countTimeout:int = message["countTimeout"];
			var playerName:String =message["playerName"];
			Scence2DCantainer.getInstance().setTimeOutCount(countTimeout , UserInfo.myUserName == playerName);
		}
	}
}