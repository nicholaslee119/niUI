package com.syndrome.sanguo.battle.skin
{
	import com.syndrome.sanguo.battle.skin.button.CardWindowCancelButtonSkin;
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
	public class MessageWindowSkin extends org.flexlite.domUI.components.supportClasses.Skin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var cancelButton:org.flexlite.domUI.components.Button;

		public var confirmButton:org.flexlite.domUI.components.Button;

		public var contentGroup:org.flexlite.domUI.components.Group;

		public var labelDisplay:org.flexlite.domUI.components.Label;

		public var moveArea:org.flexlite.domUI.components.Rect;

		public var titleDisplay:org.flexlite.domUI.components.Label;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function MessageWindowSkin()
		{
			super();
			
			this.currentState = "normal";
			this.maxHeight = 365;
			this.minHeight = 200;
			this.minWidth = 280;
			this.elementsContent = [__MessageWindowSkin_UIAsset1_i(),__MessageWindowSkin_UIAsset2_i(),titleDisplay_i(),moveArea_i(),__MessageWindowSkin_UIAsset3_i(),__MessageWindowSkin_Group1_i(),contentGroup_i()];
			
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
		private function __MessageWindowSkin_Group1_i():org.flexlite.domUI.components.Group
		{
			var temp:org.flexlite.domUI.components.Group = new org.flexlite.domUI.components.Group();
			temp.bottom = 20;
			temp.height = 29;
			temp.horizontalCenter = 0;
			temp.width = 242;
			temp.layout = __MessageWindowSkin_HorizontalLayout1_i();
			temp.elementsContent = [confirmButton_i(),cancelButton_i()];
			return temp;
		}

		private function __MessageWindowSkin_HorizontalLayout1_i():org.flexlite.domUI.layouts.HorizontalLayout
		{
			var temp:org.flexlite.domUI.layouts.HorizontalLayout = new org.flexlite.domUI.layouts.HorizontalLayout();
			temp.gap = -12;
			temp.horizontalAlign = "center";
			return temp;
		}

		private function __MessageWindowSkin_UIAsset1_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.bottom = 0;
			temp.left = 0;
			temp.right = 0;
			temp.skinName = "IMG_CardWindow_BackGround";
			temp.top = 0;
			return temp;
		}

		private function __MessageWindowSkin_UIAsset2_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.left = 18;
			temp.right = 18;
			temp.skinName = "IMG_CardWindow_TitleBackGround";
			temp.top = 20;
			return temp;
		}

		private function __MessageWindowSkin_UIAsset3_i():org.flexlite.domUI.components.UIAsset
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

		private function confirmButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			confirmButton = temp;
			temp.label = "按钮";
			temp.skinName = com.syndrome.sanguo.battle.skin.button.CardWindowOKButtonSkin;
			temp.x = 15;
			temp.y = 10;
			return temp;
		}

		private function contentGroup_i():org.flexlite.domUI.components.Group
		{
			var temp:org.flexlite.domUI.components.Group = new org.flexlite.domUI.components.Group();
			contentGroup = temp;
			temp.bottom = 55;
			temp.left = 23;
			temp.right = 23;
			temp.top = 55;
			temp.elementsContent = [labelDisplay_i()];
			return temp;
		}

		private function labelDisplay_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			labelDisplay = temp;
			temp.horizontalCenter = 0;
			temp.maxWidth = 400;
			temp.text = "标签";
			temp.textColor = 0x4f2b0e;
			temp.verticalCenter = 0;
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
			temp.left = 20;
			temp.right = 18;
			temp.size = 14;
			temp.text = "标签";
			temp.textAlign = "center";
			temp.textColor = 0x4f2b0e;
			temp.top = 20;
			temp.verticalAlign = "middle";
			return temp;
		}

	}
}