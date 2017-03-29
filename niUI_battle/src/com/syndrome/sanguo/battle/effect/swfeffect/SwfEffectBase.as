package com.syndrome.sanguo.battle.effect.swfeffect
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.core.IVisualElementContainer;
	import org.flexlite.domUI.core.UIComponent;
	
	public class SwfEffectBase extends UIAsset
	{
		protected var mc:MovieClip;
		protected var effectStartTime:Number;
		public static var SWF_EFFECT_END:String = "swf_effect_end";
		
		private var _swfFramePersecend:int = 24;
		private var _autoRemove:Boolean = true;
		
		public function SwfEffectBase(mc:MovieClip)
		{
			super();
			this.mc = mc;
		}
		
		public function startPlay() : void
		{
			this.skinName = mc;
			this.mc.gotoAndStop(1);
			this.effectStartTime = getTimer();
			
			this.mc.addFrameScript(this.mc.totalFrames-1 , enterLastFrame);
			this.mc.play();
			
//			addEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
		}
		
		protected function enterFrameHandler(event:Event) : void
		{
			var currentFrame:Number = Math.ceil((getTimer() - this.effectStartTime) / 1000 * this.swfFramePersecend);
			if (currentFrame < 1) 
			{
				return;
			}
			if (currentFrame >= this.mc.totalFrames)
			{
				this.mc.gotoAndStop(this.mc.totalFrames);
				this.enterLastFrame();
			}
			else if(currentFrame != this.mc.currentFrame)
			{
				this.mc.gotoAndStop(currentFrame);
			}
		}
		
		protected function enterLastFrame() : void
		{
			this.mc.stop();
			this.mc.addFrameScript(this.mc.totalFrames-1 , null);
			if(_autoRemove){
				this.removeSelf();
			}else{
				removeEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
			}
			dispatchEvent(new Event(SWF_EFFECT_END));
		}
		
		public function stop():void
		{
			enterLastFrame();
		}
		
		public function removeSelf() : void
		{
			removeEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
			if (parent)
			{
				this.skinName = null;
				(parent as IVisualElementContainer).removeElement(this);
			}
		}

		public function get swfFramePersecend():int
		{
			return _swfFramePersecend;
		}

		public function set swfFramePersecend(value:int):void
		{
			_swfFramePersecend = value;
		}

		public function get autoRemove():Boolean
		{
			return _autoRemove;
		}

		public function set autoRemove(value:Boolean):void
		{
			_autoRemove = value;
		}

		
	}
}