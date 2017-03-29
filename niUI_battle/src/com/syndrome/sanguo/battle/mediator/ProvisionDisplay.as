package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Scence2DCantainer;
	import com.syndrome.sanguo.battle.common.UserInfo;
	
	import manger.HistroyMessageManager;
	
	import net.IProtocolhandler;
	
	/**
	 * 粮草展示
	 */
	public class ProvisionDisplay implements IProtocolhandler
	{
		public function ProvisionDisplay()
		{
		}
		
		public function handle(message:Object):void
		{
			var provision:int = message["provision"];
			var provisionLimit:int = message["provisionLimit"];
			var playerName:String = message["playerName"];
			Scence2DCantainer.getInstance().changeHpNum(provision , provisionLimit , UserInfo.myUserName == playerName);
			
			/**
				PLAYER的粮草变为PROVISION
			 */
			HistroyMessageManager.displayChatMsg(3,
				{	"PLAYER":playerName,
					"PROVISION":provision
				});
		}
	}
}