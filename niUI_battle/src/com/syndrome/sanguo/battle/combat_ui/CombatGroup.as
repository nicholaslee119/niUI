package com.syndrome.sanguo.battle.combat_ui
{
	import app.AppContainer;
	import app.IApp;
	import app.config.AppConfig;
	
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.chat.ChatGroup;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.DebugWindow;
	import com.syndrome.sanguo.battle.command.CommandBase;
	import com.syndrome.sanguo.battle.property.BattleFieldConst;
	
	import flash.external.ExternalInterface;
	
	import manger.SoundManager;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.core.DomGlobals;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	import org.flexlite.domUI.layouts.VerticalLayout;
	
	/**
	 * 战场
	 */
	public class CombatGroup extends Group implements IApp
	{
		public var cardInfoGroup:CardInfoGroup;
		public var chatGroup:ChatGroup;
		public var systemButtonGroup:SystemButtonGroup;
		public var combatStage:CombatStage;
		
		public var debugWindow:DebugWindow;
		
		public function CombatGroup()
		{
			super();
			var horizontalLayout:HorizontalLayout = new HorizontalLayout();
			horizontalLayout.gap = 0;
			this.layout = horizontalLayout;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			var leftGroup:Group = new Group();
			cardInfoGroup = new CardInfoGroup();
			chatGroup = new ChatGroup();
			systemButtonGroup = new SystemButtonGroup();
			systemButtonGroup.left = 9;
			var verticalLayout:VerticalLayout = new VerticalLayout();
			verticalLayout.gap = 0;
			leftGroup.layout = verticalLayout; 
			leftGroup.addElement(cardInfoGroup);
			leftGroup.addElement(chatGroup);
			leftGroup.addElement(systemButtonGroup);
			
			combatStage = new CombatStage();
			addElement(leftGroup);
			addElement(combatStage);
			
			if(AppConfig.showConsole){
				debugWindow = new DebugWindow();
				debugWindow.includeInLayout = false;
				debugWindow.x = BattleFieldConst.stage_width;
				addElement(debugWindow);
			}
		}
		
		public function enter():void
		{
			ExternalInterface.call("onStopMusic");
			SoundManager.playBattleBGM(true);
			
			CombatConsole.getInstance().start();
		}
		
		public function destroy():void
		{
			ExternalInterface.call("onStartMusic");
			CommandBase.cleanAllCommands();
			CombatConsole.getInstance().clearConsole();
			CardManager.getInstance().destroy();
			
			combatStage.cleanStage();
			chatGroup.reset();
			cardInfoGroup.reset();
			DebugWindow.clearConsole();
		}
		
		public static function getInstance():CombatGroup
		{
			return (DomGlobals.systemManager as AppContainer).combatGroup;
		}
	}
}