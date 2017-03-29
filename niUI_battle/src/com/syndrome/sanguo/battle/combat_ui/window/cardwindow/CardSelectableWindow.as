package com.syndrome.sanguo.battle.combat_ui.window.cardwindow
{
	import com.syndrome.sanguo.battle.CombatConsole;
	import com.syndrome.sanguo.battle.event.SelectEvent;
	import com.syndrome.sanguo.battle.skin.CardSelectableWindowSkin;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import manger.SoundManager;
	
	import org.flexlite.domUI.collections.ArrayCollection;
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.IItemRenderer;
	import org.flexlite.domUI.components.Label;
	
	/**
	 * 卡片选择窗口
	 */
	public class CardSelectableWindow extends CardDisplayWindow
	{
		public var okButton:Button;
		public var tipLabel:Label;
		
		private var maxCount:int;
		private var minCount:int;
		private var eventStr:String;
		private var cancelEnable:Boolean = true;
		private var selectedIndices:Array = [];
		
		public function CardSelectableWindow()
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
			if(!itemObject["cardInfo"].hasOwnProperty("isSelectable")){
				return;
			}
			
			if(selectedIndices.indexOf(itemIndex)<0){
				if(selectedIndices.length >= maxCount){
					var firstItem:Object = cardGroup.dataProvider.getItemAt(selectedIndices.shift());
					firstItem["cardInfo"]["isSelected"] = false;
					(cardGroup.dataProvider as ArrayCollection).itemUpdated(firstItem);
				}
				itemObject["cardInfo"]["isSelected"] = true;
				selectedIndices.push(itemIndex);
			}else{
				itemObject["cardInfo"]["isSelected"] = false;
				selectedIndices.splice(selectedIndices.indexOf(itemIndex),1);
			}
			(cardGroup.dataProvider as ArrayCollection).itemUpdated(itemObject);
			checkNum();
			setTip();
		}
		
		/**
		 *设置要显示的卡片 
		 * @param maxCount 最大数量
		 * @param minCount 最小数量
		 * @param cancelEnable 是否可取消
		 * @param eventStr 对应的提示文本
		 */
		public function setInfo(maxCount:int = 0, minCount:int = 0, cancelEnable:Boolean = true, eventStr:String = null) : void
		{
			this.maxCount = maxCount;
			this.minCount = minCount;
			this.cancelEnable = cancelEnable;
			this.eventStr = eventStr;
			this.setTip();
			this.checkNum();
		}
		
		private function checkNum():void
		{
			if(okButton && cancelButton){
				if(selectedIndices.length>=minCount&&selectedIndices.length<=maxCount){
					okButton.enabled = true;
				}else{
					okButton.enabled = false;
				}
				cancelButton.enabled = cancelEnable;
			}
		}
		
		private function setTip():void
		{
			if(tipLabel){
				if(minCount == maxCount){
					tipLabel.text = eventStr + ":" + selectedIndices.length + "/" + minCount;
				}else{
					tipLabel.text = eventStr + ":" + selectedIndices.length;
				}
			}
		}		
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName , instance);
			if(instance == cardGroup){
				cardGroup.addEventListener(MouseEvent.CLICK , cardListClickHandle);
			}else if(instance == cancelButton){
				checkNum();
				cancelButton.addEventListener(MouseEvent.CLICK , onCancelClick);
			}else if(instance == okButton){
				checkNum();
				okButton.addEventListener(MouseEvent.CLICK , onButtonClick);
			}else if(instance == tipLabel){
				setTip();
			}
		}
		
		protected function onCancelClick(event:MouseEvent):void
		{
			SoundManager.play("MP3_Button");
			CombatConsole.getInstance().dispatchEvent(new Event("cancel"));
		}
		
		protected function onButtonClick(event:MouseEvent):void
		{
			SoundManager.play("MP3_Button");
			removeSelf();
			var cardAddresses:Array = [];
			for (var i:int = 0; i < selectedIndices.length; i++) 
			{
				cardAddresses.push(cardInfos[selectedIndices[i]]["address"]);
			}
			CombatConsole.getInstance().dispatchEvent(new SelectEvent(SelectEvent.SELECT , cardAddresses));
		}
	}
}