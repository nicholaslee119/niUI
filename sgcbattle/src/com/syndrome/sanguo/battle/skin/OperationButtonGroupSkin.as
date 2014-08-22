package com.syndrome.sanguo.battle.skin
{
	import com.syndrome.sanguo.battle.skin.button.BFBQButtonSkin;
	import com.syndrome.sanguo.battle.skin.button.FJButtonSkin;
	import com.syndrome.sanguo.battle.skin.button.FMButtonSkin;
	import com.syndrome.sanguo.battle.skin.button.QJButtonSkin;
	import com.syndrome.sanguo.battle.skin.button.QZButtonSkin;
	import com.syndrome.sanguo.battle.skin.button.ZBButtonSkin;
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.supportClasses.Skin;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class OperationButtonGroupSkin extends org.flexlite.domUI.components.supportClasses.Skin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var bfbqButton:org.flexlite.domUI.components.Button;

		public var fjButton:org.flexlite.domUI.components.Button;

		public var fmButton:org.flexlite.domUI.components.Button;

		public var qjButton:org.flexlite.domUI.components.Button;

		public var qzButton:org.flexlite.domUI.components.Button;

		public var zbButton:org.flexlite.domUI.components.Button;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function OperationButtonGroupSkin()
		{
			super();
			
			this.currentState = "normal";
			this.height = 155;
			this.width = 774;
			this.elementsContent = [bfbqButton_i(),qjButton_i(),fjButton_i(),fmButton_i(),qzButton_i(),zbButton_i()];
			
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
		private function bfbqButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			bfbqButton = temp;
			temp.skinName = com.syndrome.sanguo.battle.skin.button.BFBQButtonSkin;
			temp.x = 13;
			temp.y = 75;
			return temp;
		}

		private function fjButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			fjButton = temp;
			temp.skinName = com.syndrome.sanguo.battle.skin.button.FJButtonSkin;
			temp.x = 13;
			temp.y = 43;
			return temp;
		}

		private function fmButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			fmButton = temp;
			temp.skinName = com.syndrome.sanguo.battle.skin.button.FMButtonSkin;
			temp.x = 19;
			temp.y = 107;
			return temp;
		}

		private function qjButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			qjButton = temp;
			temp.skinName = com.syndrome.sanguo.battle.skin.button.QJButtonSkin;
			temp.x = 20;
			temp.y = 10;
			return temp;
		}

		private function qzButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			qzButton = temp;
			temp.skinName = com.syndrome.sanguo.battle.skin.button.QZButtonSkin;
			temp.x = 731;
			temp.y = 75;
			return temp;
		}

		private function zbButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			zbButton = temp;
			temp.skinName = com.syndrome.sanguo.battle.skin.button.ZBButtonSkin;
			temp.x = 731;
			temp.y = 9;
			return temp;
		}

	}
}