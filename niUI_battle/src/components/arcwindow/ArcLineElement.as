package components.arcwindow
{
	import org.flexlite.domUI.core.UIComponent;

	/**
	 * 线条效果，暂时弃用
	 */
    public class ArcLineElement extends UIComponent
    {
        public var percent:Number;
        private static const elementRadius:Number = 2.5;

        public function ArcLineElement(percent:Number, color1:uint = 16725799, color2:uint = 16725799)
        {
            this.percent = percent;
            this.init(color1, color2);
        }

        public function init(color1:uint, color2:uint , alpha:Object = null) : void
        {
			if(alpha == null){
				alpha = this.getAlpha();
			}
            graphics.clear();
            graphics.beginFill(this.getColor(color1, color2), Number(alpha));
            graphics.drawCircle(elementRadius, elementRadius, this.getRadius());
            graphics.endFill();
            return;
        }

        private function getColor(param1:uint, param2:uint) : uint
        {
            var _loc_3:* = param1 >> 16 & 255;
            var _loc_4:* = param1 >> 8 & 255;
            var _loc_5:* = param1 & 255;
            var _loc_6:* = param2 >> 16 & 255;
            var _loc_7:* = param2 >> 8 & 255;
            var _loc_8:* = param2 & 255;
            var _loc_9:* = _loc_3 + (_loc_6 - _loc_3) * this.percent;
            var _loc_10:* = _loc_4 + (_loc_7 - _loc_4) * this.percent;
            var _loc_11:* = _loc_5 + (_loc_8 - _loc_5) * this.percent;
            return _loc_9 << 16 | _loc_10 << 8 | _loc_11;
        }

        private function getAlpha() : Number
        {
			return 1;
            var base:Number = 0.3;
            return this.percent > 0.5 ? ((1 - this.percent) * 2 * base) : (base);
        }

        private function getRadius() : Number
        {
            return elementRadius * (1 - Math.abs(0.5 - this.percent) / 2);
        }

    }
}
