package
{
	import com.load.xmlmanager.XMLManager;
	import com.syndrome.sanguocard.unpackage.Main;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	
	/*
	* @author nic
	* @build-time 2014-5-23
	* @comments
	*
	*/
	
	[SWF(backgroundColor="0x000000")]
	public class Sanguocard_unpackage extends Sprite
	{
		public var Panel:Sprite = new Sprite();
		private var main:Main = null;
		
		public function Sanguocard_unpackage()
		{
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandle);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.HIGH;
			stage.stageFocusRect = false;
		}
		
		private function addToStageHandle(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addToStageHandle);
			var THIS:Sanguocard_unpackage = this;
			XMLManager.init(function():void{
				THIS.addChild(Panel);
				main = new Main(THIS);
			});
		}
	}
}