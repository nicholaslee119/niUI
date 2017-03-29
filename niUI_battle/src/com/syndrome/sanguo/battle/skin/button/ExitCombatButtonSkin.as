package com.syndrome.sanguo.battle.skin.button
{
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.StateSkin;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.states.AddItems;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class ExitCombatButtonSkin extends org.flexlite.domUI.components.StateSkin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var __ExitCombatButtonSkin_UIAsset1:org.flexlite.domUI.components.UIAsset;

		public var __ExitCombatButtonSkin_UIAsset2:org.flexlite.domUI.components.UIAsset;

		public var __ExitCombatButtonSkin_UIAsset3:org.flexlite.domUI.components.UIAsset;

		public var __ExitCombatButtonSkin_UIAsset4:org.flexlite.domUI.components.UIAsset;

		public var labelDisplay:org.flexlite.domUI.components.Label;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function ExitCombatButtonSkin()
		{
			super();
			
			this.currentState = "up";
			this.elementsContent = [labelDisplay_i()];
			__ExitCombatButtonSkin_UIAsset1_i();
			__ExitCombatButtonSkin_UIAsset2_i();
			__ExitCombatButtonSkin_UIAsset3_i();
			__ExitCombatButtonSkin_UIAsset4_i();
			
			
			states = [
				new org.flexlite.domUI.states.State ({name: "up",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__ExitCombatButtonSkin_UIAsset2",
							propertyName:"",
							position:"before",
							relativeTo:"labelDisplay"
						})
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "over",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__ExitCombatButtonSkin_UIAsset3",
							propertyName:"",
							position:"before",
							relativeTo:"labelDisplay"
						})
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "down",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__ExitCombatButtonSkin_UIAsset4",
							propertyName:"",
							position:"before",
							relativeTo:"labelDisplay"
						})
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "disabled",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__ExitCombatButtonSkin_UIAsset1",
							propertyName:"",
							position:"before",
							relativeTo:"labelDisplay"
						})
					]
				})
			];
		}


		//==========================================================================
		//                                定义成员方法
		//==========================================================================
		private function __ExitCombatButtonSkin_UIAsset1_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			__ExitCombatButtonSkin_UIAsset1 = temp;
			temp.bottom = 0;
			temp.left = 0;
			temp.right = 0;
			temp.skinName = "IMG_Button_SystemDisabled";
			temp.top = 0;
			return temp;
		}

		private function __ExitCombatButtonSkin_UIAsset2_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			__ExitCombatButtonSkin_UIAsset2 = temp;
			temp.bottom = 0;
			temp.left = 0;
			temp.right = 0;
			temp.skinName = "IMG_Button_SystemRedUp";
			temp.top = 0;
			return temp;
		}

		private function __ExitCombatButtonSkin_UIAsset3_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			__ExitCombatButtonSkin_UIAsset3 = temp;
			temp.bottom = 0;
			temp.left = 0;
			temp.right = 0;
			temp.skinName = "IMG_Button_SystemRedOver";
			temp.top = 0;
			return temp;
		}

		private function __ExitCombatButtonSkin_UIAsset4_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			__ExitCombatButtonSkin_UIAsset4 = temp;
			temp.bottom = 0;
			temp.left = 0;
			temp.right = 0;
			temp.skinName = "IMG_Button_SystemRedDown";
			temp.top = 0;
			return temp;
		}

		private function labelDisplay_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			labelDisplay = temp;
			temp.bottom = 0;
			temp.left = 0;
			temp.letterSpacing = 4;
			temp.paddingLeft = 4;
			temp.right = 0;
			temp.textAlign = "center";
			temp.textColor = 0xF6C7A5;
			temp.top = 0;
			temp.verticalAlign = "middle";
			return temp;
		}

	}
}