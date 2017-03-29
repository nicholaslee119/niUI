package com.syndrome.sanguo.battle.skin.button
{
	import com.syndrome.sanguo.battle.skin.button.CancelButtonSkin;
	import com.syndrome.sanguo.battle.skin.button.OKButtonSkin;
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.supportClasses.Skin;
	import org.flexlite.domUI.states.AddItems;
	import org.flexlite.domUI.states.SetProperty;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class OKCancelButtonGroupSkin extends org.flexlite.domUI.components.supportClasses.Skin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var __OKCancelButtonGroupSkin_UIAsset1:org.flexlite.domUI.components.UIAsset;

		public var cancelButton:org.flexlite.domUI.components.Button;

		public var okButton:org.flexlite.domUI.components.Button;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function OKCancelButtonGroupSkin()
		{
			super();
			
			this.currentState = "normal";
			this.elementsContent = [];
			__OKCancelButtonGroupSkin_UIAsset1_i();
			okButton_i();
			cancelButton_i();
			
			
			states = [
				new org.flexlite.domUI.states.State ({name: "normal",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__OKCancelButtonGroupSkin_UIAsset1",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
						,
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"okButton",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
						,
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"cancelButton",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "disabled",
					overrides: [
						new org.flexlite.domUI.states.SetProperty().initializeFromObject({
							target:"okButton",
							name:"label",
							value:"按钮"
						})
					]
				})
			];
		}


		//==========================================================================
		//                                定义成员方法
		//==========================================================================
		private function __OKCancelButtonGroupSkin_UIAsset1_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			__OKCancelButtonGroupSkin_UIAsset1 = temp;
			temp.horizontalCenter = 0;
			temp.mouseEnabled = false;
			temp.skinName = "IMG_Button_OKCancelBackGround";
			temp.verticalCenter = 0;
			return temp;
		}

		private function cancelButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			cancelButton = temp;
			temp.horizontalCenter = 52;
			temp.label = "按钮";
			temp.skinName = com.syndrome.sanguo.battle.skin.button.CancelButtonSkin;
			temp.verticalCenter = 0;
			return temp;
		}

		private function okButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			okButton = temp;
			temp.horizontalCenter = -52;
			temp.label = "按钮";
			temp.skinName = com.syndrome.sanguo.battle.skin.button.OKButtonSkin;
			temp.verticalCenter = 0;
			return temp;
		}

	}
}