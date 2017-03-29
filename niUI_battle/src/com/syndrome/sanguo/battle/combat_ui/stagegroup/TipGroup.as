package com.syndrome.sanguo.battle.combat_ui.stagegroup
{
	import com.syndrome.sanguo.battle.combat_ui.CombatGroup;
	import com.syndrome.sanguo.battle.combat_ui.CombatStage;
	import com.syndrome.sanguo.battle.property.BattleFieldConst;
	
	import flash.filters.GlowFilter;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	
	/**
	 * 提示文本容器
	 */
	public class TipGroup extends Group
	{
		private var label:Label;
		
		private var currentText:String;
		
		public function TipGroup()
		{
			super();
			this.width = BattleFieldConst.gameCanvas_width;
			this.height = BattleFieldConst.stage_height;
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			label = new Label();
			label.top = 100;
			label.horizontalCenter = 0;
			label.text = currentText;
			label.size = 30;
			label.textColor = 0;
			label.filters = [new GlowFilter(0xffffff,1,6,6,10)];
			this.addElement(label);
		}
		
		/**
		 * 显示文本提示
		 */
		public static function showText(text:String):void
		{
			if(CombatStage.getInstance().tipGroup.label)
			{
				CombatStage.getInstance().tipGroup.label.text = text;
			}
			CombatStage.getInstance().tipGroup.currentText = text;
		}
		
		/**
		 * 清除文本提示
		 */
		public static function cleanText():void
		{
			if(CombatStage.getInstance().tipGroup.label)
			{
				CombatStage.getInstance().tipGroup.label.text = "";
			}
			CombatStage.getInstance().tipGroup.currentText = "";
		}
		
	}
}