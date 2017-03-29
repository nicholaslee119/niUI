package com.syndrome.sanguo.record.components.skin
{
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.StateSkin;
	import org.flexlite.domUI.layouts.VerticalLayout;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class OperationPanelSkin extends org.flexlite.domUI.components.StateSkin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var nextButton:org.flexlite.domUI.components.Button;

		public var toggleButton:org.flexlite.domUI.components.Button;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function OperationPanelSkin()
		{
			super();
			
			this.currentState = "normal";
			this.elementsContent = [__OperationPanelSkin_Group1_i()];
			
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
		private function __OperationPanelSkin_Group1_i():org.flexlite.domUI.components.Group
		{
			var temp:org.flexlite.domUI.components.Group = new org.flexlite.domUI.components.Group();
			temp.layout = __OperationPanelSkin_VerticalLayout1_i();
			temp.elementsContent = [toggleButton_i(),nextButton_i()];
			return temp;
		}

		private function __OperationPanelSkin_VerticalLayout1_i():org.flexlite.domUI.layouts.VerticalLayout
		{
			var temp:org.flexlite.domUI.layouts.VerticalLayout = new org.flexlite.domUI.layouts.VerticalLayout();
			temp.horizontalAlign = "center";
			return temp;
		}

		private function nextButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			nextButton = temp;
			temp.label = "下一步";
			temp.x = 60;
			temp.y = 101;
			return temp;
		}

		private function toggleButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			toggleButton = temp;
			temp.label = "暂停";
			temp.x = 40;
			temp.y = 2;
			return temp;
		}

	}
}