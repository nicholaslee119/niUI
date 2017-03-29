package
{
	import app.AppContainer;
	import app.config.AppConfig;
	
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.CombatGroup;
	import com.syndrome.sanguo.record.RecordSystem;
	import com.syndrome.sanguo.record.components.OperationPanel;
	import com.syndrome.sanguo.record.components.StartPage;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	import org.flexlite.domDll.Dll;
	import org.flexlite.domDll.core.ConfigItem;
	import org.flexlite.domDll.events.DllEvent;
	
	/**
	 * 录像模块入口
	 */
	public class Record extends Sprite
	{
		private var appContainer:AppContainer;
		
		public function Record()
		{
			if(stage){
				this.init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE , onAddToStage);
			}
		}
		
		private function onAddToStage(event:Event):void
		{
			if (event.target == this)
			{
				removeEventListener(Event.ADDED_TO_STAGE, this.onAddToStage);
				this.init();
			}
		}
		
		private var startPage:StartPage;
		private var hasStartLoad:Boolean = false;
		
		private function init() : void
		{
			AppConfig.initParameters(stage.loaderInfo.parameters);
			stage.stageFocusRect = false;
			stage.focus = this;
			if (!hasStartLoad)
			{
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
				stage.quality = StageQuality.HIGH;
				stage.tabChildren = false;
				
				//加入顶层容器
				appContainer = new AppContainer();
				this.addChild(appContainer);
				
				startPage = new StartPage();
				startPage.top = 100;
				startPage.horizontalCenter = 0;
				appContainer.addElement(startPage);
				startPage.addEventListener("start" , startClick);
				ExternalInterface.addCallback("startRecord",startPage.setPath);
				ExternalInterface.addCallback("leaveRecord",onLeave);
			}else
			{
				allComplete();
			}
		}
		
		protected function startClick(event:Event):void
		{
			startPage.visible = false;
			if(isLoadComplete)
			{
				allComplete();
				return;
			}
			Dll.eventDispather.addEventListener(DllEvent.GROUP_PROGRESS,onProgress);
			Dll.eventDispather.addEventListener(DllEvent.ITEM_LOAD_FINISHED, this.onItemFinished);
			Dll.eventDispather.addEventListener(DllEvent.GROUP_COMPLETE, this.onGroupComp);
			var item1:ConfigItem = new ConfigItem(AppConfig.defaultSourceFolder+"config/ini.xml","xml",AppConfig.defaultSourceFolder);
			var item2:ConfigItem = new ConfigItem(AppConfig.defaultSourceFolder+"config/recordini.xml","xml",AppConfig.defaultSourceFolder);
			var configList:Vector.<ConfigItem> = new <ConfigItem>[item2 , item1];
			Dll.loadConfig(configList, "1", "cn");
			Dll.loadGroup("loading",2);
			Dll.loadGroup("preload",1);
			Dll.loadGroup("uigroup",0);
			hasStartLoad = true;
		}
		
		/**
		 * 预加载组加载进度
		 */
		private function onProgress(event:DllEvent):void
		{
			if(event.groupName=="preload" || event.groupName=="uigroup")
			{
				loadingSprite["progress"] = int(event.bytesLoaded*100/event.bytesTotal);
			}
		}
		
		/**
		 * 一个资源加载项加载结束
		 */		
		private function onItemFinished(event:DllEvent):void
		{
			if(!event.dllItem.loaded)
				trace("资源加载失败::::",event.dllItem);
		}
		
		private var loadingSprite:DisplayObject;
		/**
		 * Loading组加载完成
		 */
		private function onGroupComp(event:DllEvent):void
		{
			if(event.groupName=="loading")
			{
				loadingSprite = (Dll.getRes("LoadingSprite") as Loader).content;
				stage.addChild(loadingSprite);
			}
			else if(event.groupName=="uigroup")
			{
				allComplete();
			}
		}
		
		private var isLoadComplete:Boolean = false;
		private function allComplete():void
		{
			if(!isLoadComplete)
			{
				stage.removeChild(loadingSprite);
				Dll.eventDispather.removeEventListener(DllEvent.GROUP_COMPLETE,onGroupComp);
				Dll.eventDispather.removeEventListener(DllEvent.GROUP_PROGRESS,onProgress);
				Dll.eventDispather.removeEventListener(DllEvent.ITEM_LOAD_FINISHED,onItemFinished);
				AppConfig.initConfig();
			}
			appContainer.enterCombatStage();
			if(!isLoadComplete)
			{
				//加入操作面板
				addOperationPanel();
			}
			CombatConsole.getInstance().addEventListener(CombatConsole.LEAVE , onLeave);
			RecordSystem.getInstance().recordStart("record");
			isLoadComplete = true;
		}
		
		private function addOperationPanel():void
		{
			var panel:OperationPanel = new OperationPanel();
			panel.includeInLayout = false;
			CombatGroup.getInstance().addElement(panel);
		}
		
		protected function onLeave(event:Event = null):void
		{
			CombatConsole.getInstance().removeEventListener(CombatConsole.LEAVE , onLeave);
			appContainer.enterRoom();
		}
	}
}