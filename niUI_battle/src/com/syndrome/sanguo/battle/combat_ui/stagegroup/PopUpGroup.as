package com.syndrome.sanguo.battle.combat_ui.stagegroup
{
	import com.syndrome.sanguo.battle.combat_ui.CombatStage;
	import com.syndrome.sanguo.battle.property.BattleFieldConst;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.core.IVisualElement;
	import org.flexlite.domUI.core.UIComponent;
	
	/**
	 * 游戏自定义弹出层
	 */
	public class PopUpGroup extends Group
	{
		public function PopUpGroup()
		{
			super();
			this.width = BattleFieldConst.gameCanvas_width;
			this.height = BattleFieldConst.stage_height;
			this.clipAndEnableScrolling = true;
		}
		
		public function addPopUp(popUp:UIComponent,center:Boolean = true):void
		{
			popUp.isPopUp = true;
			if(center){
				popUp.verticalCenter = 0;
				popUp.horizontalCenter = 0;
			}
			this.addElement(popUp);
		}
		
		public function removePopUp(popUp:UIComponent):void
		{
			if(popUp.parent == this){
				this.removeElement(popUp);
			}
		}
		
		public static function getInstance():PopUpGroup
		{
			return CombatStage.getInstance().popUpGroup;
		}
	}
}