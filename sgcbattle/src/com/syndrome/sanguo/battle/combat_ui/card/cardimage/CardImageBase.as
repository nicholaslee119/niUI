package com.syndrome.sanguo.battle.combat_ui.card.cardimage
{
	import app.config.AppConfig;
	
	import com.syndrome.sanguo.battle.property.CardConst;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.UIAsset;
	
	public class CardImageBase extends Group
	{
		public var cardInfo:Object;
		
		protected var img:UIAsset;
		
		public function CardImageBase()
		{
			super();
			this.width = CardConst.width;
			this.height = CardConst.height;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			img = new UIAsset();
			img.skinName = CardImage.defaultImgName;
			img.width = CardConst.width;
			img.height = CardConst.height;
			this.addElement(img);
		}

		private var infoChanged:Boolean;
		/**
		 * 初始化配置
		 */
		public function setCardInfo(cardInfo:Object):void
		{
			this.cardInfo = cardInfo;
			if(initialized || parent){
				this.refreshCardInfo();
			}else{
				infoChanged = true;
				this.invalidateProperties()
			}
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(infoChanged){
				infoChanged = false;
				refreshCardInfo();
			}
		}
		
		protected var _id:int;
		protected function refreshCardInfo():void
		{
			if(_id != cardInfo["id"]){
				_id = cardInfo["id"];
				img.skinName = AppConfig.bigCardFolder + cardInfo["id"] + AppConfig.bigCardType;
			}
		}
	}
}