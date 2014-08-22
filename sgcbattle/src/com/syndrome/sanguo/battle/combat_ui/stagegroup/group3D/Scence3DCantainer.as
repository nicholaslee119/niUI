package com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D
{
	import com.syndrome.sanguo.battle.combat_ui.CombatStage;
	
	import flash.filters.GlowFilter;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.core.UIComponent;
	
	public class Scence3DCantainer extends Group
	{
		private var myMilitaryGroup:MilitaryButtonGroup;
		private var enemyMilitaryGroup:MilitaryButtonGroup;
		
		private var myGeneralLabel:Label;
		private var enemyGeneralLabel:Label;
		
		
		public function Scence3DCantainer()
		{
			super();
			this.mouseEnabled = false;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			var ui:UIComponent = new UIComponent();
			ui.visible = false;
			ui.rotationX = 1;
			this.addElement(ui);
			
			enemyMilitaryGroup = new MilitaryButtonGroup();
			enemyMilitaryGroup.isMe = false;
			enemyMilitaryGroup.x = 9;
			enemyMilitaryGroup.y = -383;
			this.addElement(enemyMilitaryGroup);
			
			myMilitaryGroup = new MilitaryButtonGroup();
			myMilitaryGroup.isMe = true;
			myMilitaryGroup.x = 9;
			myMilitaryGroup.y = -252;
			this.addElement(myMilitaryGroup);
			
			myGeneralLabel = new Label();
			myGeneralLabel.alpha = 0.7;
			myGeneralLabel.bold = true;
			myGeneralLabel.filters = [new GlowFilter(0xffffff,1,2,2,10)];
			myGeneralLabel.text = "0/3";
			myGeneralLabel.mouseChildren = myGeneralLabel.mouseEnabled = false;
			myGeneralLabel.x = 680;
			myGeneralLabel.y = -157;
			this.addElement(myGeneralLabel);
			
			enemyGeneralLabel = new Label();
			enemyGeneralLabel.alpha = 0.7;
			enemyGeneralLabel.bold = true;
			enemyGeneralLabel.filters = [new GlowFilter(0xffffff,1,2,2,10)];
			enemyGeneralLabel.text = "0/3";
			enemyGeneralLabel.mouseChildren = enemyGeneralLabel.mouseEnabled = false;
			enemyGeneralLabel.x = 680;
			enemyGeneralLabel.y = -290;
			this.addElement(enemyGeneralLabel);
		}
		
		/**
		 * 重置
		 */
		public function reset():void
		{
			myMilitaryGroup.reset();
			enemyMilitaryGroup.reset();
			myGeneralLabel.text = "0/3";
			enemyGeneralLabel.text = "0/3";
		}
		
		/**
		 *设置兵权数量 
		 * @param value 数量
		 * @param type 类型
		 * @param isMe 是否我方
		 */
		public function setMilitaryNum(value:int , type:int , isMe:Boolean):void
		{
			if(isMe){
				myMilitaryGroup.setMilitaryNum(value , type);
			}else{
				enemyMilitaryGroup.setMilitaryNum(value , type);
			}
		}
		
		/**
		 *设置武将数量 
		 * @param isMe 是否我方
		 * @param currentNum 当前数量 , -1表示不重新设置
		 * @param maxNum 最大数量， 默认-1表示不重新设置
		 */
		public function setGeneralNum(isMe:Boolean , currentNum:int , maxNum:int = -1):void
		{
			var label:Label;
			if(isMe){
				label = myGeneralLabel;
			}else{
				label = enemyGeneralLabel;
			}
			currentNum = (currentNum==-1)?label.text.split("/")[0]:currentNum;
			maxNum = (maxNum==-1)?label.text.split("/")[1]:maxNum;
			label.text = currentNum + "/" + maxNum;
		}
		
		public static function getInstance():Scence3DCantainer
		{
			return CombatStage.getInstance().scence3DCantainer;
		}
	}
}