package com.syndrome.sanguo.battle.skin
{
	import com.syndrome.sanguo.battle.skin.ChatTabButtonSkin;
	import com.syndrome.sanguo.battle.skin.ChatTextInputSkin;
	import com.syndrome.sanguo.battle.skin.button.ChatEnterButtonSkin;
	import components.chatrichtext.ChatRichTextUI;
	import org.flexlite.domUI.collections.ArrayCollection;
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Scroller;
	import org.flexlite.domUI.components.StateSkin;
	import org.flexlite.domUI.components.TabBar;
	import org.flexlite.domUI.components.TextInput;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.ViewStack;

	/**
	 * @private
	 * 此类由编译器自动生成，您应修改对应的DXML文件内容，然后重新编译，而不应直接修改其代码。
	 * @author DXMLCompiler
	 */
	public class ChatGroupSkin extends org.flexlite.domUI.components.StateSkin
	{
		//==========================================================================
		//                                定义成员变量
		//==========================================================================
		public var arr:org.flexlite.domUI.collections.ArrayCollection;

		public var chatInput:org.flexlite.domUI.components.TextInput;

		public var chatRichTextUI:components.chatrichtext.ChatRichTextUI;

		public var chatScroller:org.flexlite.domUI.components.Scroller;

		public var chatTabBar:org.flexlite.domUI.components.TabBar;

		public var histroyRichTextUI:components.chatrichtext.ChatRichTextUI;

		public var histroyScroller:org.flexlite.domUI.components.Scroller;

		public var sendButton:org.flexlite.domUI.components.Button;

		public var viewStack:org.flexlite.domUI.components.ViewStack;


		//==========================================================================
		//                                定义构造函数
		//==========================================================================
		public function ChatGroupSkin()
		{
			super();
			
			this.width = 324;
			arr_i();
			this.elementsContent = [__ChatGroupSkin_UIAsset1_i(),chatTabBar_i(),viewStack_i()];
			
		}


		//==========================================================================
		//                                定义成员方法
		//==========================================================================
		private function __ChatGroupSkin_Group1_i():org.flexlite.domUI.components.Group
		{
			var temp:org.flexlite.domUI.components.Group = new org.flexlite.domUI.components.Group();
			temp.percentHeight = 100;
			temp.name = "战场记录";
			temp.percentWidth = 100;
			temp.elementsContent = [histroyScroller_i()];
			return temp;
		}

		private function __ChatGroupSkin_Group2_i():org.flexlite.domUI.components.Group
		{
			var temp:org.flexlite.domUI.components.Group = new org.flexlite.domUI.components.Group();
			temp.elementsContent = [histroyRichTextUI_i()];
			return temp;
		}

		private function __ChatGroupSkin_Group3_i():org.flexlite.domUI.components.Group
		{
			var temp:org.flexlite.domUI.components.Group = new org.flexlite.domUI.components.Group();
			temp.percentHeight = 100;
			temp.name = "聊天";
			temp.percentWidth = 100;
			temp.elementsContent = [__ChatGroupSkin_UIAsset2_i(),sendButton_i(),chatInput_i(),chatScroller_i()];
			return temp;
		}

		private function __ChatGroupSkin_Group4_i():org.flexlite.domUI.components.Group
		{
			var temp:org.flexlite.domUI.components.Group = new org.flexlite.domUI.components.Group();
			temp.elementsContent = [chatRichTextUI_i()];
			return temp;
		}

		private function __ChatGroupSkin_UIAsset1_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.height = 265;
			temp.includeInLayout = false;
			temp.skinName = "IMG_Main_ChatBackGround";
			temp.top = 0;
			temp.width = 326;
			temp.x = 0;
			return temp;
		}

		private function __ChatGroupSkin_UIAsset2_i():org.flexlite.domUI.components.UIAsset
		{
			var temp:org.flexlite.domUI.components.UIAsset = new org.flexlite.domUI.components.UIAsset();
			temp.skinName = "IMG_Chat_InputBackGround";
			temp.x = 4;
			temp.y = 165;
			return temp;
		}

		private function arr_i():org.flexlite.domUI.collections.ArrayCollection
		{
			var temp:org.flexlite.domUI.collections.ArrayCollection = new org.flexlite.domUI.collections.ArrayCollection();
			arr = temp;
			temp.source = ['战场记录','对战','世界','私聊'];
			return temp;
		}

		private function chatInput_i():org.flexlite.domUI.components.TextInput
		{
			var temp:org.flexlite.domUI.components.TextInput = new org.flexlite.domUI.components.TextInput();
			chatInput = temp;
			temp.height = 19;
			temp.prompt = "请输入文本";
			temp.skinName = com.syndrome.sanguo.battle.skin.ChatTextInputSkin;
			temp.width = 275;
			temp.x = 8;
			temp.y = 168;
			return temp;
		}

		private function chatRichTextUI_i():components.chatrichtext.ChatRichTextUI
		{
			var temp:components.chatrichtext.ChatRichTextUI = new components.chatrichtext.ChatRichTextUI();
			chatRichTextUI = temp;
			temp.left = 25;
			temp.width = 265;
			return temp;
		}

		private function chatScroller_i():org.flexlite.domUI.components.Scroller
		{
			var temp:org.flexlite.domUI.components.Scroller = new org.flexlite.domUI.components.Scroller();
			chatScroller = temp;
			temp.height = 162;
			temp.horizontalScrollPolicy = "off";
			temp.percentWidth = 100;
			temp.x = 0;
			temp.y = 0;
			temp.viewport = __ChatGroupSkin_Group4_i();
			return temp;
		}

		private function chatTabBar_i():org.flexlite.domUI.components.TabBar
		{
			var temp:org.flexlite.domUI.components.TabBar = new org.flexlite.domUI.components.TabBar();
			chatTabBar = temp;
			temp.dataProvider = arr;
			temp.itemRendererSkinName = com.syndrome.sanguo.battle.skin.ChatTabButtonSkin;
			temp.left = 11;
			temp.top = 9;
			return temp;
		}

		private function histroyRichTextUI_i():components.chatrichtext.ChatRichTextUI
		{
			var temp:components.chatrichtext.ChatRichTextUI = new components.chatrichtext.ChatRichTextUI();
			histroyRichTextUI = temp;
			temp.left = 25;
			temp.width = 265;
			return temp;
		}

		private function histroyScroller_i():org.flexlite.domUI.components.Scroller
		{
			var temp:org.flexlite.domUI.components.Scroller = new org.flexlite.domUI.components.Scroller();
			histroyScroller = temp;
			temp.percentHeight = 100;
			temp.horizontalScrollPolicy = "off";
			temp.percentWidth = 100;
			temp.x = 0;
			temp.y = 0;
			temp.viewport = __ChatGroupSkin_Group2_i();
			return temp;
		}

		private function sendButton_i():org.flexlite.domUI.components.Button
		{
			var temp:org.flexlite.domUI.components.Button = new org.flexlite.domUI.components.Button();
			sendButton = temp;
			temp.skinName = com.syndrome.sanguo.battle.skin.button.ChatEnterButtonSkin;
			temp.x = 284;
			temp.y = 168;
			return temp;
		}

		private function viewStack_i():org.flexlite.domUI.components.ViewStack
		{
			var temp:org.flexlite.domUI.components.ViewStack = new org.flexlite.domUI.components.ViewStack();
			viewStack = temp;
			temp.height = 189;
			temp.selectedIndex = 1;
			temp.top = 40;
			temp.width = 307;
			temp.x = 8;
			temp.elementsContent = [__ChatGroupSkin_Group1_i(),__ChatGroupSkin_Group3_i()];
			return temp;
		}

	}
}