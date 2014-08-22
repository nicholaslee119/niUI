package com.syndrome.sanguo.battle.combat_ui.window.cardwindow
{
	import com.syndrome.sanguo.battle.skin.CardDisplayWindowSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import manger.SoundManager;
	
	import org.flexlite.domUI.collections.ArrayCollection;
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.DataGroup;
	import org.flexlite.domUI.components.TitleWindow;
	import org.flexlite.domUI.core.IVisualElementContainer;
	import org.flexlite.domUI.layouts.HorizontalAlign;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	import org.flexlite.domUI.layouts.TileLayout;
	import org.flexlite.domUI.managers.PopUpManager;
	
	/**
	 * 卡片展示窗口
	 */
	public class CardDisplayWindow extends TitleWindow
	{
		protected var cardInfos:Array = [];
		
		public var cardGroup:DataGroup;
		public var cancelButton:Button;
		
		public function CardDisplayWindow()
		{
			super();
			this.skinName = CardDisplayWindowSkin;
		}
		
		/**
		 * 鼠标拖拽时的移动事件
		 */		
		override protected function moveArea_mouseMoveHandler(event:MouseEvent):void
		{
			super.moveArea_mouseMoveHandler(event);
			if(this.x < -this.width/2){
				this.x = -this.width/2;
			}else if(this.x > this.parent.width - this.width/2){
				this.x = this.parent.width - this.width/2;
			}
			if(this.y < -this.height/2){
				this.y = -this.height/2;
			}else if(this.y > this.parent.height - this.height/2){
				this.y = this.parent.height - this.height/2;
			}
		}
		
		/**
		 * 添加要显示的卡片
		 */
		public function addCards(cardArray:Array) : void
		{
			cardInfos.length = 0;
			for (var i:int = 0; i < cardArray.length; i++) 
			{
				cardInfos.push(cardArray[i].cardInfo);
			}
			this.displayCards();
		}
		
		/**
		 * 添加要显示的卡片信息
		 * @param cardInfos  必须包含字段id  
		 */
		public function addCardInfos(cardInfos:Array):void
		{
			this.cardInfos = cardInfos;
			this.displayCards();
		}
		
		private var displayFlag:Boolean;
		protected function displayCards():void
		{
			if(cardGroup && cardInfos){
				var dp:ArrayCollection = new ArrayCollection();
				for (var i:int = 0; i < cardInfos.length; i++) 
				{
					var cardInfo:Object = cardInfos[i];
					dp.addItem({"text":i+1,"cardInfo":cardInfo});
				}
				cardGroup.dataProvider = dp;
				if(cardInfos.length <=5){   //依据卡片数量调整布局
					var hor:HorizontalLayout = new HorizontalLayout();
					hor.horizontalAlign = HorizontalAlign.CENTER;
					hor.gap = 10;
					cardGroup.layout = hor;
				}else{
					var til:TileLayout = new TileLayout();
					til.useVirtualLayout = true;
					til.requestedColumnCount = 5;
					til.horizontalGap = 10;
					cardGroup.layout = til;
				}
				displayFlag = true;
			}else{
				displayFlag = false;
			}
		}

		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName , instance);
			if(instance == cardGroup){
				cardGroup.itemRenderer = CardListItemRenderer;
				if(!displayFlag){
					displayCards();
				}
			}
			else if(instance==cancelButton)
			{
				cancelButton.addEventListener(MouseEvent.CLICK,onCancelButtonClick);
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object):void
		{
			super.partRemoved(partName , instance);
			if(instance==cancelButton)
			{
				cancelButton.removeEventListener(MouseEvent.CLICK,onCancelButtonClick);
			}
		}
		
		public function removeSelf():void
		{
			PopUpManager.removePopUp(this);
			if(parent){
				if(parent is IVisualElementContainer){
					(parent as IVisualElementContainer).removeElement(this);
				}else{
					parent.removeChild(this);
				}
			}
		}
		
		protected function onCancelButtonClick(event:MouseEvent):void
		{
			SoundManager.play("MP3_Button");
			this.removeSelf();
		}
	}
}