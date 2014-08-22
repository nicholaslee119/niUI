package com.syndrome.sanguo.battle.skin.button
{
	import org.flexlite.domUI.components.StateSkin;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class VScrollBarTarackButtonSkin extends org.flexlite.domUI.components.StateSkin
	{

		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function VScrollBarTarackButtonSkin()
		{
			super();
			
			this.currentState = "normal";
			this.elementsContent = [__VScrollBarTarackButtonSkin_UIAsset1_i()];
			
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


		private function __VScrollBarTarackButtonSkin_UIAsset1_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.bottom = 0;
			temp.left = 0;
			temp.right = 1;
			temp.skinName = "IMG_VScroller_Track";
			temp.top = 0;
			return temp;
		}

	}
}