package com.syndrome.sanguo.battle.skin.card
{
	import com.syndrome.sanguo.battle.combat_ui.card.cardimage.CardImage;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.StateSkin;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class CardListItemRenderderSkin extends org.flexlite.domUI.components.StateSkin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var cardImage:com.syndrome.sanguo.battle.combat_ui.card.cardimage.CardImage;

		public var labelDisplay:org.flexlite.domUI.components.Label;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function CardListItemRenderderSkin()
		{
			super();
			
			this.currentState = "up";
			this.elementsContent = [cardImage_i(),labelDisplay_i()];
			
			states = [
				new org.flexlite.domUI.states.State ({name: "up",
					overrides: [
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "over",
					overrides: [
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "down",
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
		private function cardImage_i():com.syndrome.sanguo.battle.combat_ui.card.cardimage.CardImage
		{
			var temp:com.syndrome.sanguo.battle.combat_ui.card.cardimage.CardImage = new com.syndrome.sanguo.battle.combat_ui.card.cardimage.CardImage();
			cardImage = temp;
			temp.left = 0;
			temp.right = 0;
			temp.top = 0;
			return temp;
		}

		private function labelDisplay_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			labelDisplay = temp;
			temp.left = 0;
			temp.right = 0;
			temp.text = "标签";
			temp.textAlign = "center";
			temp.top = 110;
			return temp;
		}

	}
}