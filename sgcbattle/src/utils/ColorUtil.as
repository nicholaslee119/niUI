package utils
{
    public class ColorUtil extends Object
    {

        public function ColorUtil()
        {
        }

        public static function getColorMatrixByBrightness(number:Number) : Array
        {
            var arr:Array = null;
            number = number > 1 ? (1) : (number);
            number = number < -1 ? (-1) : (number);
            if (number > 0)
            {
				arr = [1 - number, 0, 0, 0, 255 * number, 0, 1 - number, 0, 0, 255 * number, 0, 0, 1 - number, 0, 255 * number, 0, 0, 0, 1, 0];
            }
            else
            {
				arr = [1 + number, 0, 0, 0, 0, 0, 1 + number, 0, 0, 0, 0, 0, 1 + number, 0, 0, 0, 0, 0, 1, 0];
            }
            return arr;
        }

        public static function getGrayColorMatrix() : Array
        {
            var _loc_1:* = 0.212671;
            var _loc_2:* = 0.71516;
            var _loc_3:* = 0.072169;
            return [_loc_1, _loc_2, _loc_3, 0, 0, _loc_1, _loc_2, _loc_3, 0, 0, _loc_1, _loc_2, _loc_3, 0, 0, 0, 0, 0, 1, 0];
        }

    }
}
