package com.syndrome.sanguo.battle.combat_ui.window.cardwindow
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.event.SelectEvent;
	import com.syndrome.sanguo.battle.skin.CardSelectableWindowSkin;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import manger.SoundManager;
	
	import org.flexlite.domUI.collections.ArrayCollection;
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.IItemRenderer;
	import org.flexlite.domUI.components.Label;
	
	/**
	 * 卡片排序窗口
	 */
	public class CardSortWindow extends CardDisplayWindow
	{
		public var okButton:Button;
		public var tipLabel:Label;
		
		private var selectedIndex:int = -1;
		
		private var _tipText:String;
		
		public function CardSortWindow()
		{
			super();
			this.skinName = CardSelectableWindowSkin;
		}
		
		private function cardListClickHandle(event:MouseEvent):void
		{
			var itemRenderer:IItemRenderer;
			var target:DisplayObject = event.target as DisplayObject;
			while(target != cardGroup){
				if(target is IItemRenderer)
				{
					itemRenderer = target as IItemRenderer;
					break;
				}
				target = target.parent;
			}
			if(itemRenderer){
				cardClick(itemRenderer.itemIndex);
			}
		}
		
		protected function cardClick(itemIndex:int):void
		{
			var itemObject:Object = cardGroup.dataProvider.getItemAt(itemIndex);
			if(!itemObject["cardInfo"].hasOwnProperty("isSelectable"))
			{
				return;
			}
			var dp:ArrayCollection = cardGroup.dataProvider as ArrayCollection;
			if(selectedIndex<0)
			{
				selectedIndex = itemIndex;
				itemObject["cardInfo"]["isSelected"] = true;
				dp.itemUpdated(itemObject);
			}
			else
			{
				var selectedObject:Object = dp.replaceItemAt(itemObject , selectedIndex);
				selectedObject["cardInfo"]["isSelected"] = false;
				dp.replaceItemAt(selectedObject , itemIndex);
				dp.itemUpdated(selectedObject);
				dp.itemUpdated(itemObject);
				selectedIndex = -1;
			}
			checkOkButton();
		}
		
		private function checkOkButton():void
		{
			if(okButton){
				if(selectedIndex<0){
					okButton.enabled = true;
				}else{
					okButton.enabled = false;
				}
			}
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName , instance);
			if(instance == cardGroup){
				cardGroup.addEventListener(MouseEvent.CLICK , cardListClickHandle);
			}else if(instance == cancelButton){
				cancelButton.visible = cancelButton.includeInLayout = false;
			}else if(instance == okButton){
				checkOkButton();
				okButton.addEventListener(MouseEvent.CLICK , onButtonClick);
			}else if(instance == tipLabel){
				tipLabel.text = _tipText;
			}
		}
		
		protected function onButtonClick(event:MouseEvent):void
		{
			SoundManager.play("MP3_Button");
			removeSelf();
			var cardAddresses:Array = [];
			for (var i:int = 0; i < cardGroup.dataProvider.length; i++) 
			{
				var item:Object = (cardGroup.dataProvider as ArrayCollection).getItemAt(i);
				cardAddresses.push(item["cardInfo"]["address"]);
			}
			CombatConsole.getInstance().dispatchEvent(new SelectEvent(SelectEvent.SELECT , cardAddresses));
		}

		public function get tipText():String
		{
			return _tipText;
		}

		public function set tipText(value:String):void
		{
			_tipText = value;
			if(tipLabel){
				tipLabel.text = value;
			}
		}
	}
}