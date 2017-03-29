package com.syndrome.sanguo.battle.skin
{
	import com.syndrome.sanguo.battle.skin.button.CardWindowCancelButtonSkin;
	import com.syndrome.sanguo.battle.skin.card.CardListItemRenderderSkin;
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.DataGroup;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.Scroller;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.supportClasses.Skin;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class CardDisplayWindowSkin extends org.flexlite.domUI.components.supportClasses.Skin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var cancelButton:org.flexlite.domUI.components.Button;

		public var cardGroup:org.flexlite.domUI.components.DataGroup;

		public var moveArea:org.flexlite.domUI.components.Rect;

		public var titleDisplay:org.flexlite.domUI.components.Label;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function CardDisplayWindowSkin()
		{
			super();
			
			this.currentState = "normal";
			this.maxHeight = 365;
			this.minHeight = 230;
			this.minWidth = 250;
			this.elementsContent = [__CardDisplayWindowSkin_UIAsset1_i(),__CardDisplayWindowSkin_Scroller1_i(),__CardDisplayWindowSkin_UIAsset2_i(),__CardDisplayWindowSkin_UIAsset3_i(),titleDisplay_i(),moveArea_i(),__CardDisplayWindowSkin_UIAsset4_i(),cancelButton_i()];
			
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
		private function __CardDisplayWindowSkin_Scroller1_i():org.flexlite.domUI.components.Scroller
		{
			var temp:org.flexlite.domUI.components.Scroller = new org.flexlite.domUI.components.Scroller();
			temp.bottom = 53;
			temp.left = 23;
			temp.right = 20;
			temp.top = 53;
			temp.useMouseWheelDelta = false;
			temp.viewport = cardGroup_i();
			return temp;
		}

		private function __CardDisplayWindowSkin_UIAsset1_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.bottom = 0;
			temp.left = 0;
			temp.right = 0;
			temp.skinName = "IMG_CardWindow_BackGround";
			temp.top = 0;
			return temp;
		}

		private function __CardDisplayWindowSkin_UIAsset2_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.left = 18;
			temp.right = 18;
			temp.skinName = "IMG_CardWindow_BackGround2";
			temp.top = 16;
			return temp;
		}

		private function __CardDisplayWindowSkin_UIAsset3_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.horizontalCenter = 0;
			temp.skinName = "IMG_CardWindow_Title";
			temp.top = 20;
			return temp;
		}

		private function __CardDisplayWindowSkin_UIAsset4_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.bottom = 20;
			temp.height = 33;
			temp.left = 18;
			temp.right = 18;
			temp.skinName = "IMG_CardWindow_BackGround2";
			return temp;
		}

		private function cancelButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			cancelButton = temp;
			temp.bottom = 20;
			temp.horizontalCenter = 0;
			temp.label = "按钮";
			temp.skinName = com.syndrome.sanguo.battle.skin.button.CardWindowCancelButtonSkin;
			return temp;
		}

		private function cardGroup_i():org.flexlite.domUI.components.DataGroup
		{
			var temp:org.flexlite.domUI.components.DataGroup = new org.flexlite.domUI.components.DataGroup();
			cardGroup = temp;
			temp.itemRendererSkinName = com.syndrome.sanguo.battle.skin.card.CardListItemRenderderSkin;
			return temp;
		}

		private function moveArea_i():org.flexlite.domUI.components.Rect
		{
			var temp:org.flexlite.domUI.components.Rect = new org.flexlite.domUI.components.Rect();
			moveArea = temp;
			temp.fillAlpha = 0;
			temp.height = 53;
			temp.left = 0;
			temp.right = 0;
			temp.top = 0;
			return temp;
		}

		private function titleDisplay_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			titleDisplay = temp;
			temp.bold = true;
			temp.fontFamily = "SimSun";
			temp.height = 33;
			temp.horizontalCenter = 0;
			temp.size = 14;
			temp.text = "标签";
			temp.textAlign = "center";
			temp.textColor = 0x4f2b0e;
			temp.top = 18;
			temp.verticalAlign = "middle";
			temp.width = 100;
			return temp;
		}

	}
}