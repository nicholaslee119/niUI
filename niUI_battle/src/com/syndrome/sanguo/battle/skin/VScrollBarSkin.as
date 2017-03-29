package com.syndrome.sanguo.battle.skin
{
	import com.syndrome.sanguo.battle.skin.button.VScrollBarDownSkin;
	import com.syndrome.sanguo.battle.skin.button.VScrollBarTarackButtonSkin;
	import com.syndrome.sanguo.battle.skin.button.VScrollBarThumbButtonSkin;
	import com.syndrome.sanguo.battle.skin.button.VScrollBarUpButtonSkin;
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.StateSkin;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class VScrollBarSkin extends org.flexlite.domUI.components.StateSkin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var decrementButton:org.flexlite.domUI.components.Button;

		public var incrementButton:org.flexlite.domUI.components.Button;

		public var thumb:org.flexlite.domUI.components.Button;

		public var track:org.flexlite.domUI.components.Button;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function VScrollBarSkin()
		{
			super();
			
			this.currentState = "normal";
			this.height = 130;
			this.elementsContent = [decrementButton_i(),incrementButton_i(),track_i(),thumb_i()];
			
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
		private function decrementButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			decrementButton = temp;
			temp.label = "按钮";
			temp.skinName = com.syndrome.sanguo.battle.skin.button.VScrollBarUpButtonSkin;
			temp.top = 0;
			return temp;
		}

		private function incrementButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			incrementButton = temp;
			temp.bottom = 0;
			temp.label = "按钮";
			temp.skinName = com.syndrome.sanguo.battle.skin.button.VScrollBarDownSkin;
			temp.x = 0;
			return temp;
		}

		private function thumb_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			thumb = temp;
			temp.label = "按钮";
			temp.minHeight = 15;
			temp.skinName = com.syndrome.sanguo.battle.skin.button.VScrollBarThumbButtonSkin;
			temp.x = 0;
			temp.y = 76;
			return temp;
		}

		private function track_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			track = temp;
			temp.bottom = 21;
			temp.label = "按钮";
			temp.skinName = com.syndrome.sanguo.battle.skin.button.VScrollBarTarackButtonSkin;
			temp.top = 21;
			temp.x = 0;
			return temp;
		}

	}
}