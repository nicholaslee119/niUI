package com.syndrome.sanguo.battle.skin.guide
{
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.Rect;
	import org.flexlite.domUI.components.StateSkin;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.states.State;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class GuideTipSkin extends org.flexlite.domUI.components.StateSkin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var contentLabel:org.flexlite.domUI.components.Label;

		public var iconUIAsset:org.flexlite.domUI.components.UIAsset;

		public var maskRect:org.flexlite.domUI.components.Rect;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function GuideTipSkin()
		{
			super();
			
			this.currentState = "normal";
			this.elementsContent = [__GuideTipSkin_UIAsset1_i(),iconUIAsset_i(),maskRect_i(),contentLabel_i()];
			
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
		private function __GuideTipSkin_UIAsset1_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.skinName = "IMG_GuideTip";
			temp.x = 0;
			temp.y = 0;
			return temp;
		}

		private function contentLabel_i():org.flexlite.domUI.components.Label
		{
			var temp:org.flexlite.domUI.components.Label = new org.flexlite.domUI.components.Label();
			contentLabel = temp;
			temp.height = 69;
			temp.maxDisplayedLines = 3;
			temp.text = "标签";
			temp.verticalAlign = "middle";
			temp.width = 446;
			temp.x = 59;
			temp.y = 28;
			return temp;
		}

		private function iconUIAsset_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			iconUIAsset = temp;
			temp.height = 100;
			temp.mask = maskRect;
			temp.width = 100;
			temp.x = -51;
			temp.y = -51;
			return temp;
		}

		private function maskRect_i():org.flexlite.domUI.components.Rect
		{
			var temp:org.flexlite.domUI.components.Rect = new org.flexlite.domUI.components.Rect();
			maskRect = temp;
			temp.height = 100;
			temp.radius = 50;
			temp.width = 100;
			temp.x = -51;
			temp.y = -51;
			if(iconUIAsset)
			{
				iconUIAsset.mask = maskRect;
			}
			return temp;
		}

	}
}