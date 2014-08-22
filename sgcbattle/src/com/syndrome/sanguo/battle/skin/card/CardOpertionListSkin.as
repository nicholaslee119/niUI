package com.syndrome.sanguo.battle.skin.card
{
	import com.syndrome.sanguo.battle.skin.button.SystemButtonSkin;
	import org.flexlite.domUI.components.DataGroup;
	import org.flexlite.domUI.components.supportClasses.Skin;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class CardOpertionListSkin extends org.flexlite.domUI.components.supportClasses.Skin
	{
		public var dataGroup:org.flexlite.domUI.components.DataGroup;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function CardOpertionListSkin()
		{
			super();
			
			this.currentState = "normal";
			this.elementsContent = [dataGroup_i()];
			
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


		private function dataGroup_i():org.flexlite.domUI.components.DataGroup
		{
			var temp:org.flexlite.domUI.components.DataGroup = new org.flexlite.domUI.components.DataGroup();
			dataGroup = temp;
			temp.bottom = 0;
			temp.itemRendererSkinName = com.syndrome.sanguo.battle.skin.button.SystemButtonSkin;
			temp.left = 0;
			temp.right = 0;
			temp.top = 0;
			return temp;
		}

	}
}