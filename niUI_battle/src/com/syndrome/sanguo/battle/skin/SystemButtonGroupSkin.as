package com.syndrome.sanguo.battle.skin
{
	import com.syndrome.sanguo.battle.skin.button.ExitCombatButtonSkin;
	import com.syndrome.sanguo.battle.skin.button.SystemButtonSkin;
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Spacer;
	import org.flexlite.domUI.components.supportClasses.Skin;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class SystemButtonGroupSkin extends org.flexlite.domUI.components.supportClasses.Skin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var baikeButton:org.flexlite.domUI.components.Button;

		public var configButton:org.flexlite.domUI.components.Button;

		public var exitButton:org.flexlite.domUI.components.Button;

		public var soundButton:org.flexlite.domUI.components.Button;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function SystemButtonGroupSkin()
		{
			super();
			
			this.currentState = "normal";
			this.layout = __SystemButtonGroupSkin_HorizontalLayout1_i();
			this.elementsContent = [__SystemButtonGroupSkin_Spacer1_i(),exitButton_i(),soundButton_i(),configButton_i(),baikeButton_i()];
			
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
		private function __SystemButtonGroupSkin_HorizontalLayout1_i():org.flexlite.domUI.layouts.HorizontalLayout
		{
			var temp:org.flexlite.domUI.layouts.HorizontalLayout = new org.flexlite.domUI.layouts.HorizontalLayout();
			temp.gap = 0;
			return temp;
		}

		private function __SystemButtonGroupSkin_Spacer1_i():org.flexlite.domUI.components.Spacer
		{
			var temp:org.flexlite.domUI.components.Spacer = new org.flexlite.domUI.components.Spacer();
			temp.height = 9;
			temp.width = 8;
			return temp;
		}

		private function baikeButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			baikeButton = temp;
			temp.label = "游戏百科";
			temp.skinName = com.syndrome.sanguo.battle.skin.button.SystemButtonSkin;
			temp.x = 188;
			return temp;
		}

		private function configButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			configButton = temp;
			temp.label = "系统设置";
			temp.skinName = com.syndrome.sanguo.battle.skin.button.SystemButtonSkin;
			temp.x = 150;
			temp.y = 2;
			return temp;
		}

		private function exitButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			exitButton = temp;
			temp.label = "退出游戏";
			temp.skinName = com.syndrome.sanguo.battle.skin.button.ExitCombatButtonSkin;
			temp.x = -24;
			temp.y = 6;
			return temp;
		}

		private function soundButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			soundButton = temp;
			temp.label = "关闭音乐";
			temp.skinName = com.syndrome.sanguo.battle.skin.button.SystemButtonSkin;
			temp.x = 91;
			temp.y = 6;
			return temp;
		}

	}
}