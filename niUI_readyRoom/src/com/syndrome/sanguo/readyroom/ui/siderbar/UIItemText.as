package com.syndrome.sanguo.readyroom.ui.siderbar
{
	import com.syndrome.sanguo.classlib.UIItemBase;
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class UIItemText extends UIItemBase
	{
		private var name:String;
		private var content:String;
		
		public function UIItemText(_name:String, _content:String)
		{
			name = _name;
			content = _content;
			super("uiItemText");
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			if(ui==null) ui = new TextField();
			var styleFormat:TextFormat = new TextFormat();
			styleFormat.font = "宋体";
			styleFormat.size = 12;
			TextField(ui).defaultTextFormat = styleFormat;
			TextField(ui).textColor = 0xffffff;
			TextField(ui).autoSize = TextFieldAutoSize.LEFT;
			TextField(ui).wordWrap = true;
			if(name=="战斗消息")
				TextField(ui).htmlText = content;
			else
				TextField(ui).text = name+":"+content;
			TextField(ui).width = 240;
		}
	}
}