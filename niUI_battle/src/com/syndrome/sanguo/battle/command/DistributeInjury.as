package com.syndrome.sanguo.battle.command
{
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.PopUpGroup;
	import com.syndrome.sanguo.battle.combat_ui.window.DistributeInjuryWindow;

	public class DistributeInjury extends CommandBase
	{
		private var window:DistributeInjuryWindow; 
		public function DistributeInjury()
		{
			super();
		}
		
		/**
		 * 显示伤害分配界面
		 */
		public function show(attackCardArr:Array,defenseCardArr:Array):void
		{
			window = new DistributeInjuryWindow();
			window.attackCardArr = attackCardArr;
			window.defenseCardArr = defenseCardArr;
			PopUpGroup.getInstance().addPopUp(window);
		}
		
		override protected function destroy():void
		{
			super.destroy();
			PopUpGroup.getInstance().addPopUp(window);
		}
	}
}