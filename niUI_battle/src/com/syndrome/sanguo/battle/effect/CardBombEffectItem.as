package com.syndrome.sanguo.battle.effect
{
	/**
	 * 爆炸碎片
	 */
	public class CardBombEffectItem extends Object
	{
		private var initSpeedArg:Number;
		public var xSpeedArg:Number = 0;
		public var ySpeedArg:Number = 0;
		public var x:Number;
		public var y:Number;
		public var vx:Number;
		public var vy:Number;
		public var originalX:Number;
		public var originalY:Number;
		private var needMove:Boolean = true;
		
		public function CardBombEffectItem(param1:Number, param2:Number, param3:Number)
		{
			this.originalX = param1;
			this.originalY = param2;
			this.initSpeedArg = param3;
			this.restore();
		}
		
		public function restore() : void
		{
			this.needMove = true;
			this.x = this.originalX;
			this.y = this.originalY;
			this.initSpeed();
		}
		
		private function initSpeed() : void
		{
			this.vx = (Math.random() * 2 - 1) * this.initSpeedArg;
			this.vy = (Math.random() * 2 - 1) * this.initSpeedArg;
		}
		
		public function update() : void
		{
			if (this.needMove)
			{
				this.x = this.x + this.vx;
				this.y = this.y + this.vy;
				this.vx = this.vx + this.xSpeedArg;
				this.vy = this.vy + this.ySpeedArg;
				if (Math.abs(this.x - this.originalX) < Math.abs(this.vx))
				{
					this.needMove = false;
					this.x = this.originalX;
					this.y = this.originalY;
				}
			}
		}
	}
}