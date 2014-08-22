package {
	
	import com.communication.AppEvent;
	import com.load.resmanager.ResManager;
	import com.load.xmlmanager.XMLManager;
	import com.syndrome.client.parameters.ParametersXMLLoader;
	import com.syndrome.client.parameters.PublicParameters;
	import com.syndrome.sanguocard.mainfram.main.Main;
	import com.syndrome.sanguocard.mainfram.ui.AlertPanel;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	
	[SWF(backgroundColor="0x000000")]
	public class gameFram extends Sprite
	{
		private var main:Main =null;
		private var parametersXMLLoader:ParametersXMLLoader;
		public var backPanel:Sprite = new Sprite();
		public var sonProjectPanel:Sprite = new Sprite();
		public var floatPanel:Sprite=new Sprite();
		public var loadingPanel:Sprite = new Sprite();
		
		public function gameFram()
		{
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandle);
		}
		
		private function addToStageHandle(event:Event):void
		{
			if(stage.loaderInfo.parameters.debug)
				PublicParameters.RUNTIME_ENVIRONMENT = "localDebug";
			else
				PublicParameters.RUNTIME_ENVIRONMENT = "release";
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandle);
			var THIS:gameFram = this;
			XMLManager.init(function():void{
				main = new Main(THIS);
				opaqueBackground = 0x000000;
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
				stage.quality = StageQuality.HIGH;
				stage.stageFocusRect = false;
				stage.addEventListener(Event.RESIZE, resizeDisplay);
				addChild(backPanel);
				addChild(sonProjectPanel);
				addChild(loadingPanel);
				addChild(floatPanel);
				loadingPanel.mouseEnabled = false;
				floatPanel.mouseEnabled = false;
				reflash(0,0);
				AlertPanel.creatInstance().addToPanel(floatPanel);
			});
		}
		
		private function resizeDisplay(event:Event):void
		{
			reflash(stage.stageWidth,stage.stageHeight);
			main.esRoomManager.mainResizeDisplay();
		}
		
		public function reflash(stageW:int,stageH:int):void
		{
			floatPanel.x = (stage.stageWidth-floatPanel.width)/2;
			backPanel.x = (stage.stageWidth-backPanel.width)/2;
			loadingPanel.x = (stage.stageWidth-1280)/2;
			if(stageW==0)stageW = stage.stageWidth;
			if(stageH==0)stageH = stage.stageHeight;
		}
	}
}
