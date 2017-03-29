package com.syndrome.sanguo.battle.skin.button
{
	import com.syndrome.sanguo.battle.skin.button.SkipButtonSkin;
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.components.supportClasses.Skin;
	import org.flexlite.domUI.states.AddItems;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class SkipButtonGroupSkin extends org.flexlite.domUI.components.supportClasses.Skin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var skipButton:org.flexlite.domUI.components.Button;

		public var skipMC:org.flexlite.domUI.components.UIMovieClip;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function SkipButtonGroupSkin()
		{
			super();
			
			this.currentState = "normal";
			this.elementsContent = [];
			skipButton_i();
			skipMC_i();
			
			
			states = [
				new org.flexlite.domUI.states.State ({name: "normal",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"skipButton",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
						,
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"skipMC",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
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
		private function skipButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			skipButton = temp;
			temp.horizontalCenter = 0;
			temp.skinName = com.syndrome.sanguo.battle.skin.button.SkipButtonSkin;
			temp.verticalCenter = 0;
			return temp;
		}

		private function skipMC_i():org.flexlite.domUI.components.UIMovieClip
		{
			var temp:org.flexlite.domUI.components.UIMovieClip = new org.flexlite.domUI.components.UIMovieClip();
			skipMC = temp;
			temp.blendMode = "add";
			temp.height = 27;
			temp.horizontalCenter = -0.5;
			temp.mouseEnabled = false;
			temp.skinName = "SWF_Button_SkipMovie";
			temp.verticalCenter = 0.5;
			temp.width = 192;
			return temp;
		}

	}
}