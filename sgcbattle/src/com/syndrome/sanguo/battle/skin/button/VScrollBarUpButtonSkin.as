package com.syndrome.sanguo.battle.skin.button
{
	import org.flexlite.domUI.components.StateSkin;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.states.AddItems;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class VScrollBarUpButtonSkin extends org.flexlite.domUI.components.StateSkin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var __VScrollBarUpButtonSkin_UIAsset1:org.flexlite.domUI.components.UIAsset;

		public var __VScrollBarUpButtonSkin_UIAsset2:org.flexlite.domUI.components.UIAsset;

		public var __VScrollBarUpButtonSkin_UIAsset3:org.flexlite.domUI.components.UIAsset;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function VScrollBarUpButtonSkin()
		{
			super();
			
			this.currentState = "up";
			this.elementsContent = [];
			__VScrollBarUpButtonSkin_UIAsset1_i();
			__VScrollBarUpButtonSkin_UIAsset2_i();
			__VScrollBarUpButtonSkin_UIAsset3_i();
			
			
			states = [
				new org.flexlite.domUI.states.State ({name: "up",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__VScrollBarUpButtonSkin_UIAsset3",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "over",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__VScrollBarUpButtonSkin_UIAsset2",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "down",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__VScrollBarUpButtonSkin_UIAsset1",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "disabled",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__VScrollBarUpButtonSkin_UIAsset1",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
					]
				})
			];
		}


		//==========================================================================
		//                                定义成员方法
		//==========================================================================
		private function __VScrollBarUpButtonSkin_UIAsset1_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			__VScrollBarUpButtonSkin_UIAsset1 = temp;
			temp.skinName = "IMG_VScroller_UpButtonDown";
			return temp;
		}

		private function __VScrollBarUpButtonSkin_UIAsset2_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			__VScrollBarUpButtonSkin_UIAsset2 = temp;
			temp.skinName = "IMG_VScroller_UpButtonOver";
			return temp;
		}

		private function __VScrollBarUpButtonSkin_UIAsset3_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			__VScrollBarUpButtonSkin_UIAsset3 = temp;
			temp.skinName = "IMG_VScroller_UpButtonUp";
			return temp;
		}

	}
}