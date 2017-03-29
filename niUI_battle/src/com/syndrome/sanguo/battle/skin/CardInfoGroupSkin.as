package com.syndrome.sanguo.battle.skin
{
	import org.flexlite.domUI.collections.ArrayCollection;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.StateSkin;
	import org.flexlite.domUI.components.UIAsset;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class CardInfoGroupSkin extends org.flexlite.domUI.components.StateSkin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var contentGroup:org.flexlite.domUI.components.Group;

		public var dp:org.flexlite.domUI.collections.ArrayCollection;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function CardInfoGroupSkin()
		{
			super();
			
			dp_i();
			this.elementsContent = [__CardInfoGroupSkin_UIAsset1_i(),contentGroup_i(),__CardInfoGroupSkin_UIAsset2_i()];
			
		}


		//==========================================================================
		//                                定义成员方法
		//==========================================================================
		private function __CardInfoGroupSkin_UIAsset1_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.bottom = 0;
			temp.left = 0;
			temp.right = 0;
			temp.skinName = "IMG_Main_CardInfoBackGround";
			temp.top = 0;
			return temp;
		}

		private function __CardInfoGroupSkin_UIAsset2_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.bottom = 0;
			temp.left = 0;
			temp.right = 0;
			temp.skinName = "IMG_Main_CardInfoFrontGround";
			temp.top = 0;
			return temp;
		}

		private function contentGroup_i():org.flexlite.domUI.components.Group
		{
			var temp:org.flexlite.domUI.components.Group = new org.flexlite.domUI.components.Group();
			contentGroup = temp;
			temp.bottom = 0;
			temp.left = 0;
			temp.right = 0;
			temp.top = 0;
			return temp;
		}

		private function dp_i():org.flexlite.domUI.collections.ArrayCollection
		{
			var temp:org.flexlite.domUI.collections.ArrayCollection = new org.flexlite.domUI.collections.ArrayCollection();
			dp = temp;
			temp.source = [1,2,3,5];
			return temp;
		}

	}
}