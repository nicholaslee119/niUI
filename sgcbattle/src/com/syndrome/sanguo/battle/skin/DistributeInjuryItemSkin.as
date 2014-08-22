package com.syndrome.sanguo.battle.skin
{
	import com.syndrome.sanguo.battle.combat_ui.card.cardimage.CardImage;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.supportClasses.Skin;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	import org.flexlite.domUI.layouts.TileLayout;
	import org.flexlite.domUI.layouts.VerticalLayout;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class DistributeInjuryItemSkin extends org.flexlite.domUI.components.supportClasses.Skin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var cardImage:com.syndrome.sanguo.battle.combat_ui.card.cardimage.CardImage;

		public var cardNameLabel:org.flexlite.domUI.components.Label;

		public var iconGroup:org.flexlite.domUI.components.Group;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function DistributeInjuryItemSkin()
		{
			super();
			
			this.currentState = "normal";
			this.layout = __DistributeInjuryItemSkin_HorizontalLayout1_i();
			this.elementsContent = [__DistributeInjuryItemSkin_Group1_i(),iconGroup_i()];
			
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
		private function __DistributeInjuryItemSkin_Group1_i():org.flexlite.domUI.components.Group
		{
			var temp:org.flexlite.domUI.components.Group = new org.flexlite.domUI.components.Group();
			temp.x = -41;
			temp.y = 105;
			temp.layout = __DistributeInjuryItemSkin_VerticalLayout1_i();
			temp.elementsContent = [cardImage_i(),cardNameLabel_i()];
			return temp;
		}

		private function __DistributeInjuryItemSkin_HorizontalLayout1_i():org.flexlite.domUI.layouts.HorizontalLayout
		{
			var temp:org.flexlite.domUI.layouts.HorizontalLayout = new org.flexlite.domUI.layouts.HorizontalLayout();
			temp.gap = 3;
			return temp;
		}

		private function __DistributeInjuryItemSkin_TileLayout1_i():org.flexlite.domUI.layouts.TileLayout
		{
			var temp:org.flexlite.domUI.layouts.TileLayout = new org.flexlite.domUI.layouts.TileLayout();
			temp.horizontalGap = 3;
			temp.orientation = "columns";
			temp.requestedRowCount = 5;
			temp.verticalGap = 3;
			return temp;
		}

		private function __DistributeInjuryItemSkin_VerticalLayout1_i():org.flexlite.domUI.layouts.VerticalLayout
		{
			var temp:org.flexlite.domUI.layouts.VerticalLayout = new org.flexlite.domUI.layouts.VerticalLayout();
			temp.gap = 2;
			temp.horizontalAlign = "center";
			return temp;
		}

		private function cardImage_i():com.syndrome.sanguo.battle.combat_ui.card.cardimage.CardImage
		{
			var temp:com.syndrome.sanguo.battle.combat_ui.card.cardimage.CardImage = new com.syndrome.sanguo.battle.combat_ui.card.cardimage.CardImage();
			cardImage = temp;
			temp.isPositive = true;
			return temp;
		}

		private function cardNameLabel_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			cardNameLabel = temp;
			temp.height = 16;
			temp.x = 69;
			temp.y = 142;
			return temp;
		}

		private function iconGroup_i():org.flexlite.domUI.components.Group
		{
			var temp:org.flexlite.domUI.components.Group = new org.flexlite.domUI.components.Group();
			iconGroup = temp;
			temp.minWidth = 21;
			temp.layout = __DistributeInjuryItemSkin_TileLayout1_i();
			return temp;
		}

	}
}