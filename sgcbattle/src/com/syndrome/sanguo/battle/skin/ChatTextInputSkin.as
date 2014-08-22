package com.syndrome.sanguo.battle.skin
{
	import org.flexlite.domUI.components.EditableText;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.StateSkin;
	import org.flexlite.domUI.states.AddItems;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class ChatTextInputSkin extends org.flexlite.domUI.components.StateSkin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var promptDisplay:org.flexlite.domUI.components.Label;

		public var textDisplay:org.flexlite.domUI.components.EditableText;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function ChatTextInputSkin()
		{
			super();
			
			this.currentState = "normal";
			this.elementsContent = [textDisplay_i()];
			promptDisplay_i();
			
			
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
				,
				new org.flexlite.domUI.states.State ({name: "normalWithPrompt",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"promptDisplay",
							propertyName:"",
							position:"last",
							relativeTo:""
						})
					]
				})
				,
				new org.flexlite.domUI.states.State ({name: "disabledWithPrompt",
					overrides: [
						new org.flexlite.domUI.states.AddItems().initializeFromObject({
							target:"promptDisplay",
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
		private function promptDisplay_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			promptDisplay = temp;
			temp.bottom = 0;
			temp.left = 0;
			temp.mouseChildren = false;
			temp.mouseEnabled = false;
			temp.right = 0;
			temp.top = 0;
			return temp;
		}

		private function textDisplay_i():org.flexlite.domUI.components.EditableText
		{
			var temp:org.flexlite.domUI.components.EditableText = new org.flexlite.domUI.components.EditableText();
			textDisplay = temp;
			temp.horizontalCenter = 0;
			temp.left = 1;
			temp.right = 1;
			temp.y = 0;
			return temp;
		}

	}
}