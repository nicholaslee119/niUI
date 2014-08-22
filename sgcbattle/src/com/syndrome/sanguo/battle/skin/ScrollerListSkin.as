package com.syndrome.sanguo.battle.skin
{
	import org.flexlite.domUI.components.DataGroup;
	import org.flexlite.domUI.components.Scroller;
	import org.flexlite.domUI.components.supportClasses.Skin;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class ScrollerListSkin extends org.flexlite.domUI.components.supportClasses.Skin
	{
		public var dataGroup:org.flexlite.domUI.components.DataGroup;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function ScrollerListSkin()
		{
			super();
			
			this.currentState = "normal";
			this.elementsContent = [__ScrollerListSkin_Scroller1_i()];
			
			states = [
				new org.flexlite.domUI.states.State ({name: "normal",
					overrides: [
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "disabled",
					overrides: [
					]
				})
			];
		}


		//==========================================================================
		//                                定义成员方法
		//==========================================================================
		private function __ScrollerListSkin_Scroller1_i():org.flexlite.domUI.components.Scroller
		{
			var temp:org.flexlite.domUI.components.Scroller = new org.flexlite.domUI.components.Scroller();
			temp.bottom = 0;
			temp.left = 0;
			temp.right = 0;
			temp.top = 0;
			temp.useMouseWheelDelta = false;
			temp.viewport = dataGroup_i();
			return temp;
		}

		private function dataGroup_i():org.flexlite.domUI.components.DataGroup
		{
			var temp:org.flexlite.domUI.components.DataGroup = new org.flexlite.domUI.components.DataGroup();
			dataGroup = temp;
			temp.x = 0;
			temp.y = 0;
			return temp;
		}

	}
}