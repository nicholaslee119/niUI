package components.rollnum
{
	import flash.events.Event;
	import flash.text.TextFormat;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.layouts.HorizontalAlign;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	import org.flexlite.domUI.layouts.VerticalAlign;
	
	/**
	 * 可滚动的数字容器
	 */
	public class RollNumGroup extends Group
	{
		protected var currentNum:int = -1;
		protected var rollNumWindows:Array = [];
		protected var _rollDuration:Number = 250;
		protected var _moveDuration:Number = 200;
		
		public function RollNumGroup()
		{
			super();
			var horizontalLayout:HorizontalLayout = new HorizontalLayout();
			horizontalLayout.horizontalAlign = HorizontalAlign.CENTER;
			horizontalLayout.verticalAlign = VerticalAlign.MIDDLE;
			horizontalLayout.gap = 0;
			this.layout = horizontalLayout;
		}
		
		public function setNum(num:int , playEffect:Boolean = true) : void
		{
			this.currentNum = num;
			var numString:String = num.toString();
			var windowNum:int = this.rollNumWindows.length;
			while (windowNum < numString.length)
			{
				this.createRollNumWindow();
				windowNum++;
			}
			var windows:Array = this.rollNumWindows.slice();
			var index:int = 0;
			while (index < windows.length)
			{
				var rollNum:OneRollNum = windows[index] as OneRollNum;
				if (index >= numString.length)
				{
					rollNum = windows[index] as OneRollNum;
					this.removeElement(rollNum);
					this.rollNumWindows.splice(this.rollNumWindows.indexOf(rollNum), 1);
				}
				else if (rollNum.hasCreationComplete && playEffect)
				{
					(rollNum).num = int(numString.charAt(numString.length - index - 1));
				}
				else
				{
					(rollNum).originalNum = int(numString.charAt(numString.length - index - 1));
				}
				index++;
			}
		}
		
		protected function rollEffectEnd(event:Event) : void
		{
			if (this.currentNum == 0 && this.rollNumWindows.length == 1)
			{
				return;
			}
			var rollNum:OneRollNum = event.currentTarget as OneRollNum;
			var rollNumIndex:int = this.rollNumWindows.indexOf(rollNum);
			if (rollNumIndex >= this.currentNum.toString().length)
			{
				this.removeElement(rollNum);
				this.rollNumWindows.splice(rollNumIndex, 1);
			}
		}
		
		protected function createRollNumWindow() : void
		{
			var rollNum:OneRollNum = new OneRollNum();
			rollNum.textFormat = textFormat;
			rollNum.width = Number(textFormat.size)-4;
			rollNum.height = Number(textFormat.size)+2;
			rollNum.rollDura = this._rollDuration;
			rollNum.addEventListener("rollEffectEnd", this.rollEffectEnd);
			this.addElementAt(rollNum,0);
			this.rollNumWindows.push(rollNum);
		}
		
		public function getNum() : int
		{
			return this.currentNum;
		}

		public function get rollDuration():Number
		{
			return _rollDuration;
		}

		public function set rollDuration(value:Number):void
		{
			_rollDuration = value;
		}

		public function get moveDuration():Number
		{
			return _moveDuration;
		}

		public function set moveDuration(value:Number):void
		{
			_moveDuration = value;
		}

		private var _textFormat:TextFormat;
		public function get textFormat():TextFormat
		{
			if(_textFormat == null){
				_textFormat = new TextFormat("Times New Roman",15,0,false);
			}
			return _textFormat;
		}

		public function set textFormat(value:TextFormat):void
		{
			_textFormat = value;
			for (var i:int = 0; i < rollNumWindows.length; i++) 
			{
				(rollNumWindows[i] as OneRollNum).textFormat = value;
			}
		}
	}
}