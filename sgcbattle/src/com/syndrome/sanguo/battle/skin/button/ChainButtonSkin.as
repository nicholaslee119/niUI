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
	public class ChainButtonSkin extends org.flexlite.domUI.components.StateSkin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var __ChainButtonSkin_UIAsset1:org.flexlite.domUI.components.UIAsset;

		public var backGround:org.flexlite.domUI.components.UIAsset;

		public var cardNameLabel:org.flexlite.domUI.components.Label;

		public var chainTypeLabel:org.flexlite.domUI.components.Label;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function ChainButtonSkin()
		{
			super();
			
			this.currentState = "up";
			this.height = 49;
			this.width = 86;
			this.elementsContent = [backGround_i(),chainTypeLabel_i(),cardNameLabel_i()];
			__ChainButtonSkin_UIAsset1_i();
			
			
			states = [
				new org.flexlite.domUI.states.State ({name: "up",
					overrides: [
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "over",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__ChainButtonSkin_UIAsset1",
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
							target:"__ChainButtonSkin_UIAsset1",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
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
		private function __ChainButtonSkin_UIAsset1_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			__ChainButtonSkin_UIAsset1 = temp;
			temp.horizontalCenter = 0;
			temp.skinName = "IMG_Chain_Mask";
			temp.verticalCenter = 0;
			return temp;
		}

		private function backGround_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			backGround = temp;
			temp.horizontalCenter = 0;
			temp.skinName = "IMG_Chain_MyBackGround";
			temp.verticalCenter = 0;
			return temp;
		}

		private function cardNameLabel_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			cardNameLabel = temp;
			temp.horizontalCenter = 0;
			temp.text = "关羽";
			temp.textAlign = "right";
			temp.textColor = 0xFBD283;
			temp.y = 27;
			return temp;
		}

		private function chainTypeLabel_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			chainTypeLabel = temp;
			temp.horizontalCenter = 0;
			temp.text = "上场技能";
			temp.textColor = 0xFFB400;
			temp.y = 5;
			return temp;
		}

	}
}