package com.syndrome.sanguo.battle.effect
{
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	import com.syndrome.sanguo.battle.effect.effectbase.CustomEffectBase;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import org.flexlite.domUI.core.IVisualElementContainer;
	import org.flexlite.domUI.core.UIComponent;
	
	/**
	 * 线条效果
	 */
	public class LineEffect extends CustomEffectBase
	{
		public var target:UIComponent;
		public var duration:Number;
		public var from:Point;
		public var sourceCard:GameCard;
		public var targetCard:GameCard;
		public var to:Point;
		
		public function LineEffect(target:UIComponent , sourceCard:GameCard , targetCard:GameCard , duration:Number = 500)
		{
			super();
			this.from = new Point(sourceCard.x , sourceCard.y);
			this.to = sourceCard.parent.globalToLocal(targetCard.localToGlobal(new Point(0,0)));
			this.sourceCard = sourceCard;
			this.targetCard = targetCard;
			this.duration = duration;
			this.target = target;
		}
		
		override public function play() : void
		{
			super.play();
		}
		
		override public function end() : void
		{
			super.end();
			if(target.parent)
			{
				(target.parent as IVisualElementContainer).removeElement(target);
			}
		}
		
		override public function stop():void
		{
			// TODO Auto Generated method stub
			super.stop();
			sourceCard.isChainSource(false);
			targetCard.isChainTarget(false);
		}
		
		private var tempPoint:Point = new Point();
		/**
		 * 获取新终点坐标 , a表示定比分点的比例
		 */
		private function setTempTo(a:Number , start:Point , end:Point):void
		{
			tempPoint.x = (end.x - start.x)*a + start.x;
			tempPoint.y = (end.y - start.y)*a + start.y;
		}
		
		override protected function enterFrameHandler(event:Event):void
		{
			var percent:Number = (getTimer() - effectStartTime) / this.duration;
			sourceCard.isChainSource(true);
			targetCard.isChainTarget(true);
			if (percent >= 1)
			{
				this.end();
			}
			else if(percent <= 0.5)
			{
				var a:Number = percent*2;
				setTempTo(a , from , to);
				target.graphics.clear();
				target.graphics.lineStyle(3,0x00ff00);
				target.graphics.moveTo(from.x , from.y);
				target.graphics.lineTo(tempPoint.x , tempPoint.y);
			}
			else if(percent >= 0.5)
			{
				a = percent*2 - 1;
				setTempTo(a , from , to);
				target.graphics.clear();
				target.graphics.lineStyle(3,0x00ff00);
				target.graphics.moveTo(tempPoint.x , tempPoint.y);
				target.graphics.lineTo(to.x , to.y);
			}
		}
	}
}