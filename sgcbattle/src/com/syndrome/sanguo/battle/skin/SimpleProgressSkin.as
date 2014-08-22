package com.syndrome.sanguo.battle.skin
{
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.StateSkin;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class SimpleProgressSkin extends org.flexlite.domUI.components.StateSkin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var thumb:org.flexlite.domUI.components.Rect;

		public var track:org.flexlite.domUI.components.UIAsset;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function SimpleProgressSkin()
		{
			super();
			
			this.currentState = "normal";
			this.height = 5;
			this.width = 100;
			this.elementsContent = [track_i(),thumb_i()];
			
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
		private function thumb_i():org.flexlite.domUI.components.Rect
		{
			var temp:org.flexlite.domUI.components.Rect = new org.flexlite.domUI.components.Rect();
			thumb = temp;
			temp.bottom = 0;
			temp.fillColor = 0xe5cd02;
			temp.top = 0;
			temp.width = 20;
			temp.x = 0;
			return temp;
		}

		private function track_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			track = temp;
			temp.bottom = 0;
			temp.left = 0;
			temp.right = 0;
			temp.top = 0;
			return temp;
		}

	}
}