package com.syndrome.sanguo.battle.combat_ui.card
{
	import com.syndrome.sanguo.battle.combat_ui.CombatStage;
	import com.syndrome.sanguo.battle.combat_ui.stagegroup.PopUpGroup;
	import com.syndrome.sanguo.battle.skin.card.CardOpertionListSkin;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	import org.flexlite.domUI.collections.ArrayCollection;
	import org.flexlite.domUI.components.List;
	
	public class CardOpertionList extends List
	{
		private static var _instance:CardOpertionList;
		public function CardOpertionList()
		{
			super();
//			this.useVirtualLayout = false;
			this.skinName = CardOpertionListSkin;
		}
		
		/**
		 * arr每一项有字段 label用于显示文本 value则表示值
		 */
		public function show(arr:Array , point:Point = null , clickHide:Boolean = true):void
		{
			this.dataProvider = new ArrayCollection(arr);
			if(point){
				this.x = point.x;
				this.y = point.y;
				this.includeInLayout = false;
				PopUpGroup.getInstance().addPopUp(this ,false);
			}else{
				this.includeInLayout = true;
				PopUpGroup.getInstance().addPopUp(this ,true);
			}
			if(clickHide){
				CombatStage.getInstance().stage.addEventListener(MouseEvent.CLICK , stageMouseClick , true);
				CombatStage.getInstance().stage.addEventListener(MouseEvent.MOUSE_UP , stageMouseUp);
			}
		}
		
		public function hide():void
		{
			CombatStage.getInstance().stage.removeEventListener(MouseEvent.MOUSE_UP , stageMouseUp);
			CombatStage.getInstance().stage.removeEventListener(MouseEvent.CLICK , stageMouseClick , true);
			
			this.selectedItem = null;
			dispatchEvent(new Event("hide"));
			if(parent){
				PopUpGroup.getInstance().removePopUp(this);
			}
		}
		
		protected function stageMouseClick(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
		}
		
		protected function stageMouseUp(event:MouseEvent):void
		{
			setTimeout(hide,30);
		}
		
		public static function getInstance():CardOpertionList
		{
			if (_instance == null)
			{
				_instance = new CardOpertionList();
			}
			return _instance;
		}
	}
}