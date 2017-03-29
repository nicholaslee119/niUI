package com.syndrome.sanguo.battle.skin
{
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.StateSkin;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.states.AddItems;
	import org.flexlite.domUI.states.SetProperty;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class CardRoundCountSkin extends org.flexlite.domUI.components.StateSkin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var __CardRoundCountSkin_UIAsset1:org.flexlite.domUI.components.UIAsset;

		public var __CardRoundCountSkin_UIAsset2:org.flexlite.domUI.components.UIAsset;

		public var numLabel:org.flexlite.domUI.components.Label;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function CardRoundCountSkin()
		{
			super();
			
			this.currentState = "normal";
			this.elementsContent = [];
			__CardRoundCountSkin_UIAsset1_i();
			__CardRoundCountSkin_UIAsset2_i();
			numLabel_i();
			
			
			states = [
				new org.flexlite.domUI.states.State ({name: "normal",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__CardRoundCountSkin_UIAsset1",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
						,
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"numLabel",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
						,
						new org.flexlite.domUI.states.SetProperty().initializeFromObject({
							target:"numLabel",
							name:"textAlign",
							value:"center"
						})
						,
						new org.flexlite.domUI.states.SetProperty().initializeFromObject({
							target:"numLabel",
							name:"x",
							value:12
						})
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "disabled",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__CardRoundCountSkin_UIAsset1",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
						,
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"numLabel",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
						,
						new org.flexlite.domUI.states.SetProperty().initializeFromObject({
							target:"__CardRoundCountSkin_UIAsset2",
							name:"visible",
							value:false
						})
						,
						new org.flexlite.domUI.states.SetProperty().initializeFromObject({
							target:"numLabel",
							name:"text",
							value:"3"
						})
						,
						new org.flexlite.domUI.states.SetProperty().initializeFromObject({
							target:"numLabel",
							name:"x",
							value:12
						})
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "forever",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"__CardRoundCountSkin_UIAsset2",
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
		private function __CardRoundCountSkin_UIAsset1_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			__CardRoundCountSkin_UIAsset1 = temp;
			temp.skinName = "IMG_Card_count";
			temp.x = 0;
			temp.y = 0;
			return temp;
		}

		private function __CardRoundCountSkin_UIAsset2_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			__CardRoundCountSkin_UIAsset2 = temp;
			temp.skinName = "IMG_Card_forerver";
			temp.x = 0;
			temp.y = 0;
			return temp;
		}

		private function numLabel_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			numLabel = temp;
			temp.bold = true;
			temp.text = "2";
			temp.textColor = 0xffffff;
			temp.x = 13;
			temp.y = 8;
			return temp;
		}

	}
}