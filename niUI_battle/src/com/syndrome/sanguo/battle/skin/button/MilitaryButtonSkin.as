package com.syndrome.sanguo.battle.skin.button
{
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.StateSkin;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.states.AddItems;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class MilitaryButtonSkin extends org.flexlite.domUI.components.StateSkin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var __MilitaryButtonSkin_Rect1:org.flexlite.domUI.components.Rect;

		public var __MilitaryButtonSkin_UIAsset1:org.flexlite.domUI.components.UIAsset;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function MilitaryButtonSkin()
		{
			super();
			
			this.currentState = "up";
			this.elementsContent = [];
			__MilitaryButtonSkin_UIAsset1_i();
			__MilitaryButtonSkin_Rect1_i();
			
			
			states = [
				new org.flexlite.domUI.states.State ({name: "up",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__MilitaryButtonSkin_Rect1",
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
							target:"__MilitaryButtonSkin_UIAsset1",
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
							target:"__MilitaryButtonSkin_UIAsset1",
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
							target:"__MilitaryButtonSkin_Rect1",
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
		private function __MilitaryButtonSkin_Rect1_i():org.flexlite.domUI.components.Rect
		{
			var temp:org.flexlite.domUI.components.Rect = new org.flexlite.domUI.components.Rect();
			__MilitaryButtonSkin_Rect1 = temp;
			temp.alpha = 0;
			temp.bottom = 0;
			temp.left = 0;
			temp.right = 0;
			temp.top = 0;
			return temp;
		}

		private function __MilitaryButtonSkin_UIAsset1_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			__MilitaryButtonSkin_UIAsset1 = temp;
			temp.height = 20;
			temp.horizontalCenter = 0;
			temp.skinName = "IMG_BqFlag_Mask";
			temp.verticalCenter = 0;
			temp.width = 53;
			return temp;
		}

	}
}