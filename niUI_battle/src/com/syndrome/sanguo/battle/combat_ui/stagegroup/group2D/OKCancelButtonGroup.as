package com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.skin.button.OKCancelButtonGroupSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import manger.SoundManager;
	
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.SkinnableComponent;
	
	public class OKCancelButtonGroup extends SkinnableComponent
	{
		public var okButton:Button;
		public var cancelButton:Button;
		
		public function OKCancelButtonGroup()
		{
			super();
			this.skinName = OKCancelButtonGroupSkin;
			this.mouseEnabled = false;
		}
		
		/**
		 *显示确认取消按钮 
		 * @param okEnable 确认按钮是否可用
		 * @param cancelEnable 取消按钮是否可用
		 */
		public function showOKCancel(okEnable:Boolean = false,cancelEnable:Boolean = false):void
		{
			if(!okEnable && !cancelEnable){
				this.enabled = false;
			}else{
				this.enabled = true;
				if(okEnable){
					okButton.enabled = true;
				}else{
					okButton.enabled = false;
				}
				if(cancelEnable){
					cancelButton.enabled = true;
				}else{
					cancelButton.enabled = false;
				}
			}
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			if(instance == okButton){
				okButton.addEventListener(MouseEvent.CLICK , okClick);
			}else if(instance == cancelButton){
				cancelButton.addEventListener(MouseEvent.CLICK , cancelClick);
			}
		}
		
		private function cancelClick(event:MouseEvent):void
		{
			SoundManager.play("MP3_Button");
			CombatConsole.getInstance().dispatchEvent(new Event(CombatConsole.CANCEL));
		}
		
		private function okClick(event:MouseEvent):void
		{
			SoundManager.play("MP3_Button");
			CombatConsole.getInstance().dispatchEvent(new Event(CombatConsole.CONFIRM));
		}
	}
}