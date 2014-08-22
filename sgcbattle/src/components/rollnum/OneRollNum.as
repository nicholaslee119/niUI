package components.rollnum
{
	import flash.events.Event;
	import flash.text.TextFormat;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.effects.animation.Animation;
	import org.flexlite.domUI.effects.animation.MotionPath;
	import org.flexlite.domUI.events.UIEvent;
	import org.flexlite.domUI.layouts.VerticalLayout;
	
	public class OneRollNum extends Group
	{
		private var labelArr:Array = [];
		public var currentNum:int = 0;
		public var rollWay:Boolean;
		private var dura:Number = 100;
		public var hasCreationComplete:Boolean = false;
		
		private var vgroup:Group;
		
		public function OneRollNum()
		{
			super();
			this.clipAndEnableScrolling = true;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			vgroup = new Group();
			vgroup.addEventListener(UIEvent.CREATION_COMPLETE , labelGroupCreateComplete);
			var ver:VerticalLayout = new VerticalLayout();
			ver.gap = 0;
			vgroup.layout = ver;
			this.addElement(vgroup);
		}
		
		private function init() : void
		{
			var i:int = 0;
			while (i < 6)
			{
				var label:Label = new Label();
				label.text = this.currentNum.toString();
				label.setFormatOfRange(textFormat);
				label.width = this.width;
				label.height = this.height;
				label.textAlign = "center";
				label.verticalAlign = "middle";
				this.vgroup.addElement(label);
				this.labelArr.push(label);
				i++;
			}
		}
		
		protected function labelGroupCreateComplete(event:UIEvent):void
		{
			this.hasCreationComplete = true;
			this.init();
		}		
		
		public function set rollDura(param1:Number) : void
		{
			this.dura = param1;
		}
		
		public function set originalNum(param1:int) : void
		{
			var label:Label;
			this.currentNum = param1;
			for each (label in this.labelArr)
			{
				label.text = this.currentNum.toString();
				label.setFormatOfRange(textFormat);
			}
		}
		
		public function set num(number:int) : void
		{
			var index:int = 0;
			number = number % 10;
			if (number == this.currentNum)
			{
				return;
			}
			if (!this.hasCreationComplete)
			{
				this.currentNum = number;
				return;
			}
			var changeNum:int = Math.abs(number - this.currentNum);
			if (changeNum >= 5)
			{
				this.rollWay = number > this.currentNum ? (true) : (false);
				changeNum = 10 - changeNum;
			}
			else
			{
				this.rollWay = number > this.currentNum ? (false) : (true);
			}
			
			var yFrom:Number;
			var yTo:Number;
			if (this.rollWay)
			{
				yFrom = -this.labelArr[5].y;
				yTo = yFrom + this.labelArr[changeNum].y;
				index = 5;
				while (index >= 0)
				{
					this.labelArr[index].text = this.currentNum.toString();
					this.labelArr[index].setFormatOfRange(textFormat);
					if(this.currentNum == 0){
						this.currentNum = 9;
					}else{
						this.currentNum --;
					}
					index = index - 1;
				}
			}
			else
			{
				yFrom = 0;
				yTo = -this.labelArr[changeNum].y;
				index = 0;
				while (index < 6)
				{
					
					this.labelArr[index].text = this.currentNum.toString();
					this.labelArr[index].setFormatOfRange(textFormat);
					if(this.currentNum == 9){
						this.currentNum = 0;
					}else{
						this.currentNum ++;
					}
					index++;
				}
			}
			this.vgroup.y = yFrom;
			
			var updateFunction:Function = function(animation:Animation):void
			{
				vgroup.y = animation.currentValue["y"];
			};
			var endFunction:Function = function(animation:Animation):void
			{
				dispatchEvent(new Event("rollEffectEnd"));
			};
			
			var animation:Animation = new Animation(updateFunction);
			animation.endFunction = endFunction;
			animation.duration = this.dura*changeNum;
			animation.motionPaths = new <MotionPath>[new MotionPath("y",yFrom , yTo)];
			animation.play();
			this.currentNum = number;
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
			for (var i:int = 0; i < labelArr.length; i++) 
			{
				(labelArr[i]).setFormatOfRange(_textFormat);
			}
		}
	}
}