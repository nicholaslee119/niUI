package com.syndrome.sanguo.battle.combat_ui.card.cardimage
{
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.layouts.HorizontalLayout;
	
	public class CardHurtGroup extends Group
	{
		public function CardHurtGroup()
		{
			super();
			var hor:HorizontalLayout = new HorizontalLayout();
			hor.gap = 0;
			this.layout = hor;
		}
		
		public function getHurtNum():int
		{
			return this.numElements;
		}
		
		public function addHurt(num:int):void
		{
			for (var i:int = 0; i < num; i++) 
			{
				var hurtUI:UIAsset = new UIAsset();
				hurtUI.skinName = "IMG_Card_hurt";
				this.addElement(hurtUI);
			}
		}
		
		public function removeHurt(num:int = int.MAX_VALUE):void
		{
			while(num>0){
				if(this.numElements>0){
					this.removeElementAt(this.numElements-1);
				}else{
					return;
				}
				num--;
			}
		}
	}
}