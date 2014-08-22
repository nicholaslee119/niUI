package com.syndrome.sanguo.battle.combat_ui.card.cardimage
{
	import com.syndrome.sanguo.battle.combat_ui.card.GameCard;
	
	import flash.filters.GlowFilter;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	
	public class GeneralCardImage extends CardImageBase
	{
		private var cardAttribInfoGroup:CardAttribInfoGroup;
		
		/**
		 * 武将卡
		 */
		public function GeneralCardImage()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			cardAttribInfoGroup = new CardAttribInfoGroup();
			cardAttribInfoGroup.left = 2;
			cardAttribInfoGroup.bottom = 0;
			this.addElement(cardAttribInfoGroup);
		}
		
		public function setAttribInfo(attack:int, health:int, intelligence:int, playEffect:Boolean = true, visible:Boolean = true) : void
		{
			cardAttribInfoGroup.visible = visible;
			if(visible && attack>-1 && health>-1 && intelligence>-1){
				cardAttribInfoGroup.setAttribInfo(cardInfo["id"] , attack , health , intelligence , playEffect);
			}
		}
		
		private var cardFlagLabel:Label;
		/**
		 * 添加阵型标记
		 */
		public function showPhalanxFlag():void
		{
			if(!cardFlagLabel){
				cardFlagLabel = new Label();
				cardFlagLabel.size = 14;
				cardFlagLabel.textColor = 0;
				cardFlagLabel.filters = [new GlowFilter(0xffffff,1,6,6,10)];
				cardFlagLabel.verticalCenter = 0;
				cardFlagLabel.horizontalCenter = 0;
				this.addElement(cardFlagLabel);
			}
			this.alpha = 0.75;
			cardFlagLabel.text = "阵";
		}
		
		/**
		 * 移除阵型标记
		 */
		public function hidePhalanxFlag():void
		{
			this.alpha = 1;
			if(cardFlagLabel){
				this.removeElement(cardFlagLabel);
				cardFlagLabel = null;
			}
		}
		
		
		private var cardHurtGroup:CardHurtGroup;
		/**
		 * 添加伤害标记
		 */
		public function addHurt(num:int):void
		{
			if(!cardHurtGroup){
				cardHurtGroup = new CardHurtGroup();
				cardHurtGroup.left = 2;
				cardHurtGroup.top = 5;
				this.addElement(cardHurtGroup);
			}
			cardHurtGroup.addHurt(num);
		}
		
		/**
		 * 移除伤害标记
		 */
		public function removeHurt(num:int = int.MAX_VALUE):void
		{
			if(cardHurtGroup){
				cardHurtGroup.removeHurt(num);
				if(cardHurtGroup.getHurtNum() == 0){
					this.removeElement(cardHurtGroup);
					cardHurtGroup = null;
				}
			}
		}
		
		protected var _attack:String;
		protected var _health:String;
		protected var _intelligence:String;
		override protected function refreshCardInfo():void
		{
			super.refreshCardInfo();
			if(!cardInfo["base"].hasOwnProperty("attack")){
				cardAttribInfoGroup.visible = false;
				return;
			}
			if(_attack != cardInfo["base"]["attack"] || _health != cardInfo["base"]["health"] || _intelligence != cardInfo["base"]["intelligence"]){
				_attack = cardInfo["base"]["attack"];
				_health = cardInfo["base"]["health"];
				_intelligence = cardInfo["base"]["intelligence"];
				setAttribInfo(cardInfo["base"]["attack"],cardInfo["base"]["health"],cardInfo["base"]["intelligence"],false);
			}
		}
	}
}