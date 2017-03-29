package com.syndrome.sanguo.battle.combat_ui.card.cardimage
{
	import com.syndrome.sanguo.battle.common.CardInfo;
	
	import components.rollnum.RollNumGroup;
	
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	
	import utils.ObjectUtil;
	
	/**
	 * 武将3围
	 */
	public class CardAttribInfoGroup extends Group
	{
		private var rollNum1:RollNumGroup;
		private var rollNum2:RollNumGroup;
		private var rollNum3:RollNumGroup;

		private var label1:Label;
		private var label2:Label;
		
		public function CardAttribInfoGroup()
		{
			super();
			var hor:HorizontalLayout = new HorizontalLayout();
			hor.gap = -4;
			this.layout = hor;
			
			rollNum1 = new RollNumGroup();
			rollNum2 = new RollNumGroup();
			rollNum3 = new RollNumGroup();
			
			label1 = new Label();
			label1.width = 10;
			label2 = new Label();
			label2.width = 10;
			
			this.addElement(rollNum1);
			this.addElement(label1);
			this.addElement(rollNum2);
			this.addElement(label2);
			this.addElement(rollNum3);
		}
		
		/**
		 * 显示三围属性
		 */
		public function setAttribInfo(id:int , attack:int, health:int, intelligence:int ,playEffect:Boolean = true) : void
		{
			var originalCardInfo:Object = CardInfo.getCardInfoById(id);
			ObjectUtil.concat(originalCardInfo , {"attack":0 , "health":0 , "intelligence":0});
			setNum(attack,originalCardInfo["attack"],1,playEffect);
			setNum(health,originalCardInfo["health"],2,playEffect);
			setNum(intelligence,originalCardInfo["intelligence"],3,playEffect);
		}
		
		private function setNum(current:int ,original:int ,index:int,playEffect:Boolean):void
		{
			var rollNumGroup:RollNumGroup = this["rollNum"+index] as RollNumGroup;
			var filter:GlowFilter = new GlowFilter(current==original?0xffffff:0,1,2,2,10);
			rollNumGroup.filters = [filter];
			rollNumGroup.textFormat = new TextFormat("Times New Roman",16,getColor(current,original),true);
			rollNumGroup.setNum(current,playEffect);
			if(index!=3){
				var label:Label = this["label"+index] as Label;
				label.filters = [new GlowFilter(0,1,2,2,10)];
				label.text = "/";
				label.setFormatOfRange(new TextFormat("Times New Roman",16,0xffffff,true));
			}
		}
		
		/**
		 * 比较属性差异，返回对应帧倍数
		 */
		private function getColor(current:int ,original:int):uint
		{
			if(current == original){
				return 0;
			}else if(current >= original){
				return 0x00ff00;
			}else{
				return 0xff0000;
			}
		}
	}
}