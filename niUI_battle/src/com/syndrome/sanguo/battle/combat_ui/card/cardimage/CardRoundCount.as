package com.syndrome.sanguo.battle.combat_ui.card.cardimage
{
	import com.syndrome.sanguo.battle.skin.CardRoundCountSkin;
	
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.SkinnableComponent;
	
	/**
	 * 回合计数标记
	 */
	public class CardRoundCount extends SkinnableComponent
	{
		public var numLabel:Label;
		
		public function CardRoundCount()
		{
			super();
			this.skinName = CardRoundCountSkin;
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName , instance);
			if(instance == numLabel){
				numLabel.text = _value.toString();
				invalidateSkinState();
			}
		}
		
		private var _value:int = 0;
		
		/**
		 * 要显示的数字 ， -1表示永久
		 */
		public function get value():int
		{
			return _value;
		}

		public function set value(value:int):void
		{
			_value = value;
			if(numLabel && _value >= 0){
				numLabel.text = _value.toString();
			}
			invalidateSkinState();
		}
		
		override protected function getCurrentSkinState():String
		{
			if(_value>=0){
				return super.getCurrentSkinState();
			}else{
				return "forever";
			}
		}
	}
}