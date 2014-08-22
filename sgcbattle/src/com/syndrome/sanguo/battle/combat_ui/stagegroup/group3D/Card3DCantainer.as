package com.syndrome.sanguo.battle.combat_ui.stagegroup.group3D
{
	import com.syndrome.sanguo.battle.combat_ui.CombatStage;
	
	import flash.geom.Point;
	
	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.core.IVisualElement;
	
	/**
	 * 3D卡牌容器
	 */
	public class Card3DCantainer extends Group
	{
		public function Card3DCantainer()
		{
			super();
			this.mouseEnabled = false;
		}
		
		override public function addElementAt(element:IVisualElement, index:int):IVisualElement
		{
			var point:Point;
			var point2:Point;
			if (element.parent!=null)
			{
				point = new Point(element.x, element.y);
				point2 = globalToLocal(element.parent.localToGlobal(point));
				element.x = point2.x;
				element.y = point2.y;
			}
			return super.addElementAt(element , index);
		}
		
		public static function getInstance():Card3DCantainer
		{
			return CombatStage.getInstance().card3DCantainer;
		}
	}
}