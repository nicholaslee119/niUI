package components.chatrichtext
{
	import components.chatrichtext.com.riaidea.text.RichTextField;
	
	import flash.events.Event;
	
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.core.UIComponent;
	import org.flexlite.domUI.events.ResizeEvent;
	
	public class ChatRichTextUI extends UIAsset
	{
		protected var _richTextField:RichTextField;

		public function ChatRichTextUI()
		{
			super();
			_richTextField = new RichTextField();
			_richTextField.html = true;
			this.skinName = _richTextField;
			this.addEventListener(ResizeEvent.RESIZE , sizeChange);
			_richTextField.textfield.addEventListener(Event.CHANGE , changeHandler);
		}
		
		/**
		 * 清除所有文本和显示元素。
		 */
		public function clear():void
		{
			_richTextField.clear();
			invalidateSize();
		}
		
		/**
		 * 追加newText参数指定的文本和newSprites参数指定的显示元素到文本字段的末尾。
		 * @param	htmlText 要追加的新文本。
		 * @param	newSprites 要追加的显示元素数组，每个元素包含src和index两个属性，如：{src:sprite, index:1}。
		 * @param	autoWordWrap 指示是否自动换行。
		 * @param	format 应用于追加的新文本的格式。
		 */
		public function append(htmlText:String):void
		{
			_richTextField.append(htmlText , null);
			invalidateSize();
		}
		
		/**
		 * 导出XML格式的RichTextField的文本和显示元素内容。
		 * @return
		 */
		public function exportXML():XML
		{
			return _richTextField.exportXML();
		}
		
		/**
		 * 导入指定XML格式的文本和显示元素内容。
		 * @param	data 具有指定格式的XML内容。
		 */
		public function importXML(data:XML):void
		{
			_richTextField.importXML(data);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
//			super.updateDisplayList(unscaledWidth , unscaledHeight);
		}
		
		override protected function measure():void
		{
//			super.measure();
			measuredHeight = _richTextField.textfield.textHeight + 3;
		}
		
		protected function changeHandler(event:Event = null):void
		{
			invalidateSize();
		}
		
		protected function sizeChange(event:ResizeEvent):void
		{
			_richTextField.setSize(width , 10000);
		}
		
		/**
		 * 指示RichTextField的类型。
		 * @default RichTextField.DYNAMIC
		 */
		public function get type():String 
		{ 
			return _richTextField.type;
		}
		
		public function set type(value:String):void 
		{
			_richTextField.type = value;
		}

		public function get richTextField():RichTextField
		{
			return _richTextField;
		}
	}
}