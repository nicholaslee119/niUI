package com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.CombatGroup;
	import com.syndrome.sanguo.battle.skin.button.SkipButtonGroupSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import manger.SoundManager;
	
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.SkinnableComponent;
	import org.flexlite.domUI.components.UIMovieClip;
	
	public class SkipButtonGroup extends SkinnableComponent
	{
		public var skipButton:Button;
		public var skipMC:UIMovieClip;
		public function SkipButtonGroup()
		{
			super();
			this.skinName = SkipButtonGroupSkin;
			this.mouseEnabled = false;
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			if(instance == skipButton){
				skipButton.addEventListener(MouseEvent.MOUSE_OVER , skipOver);
				skipButton.addEventListener(MouseEvent.MOUSE_OUT , skipOut);
				skipButton.addEventListener(MouseEvent.CLICK , skipClick);
			}else if(instance == skipMC){
				skipMC.stop();
			}
		}
		
		protected function skipOut(event:MouseEvent):void
		{
			skipMC.visible = true;
		}
		
		protected function skipOver(event:MouseEvent):void
		{
			skipMC.visible = false;
		}
		
		/**
		 * 显示跳过按钮
		 * @param enabled 是否可用
		 * 
		 */
		public function showSkip(enabled:Boolean):void
		{
			this.enabled = enabled;
			if(enabled){
				skipMC.play();
			}else{
				skipMC.stop();
			}
			CombatGroup.getInstance().systemButtonGroup.exitButton.enabled = this.enabled;
		}
		
		private function skipClick(event:MouseEvent):void
		{
			SoundManager.play("MP3_Button");
			CombatConsole.getInstance().dispatchEvent(new Event(CombatConsole.SKIP));
		}
	}
}