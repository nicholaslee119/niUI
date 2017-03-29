package com.syndrome.sanguocard.uiclass
{
	import com.syndrome.sanguo.classlib.UISpriteWithChildren;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class UISpriteWithSlider extends UISpriteWithChildren
	{
		private var sliderLength:Number = 0;  
		private var y:Number = 0;
		private var rect:Rectangle = null;
		private var _autoRoll:Boolean = false;
		public var defineY:Number = Number.NEGATIVE_INFINITY;
		
		public function UISpriteWithSlider(_type:String, _sprite:*, _children:*)
		{
			super(_type, _sprite, _children);
		}
		
		override protected function init():void
		{
			// TODO Auto Generated method stub
			super.init();
			sprite.container.mask =  sprite.myMask;
			sliderLength = (sprite.slider.btn_down.y-sprite.slider.btn_up.y)-(sprite.slider.block.height+sprite.slider.btn_up.height);
			rect = new Rectangle(0, sprite.slider.btn_up.height, 0, sliderLength);
			sprite.slider.btn_up.addEventListener(MouseEvent.CLICK, onSliderUpClick);
			sprite.slider.btn_down.addEventListener(MouseEvent.CLICK, onSliderDownClick);
			sprite.slider.block.addEventListener(MouseEvent.MOUSE_DOWN, onBlockDown);
			sprite.container.addEventListener(MouseEvent.MOUSE_WHEEL, onWheel, true);
		}
		
		private function onWheel(e:MouseEvent):void
		{
			var tempEvent:MouseEvent = new MouseEvent(MouseEvent.CLICK);
			if(e.delta<0)
			{
				onSliderDownClick(tempEvent);
			}else{ 
				onSliderUpClick(tempEvent);
			}
		}
		
		private function onBlockDown(e:MouseEvent):void
		{
			e.stopPropagation();
			sprite.slider.block.startDrag(false, rect);
			sprite.stage.addEventListener(MouseEvent.MOUSE_UP, onBlockUp);
			sprite.stage.addEventListener(MouseEvent.MOUSE_MOVE, onBlockDownMove);
		}
		
		private function onBlockDownMove(e:MouseEvent):void
		{
			sprite.container.y = sprite.myMask.y - (sprite.container.height-sprite.myMask.height) * blockPosition();
		}
		
		private function blockPosition():Number
		{
			if(sprite.container.height<=sprite.myMask.height)
				return 0;
			else
				return (sprite.slider.block.y-sprite.slider.btn_up.y-sprite.slider.btn_up.height)/sliderLength;
		}
		
		private function containerPosition():Number
		{
			if(sprite.container.height<=sprite.myMask.height)
				return 0;
			else{
				return (sprite.container.y - sprite.myMask.y)/(sprite.container.height-sprite.myMask.height);
			}
		}
		
		private function onBlockUp(e:MouseEvent):void
		{
			if(sprite.stage.hasEventListener(MouseEvent.MOUSE_UP))
				sprite.stage.removeEventListener(MouseEvent.MOUSE_UP, onBlockUp);
			if(sprite.stage.hasEventListener(MouseEvent.MOUSE_MOVE))
				sprite.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onBlockDownMove);
			sprite.slider.block.stopDrag();
		}
		
		private function onSliderUpClick(e:MouseEvent):void
		{
			e.stopPropagation();
			var tempY:Number;
			if(defineY==Number.NEGATIVE_INFINITY)
				tempY = sprite.container.y + children[0].ui.height;
			else 
				tempY = sprite.container.y + defineY;
			if(tempY<sprite.myMask.y)
			{
				sprite.container.y = tempY;
				sprite.slider.block.y = (sprite.slider.btn_up.y+sprite.slider.btn_up.height) - sliderLength*containerPosition();
			}else{
				sprite.container.y = sprite.myMask.y;
				sprite.slider.block.y = (sprite.slider.btn_up.y+sprite.slider.btn_up.height) - sliderLength*containerPosition();
			}
		}
		
		private function onSliderDownClick(e:MouseEvent):void
		{
			e.stopPropagation();
			var tempY:Number;
			if(defineY==Number.NEGATIVE_INFINITY)
				tempY = sprite.container.y - children[children.length-1].ui.height;
			else 
				tempY = sprite.container.y - defineY;
			
			if(tempY>sprite.myMask.y-(sprite.container.height-sprite.myMask.height))
			{
				sprite.container.y = tempY;
				sprite.slider.block.y = (sprite.slider.btn_up.y+sprite.slider.btn_up.height) - sliderLength*containerPosition();
			}else if(sprite.myMask.height<sprite.container.height){
				sprite.container.y = sprite.myMask.y-(sprite.container.height-sprite.myMask.height);
				sprite.slider.block.y = (sprite.slider.btn_up.y+sprite.slider.btn_up.height) - sliderLength*containerPosition();
			}
		}
		
		public function addItem(item:*):void
		{
			if(item==null)throw"[UISpriteWithSliderDisperse] item is null";
			children.push(item);
			formateChildrenUI();
		}
		
		public function deleteItem(item:*):void
		{
			if(item==null)throw"[UISpriteWithSliderDisperse] item is null";
			if(children.indexOf(item)!=-1){
				children.splice(children.indexOf(item),1);
				formateChildrenUI();
			}
			else
				trace("[UISpriteWithSliderDisperse] can't find item in vector!");
		}
		
		override public function formateChildrenUI():void
		{
			if(children==null) throw "[UISpriteWithSliderDisperse] children is null";
			y = 0;
			sprite.container.removeChildren();
			children.forEach(formateEachChildrenUI, null);
			if(_autoRoll)
				onSliderDownClick(new MouseEvent(MouseEvent.CLICK));
			
			function formateEachChildrenUI(item:*, index:int, vector:Vector.<*>):void
			{
				if(item!=null && sprite!=null)
				{
					item.ui.y = y;
					if(defineY==Number.NEGATIVE_INFINITY)y = y + item.ui.height;
					else y = y + defineY;
					if(item.hasOwnProperty("formateSelf"))
						item.formateSelf();
					sprite.container.addChild(item.ui);
				}else{
					trace("["+type+"||UISprite] ui or sprite is null,please check it ");
				}
			}
		}
		
		public function get autoRoll():Boolean
		{
			return _autoRoll;
		}

		public function set autoRoll(value:Boolean):void
		{
			_autoRoll = value;
		}

	}
}