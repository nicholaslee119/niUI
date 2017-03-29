package com.syndrome.sanguo.battle.skin
{
	import com.syndrome.sanguo.battle.skin.button.CardWindowOKButtonSkin;
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.supportClasses.Skin;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class DistributeInjuryWindowSkin extends org.flexlite.domUI.components.supportClasses.Skin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var enemyItemGroup:org.flexlite.domUI.components.Group;

		public var moveArea:org.flexlite.domUI.components.Rect;

		public var myItemGroup:org.flexlite.domUI.components.Group;

		public var okButton:org.flexlite.domUI.components.Button;

		public var titleDisplay:org.flexlite.domUI.components.Label;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function DistributeInjuryWindowSkin()
		{
			super();
			
			this.currentState = "normal";
			this.maxHeight = 390;
			this.minHeight = 300;
			this.minWidth = 400;
			this.elementsContent = [__DistributeInjuryWindowSkin_UIAsset1_i(),__DistributeInjuryWindowSkin_UIAsset2_i(),__DistributeInjuryWindowSkin_UIAsset3_i(),titleDisplay_i(),moveArea_i(),__DistributeInjuryWindowSkin_UIAsset4_i(),__DistributeInjuryWindowSkin_Group1_i(),__DistributeInjuryWindowSkin_Group2_i()];
			
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
		private function __DistributeInjuryWindowSkin_Group1_i():org.flexlite.domUI.components.Group
		{
			var temp:org.flexlite.domUI.components.Group = new org.flexlite.domUI.components.Group();
			temp.bottom = 20;
			temp.horizontalCenter = 0;
			temp.layout = __DistributeInjuryWindowSkin_HorizontalLayout1_i();
			temp.elementsContent = [okButton_i()];
			return temp;
		}

		private function __DistributeInjuryWindowSkin_Group2_i():org.flexlite.domUI.components.Group
		{
			var temp:org.flexlite.domUI.components.Group = new org.flexlite.domUI.components.Group();
			temp.bottom = 53;
			temp.left = 20;
			temp.right = 20;
			temp.top = 53;
			temp.elementsContent = [myItemGroup_i(),enemyItemGroup_i(),__DistributeInjuryWindowSkin_Label1_i(),__DistributeInjuryWindowSkin_Label2_i()];
			return temp;
		}

		private function __DistributeInjuryWindowSkin_HorizontalLayout1_i():org.flexlite.domUI.layouts.HorizontalLayout
		{
			var temp:org.flexlite.domUI.layouts.HorizontalLayout = new org.flexlite.domUI.layouts.HorizontalLayout();
			temp.gap = -12;
			return temp;
		}

		private function __DistributeInjuryWindowSkin_HorizontalLayout2_i():org.flexlite.domUI.layouts.HorizontalLayout
		{
			var temp:org.flexlite.domUI.layouts.HorizontalLayout = new org.flexlite.domUI.layouts.HorizontalLayout();
			temp.gap = 20;
			temp.horizontalAlign = "center";
			return temp;
		}

		private function __DistributeInjuryWindowSkin_HorizontalLayout3_i():org.flexlite.domUI.layouts.HorizontalLayout
		{
			var temp:org.flexlite.domUI.layouts.HorizontalLayout = new org.flexlite.domUI.layouts.HorizontalLayout();
			temp.gap = 20;
			temp.horizontalAlign = "center";
			return temp;
		}

		private function __DistributeInjuryWindowSkin_Label1_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			temp.bold = true;
			temp.size = 16;
			temp.text = "防守战团";
			temp.textAlign = "center";
			temp.textColor = 0xff0000;
			temp.verticalAlign = "middle";
			temp.verticalCenter = 68;
			temp.width = 20;
			return temp;
		}

		private function __DistributeInjuryWindowSkin_Label2_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			temp.bold = true;
			temp.size = 16;
			temp.text = "攻击战团";
			temp.textAlign = "center";
			temp.textColor = 0xFF0000;
			temp.verticalAlign = "middle";
			temp.verticalCenter = -68;
			temp.width = 20;
			temp.x = 0;
			return temp;
		}

		private function __DistributeInjuryWindowSkin_UIAsset1_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.bottom = 0;
			temp.left = 0;
			temp.right = 0;
			temp.skinName = "IMG_CardWindow_BackGround";
			temp.top = 0;
			return temp;
		}

		private function __DistributeInjuryWindowSkin_UIAsset2_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.left = 18;
			temp.right = 18;
			temp.skinName = "IMG_CardWindow_BackGround2";
			temp.top = 16;
			return temp;
		}

		private function __DistributeInjuryWindowSkin_UIAsset3_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.horizontalCenter = 0;
			temp.skinName = "IMG_CardWindow_Title";
			temp.top = 20;
			return temp;
		}

		private function __DistributeInjuryWindowSkin_UIAsset4_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.bottom = 20;
			temp.height = 33;
			temp.left = 18;
			temp.right = 18;
			temp.skinName = "IMG_CardWindow_BackGround2";
			return temp;
		}

		private function enemyItemGroup_i():org.flexlite.domUI.components.Group
		{
			var temp:org.flexlite.domUI.components.Group = new org.flexlite.domUI.components.Group();
			enemyItemGroup = temp;
			temp.height = 129;
			temp.left = 27;
			temp.right = 0;
			temp.layout = __DistributeInjuryWindowSkin_HorizontalLayout3_i();
			return temp;
		}

		private function moveArea_i():org.flexlite.domUI.components.Rect
		{
			var temp:org.flexlite.domUI.components.Rect = new org.flexlite.domUI.components.Rect();
			moveArea = temp;
			temp.fillAlpha = 0;
			temp.height = 49;
			temp.left = 0;
			temp.right = 0;
			temp.top = 0;
			return temp;
		}

		private function myItemGroup_i():org.flexlite.domUI.components.Group
		{
			var temp:org.flexlite.domUI.components.Group = new org.flexlite.domUI.components.Group();
			myItemGroup = temp;
			temp.height = 129;
			temp.left = 27;
			temp.right = 0;
			temp.top = 136;
			temp.layout = __DistributeInjuryWindowSkin_HorizontalLayout2_i();
			return temp;
		}

		private function okButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			okButton = temp;
			temp.label = "按钮";
			temp.skinName = com.syndrome.sanguo.battle.skin.button.CardWindowOKButtonSkin;
			temp.x = 11;
			temp.y = 4;
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
			temp.text = "伤害分配";
			temp.textAlign = "center";
			temp.textColor = 0x4f2b0e;
			temp.top = 18;
			temp.verticalAlign = "middle";
			temp.width = 100;
			return temp;
		}

	}
}