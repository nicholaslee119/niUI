package com.syndrome.sanguo.battle.combat_ui
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.skin.SystemButtonGroupSkin;
	
	import components.MessageWindow;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import manger.SoundManager;
	
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.SkinnableComponent;
	
	public class SystemButtonGroup extends SkinnableComponent
	{
		public var exitButton:Button;
		public var soundButton:Button;
		public var configButton:Button;
		public var baikeButton:Button;
		
		public function SystemButtonGroup()
		{
			super();
			this.skinName = SystemButtonGroupSkin;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName , instance);
			if(exitButton == instance){
				exitButton.addEventListener(MouseEvent.CLICK , exitClick);
			}else if(soundButton == instance){
				if(SoundManager.bgmVolumn >0){
					soundButton.label = "关闭音乐";
				}else{
					soundButton.label = "开启音乐";
				}
				soundButton.addEventListener(MouseEvent.CLICK , soundClick);
			}else if(configButton == instance){
				configButton.addEventListener(MouseEvent.CLICK , configClick);
			}else if(baikeButton == instance){
				baikeButton.addEventListener(MouseEvent.CLICK , baikeClick);
			}
		}
		
		protected function baikeClick(event:MouseEvent):void
		{
			MessageWindow.show("暂未开放，敬请期待！" , "提示" ,  null , true , false);
		}
		
		protected function configClick(event:MouseEvent):void
		{
			MessageWindow.show("暂未开放，敬请期待！" , "提示" ,  null , true , false);
		}
		
		protected function soundClick(event:MouseEvent):void
		{
			if(SoundManager.bgmVolumn > 0){
				SoundManager.bgmVolumn = 0;
				soundButton.label = "开启音乐";
			}else{
				SoundManager.bgmVolumn = 0.5;
				soundButton.label = "关闭音乐";
			}
		}
		
		protected function exitClick(event:MouseEvent):void
		{
			MessageWindow.show("确定退出游戏？" , "提示" , clickHandler);
		}		
		
		private function clickHandler(detail:String):void
		{
			if(detail == MessageWindow.COMFIRM){
				CombatConsole.getInstance().dispatchEvent(new Event(CombatConsole.LEAVE));
			}
		}
	}
}