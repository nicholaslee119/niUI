package utils
{
    public class StringUtils extends Object
    {
        public function StringUtils()
        {
        }

		/**
		 * 字符串装换为html。 #n表示结束    #y,#r,#p,#c,#h表示颜色    \n表示空行
		 */
		public static function parseColor(param1:String) : String
        {
            param1 = param1.replace(/\n/g, "<br>");
            param1 = param1.replace(/#n/g, "</font>");
            param1 = param1.replace(/#y/g, "<font color=\'#7BFF2B\'>");
			param1 = param1.replace(/#r/g, "<font color=\'#FF0000\'>");
			param1 = param1.replace(/#p/g, "<font color=\'#77FF00\'>");
			param1 = param1.replace(/#c/g, "<font color=\'#41A8FF\'>");
			param1 = param1.replace(/#h/g, "<font color=\'#FFCD8D\'>");
            return param1;
        }
    }
}
