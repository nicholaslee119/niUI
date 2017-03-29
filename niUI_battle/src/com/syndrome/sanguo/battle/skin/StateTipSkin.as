package com.syndrome.sanguo.battle.skin
{
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.UIMovieClip;
	import org.flexlite.domUI.components.supportClasses.Skin;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class StateTipSkin extends org.flexlite.domUI.components.supportClasses.Skin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var currentRound:org.flexlite.domUI.components.Label;

		public var stateMC:org.flexlite.domUI.components.UIMovieClip;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function StateTipSkin()
		{
			super();
			
			this.currentState = "normal";
			this.height = 106;
			this.elementsContent = [stateMC_i(),__StateTipSkin_Label1_i(),currentRound_i()];
			
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
		private function __StateTipSkin_Label1_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			temp.text = "第   回合";
			temp.textAlign = "center";
			temp.textColor = 0xF6C7A5;
			temp.width = 75;
			temp.x = 0;
			temp.y = 3;
			return temp;
		}

		private function currentRound_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			currentRound = temp;
			temp.text = "01";
			temp.textAlign = "center";
			temp.textColor = 0xF6C7A5;
			temp.width = 23;
			temp.x = 21;
			temp.y = 3;
			return temp;
		}

		private function stateMC_i():org.flexlite.domUI.components.UIMovieClip
		{
			var temp:org.flexlite.domUI.components.UIMovieClip = new org.flexlite.domUI.components.UIMovieClip();
			stateMC = temp;
			temp.skinName = "SWF_StateMovie";
			temp.x = 0;
			temp.y = 0;
			return temp;
		}

	}
}