package com.syndrome.sanguo.battle.mediator
{
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.TipGroup;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Scence2DCantainer;
	import com.syndrome.sanguo.battle.command.CommandBase;
	import com.syndrome.sanguo.battle.command.TimeControl;
	import com.syndrome.sanguo.battle.common.UserInfo;
	
	import net.ESB;
	import net.IProtocolhandler;
	import net.parameter.MessageParameters;

	/**
	 * 计时器显示
	 */
	public class CountDownDisplay implements IProtocolhandler
	{
		public function CountDownDisplay()
		{
		}
		
		public function handle(message:Object):void
		{
			var stime:int = message["timeOut"];
			var playerName:String= message["playerName"];
			if(UserInfo.myUserName == playerName){
				TimeControl.start(true , stime , stime , timeOut);
			}else{
				TimeControl.start(false , stime , stime);
			}
		}
		
		protected function timeOut():void
		{
			CommandBase.cleanAllCommands();
			Scence2DCantainer.getInstance().disabledAllButton();
			TipGroup.cleanText();
			
			var obj:Object = {};
			obj["id"] = MessageParameters.TIME_OUT_RESPOND;
			ESB.sendBattleMsg(obj);
		}
	}
}