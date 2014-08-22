package com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D
{
	import com.syndrome.sanguo.battle.skin.button.MilitaryFlagSkin;
	
	import components.rollnum.RollNumGroup;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.flexlite.domUI.components.Button;
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.SkinnableComponent;
	import org.flexlite.domUI.components.SkinnableContainer;
	import org.flexlite.domUI.components.UIAsset;
	import org.flexlite.domUI.components.UIMovieClip;
	
	[Event(name="militaryClick", type="Event")]
	
	/**
	 * 兵权按钮
	 */
	public class MilitaryFlagButton extends SkinnableComponent
	{
		public var icon:UIMovieClip;
		public var button:Button;
		public var numGroup:RollNumGroup;
		
		public function MilitaryFlagButton()
		{
			super();
			this.skinName = MilitaryFlagSkin;
		}
		
		private var _type:int =1;
		public function set type(value:int):void
		{
			_type = value;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			setMilitaryNum(0,false);
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName,instance);
			if(instance == icon){
				icon.gotoAndStop(_type);
			}else if(numGroup == instance){
				numGroup.setNum(0);
			}else if(button == instance){
				button.addEventListener(MouseEvent.CLICK , buttonClick);
			}
		}
		
		protected function buttonClick(event:MouseEvent):void
		{
			dispatchEvent(new Event("militaryClick"));
		}
		
		/**
		 * 获取兵权数量
		 */
		public function getMilitaryNum():int
		{
			return numGroup.getNum();
		}
		
		/**
		 * 设置兵权数量
		 */
		public function setMilitaryNum(value:int , playEffect:Boolean=true):void
		{
			icon.visible = numGroup.visible = button.visible = value==0?false:true;
			numGroup.setNum(value , playEffect);
		}
	}
}