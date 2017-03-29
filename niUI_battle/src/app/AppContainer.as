package app
{
	import app.config.AppConfig;
	
	import com.syndrome.sanguo.battle.combat_ui.CombatGroup;
	import com.syndrome.sanguo.room.RoomGroup;
	
	import org.flexlite.domCore.Injector;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.core.ISkinAdapter;
	import org.flexlite.domUI.core.Theme;
	import org.flexlite.domUI.managers.SystemManager;
	import org.flexlite.domUtils.Debugger;
	
	public class AppContainer extends SystemManager
	{
		
		/**
		 * 主容器
		 */
		protected var mainGroup:Group;
		
		public var combatGroup:CombatGroup;
		public var roomGroup:RoomGroup;
		
		public var loadingGroup:Group;
		
		/**
		 * 当前模块
		 */
		public var customCurrentState:String;
		
		/**
		 *	模块对应实例窗口
		 */
		protected var stateWindowInfo:Object;
		
		public function AppContainer()
		{
			super();
			Injector.mapClass(ISkinAdapter, SkinAdapter);
			Injector.mapClass(Theme, AppTheme);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			if(AppConfig.showConsole){
				Debugger.initialize(stage);		//显示列表调试工具(可选)。
			}
			mainGroup = new Group();
			mainGroup.horizontalCenter = 0;
			this.addElement(mainGroup);
		}
		
		override protected function childrenCreated():void
		{
			combatGroup = new CombatGroup();
			roomGroup = new RoomGroup();
			loadingGroup = new Group();
			stateWindowInfo = {"room":roomGroup , "combatGroup":combatGroup , "loadingGroup":loadingGroup };
		}
		
		/**
		 * 改变游戏模块
		 */
		public function changeCurrentState(state:String) : void
		{
			if (state == this.customCurrentState)
			{
				return;
			}
			if (this.stateWindowInfo[this.customCurrentState] && this.stateWindowInfo[this.customCurrentState].parent == this.mainGroup)
			{
				(this.stateWindowInfo[this.customCurrentState] as IApp).destroy();
				this.mainGroup.removeElement(this.stateWindowInfo[this.customCurrentState]);
			}
			if (this.stateWindowInfo[state])
			{
				this.mainGroup.addElement(this.stateWindowInfo[state]);
				(this.stateWindowInfo[state] as IApp).enter();
			}
			this.customCurrentState = state;
		}
		
		public function enterRoom() : void
		{
			this.changeCurrentState("room");
		}
		
		/**
		 * 进入对战模块
		 */
		public function enterCombatStage() : void
		{
			this.changeCurrentState("combatGroup");
		}
		
	}
}