package com.syndrome.sanguo.battle.skin
{
	import org.flexlite.domUI.components.StateSkin;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class DefenseIconSkin extends org.flexlite.domUI.components.StateSkin
	{
		public var colorUI:org.flexlite.domUI.components.UIAsset;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function DefenseIconSkin()
		{
			super();
			
			this.currentState = "normal";
			this.elementsContent = [__DefenseIconSkin_UIAsset1_i(),colorUI_i()];
			
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
		private function __DefenseIconSkin_UIAsset1_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.skinName = "IMG_Battle_Denfense";
			temp.x = 0;
			temp.y = 0;
			return temp;
		}

		private function colorUI_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			colorUI = temp;
			temp.skinName = "IMG_Battle_DenfenseColor";
			temp.x = 0;
			temp.y = 0;
			return temp;
		}

	}
}