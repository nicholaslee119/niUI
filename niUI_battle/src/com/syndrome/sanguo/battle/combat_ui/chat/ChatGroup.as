package com.syndrome.sanguo.battle.combat_ui.chat
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.CombatGroup;
	import com.syndrome.sanguo.battle.event.MessageEvent;
	import com.syndrome.sanguo.battle.skin.ChatGroupSkin;
	
	import components.chatrichtext.ChatRichTextUI;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Scroller;
	import org.flexlite.domUI.components.SkinnableComponent;
	import org.flexlite.domUI.components.TabBar;
	import org.flexlite.domUI.components.TextInput;
	import org.flexlite.domUI.components.ViewStack;
	import org.flexlite.domUI.events.IndexChangeEvent;
	import org.flexlite.domUI.utils.callLater;
	
	public class ChatGroup extends SkinnableComponent
	{
		public var viewStack:ViewStack;
		public var chatTabBar:TabBar;
		public var histroyRichTextUI:ChatRichTextUI;
		public var histroyScroller:Scroller;
		public var chatRichTextUI:ChatRichTextUI;
		public var chatScroller:Scroller;
		public var sendButton:Button;
		public var chatInput:TextInput;
		
		/**
		 * 用于转换文本为xml
		 */
		private var tempRichTextUI:ChatRichTextUI;
		
		private var xmlArray:Array = new Array(4);
		
		public function ChatGroup()
		{
			super();
			tempRichTextUI = new ChatRichTextUI();
			this.skinName = ChatGroupSkin;
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName , instance);
			if(instance == viewStack){
			}else if(instance == chatTabBar){
				chatTabBar.addEventListener(IndexChangeEvent.CHANGE , channelChange);
			}else if(instance == sendButton){
				sendButton.addEventListener(MouseEvent.CLICK , sendClick);
			}else if(instance == chatInput){
				chatInput.addEventListener(KeyboardEvent.KEY_DOWN , sendClick);
			}
		}
		
		protected function sendClick(event:Event):void
		{
			if(event is KeyboardEvent && (event as KeyboardEvent).keyCode != Keyboard.ENTER){
				return;
			}
			if(!chatInput.text){
				return;
			}
			
			CombatConsole.getInstance().dispatchEvent(new MessageEvent(MessageEvent.SEND , chatInput.text , chatTabBar.selectedIndex));
//			addText(StringUtils.parseColor("#y"+UserInfo.myNickName + ":" + chatInput.text+"#n") , chatTabBar.selectedIndex);
			chatInput.text = "";
		}
		
		/**
		 * 添加文本
		 */
		public function addText(text:String , index:int):void
		{
			if(chatTabBar.selectedIndex == index)    //添加文本到当前标签页
			{
				if(index == 0){ 
					histroyRichTextUI.append(text);
					setScollerMax(histroyScroller , false);
				}else{
					chatRichTextUI.append(text);
					setScollerMax(chatScroller , false);
				}
			}else  //添加文本到其他标签页
			{
				if(index == 0){ 
					histroyRichTextUI.append(text);
				}else{
					tempRichTextUI.clear();
					if(xmlArray[index]){
						tempRichTextUI.importXML(xmlArray[index] as XML);
					}
					tempRichTextUI.append(text);
					xmlArray[index] = tempRichTextUI.exportXML();
				}
			}
		}
		
		protected function channelChange(event:IndexChangeEvent):void
		{
			if(event.newIndex == 0){
				viewStack.selectedIndex = 0;
				xmlArray[event.oldIndex] = chatRichTextUI.exportXML();
				setScollerMax(histroyScroller);
			}else{
				if(event.oldIndex == 0){
					xmlArray[event.oldIndex] = histroyRichTextUI.exportXML();
				}else{
					xmlArray[event.oldIndex] = chatRichTextUI.exportXML();
				}
				chatRichTextUI.clear();
				if(xmlArray[event.newIndex]){
					chatRichTextUI.importXML(xmlArray[event.newIndex] as XML);
					setScollerMax(chatScroller);
				}
				viewStack.selectedIndex = 1;
			}
		}
		
		/**
		 * 让滚动条滚动到最大值
		 */
		private function setScollerMax(scroller:Scroller , hide:Boolean = true):void
		{
			scroller.viewport.visible = !hide;
			callLater(function():void{
				scroller.viewport.visible = true;
				scroller.verticalScrollBar.value = scroller.verticalScrollBar.maximum;
			},null,1);
		}
		
		public function reset():void
		{
			chatRichTextUI.clear();
			histroyRichTextUI.clear();
			xmlArray.length = 0;
		}
		
		public static function getInstance():ChatGroup
		{
			return CombatGroup.getInstance().chatGroup;
		}
	}
}