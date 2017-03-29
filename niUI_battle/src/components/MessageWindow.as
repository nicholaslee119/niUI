package components
{
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.PopUpGroup;
	import com.syndrome.sanguo.battle.skin.MessageWindowSkin;
	
	import flash.events.MouseEvent;
	
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.TitleWindow;
	import org.flexlite.domUI.core.IVisualElementContainer;
	
	public class MessageWindow extends TitleWindow
	{
		private static var _instance:MessageWindow;
		
		public static const COMFIRM:String = "confirm";		
		public static const CANCEL:String = "cancel";		

		public var confirmButton:Button;
		public var cancelButton:Button;
		public var labelDisplay:Label;
		
		private var _message:String = "";
		private var _clickHandler:Function;
		private var _clickClose:Boolean = true;
		
		private var confirmVisible:Boolean = true;
		private var cancelVisible:Boolean = true;
		
		public function MessageWindow()
		{
			super();
			this.skinName = MessageWindowSkin;
		}
		
		/**
		 * 弹出Alert控件的静态方法。在Alert控件中选择一个按钮，将关闭该控件。
		 * @param text 要显示的文本内容字符串。
		 * @param title 对话框标题
		 * @param clickHandler 按下MessageWindow控件上的任意按钮时的回调函数。参数为 clickHandler(detail:String):void 或者 clickHandler(detail:String , messageWindow:MessageWindow):void
		 * @param confirmVisible 确定按钮是否可见
		 * @param cancelVisible 取消按钮是否可见
		 * @param clickClose 点击后是否关闭 ，默认true
		 * @return 弹出的对话框实例的引用
		 */
		public static function show(text:String="",title:String="",clickHandler:Function=null,
									confirmVisible:Boolean = true , cancelVisible:Boolean = true , clickClose:Boolean = true
									,center:Boolean=true):MessageWindow
		{
			if(!_instance){
				_instance = new MessageWindow();
			}else{
				if(_instance.parent != null){
					(_instance.parent as IVisualElementContainer).removeElement(_instance);
				}
			}
			_instance.message = text;
			_instance.title = title;
			_instance.clickHandler = clickHandler;
			_instance.confirmVisible = confirmVisible;
			_instance.cancelVisible = cancelVisible;
			_instance.clickClose = clickClose;
			PopUpGroup.getInstance().addPopUp(_instance , center);
			return _instance;
		}
		
		/**
		 * 点击后是否关闭 ，默认true
		 */
		public function get clickClose():Boolean
		{
			return _clickClose;
		}
		
		public function set clickClose(value:Boolean):void
		{
			_clickClose = value;
		}
		
		/**
		 * 点击按钮的回调函数 , 参数为 clickHandler(detail:String):void 或者 clickHandler(detail:String , messageWindow:MessageWindow):void
		 */
		public function get clickHandler():Function
		{
			return _clickHandler;
		}
		
		public function set clickHandler(value:Function):void
		{
			if(_clickHandler == value){
				return
			}
			_clickHandler = value;
		}
		
		/**
		 * 要显示的消息内容
		 */
		public function get message():String
		{
			return _message;
		}
		public function set message(value:String):void
		{
			if(_message==value)
				return;
			_message = value;
			if(labelDisplay)
				labelDisplay.text = _message;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName,instance);
			if(instance==confirmButton)
			{
				confirmButton.visible = confirmButton.includeInLayout = confirmVisible;
				confirmButton.addEventListener(MouseEvent.CLICK,onClick);
			}
			else if(instance==cancelButton)
			{
				cancelButton.visible = cancelButton.includeInLayout = cancelVisible;
				cancelButton.addEventListener(MouseEvent.CLICK,onClick);
			}
			else if(instance==labelDisplay)
			{
				labelDisplay.text = _message;
			}
		}
		
		/**
		 * 关闭事件
		 */		
		private function onClick(event:MouseEvent):void
		{
			if(clickHandler!=null)
			{
				var detail:String = "";
				switch(event.currentTarget)
				{
					case confirmButton:
						detail = MessageWindow.COMFIRM;
						break;
					case cancelButton:
						detail = MessageWindow.CANCEL;
						break;
				}
				if(clickHandler.length ==1){
					clickHandler(detail);
				}else if(clickHandler.length ==2){
					clickHandler(detail , this);
				}else{
					throw(new Error("clickHandler参数数量不正确"));
				}
			}
			if(clickClose && parent != null){
				(this.parent as IVisualElementContainer).removeElement(this);
			}
		}
	}
}