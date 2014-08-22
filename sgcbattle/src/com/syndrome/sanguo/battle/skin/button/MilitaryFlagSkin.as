package com.syndrome.sanguo.battle.skin.button
{
	import com.syndrome.sanguo.battle.skin.button.MilitaryButtonSkin;
	import components.rollnum.RollNumGroup;
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.components.supportClasses.Skin;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class MilitaryFlagSkin extends org.flexlite.domUI.components.supportClasses.Skin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var button:org.flexlite.domUI.components.Button;

		public var icon:org.flexlite.domUI.components.UIMovieClip;

		public var numGroup:components.rollnum.RollNumGroup;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function MilitaryFlagSkin()
		{
			super();
			
			this.height = 27;
			this.width = 87;
			this.elementsContent = [icon_i(),numGroup_i(),button_i()];
			
		}


		//==========================================================================
		//                                定义成员方法
		//==========================================================================
		private function button_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			button = temp;
			temp.height = 20;
			temp.left = 35;
			temp.skinName = com.syndrome.sanguo.battle.skin.button.MilitaryButtonSkin;
			temp.verticalCenter = 0;
			temp.width = 52;
			return temp;
		}

		private function icon_i():org.flexlite.domUI.components.UIMovieClip
		{
			var temp:org.flexlite.domUI.components.UIMovieClip = new org.flexlite.domUI.components.UIMovieClip();
			icon = temp;
			temp.left = -4;
			temp.skinName = "IMG_BqFlag_Icon";
			temp.verticalCenter = 0;
			return temp;
		}

		private function numGroup_i():components.rollnum.RollNumGroup
		{
			var temp:components.rollnum.RollNumGroup = new components.rollnum.RollNumGroup();
			numGroup = temp;
			temp.bottom = 0;
			temp.left = 32;
			temp.right = 0;
			temp.top = 0;
			return temp;
		}

	}
}