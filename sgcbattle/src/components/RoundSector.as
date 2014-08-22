package components
{
	import flash.display.Graphics;
	
	import org.flexlite.domUI.core.UIComponent;
	
	/**
	 * 环形扇形
	 */
	public class RoundSector extends UIComponent
	{
		public function RoundSector()
		{
			super();
		}
		
		private var _fillColor:uint = 0xFF0000;
		/**
		 * 填充颜色
		 */
		public function get fillColor():uint
		{
			return _fillColor;
		}
		public function set fillColor(value:uint):void
		{
			if(_fillColor==value)
				return;
			_fillColor = value;
			invalidateDisplayList();
		}
		
		private var _fillAlpha:Number = 1;
		/**
		 * 填充透明度,默认值为0。
		 */
		public function get fillAlpha():Number
		{
			return _fillAlpha;
		}
		public function set fillAlpha(value:Number):void
		{
			if(_fillAlpha==value)
				return;
			_fillAlpha = value;
			invalidateDisplayList();
		}
		
		private var _strokeColor:uint = 0x444444;
		/**
		 * 边框颜色,注意：当strokeAlpha为0时，不显示边框。
		 */
		public function get strokeColor():uint
		{
			return _strokeColor;
		}
		
		public function set strokeColor(value:uint):void
		{
			if(_strokeColor==value)
				return;
			_strokeColor = value;
			invalidateDisplayList();
		}
		
		private var _strokeAlpha:Number = 0;
		/**
		 * 边框透明度，默认值为0。
		 */
		public function get strokeAlpha():Number
		{
			return _strokeAlpha;
		}
		public function set strokeAlpha(value:Number):void
		{
			if(_strokeAlpha==value)
				return;
			_strokeAlpha = value;
			invalidateDisplayList();
		}
		
		private var _strokeWeight:Number = 1;
		/**
		 * 边框粗细(像素),注意：当strokeAlpha为0时，不显示边框。
		 */
		public function get strokeWeight():Number
		{
			return _strokeWeight;
		}
		public function set strokeWeight(value:Number):void
		{
			if(_strokeWeight==value)
				return;
			_strokeWeight = value;
			invalidateDisplayList();
		}
		
		private var _outerRadius:Number = 50;
		/**
		 * 外环半径
		 */
		public function get outerRadius():Number
		{
			return _outerRadius;
		}
		public function set outerRadius(value:Number):void
		{
			if(value<0)
				value=0;
			if(_outerRadius==value)
				return;
			_outerRadius = value;
			invalidateDisplayList();
		}

		private var _innerRadius:Number = 25;
		/**
		 * 内环半径
		 */
		public function get innerRadius():Number
		{
			return _innerRadius;
		}
		public function set innerRadius(value:Number):void
		{
			if(value<0)
				value=0;
			if(_innerRadius==value)
				return;
			_innerRadius = value;
			invalidateDisplayList();
		}
		
		private var _angle:Number = 90;
		/**
		 * 弧形角度
		 */
		public function get angle():Number
		{
			return _angle;
		}
		public function set angle(value:Number):void
		{
			if(value<0)
				value=0;
			if(_angle==value)
				return;
			_angle = value;
			invalidateDisplayList();
		}
		
		private var _startAngle:Number = -90;
		/**
		 * 开始的角度，顺时针方向，0表示右
		 */
		public function get startAngle():Number
		{
			return _startAngle;
		}
		public function set startAngle(value:Number):void
		{
			if(_startAngle==value)
				return;
			_startAngle = value;
			invalidateDisplayList();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledWidth);
			var g:Graphics = graphics;
			g.clear();
			g.lineStyle (strokeWeight, strokeColor ,strokeAlpha);
			g.beginFill(fillColor , fillAlpha);
			if (Math.abs(angle) > 360)
			{
				angle=360;
			}
			var n:Number = Math.ceil(Math.abs(angle) / 45);
			var angleA:Number=angle / n;
			angleA = angleA * Math.PI / 180;
			var startB:Number = startAngle * Math.PI / 180;
			var newStart:Number = startB
			//起始边
			g.moveTo(width/2 + innerRadius * Math.cos(startB), height/2 + innerRadius * Math.sin(startB));
			g.lineTo(width/2 + outerRadius * Math.cos(startB), height/2 + outerRadius * Math.sin(startB));
			//外圆弧
			for (var i:int=1; i <= n; i++)
			{
				newStart += angleA;
				var angleMid1:Number = newStart - angleA / 2;
				var bx:Number = width/2 + outerRadius / Math.cos(angleA / 2) * Math.cos(angleMid1);
				var by:Number = height/2 + outerRadius / Math.cos(angleA / 2) * Math.sin(angleMid1);
				var cx:Number = width/2 + outerRadius * Math.cos(newStart);
				var cy:Number = height/2 + outerRadius * Math.sin(newStart);
				g.curveTo(bx, by, cx, cy);
			}
			//内圆起点
			g.lineTo(width/2 + innerRadius * Math.cos(newStart),height/2 + innerRadius * Math.sin(newStart));
			//内圆弧
			for (var j:int = n; j >= 1; j--)
			{
				newStart-= angleA;
				var angleMid2:Number=newStart + angleA / 2;
				var bx2:Number=width/2 + innerRadius / Math.cos(angleA / 2) * Math.cos(angleMid2);
				var by2:Number=height/2 + innerRadius / Math.cos(angleA / 2) * Math.sin(angleMid2);
				var cx2:Number=width/2 + innerRadius * Math.cos(newStart);
				var cy2:Number=height/2 + innerRadius * Math.sin(newStart);
				g.curveTo(bx2, by2, cx2, cy2);
			}
			//内圆终点
			g.lineTo(width/2 + innerRadius * Math.cos(startB),height/2 + innerRadius * Math.sin(startB));
			//完成
			g.endFill();
		}
		
	}
}