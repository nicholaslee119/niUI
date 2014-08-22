package
{
	import app.AppContainer;
	import app.config.AppConfig;
	
	import com.communication.AppEvent;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import net.ESB;
	
	import org.flexlite.domDll.Dll;
	import org.flexlite.domDll.core.ConfigItem;
	import org.flexlite.domDll.events.DllEvent;
	
	/**
	 * 对战模块入口
	 */
	public class Battle extends Sprite
	{
		private var appContainer:AppContainer;
		
		public function Battle()
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
			addEventListener(AppEvent.ScenePrepare,onStart);
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
				var configList:Vector.<ConfigItem> = new <ConfigItem>[item1];
				Dll.loadConfig(configList, "1", "cn");
				Dll.loadGroup("preload",1);
				Dll.loadGroup("uigroup",0);
			}
			else
			{
				allComplete();
			}
		}
		
		private function onStart(e:AppEvent):void
		{
			removeEventListener(AppEvent.ScenePrepare,onStart);
			ESB.init(e.objHander);
		}
		
		/**
		 * 预加载组加载进度
		 */
		private function onProgress(event:DllEvent):void
		{
			if(event.groupName=="preload" && ESB.interfaceOfSon != null)
			{
				ESB.interfaceOfSon.onResProgress(event.bytesLoaded/event.bytesTotal);
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
		
		/**
		 * Loading组加载完成
		 */		
		private function onGroupComp(event:DllEvent):void
		{
			if(event.groupName=="uigroup")
			{
				allComplete();
			}
		}
		
		private function allComplete():void
		{
			Dll.eventDispather.removeEventListener(DllEvent.GROUP_COMPLETE,onGroupComp);
			Dll.eventDispather.removeEventListener(DllEvent.GROUP_PROGRESS,onProgress);
			Dll.eventDispather.removeEventListener(DllEvent.ITEM_LOAD_FINISHED,onItemFinished);
			AppConfig.initConfig();
			
			//加入顶层容器
			appContainer = new AppContainer();
			this.addChild(appContainer);
			appContainer.enterCombatStage();
			
			if(ESB.interfaceOfSon != null){
				ESB.interfaceOfSon.onResLoadComplete();
			}
			dispatchEvent(new AppEvent(AppEvent.ScenePrepareDone));
		}
	}
}