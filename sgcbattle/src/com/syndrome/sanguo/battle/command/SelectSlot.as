package com.syndrome.sanguo.battle.command
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.combat_ui.card.CardManager;
	import com.syndrome.sanguo.battle.combat_ui.card.cardslot.GeneralCardSlot;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group2D.Scence2DCantainer;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.Effect3DCantainer;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D.Scence3DCantainer;
	import com.syndrome.sanguo.battle.event.SelectSlotEvent;
	import com.syndrome.sanguo.battle.property.CardConst;
	import com.syndrome.sanguo.battle.property.CardSlotConst;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.flexlite.domUI.components.Rect;

	public class SelectSlot extends CommandBase
	{
		
		/**
		 * 可选中的地址
		 */
		private var addresses:Array;
		
		private var cancelEnabled:Boolean;
		
		private var rects:Array = [];
		
		/**
		 * 武将上场时选择卡槽
		 */
		public function SelectSlot()
		{
			super();
		}
		
		/**
		 * 显示可选中区域
		 * @param click(index:int)  点击区域的index
		 * @param cancelClick()  取消
		 */
		public function show(addresses:Array , cancel:Boolean):void
		{
			this.addresses = addresses;
			this.cancelEnabled = cancel;
			this.init();
		}
		
		private function init():void
		{
			if(cancelEnabled){
				Scence2DCantainer.getInstance().showOKCancel(false , cancelEnabled);
				CombatConsole.getInstance().addEventListener(CombatConsole.CANCEL , cancelClick , false , 1);
			}
			for (var i:int = 0; i < addresses.length; i++) 
			{
				var index:int = CardManager.getCardIndex(addresses[i]);
				var point:Point;
				var rect:Rect = new Rect();
				rect.id = i.toString();
				rect.addEventListener(MouseEvent.CLICK,rectClick);
				if(index < 2){
					point = CardManager.getPointByAddress(addresses[i]);
					draw(rect,point.x,point.y,CardConst.width,CardConst.height);
				}else{
					point = CardManager.getPointByAddress(CardSlotConst.generalCardSlot*10000+2);   //第一个副将的位置
					draw(rect,point.x,point.y,GeneralCardSlot.assistantWidth+20,CardConst.height);
				}
				Scence3DCantainer.getInstance().addElement(rect);
				rects.push(rect);
			}
		}
		
		private function draw(rect:Rect,x:Number,y:Number,width:Number,height:Number):void
		{
			rect.x = x-CardConst.width/2;
			rect.y = y-CardConst.height/2;
			rect.width = width;
			rect.height = height;
			rect.fillAlpha = 0.3;
			rect.fillColor = 0xff0000;
		}
		
		protected function cancelClick(event:Event):void
		{
			event.stopImmediatePropagation();
			Scence2DCantainer.getInstance().showOKCancel();
			destroy();
			CombatConsole.getInstance().dispatchEvent(new Event(CombatConsole.CANCEL));
		}
		
		private function rectClick(event:MouseEvent):void
		{
			var rect:Rect = event.currentTarget as Rect;
			CombatConsole.getInstance().dispatchEvent(new SelectSlotEvent(SelectSlotEvent.SELECTSLOT , int(rect.id)));
			Scence2DCantainer.getInstance().showOKCancel();
			destroy();
		}
		
		override protected function destroy():void
		{
			super.destroy();
			CombatConsole.getInstance().removeEventListener(CombatConsole.CANCEL , cancelClick);
			for (var i:int = 0; i < rects.length; i++) 
			{
				var rect:Rect = rects[i] as Rect;
				rect.removeEventListener(MouseEvent.CLICK , rectClick);
				Scence3DCantainer.getInstance().removeElement(rect);
			}
		}
		
	}
}