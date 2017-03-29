package com.syndrome.sanguo.guide.components
{
	import com.syndrome.sanguo.battle.skin.guide.GuideArrowSkin;
	
	import flash.events.Event;
	
	import org.flexlite.domUI.components.SkinnableComponent;
	import org.flexlite.domUI.effects.Move;
	import org.flexlite.domUI.effects.animation.Animation;
	import org.flexlite.domUI.effects.animation.RepeatBehavior;
	import org.flexlite.domUI.events.EffectEvent;
	
	import utils.Tween;
	
	public class GuideArrow extends SkinnableComponent
	{
		public function GuideArrow()
		{
			super();
			this.includeInLayout = false;
			this.skinName = GuideArrowSkin;
			this.addEventListener(Event.ADDED_TO_STAGE , startUp);
			this.addEventListener(Event.REMOVED_FROM_STAGE , onRemove);
		}
		
		protected function onRemove(event:Event):void
		{
			if(move && move.isPlaying)
				move.stop();
		}
		
		private  var move:Move = new Move();
		
		private function startUp(e:Event = null):void
		{
			if(e != null && e.type == Event.ADDED_TO_STAGE){
				this.removeEventListener(Event.ADDED_TO_STAGE,startUp);
			}
			move.target = this;
			move.repeatBehavior = RepeatBehavior.REVERSE;
			move.repeatCount = 0;
			move.duration = 500;
			
			if(direction == "right")
				move.xBy = -10;
			else if(direction == "left")
				move.xBy = 10;
			else if(direction == "up")
				move.yBy = 10;
			else
				move.yBy = -10;
			move.play();
		}
		
		private var _direction:String;
		/**
		 * 方向
		 */
		public function get direction():String
		{
			return _direction;
		}
		
		public function set direction(value:String):void
		{
			_direction = value;
			if(direction == "right")
				this.rotation = -90;
			else if(direction == "left")
				this.rotation = 90;
			else if(direction == "up")
				this.rotation = 180;
			else
				this.rotation = 0;
		}
	}
}