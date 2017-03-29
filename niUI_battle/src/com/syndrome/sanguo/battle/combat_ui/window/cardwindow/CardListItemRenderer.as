package com.syndrome.sanguo.battle.combat_ui.window.cardwindow
{
	import com.syndrome.sanguo.battle.combat_ui.CardInfoGroup;
	import com.syndrome.sanguo.battle.combat_ui.card.cardimage.CardImage;
	import com.syndrome.sanguo.battle.skin.card.CardListItemRenderderSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.flexlite.domUI.components.supportClasses.ItemRenderer;
	
	/**
	 * 卡片弹窗中的ItemRenderer
	 */
	public class CardListItemRenderer extends ItemRenderer
	{
		public var cardImage:CardImage;
		
		public function CardListItemRenderer()
		{
			super();
			this.skinName = CardListItemRenderderSkin;
			this.addEventListener(Event.ADDED_TO_STAGE , addToStage);
		}
		
		protected function addToStage(event:Event):void
		{
			this.addEventListener(Event.REMOVED_FROM_STAGE , removeFromStage);
		}
		
		protected function removeFromStage(event:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE , removeFromStage);
			cardImage.isSelectable = false;
			cardImage.isSelected = false;
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName , instance);
			if(instance == cardImage){
				cardImage.addEventListener(MouseEvent.ROLL_OVER , itemRollOver);
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object):void
		{
			super.partRemoved(partName , instance);
			if(instance == cardImage){
				cardImage.removeEventListener(MouseEvent.ROLL_OVER , itemRollOver);
			}
		}
		
		override protected function dataChanged():void
		{
			if(data["cardInfo"].hasOwnProperty("isPositive")){
				cardImage.isPositive = data["cardInfo"]["isPositive"];
			}else{
				cardImage.isPositive = true;
			}
			if(data["cardInfo"].hasOwnProperty("isSelectable")){
				cardImage.isSelectable = data["cardInfo"]["isSelectable"];
			}else{
				cardImage.isSelectable = false;
			}
			if(data["cardInfo"].hasOwnProperty("isSelected")){
				cardImage.isSelected = data["cardInfo"]["isSelected"];
			}else{
				cardImage.isSelected = false;
			}
			cardImage.refreshCardInfo(data["cardInfo"]);
			labelDisplay.text = data["text"];
		}
		
		protected function itemRollOver(event:MouseEvent):void
		{
			var cardImage:CardImage = event.currentTarget as CardImage;
			if(cardImage.cardInfo["id"]>0 || cardImage.isPositive){
				CardInfoGroup.getInstance().showCard(cardImage.cardInfo["id"]);
			}
		}
	}
}