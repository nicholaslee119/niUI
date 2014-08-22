package com.syndrome.sanguo.battle.combat_ui.window
{
	import com.syndrome.sanguo.battle.combat_ui.CardInfoGroup;
	import com.syndrome.sanguo.battle.combat_ui.card.cardimage.CardImage;
	import com.syndrome.sanguo.battle.skin.DistributeInjuryItemSkin;
	
	import flash.events.MouseEvent;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.SkinnableComponent;
	
	public class DistributeInjuryItem extends SkinnableComponent
	{
		public var cardImage:CardImage;
		public var cardNameLabel:Label;
		public var iconGroup:Group;
		
		/**
		 * 是否是进攻方
		 */
		public var isAttacker:Boolean;
		
		private var cardInfo:Object = {};
		private var value:int;
		
		private var _itemIndex:int;
		
		public function DistributeInjuryItem()
		{
			super();
			this.skinName = DistributeInjuryItemSkin;
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName , instance);
			if(cardImage == instance){
				cardImage.addEventListener(MouseEvent.ROLL_OVER , itemRollOver);
			}
		}
		
		protected function itemRollOver(event:MouseEvent):void
		{
			var cardImage:CardImage = event.currentTarget as CardImage;
			if(cardImage.isPositive){
				CardInfoGroup.getInstance().showCard(cardImage.cardInfo["id"]);
			}			
		}
		
		public function setCardInfo(cardInfo:Object ,value:int ,isAttacker:Boolean):void
		{
			this.cardInfo = cardInfo;
			this.isAttacker = isAttacker;
			this.value = value;
			cardInfoChanged = true;
			this.invalidateProperties();
		}
		
		private var cardInfoChanged:Boolean =false;
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(cardInfoChanged){
				cardNameLabel.text = cardInfo["card_name"];
				cardImage.refreshCardInfo(cardInfo);
				addIcon();
				cardInfoChanged = false;
			}
		}
		
		/**
		 * 获取图标  DistributeInjuryIcon
		 */
		public function get icons():Array
		{
			if(iconGroup){
				var arr:Array = new Array();
				for (var i:int = 0; i < iconGroup.numElements; i++) 
				{
					arr.push(iconGroup.getElementAt(i));
				}
				return arr;
			}
			return null;
		}
		
		private function addIcon():void
		{
			for (var i:int = 0; i < value; i++) 
			{
				var distributeInjuryIcon:DistributeInjuryIcon = new DistributeInjuryIcon();
//				if(isAttacker){
//					distributeInjuryIcon.currentState = 1;
//					distributeInjuryIcon.addEventListener(MouseEvent.MOUSE_DOWN , onStartDrag);
//					distributeInjuryIcon.addEventListener(DragEvent.DRAG_COMPLETE,onDragComp);
//				}else{
//					distributeInjuryIcon.currentState = 2;
//					distributeInjuryIcon.addEventListener(DragEvent.DRAG_DROP,onDragDrop);
//				}
				distributeInjuryIcon.currentState = isAttacker?1:2;
				iconGroup.addElement(distributeInjuryIcon);
			}
		}

		public function get itemIndex():int
		{
			return _itemIndex;
		}

		public function set itemIndex(value:int):void
		{
			_itemIndex = value;
		}
		
		/**
		 * 是否能减少攻击图标
		 */
		public function get canReduce():Boolean
		{
			for (var i:int = 0; i < icons.length; i++) 
			{
				var icon:DistributeInjuryIcon = icons[i];
				if(isAttacker){
					if(icon.currentState == 1){
						return true;
					}
				}else{
					if(icon.currentState == 4){
						return true;
					}
				}
			}
			return false;
		}
		
		public function reduceAttack():void
		{
			for (var i:int = icons.length-1; i >=0 ; i--) 
			{
				var icon:DistributeInjuryIcon = icons[i];
				if(isAttacker){
					if(icon.currentState == 1){
						icon.currentState = 3;
						return;
					}
				}else{
					if(icon.currentState == 4){
						icon.currentState = 2;
						return;
					}
				}
			}
		}
		
		/**
		 * 是否能添加攻击图标
		 */
		public function get canAdd():Boolean
		{
			for (var i:int = 0; i < icons.length; i++) 
			{
				var icon:DistributeInjuryIcon = icons[i];
				if(isAttacker){
					if(icon.currentState == 3){
						return true;
					}
				}else{
					if(icon.currentState == 2){
						return true;
					}
				}
			}
			return false;
		}
		
		public function addAttack():void
		{
			for (var i:int = 0; i <icons.length ; i++) 
			{
				var icon:DistributeInjuryIcon = icons[i];
				if(isAttacker){
					if(icon.currentState == 3){
						icon.currentState = 1;
						return;
					}
				}else{
					if(icon.currentState == 2){
						icon.currentState = 4;
						return;
					}
				}
			}
		}

//		
//		private function onDragDrop(event:DragEvent):void
//		{
//			var icon:DistributeInjuryIcon = event.currentTarget;
//			if(icon.currentState != 1){
//				return;
//			}
//		}
//		
//		protected function onDragComp(event:DragEvent):void
//		{
//			var isSuccess:Boolean;
//			if(event.relatedObject && event.relatedObject is DistributeInjuryIcon && event.relatedObject)
//			{
//				
//				
//			}
//		}
//		
//		protected function onStartDrag(event:MouseEvent):void
//		{
//			var icon:DistributeInjuryIcon = event.currentTarget;
//			if(icon.currentState != 1){
//				return;
//			}
//			icon.currentState = 3;
//			var dragSource:DragSource = new DragSource();
////			dragSource.addData("按钮"+count,"ButtonData");
//			var bitmapData:BitmapData = new BitmapData(icon.width,icon.height);
//			bitmapData.draw(icon);
//			var dragImage:Bitmap = new Bitmap();
//			dragImage.bitmapData = bitmapData;
//			DragManager.doDrag(icon,dragSource,dragImage);
//		}
	}
}