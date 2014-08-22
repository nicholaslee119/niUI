package com.syndrome.sanguo.record.components.skin
{
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.DropDownList;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.StateSkin;
	import org.flexlite.domUI.components.TextInput;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class StartPageSkin extends org.flexlite.domUI.components.StateSkin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var loadButton:org.flexlite.domUI.components.Button;

		public var pathTextInput:org.flexlite.domUI.components.TextInput;

		public var playerDropDownList:org.flexlite.domUI.components.DropDownList;

		public var startButton:org.flexlite.domUI.components.Button;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function StartPageSkin()
		{
			super();
			
			this.currentState = "normal";
			this.height = 148;
			this.width = 400;
			this.elementsContent = [loadButton_i(),pathTextInput_i(),startButton_i(),__StartPageSkin_Label1_i(),playerDropDownList_i()];
			
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
		private function __StartPageSkin_Label1_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			temp.text = "请选择视角:";
			temp.x = 75;
			temp.y = 66;
			return temp;
		}

		private function loadButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			loadButton = temp;
			temp.label = "载入录像";
			temp.x = 293;
			temp.y = 4;
			return temp;
		}

		private function pathTextInput_i():org.flexlite.domUI.components.TextInput
		{
			var temp:org.flexlite.domUI.components.TextInput = new org.flexlite.domUI.components.TextInput();
			pathTextInput = temp;
			temp.editable = false;
			temp.width = 248;
			temp.x = 35;
			temp.y = 4;
			return temp;
		}

		private function playerDropDownList_i():org.flexlite.domUI.components.DropDownList
		{
			var temp:org.flexlite.domUI.components.DropDownList = new org.flexlite.domUI.components.DropDownList();
			playerDropDownList = temp;
			temp.width = 136;
			temp.x = 148;
			temp.y = 61;
			return temp;
		}

		private function startButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			startButton = temp;
			temp.label = "开始回放";
			temp.x = 169;
			temp.y = 121;
			return temp;
		}

	}
}