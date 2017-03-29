package com.syndrome.sanguo.record.components
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.record.RecordSystem;
	import com.syndrome.sanguo.record.components.skin.OperationPanelSkin;
	
	import flash.events.MouseEvent;
	
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.SkinnableComponent;
	
	public class OperationPanel extends SkinnableComponent
	{
		public var toggleButton:Button;
		public var nextButton:Button;
		
		public function OperationPanel()
		{
			super();
			this.skinName = OperationPanelSkin;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			changeLabel();
			toggleButton.addEventListener(MouseEvent.CLICK , toggleButtonClick);
			nextButton.addEventListener(MouseEvent.CLICK , nextButtonClick);
		}
		
		private function changeLabel():void
		{
			if(RecordSystem.getInstance().auto)
			{
				toggleButton.label = "暂停";
				nextButton.visible = false;
			}
			else
			{
				toggleButton.label = "播放";
				nextButton.visible = true;
			}
		}
		
		protected function toggleButtonClick(event:MouseEvent):void
		{
			var auto:Boolean = RecordSystem.getInstance().auto;
			RecordSystem.getInstance().auto = !auto;
			if(!auto)
				RecordSystem.getInstance().doNext();
			changeLabel();
		}
		
		protected function nextButtonClick(event:MouseEvent):void
		{
			if(CombatConsole.getInstance().actionLength == 0)
			{
				RecordSystem.getInstance().doNext();
			}
		}
	}
}