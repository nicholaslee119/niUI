package com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.CombatStage;
	import com.syndrome.sanguo.battle.event.OperationEvent;
	import com.syndrome.sanguo.battle.skin.OperationButtonGroupSkin;
	import com.syndrome.sanguo.battle.skin.button.BFBQButtonSkin;
	import com.syndrome.sanguo.battle.skin.button.FJButtonSkin;
	import com.syndrome.sanguo.battle.skin.button.FMButtonSkin;
	import com.syndrome.sanguo.battle.skin.button.QJButtonSkin;
	import com.syndrome.sanguo.battle.skin.button.QZButtonSkin;
	import com.syndrome.sanguo.battle.skin.button.ZBButtonSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import manger.SoundManager;
	
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.SkinnableComponent;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	
	/**
	 * 操作按钮组
	 */
	public class OperationButtonGroup extends SkinnableComponent
	{
		public var bfbqButton:Button;
		public var qjButton:Button;
		public var fjButton:Button;
		public var fmButton:Button;
		public var qzButton:Button;
		public var zbButton:Button;
		public function OperationButtonGroup()
		{
			super();
			this.skinName = OperationButtonGroupSkin;
			this.mouseEnabled = false;
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			if(instance == bfbqButton){
				bfbqButton.addEventListener(MouseEvent.CLICK , operationClick);
			}else if(instance == qjButton){
				qjButton.addEventListener(MouseEvent.CLICK , operationClick);
			}else if(instance == fjButton){
				fjButton.addEventListener(MouseEvent.CLICK , operationClick);
			}else if(instance == fmButton){
				fmButton.addEventListener(MouseEvent.CLICK , operationClick);
			}else if(instance == qzButton){
				qzButton.addEventListener(MouseEvent.CLICK , operationClick);
			}else if(instance == zbButton){
				zbButton.addEventListener(MouseEvent.CLICK , operationClick);
			}
		}
		
		/**
		 *显示可选动作   
		 * @param enabledArray  0：摆放兵权		1：征兵		2：取镇		3：伏将		4：伏谋		5：遣将
		 * 
		 */
		public function showOperations(enabledArray:Array):void
		{
			bfbqButton.enabled = false;
			qjButton.enabled = false;
			fjButton.enabled = false;
			fmButton.enabled = false;
			qzButton.enabled = false;
			zbButton.enabled = false;
			if(enabledArray == null || enabledArray.length ==0){
				return;
			}
			if(enabledArray.indexOf("0")>=0){
				bfbqButton.enabled = true;
			}
			if(enabledArray.indexOf("1")>=0){
				zbButton.enabled = true;
			}
			if(enabledArray.indexOf("2")>=0){
				qzButton.enabled = true;
			}
			if(enabledArray.indexOf("3")>=0){
				fjButton.enabled = true;
			}
			if(enabledArray.indexOf("4")>=0){
				fmButton.enabled = true;
			}
			if(enabledArray.indexOf("5")>=0){
				qjButton.enabled = true;
			}
		}
		
		private function operationClick(e:MouseEvent):void
		{
			SoundManager.play("MP3_Button");
			if(e.currentTarget == bfbqButton){
				CombatConsole.getInstance().dispatchEvent(new OperationEvent(OperationEvent.OPERATION,0));
			}else if(e.currentTarget == qjButton){
				CombatConsole.getInstance().dispatchEvent(new OperationEvent(OperationEvent.OPERATION,5));
			}else if(e.currentTarget == fjButton){
				CombatConsole.getInstance().dispatchEvent(new OperationEvent(OperationEvent.OPERATION,3));
			}else if(e.currentTarget == fmButton){
				CombatConsole.getInstance().dispatchEvent(new OperationEvent(OperationEvent.OPERATION,4));
			}else if(e.currentTarget == qzButton){
				CombatConsole.getInstance().dispatchEvent(new OperationEvent(OperationEvent.OPERATION,2));
			}else if(e.currentTarget == zbButton){
				CombatConsole.getInstance().dispatchEvent(new OperationEvent(OperationEvent.OPERATION,1));
			}
		}
	}
}