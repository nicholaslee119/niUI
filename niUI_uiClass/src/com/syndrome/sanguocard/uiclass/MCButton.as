package com.syndrome.sanguocard.uiclass
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * 按钮封装类
	 * @author nic
	 * 
	 */	
	public class MCButton extends MovieClip
	{
		public var ui:MovieClip;
		
		public var tags:Object;
		
		/**
		 * 可选中，true为可选中，false为不可选中.
		 */		
		private var DEFAULT_TOGGLE:Boolean;
		/**
		 * 可操作，true为可操作，false为不可操作
		 */		
		private var DEFAULT_BTN_ENABLED:Boolean;
		/**
		 * 选中状态，true为选中状态，false为不可选中状态
		 */		
		private var DEFAULT_SELECTED:Boolean;
		
		private var _toggleInited:Boolean;
		private var _btnEnabledInited:Boolean;
		private var _selectedInited:Boolean;
		
		//属性变量
		private var _toggle:Boolean;//可选中.
		private var _btnEnabled:Boolean;//可操作
		private var _selected:Boolean;//选中状态
		
		//这个变量不要改
		private var _inited:Boolean = false;
		
		public function MCButton(_ui:MovieClip, toggle:Boolean=false, selected:Boolean=false, enable:Boolean=true)
		{
			ui = _ui;
			this.addChild(ui);
			DEFAULT_TOGGLE = toggle;
			DEFAULT_BTN_ENABLED = enable;
			DEFAULT_SELECTED = selected;
			init();
		}
		
		private function init():void
		{
			//初始化过程
			ui.addEventListener(MouseEvent.ROLL_OVER, rollOverHandle, false, int.MAX_VALUE, true);
			ui.addEventListener(MouseEvent.ROLL_OUT, rollOutHandle, false, int.MAX_VALUE, true);
			ui.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandle, false, int.MAX_VALUE, true);
			ui.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandle, false, int.MAX_VALUE, true);
			ui.addEventListener(MouseEvent.CLICK, clickHandle, false, int.MAX_VALUE, true);
			ui.mouseChildren = false;
			if (!_toggleInited)
			{
				_toggle = DEFAULT_TOGGLE;
			}
			if (!_btnEnabledInited)
			{
				_btnEnabled = DEFAULT_BTN_ENABLED;
			}
			if (!_selectedInited)
			{
				_selected = DEFAULT_SELECTED;
			}
			refresh();
			_inited = true;
		}
		
		//响应函数
		private function rollOverHandle(event:MouseEvent):void
		{
			if (_btnEnabled)
			{
				if (_selected)
				{
					ui.gotoAndStop("selectedOver");
				}
				else
				{
					ui.gotoAndStop("over");
				}
			}
		}
		
		private function rollOutHandle(event:MouseEvent):void
		{
			if (_btnEnabled)
			{
				if (_selected)
				{
					ui.gotoAndStop("selectedUp");
				}
				else
				{
					ui.gotoAndStop("up");
				}
			}
		}
		
		private function mouseDownHandle(event:MouseEvent):void
		{
			if (_btnEnabled)
			{
				if (_selected)
				{
					ui.gotoAndStop("selectedDown");
				}
				else
				{
					ui.gotoAndStop("down");
				}
			}
			else
			{
				event.stopImmediatePropagation();
			}
		}
		
		private function mouseUpHandle(event:MouseEvent):void
		{
			if (_btnEnabled)
			{
			}
			else
			{
				event.stopImmediatePropagation();
			}
		}
		
		
		private function clickHandle(event:MouseEvent):void
		{
			if (_btnEnabled)
			{
				if (_toggle)
				{
					_selected = !_selected;
					if (_selected)
					{
						ui.gotoAndStop("selectedOver");
					}
					else
					{
						ui.gotoAndStop("over");
					}
				}
				else
				{
					ui.gotoAndStop("over");
				}
			}
			else
			{
				event.stopImmediatePropagation();
			}
		}
		
		//对外接口，弱类型下面的对外接口，不是很好
		public function set btnEnabled(value:Boolean):void
		{
			if (!_btnEnabledInited || _btnEnabled != value)
			{
				_btnEnabled = value;
				
				_btnEnabledInited = true;
				
				if (_inited)
				{
					refresh();
				}
			}
		}
		
		public function get btnEnabled():Boolean
		{
			return _btnEnabled;
		}
		
		public function addMouseClickEventListener(handler:Function):void
		{
			if(ui==null)return;
			ui.addEventListener(MouseEvent.CLICK, handler);
		}
		
		//toggle会限制_selected的值
		public function set toggle(value:Boolean):void
		{
			if (!_toggleInited || _toggle != value)
			{
				_toggle = value;
				_toggleInited = true;
				if (!_toggle)
				{
					_selected = false;
				}
				if (_inited)
				{
					refresh();
				}
			}
		}
		
		public function get toggle():Boolean
		{
			return _toggle;
		}
		
		public function set selected(value:Boolean):void
		{
			if (!_selectedInited || _toggle && _selected != value)
			{
				_selected = value;
				
				_selectedInited = true;
				
				if (_inited)
				{
					refresh();
				}
			}
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function refresh():void
		{
			if (_btnEnabled)
			{
				if (_selected)
				{
					ui.gotoAndStop("selectedUp");
				}
				else
				{
					ui.gotoAndStop("up");
				}
			}
			else
			{
				if (_selected)
				{
					ui.gotoAndStop("selectedDisabled");
				}
				else
				{
					ui.gotoAndStop("disabled");
				}
			}
		}

	}
}