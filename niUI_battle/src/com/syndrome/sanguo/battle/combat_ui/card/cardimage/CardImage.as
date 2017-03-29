package com.syndrome.sanguo.battle.combat_ui.card.cardimage
{
	import com.syndrome.sanguo.battle.common.CardInfo;
	import com.syndrome.sanguo.battle.property.CardConst;
	
	import flashx.textLayout.formats.BackgroundColor;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.UIAsset;
	
	/**
	 * 卡图对象
	 */
	public class CardImage extends Group
	{
		public static var defaultImgName:String = "IMG_Card_carderror";
		public static var reversedImgName:String = "IMG_Card_cardbg";
		
		private var positiveGroup:Group = new Group();
		private var positiveImg:CardImageBase;
		private var effectUIAsset:UIAsset = new UIAsset();
		
		private var reversedImg:UIAsset = new UIAsset();
		private var _isPositive:Boolean = false;
		private var _isSelected:Boolean = false;
		private var _isSelectable:Boolean = false;
		
		public var cardInfo:Object;
		
		public function CardImage()
		{
			super();
			this.width = CardConst.width;
			this.height = CardConst.height;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			positiveGroup.width = this.width;
			positiveGroup.height = this.height;
			this.addElement(positiveGroup);
			
			reversedImg.width = this.width;
			reversedImg.height = this.height;
			reversedImg.skinName = reversedImgName;
			this.addElement(reversedImg);
			
			effectUIAsset.x = this.width/2;
			effectUIAsset.y = this.height/2;
			effectUIAsset.includeInLayout = false;
			this.addElement(effectUIAsset);
		}
		
		/**
		 * 添加阵型标记
		 */
		public function showPhalanxFlag():void
		{
			if(positiveImg is GeneralCardImage){
				(positiveImg as GeneralCardImage).showPhalanxFlag();
			}
		}
		
		/**
		 * 移除阵型标记
		 */
		public function hidePhalanxFlag():void
		{
			if(positiveImg is GeneralCardImage){
				(positiveImg as GeneralCardImage).hidePhalanxFlag();
			}
		}
		
		/**
		 * 显示回合计数标记
		 */
		public function showCardRoundCount(value:int):void
		{
			if(positiveImg is StrategyCardImage){
				(positiveImg as StrategyCardImage).showCardRoundCount(value);
			}
		}
		
		/**
		 * 移除回合计数标记
		 */
		public function hideCardRoundCount():void
		{
			if(positiveImg is StrategyCardImage){
				(positiveImg as StrategyCardImage).hideCardRoundCount();
			}
		}
		
		/**
		 * 添加伤害标记
		 */
		public function addHurt(num:int) : void
		{
			if(positiveImg is GeneralCardImage){
				(positiveImg as GeneralCardImage).addHurt(num);
			}
		}
		
		public function addChainSource(on:Boolean):void
		{
			if(on)
				effectUIAsset.skinName = "Effect_Chain_Source";
			else
				effectUIAsset.skinName = "";
		}
		
		public function addChainTarget(on:Boolean):void
		{
			if(on)
				effectUIAsset.skinName = "Effect_Chain_Target";
			else
				effectUIAsset.skinName = "";
		}
		
		/**
		 * 移除伤害标记
		 */
		public function removeHurt(num:int = int.MAX_VALUE):void
		{
			if(positiveImg is GeneralCardImage){
				(positiveImg as GeneralCardImage).removeHurt(num);
			}
		}
		
		/**
		 * 改变卡牌属性
		 */
		public function setAttribInfo(attack:int, health:int, intelligence:int, visible:Boolean = true) : void
		{
			if(positiveImg is GeneralCardImage){
				(positiveImg as GeneralCardImage).setAttribInfo(attack , health , intelligence , true , visible);
			}
		}
		
		private var _id:int;
		/**
		 * 根据属性刷新基本的元素 needAddPro是否需要添加基本属性
		 */
		public function refreshCardInfo(cardInfo:Object , needAddPro:Boolean = false , isRefreshPositive:Boolean = true) : void
		{
			if(needAddPro){
				var addPro:Object = CardInfo.getCardInfoById(cardInfo["id"]);
				cardInfo["base"] = addPro;
			}
			this.cardInfo = cardInfo;
			_id = cardInfo["id"];
			if(isRefreshPositive){
				refreshPositiveImg();
			}
		}
		
		/**
		 * 获取卡牌正面的class
		 */
		private function getCardImageClass():Class
		{
			if (this.cardInfo["base"]["card_type"] == "GENERAL" || String(this.cardInfo["id"]).charAt(0) == "6")   //武将卡 , 阵型卡
			{
				return GeneralCardImage;
			}else if(this.cardInfo["base"]["card_type"] == "STRATEGY"){
				return StrategyCardImage;
			}else{
				return OtherCardImage;
			}
		}
		
		/**
		 * 刷新卡片正面
		 */
		private function refreshPositiveImg():void
		{
			if (this.cardInfo.hasOwnProperty("id") &&  (this.cardInfo["id"] >0))
			{
				var clazz:Class = getCardImageClass();
				if (!this.positiveImg || !(this.positiveImg is clazz))
				{
					this.positiveImg = new clazz();
				}
				
				if (this.positiveGroup != positiveImg.parent)
				{
					this.positiveGroup.removeAllElements();
					this.positiveGroup.addElement(positiveImg);
				}
				positiveImg.setCardInfo(this.cardInfo);
			}
		}
		
		public function set isPositive(value:Boolean) : void
		{
			_isPositive = value;
			if (value)
			{
				positiveGroup.visible = true;
				if(!positiveImg && cardInfo){
					refreshPositiveImg();
				}
				reversedImg.visible = false;
			}
			else
			{
				positiveGroup.visible = false;
				reversedImg.visible = true;
			}
		}
		
		public function get isPositive() : Boolean
		{
			return _isPositive;
		}

		public function get isSelected():Boolean
		{
			return _isSelected;
		}

		public function set isSelected(value:Boolean):void
		{
			_isSelected = value;
			if(value){
				effectUIAsset.skinName = "Effect_Selected";
			}else if(effectUIAsset.skinName == "Effect_Selected"){
				effectUIAsset.skinName = "";
			}
		}

		public function get isSelectable():Boolean
		{
			return _isSelectable;
		}

		public function set isSelectable(value:Boolean):void
		{
			_isSelectable = value;
			if(value){
				effectUIAsset.skinName = "Effect_Selectable";
			}else if(effectUIAsset.skinName == "Effect_Selectable"){
				effectUIAsset.skinName = "";
			}
		}
		
	}
}