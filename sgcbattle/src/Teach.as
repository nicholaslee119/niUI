package
{
	import app.AppContainer;
	import app.config.AppConfig;
	
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.CombatGroup;
	import com.syndrome.sanguo.guide.GuideSystem;
	
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
	 * 教学模块入口
	 */
	public class Teach extends Sprite
	{
		private var appContainer:AppContainer;
		
		public function Teach()
		{
			if(stage){
				this.init(false);
			}else{
				addEventListener(Event.ADDED_TO_STAGE , onAddToStage);
			}
		}
		
		private function onAddToStage(event:Event):void
		{
			if (event.target == this)
			{
				removeEventListener(Event.ADDED_TO_STAGE, this.onAddToStage);
				this.init(false);
			}
		}
		
		private function init(hasStartLoad:Boolean) : void
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
				Dll.eventDispather.addEventListener(DllEvent.GROUP_PROGRESS,onProgress);
				Dll.eventDispather.addEventListener(DllEvent.ITEM_LOAD_FINISHED, this.onItemFinished);
				Dll.eventDispather.addEventListener(DllEvent.GROUP_COMPLETE, this.onGroupComp);
				var item1:ConfigItem = new ConfigItem(AppConfig.defaultSourceFolder+"config/ini.xml","xml",AppConfig.defaultSourceFolder);
				var item2:ConfigItem = new ConfigItem(AppConfig.defaultSourceFolder+"config/teachini.xml","xml",AppConfig.defaultSourceFolder);
				var configList:Vector.<ConfigItem> = new <ConfigItem>[item2 , item1];
				Dll.loadConfig(configList, "1", "cn");
				Dll.loadGroup("loading",2);
				Dll.loadGroup("preload",1);
				Dll.loadGroup("uigroup",0);
			}else
			{
				allComplete();
			}
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
		
		private function allComplete():void
		{
			stage.removeChild(loadingSprite);

			Dll.eventDispather.removeEventListener(DllEvent.GROUP_COMPLETE,onGroupComp);
			Dll.eventDispather.removeEventListener(DllEvent.GROUP_PROGRESS,onProgress);
			Dll.eventDispather.removeEventListener(DllEvent.ITEM_LOAD_FINISHED,onItemFinished);
			AppConfig.initConfig();
			
			//加入顶层容器
			appContainer = new AppContainer();
			this.addChild(appContainer);
			appContainer.enterCombatStage();
			
			CombatConsole.getInstance().addEventListener(CombatConsole.LEAVE , onLeave);
			
			if(AppConfig.debug)
				onChoiceTeach("debugTeach");
			else
				ExternalInterface.addCallback("ChoiceTeach", onChoiceTeach);
		}
		
		public function onChoiceTeach(which:String):void{
			var guideConfig:XML = Dll.getRes("command");
			var scripts:Object = {
				"teach":Dll.getRes(which)
			};
			GuideSystem.getInstance().init(guideConfig , scripts);
			GuideSystem.getInstance().guideStart("teach");
		}
		
		protected function onLeave(event:Event):void
		{
//			appContainer.enterRoom();
			CombatGroup.getInstance().destroy();
			ExternalInterface.call("hide_teach");
		}
	}
}