package com.syndrome.sanguo.battle.skin
{
	import flash.filters.GlowFilter;
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
	public class ChatTabButtonSkin extends org.flexlite.domUI.components.StateSkin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var __ChatTabButtonSkin_UIAsset1:org.flexlite.domUI.components.UIAsset;

		public var __ChatTabButtonSkin_UIAsset2:org.flexlite.domUI.components.UIAsset;

		public var labelDisplay:org.flexlite.domUI.components.Label;

		public var shadow:flash.filters.GlowFilter;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function ChatTabButtonSkin()
		{
			super();
			
			this.currentState = "up";
			shadow_i();
			this.elementsContent = [labelDisplay_i()];
			__ChatTabButtonSkin_UIAsset1_i();
			__ChatTabButtonSkin_UIAsset2_i();
			
			
			states = [
				new org.flexlite.domUI.states.State ({name: "up",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__ChatTabButtonSkin_UIAsset1",
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
							target:"__ChatTabButtonSkin_UIAsset2",
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
							target:"__ChatTabButtonSkin_UIAsset2",
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
							target:"__ChatTabButtonSkin_UIAsset1",
							propertyName:"",
							position:"before",
							relativeTo:"labelDisplay"
						})
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "upAndSelected",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__ChatTabButtonSkin_UIAsset2",
							propertyName:"",
							position:"before",
							relativeTo:"labelDisplay"
						})
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "overAndSelected",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__ChatTabButtonSkin_UIAsset2",
							propertyName:"",
							position:"before",
							relativeTo:"labelDisplay"
						})
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "downAndSelected",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__ChatTabButtonSkin_UIAsset2",
							propertyName:"",
							position:"before",
							relativeTo:"labelDisplay"
						})
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "disabledAndSelected",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__ChatTabButtonSkin_UIAsset2",
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
		private function __ChatTabButtonSkin_UIAsset1_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			__ChatTabButtonSkin_UIAsset1 = temp;
			temp.horizontalCenter = 0;
			temp.skinName = "IMG_Chat_ButtonBackGroundUp";
			temp.verticalCenter = 0;
			return temp;
		}

		private function __ChatTabButtonSkin_UIAsset2_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			__ChatTabButtonSkin_UIAsset2 = temp;
			temp.horizontalCenter = 0;
			temp.skinName = "IMG_Chat_ButtonBackGroundOver";
			temp.verticalCenter = 0;
			return temp;
		}

		private function labelDisplay_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			labelDisplay = temp;
			temp.alpha = 0.7;
			temp.bottom = 0;
			temp.filters = [shadow];
			temp.fontFamily = "STKaiti";
			temp.left = 0;
			temp.right = 0;
			temp.size = 16;
			temp.text = "战场记录";
			temp.textAlign = "center";
			temp.textColor = 0xffffff;
			temp.top = 0;
			temp.verticalAlign = "middle";
			return temp;
		}

		private function shadow_i():flash.filters.GlowFilter
		{
			var temp:flash.filters.GlowFilter = new flash.filters.GlowFilter();
			shadow = temp;
			temp.blurX = 3;
			temp.blurY = 3;
			temp.color = 0x000000;
			temp.strength = 8;
			return temp;
		}

	}
}