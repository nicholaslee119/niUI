package components
{
	import org.flexlite.domUI.components.VScrollBar;
	
	/**
	 * 具有自动显示策略的垂直滚动条
	 */
	public class VScrollBar2 extends VScrollBar
	{
		public function VScrollBar2()
		{
			super();
		}
		
		private var _autoPolicy:Boolean = true;
		
		/**
		 * 滚动条显示策略，参见ScrollPolicy类定义的常量。
		 */		
		public function get autoPolicy():Boolean
		{
			return _autoPolicy;
		}
		
		public function set autoPolicy(value:Boolean):void
		{
			if(_autoPolicy  == value)
				return;
			_autoPolicy = value;
			invalidateDisplayList();
		}
		
		override protected function updateSkinDisplayList():void
		{
			super.updateSkinDisplayList();
			if(_autoPolicy && maximum<=minimum){
				this.visible = false;
			}else{
				this.visible = true;
			}
		}
	}
}