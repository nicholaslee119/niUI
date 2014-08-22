package com.syndrome.sanguo.battle.skin.card
{
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.StateSkin;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.states.AddItems;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class CardImageSkin extends org.flexlite.domUI.components.StateSkin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var positiveGroup:org.flexlite.domUI.components.Group;

		public var reversedImg:org.flexlite.domUI.components.UIAsset;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function CardImageSkin()
		{
			super();
			
			this.currentState = "reversed";
			this.height = 110;
			this.width = 81;
			this.elementsContent = [];
			reversedImg_i();
			positiveGroup_i();
			
			
			states = [
				new org.flexlite.domUI.states.State ({name: "reversed",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"reversedImg",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "positive",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"positiveGroup",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
					]
				})
			];
		}


		//==========================================================================
		//                                定义成员方法
		//==========================================================================
		private function positiveGroup_i():org.flexlite.domUI.components.Group
		{
			var temp:org.flexlite.domUI.components.Group = new org.flexlite.domUI.components.Group();
			positiveGroup = temp;
			temp.bottom = 0;
			temp.left = 0;
			temp.right = 0;
			temp.top = 0;
			return temp;
		}

		private function reversedImg_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			reversedImg = temp;
			temp.bottom = 0;
			temp.left = 0;
			temp.right = 0;
			temp.skinName = "IMG_Card_cardbg";
			temp.top = 0;
			return temp;
		}

	}
}