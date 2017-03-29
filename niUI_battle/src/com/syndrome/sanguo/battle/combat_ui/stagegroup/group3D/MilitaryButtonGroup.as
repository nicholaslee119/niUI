package com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D
{
	import com.syndrome.sanguo.battle.combat_ui.CombatStage;
	
	import flash.events.Event;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.layouts.VerticalLayout;
	
	/**
	 * 兵权按钮组
	 */
	public class MilitaryButtonGroup extends Group
	{
		public var msFlag:MilitaryFlagButton;
		public var qbFlag:MilitaryFlagButton;
		public var gbFlag:MilitaryFlagButton;
		public var bbFlag:MilitaryFlagButton;
		
		private var buttons:Array = [];
		
		public var isMe:Boolean;
		
		public function MilitaryButtonGroup()
		{
			super();
		}
		
		public function reset():void
		{
			for (var i:int = 0; i < buttons.length; i++) 
			{
				buttons[i].setMilitaryNum(0 , false);
			}
		}
		
		/**
		 *设置兵权数量 
		 * @param value 数量
		 * @param type 类型
		 * 
		 */
		public function setMilitaryNum(value:int , type:int , playEffect:Boolean=true):void
		{
			buttons[type].setMilitaryNum(value , playEffect);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			var verticalLayout:VerticalLayout = new VerticalLayout();
			verticalLayout.gap = 2;
			this.layout = verticalLayout;

			msFlag = new MilitaryFlagButton();
			msFlag.type = 0;
			qbFlag = new MilitaryFlagButton();
			qbFlag.type = 1;
			gbFlag = new MilitaryFlagButton();
			gbFlag.type = 2;
			bbFlag = new MilitaryFlagButton();
			bbFlag.type = 3;
			this.addElement(msFlag);
			this.addElement(qbFlag);
			this.addElement(gbFlag);
			this.addElement(bbFlag);
			buttons = [msFlag,qbFlag,gbFlag,bbFlag];
			for (var i:int = 0; i < buttons.length; i++) 
			{
				buttons[i].addEventListener("militaryClick" , buttonClick);
			}
		}
		
		protected function buttonClick(event:Event):void
		{
			CombatStage.getInstance().mouseClickMilitary(isMe , buttons.indexOf(event.currentTarget));
		}
	}
}