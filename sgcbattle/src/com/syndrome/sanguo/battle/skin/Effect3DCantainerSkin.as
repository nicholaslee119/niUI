package com.syndrome.sanguo.battle.skin
{
	import flash.filters.GlowFilter;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.supportClasses.Skin;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class Effect3DCantainerSkin extends org.flexlite.domUI.components.supportClasses.Skin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var contentGroup:org.flexlite.domUI.components.Group;

		public var enemyEncampmentNumLabel:org.flexlite.domUI.components.Label;

		public var enemyMDNumLabel:org.flexlite.domUI.components.Label;

		public var glowFilter:flash.filters.GlowFilter;

		public var myEncampmentNumLabel:org.flexlite.domUI.components.Label;

		public var myMDNumLabel:org.flexlite.domUI.components.Label;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function Effect3DCantainerSkin()
		{
			super();
			
			this.currentState = "normal";
			this.height = 518;
			this.width = 908;
			glowFilter_i();
			this.elementsContent = [__Effect3DCantainerSkin_UIAsset1_i(),__Effect3DCantainerSkin_UIAsset2_i(),myEncampmentNumLabel_i(),myMDNumLabel_i(),enemyEncampmentNumLabel_i(),enemyMDNumLabel_i(),contentGroup_i()];
			
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
		private function __Effect3DCantainerSkin_UIAsset1_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.skinName = "IMG_Main_MDMask";
			temp.x = 12;
			temp.y = 390;
			return temp;
		}

		private function __Effect3DCantainerSkin_UIAsset2_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.skinName = "IMG_Main_MDMask";
			temp.x = 15;
			temp.y = 8;
			return temp;
		}

		private function contentGroup_i():org.flexlite.domUI.components.Group
		{
			var temp:org.flexlite.domUI.components.Group = new org.flexlite.domUI.components.Group();
			contentGroup = temp;
			temp.percentHeight = 100;
			temp.percentWidth = 100;
			return temp;
		}

		private function enemyEncampmentNumLabel_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			enemyEncampmentNumLabel = temp;
			temp.filters = [glowFilter];
			temp.height = 29;
			temp.size = 25;
			temp.textAlign = "right";
			temp.textColor = 13947602;
			temp.width = 50;
			temp.x = 748;
			temp.y = 96;
			return temp;
		}

		private function enemyMDNumLabel_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			enemyMDNumLabel = temp;
			temp.filters = [glowFilter];
			temp.height = 29;
			temp.size = 25;
			temp.textAlign = "right";
			temp.textColor = 0xD4D2D2;
			temp.width = 50;
			temp.x = 51;
			temp.y = 93;
			return temp;
		}

		private function glowFilter_i():flash.filters.GlowFilter
		{
			var temp:flash.filters.GlowFilter = new flash.filters.GlowFilter();
			glowFilter = temp;
			temp.color = 0;
			temp.strength = 2;
			return temp;
		}

		private function myEncampmentNumLabel_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			myEncampmentNumLabel = temp;
			temp.filters = [glowFilter];
			temp.height = 29;
			temp.size = 25;
			temp.textAlign = "right";
			temp.textColor = 13947602;
			temp.width = 50;
			temp.x = 749;
			temp.y = 476;
			return temp;
		}

		private function myMDNumLabel_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			myMDNumLabel = temp;
			temp.filters = [glowFilter];
			temp.height = 29;
			temp.size = 25;
			temp.textAlign = "right";
			temp.textColor = 0xD4D2D2;
			temp.width = 50;
			temp.x = 48;
			temp.y = 476;
			return temp;
		}

	}
}